Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWFHEHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWFHEHa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 00:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWFHEH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 00:07:29 -0400
Received: from palrel13.hp.com ([156.153.255.238]:15802 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S932477AbWFHEH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 00:07:28 -0400
Date: Thu, 8 Jun 2006 00:07:26 -0400
From: Amy Griffis <amy.griffis@hp.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] audit: path-based rules
Message-ID: <20060608040726.GB1969@zk3.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: Mutt http://www.mutt.org/
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch augments the existing inode-based auditing to
audit a filesystem location.  When a path-based rule is used, the
rule's inode data is automatically updated as entities come and go at
that location.

In this implementation, audit registers inotify watches on the parent
directories of paths specified in audit rules.  When audit's inotify
event handler is called, it updates any affected rules based on the
filesystem event.  If the parent directory is renamed, removed, or its
filesystem is unmounted, audit removes all rules referencing that
inotify watch.

To keep things simple, this implementation limits location-based
auditing to the directory entries in an existing directory.  Given
a path-based rule for /foo/bar/passwd, the following table applies:

    passwd modified -- audit event logged
    passwd replaced -- audit event logged, rules list updated
    bar renamed     -- rule removed
    foo renamed     -- untracked, meaning that the rule now applies to
                       the new location

Audit users typically want to have many rules referencing filesystem
objects, which can significantly impact filtering performance.  This
patch also adds an inode-number-based rule hash to mitigate this
situation.

The patch is relative to the audit git tree:
http://kernel.org/git/?p=linux/kernel/git/viro/audit-current.git;a=summary

and uses the inotify kernel API:
http://lkml.org/lkml/2006/6/1/145

Signed-off-by: Amy Griffis <amy.griffis@hp.com>

---

 include/linux/audit.h |    1 
 init/Kconfig          |    3 
 kernel/audit.c        |   39 ++
 kernel/audit.h        |   36 ++
 kernel/auditfilter.c  |  774 +++++++++++++++++++++++++++++++++++++++++++++++---
 kernel/auditsc.c      |  124 +++++---
 6 files changed, 889 insertions(+), 88 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 7c8780b..c783275 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -165,6 +165,7 @@ #define AUDIT_DEVMINOR	101
 #define AUDIT_INODE	102
 #define AUDIT_EXIT	103
 #define AUDIT_SUCCESS   104	/* exit >= 0; value ignored */
+#define AUDIT_WATCH	105
 
 #define AUDIT_ARG0      200
 #define AUDIT_ARG1      (AUDIT_ARG0+1)
diff --git a/init/Kconfig b/init/Kconfig
index 3b36a1d..c4d0fa6 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -182,7 +182,8 @@ config AUDITSYSCALL
 	help
 	  Enable low-overhead system-call auditing infrastructure that
 	  can be used independently or with another kernel subsystem,
-	  such as SELinux.
+	  such as SELinux.  To use audit's filesystem watch feature, please
+	  ensure that INOTIFY is configured.
 
 config IKCONFIG
 	bool "Kernel .config support"
diff --git a/kernel/audit.c b/kernel/audit.c
index 0738a4b..c12e2ae 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -56,6 +56,7 @@ #include <net/netlink.h>
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
 #include <linux/selinux.h>
+#include <linux/inotify.h>
 
 #include "audit.h"
 
@@ -103,6 +104,12 @@ static atomic_t    audit_lost = ATOMIC_I
 /* The netlink socket. */
 static struct sock *audit_sock;
 
+/* Inotify handle. */
+struct inotify_handle *audit_ih;
+
+/* Hash for inode-based rules */
+struct list_head audit_inode_hash[AUDIT_INODE_BUCKETS];
+
 /* The audit_freelist is a list of pre-allocated audit buffers (if more
  * than AUDIT_MAXFREE are in use, the audit buffer is freed instead of
  * being placed on the freelist). */
@@ -115,10 +122,8 @@ static struct task_struct *kauditd_task;
 static DECLARE_WAIT_QUEUE_HEAD(kauditd_wait);
 static DECLARE_WAIT_QUEUE_HEAD(audit_backlog_wait);
 
-/* The netlink socket is only to be read by 1 CPU, which lets us assume
- * that list additions and deletions never happen simultaneously in
- * auditsc.c */
-DEFINE_MUTEX(audit_netlink_mutex);
+/* Serialize requests from userspace. */
+static DEFINE_MUTEX(audit_cmd_mutex);
 
 /* AUDIT_BUFSIZ is the size of the temporary buffer used for formatting
  * audit records.  Since printk uses a 1024 byte buffer, this buffer
@@ -373,8 +378,8 @@ int audit_send_list(void *_dest)
 	struct sk_buff *skb;
 
 	/* wait for parent to finish and send an ACK */
-	mutex_lock(&audit_netlink_mutex);
-	mutex_unlock(&audit_netlink_mutex);
+	mutex_lock(&audit_cmd_mutex);
+	mutex_unlock(&audit_cmd_mutex);
 
 	while ((skb = __skb_dequeue(&dest->q)) != NULL)
 		netlink_unicast(audit_sock, skb, pid, 0);
@@ -665,20 +670,28 @@ static void audit_receive(struct sock *s
 	struct sk_buff  *skb;
 	unsigned int qlen;
 
-	mutex_lock(&audit_netlink_mutex);
+	mutex_lock(&audit_cmd_mutex);
 
 	for (qlen = skb_queue_len(&sk->sk_receive_queue); qlen; qlen--) {
 		skb = skb_dequeue(&sk->sk_receive_queue);
 		audit_receive_skb(skb);
 		kfree_skb(skb);
 	}
-	mutex_unlock(&audit_netlink_mutex);
+	mutex_unlock(&audit_cmd_mutex);
 }
 
+#ifdef CONFIG_AUDITSYSCALL
+static const struct inotify_operations audit_inotify_ops = {
+	.handle_event	= audit_handle_ievent,
+	.destroy_watch	= audit_free_parent,
+};
+#endif
 
 /* Initialize audit support at boot time. */
 static int __init audit_init(void)
 {
+	int i;
+
 	printk(KERN_INFO "audit: initializing netlink socket (%s)\n",
 	       audit_default ? "enabled" : "disabled");
 	audit_sock = netlink_kernel_create(NETLINK_AUDIT, 0, audit_receive,
@@ -697,6 +710,16 @@ static int __init audit_init(void)
 	selinux_audit_set_callback(&selinux_audit_rule_update);
 
 	audit_log(NULL, GFP_KERNEL, AUDIT_KERNEL, "initialized");
+
+#ifdef CONFIG_AUDITSYSCALL
+	audit_ih = inotify_init(&audit_inotify_ops);
+	if (IS_ERR(audit_ih))
+		audit_panic("cannot initialize inotify handle");
+
+	for (i = 0; i < AUDIT_INODE_BUCKETS; i++)
+		INIT_LIST_HEAD(&audit_inode_hash[i]);
+#endif
+
 	return 0;
 }
 __initcall(audit_init);
diff --git a/kernel/audit.h b/kernel/audit.h
index 52cb1e3..f337845 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -19,7 +19,6 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include <linux/mutex.h>
 #include <linux/fs.h>
 #include <linux/audit.h>
 #include <linux/skbuff.h>
@@ -54,6 +53,18 @@ enum audit_state {
 };
 
 /* Rule lists */
+struct audit_parent;
+
+struct audit_watch {
+	atomic_t		count;	/* reference count */
+	char			*path;	/* insertion path */
+	dev_t			dev;	/* associated superblock device */
+	unsigned long		ino;	/* associated inode number */
+	struct audit_parent	*parent; /* associated parent */
+	struct list_head	wlist;	/* entry in parent->watches list */
+	struct list_head	rules;	/* associated rules */
+};
+
 struct audit_field {
 	u32				type;
 	u32				val;
@@ -71,6 +82,9 @@ struct audit_krule {
 	u32			buflen; /* for data alloc on list rules */
 	u32			field_count;
 	struct audit_field	*fields;
+	struct audit_field	*inode_f; /* quick access to an inode field */
+	struct audit_watch	*watch;	/* associated watch */
+	struct list_head	rlist;	/* entry in audit_watch.rules list */
 };
 
 struct audit_entry {
@@ -79,10 +93,18 @@ struct audit_entry {
 	struct audit_krule	rule;
 };
 
-
 extern int audit_pid;
-extern int audit_comparator(const u32 left, const u32 op, const u32 right);
 
+#define AUDIT_INODE_BUCKETS	32
+extern struct list_head audit_inode_hash[AUDIT_INODE_BUCKETS];
+
+static inline int audit_hash_ino(u32 ino)
+{
+	return (ino & (AUDIT_INODE_BUCKETS-1));
+}
+
+extern int audit_comparator(const u32 left, const u32 op, const u32 right);
+extern int audit_compare_dname_path(const char *dname, const char *path);
 extern struct sk_buff *	    audit_make_reply(int pid, int seq, int type,
 					     int done, int multi,
 					     void *payload, int size);
@@ -91,7 +113,6 @@ extern void		    audit_send_reply(int pi
 					     void *payload, int size);
 extern void		    audit_log_lost(const char *message);
 extern void		    audit_panic(const char *message);
-extern struct mutex audit_netlink_mutex;
 
 struct audit_netlink_list {
 	int pid;
@@ -100,7 +121,14 @@ struct audit_netlink_list {
 
 int audit_send_list(void *);
 
+struct inotify_watch;
+extern void audit_free_parent(struct inotify_watch *);
+extern void audit_handle_ievent(struct inotify_watch *, u32, u32, u32,
+				const char *, struct inode *);
 extern int selinux_audit_rule_update(void);
+extern enum audit_state audit_filter_inodes(struct task_struct *,
+					    struct audit_context *);
+extern void audit_set_auditable(struct audit_context *);
 
 #ifdef CONFIG_AUDITSYSCALL
 extern void __audit_signal_info(int sig, struct task_struct *t);
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index df9503d..9697d38 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -22,13 +22,59 @@
 #include <linux/kernel.h>
 #include <linux/audit.h>
 #include <linux/kthread.h>
+#include <linux/mutex.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
 #include <linux/netlink.h>
+#include <linux/sched.h>
+#include <linux/inotify.h>
 #include <linux/selinux.h>
 #include "audit.h"
 
-/* There are three lists of rules -- one to search at task creation
- * time, one to search at syscall entry time, and another to search at
- * syscall exit time. */
+/*
+ * Locking model:
+ *
+ * audit_filter_mutex:
+ * 		Synchronizes writes and blocking reads of audit's filterlist
+ * 		data.  Rcu is used to traverse the filterlist and access
+ * 		contents of structs audit_entry, audit_watch and opaque
+ * 		selinux rules during filtering.  If modified, these structures
+ * 		must be copied and replace their counterparts in the filterlist.
+ * 		An audit_parent struct is not accessed during filtering, so may
+ * 		be written directly provided audit_filter_mutex is held.
+ */
+
+/*
+ * Reference counting:
+ *
+ * audit_parent: lifetime is from audit_init_parent() to receipt of an IN_IGNORED
+ * 	event.  Each audit_watch holds a reference to its associated parent.
+ *
+ * audit_watch: if added to lists, lifetime is from audit_init_watch() to
+ * 	audit_remove_watch().  Additionally, an audit_watch may exist
+ * 	temporarily to assist in searching existing filter data.  Each
+ * 	audit_krule holds a reference to its associated watch.
+ */
+
+struct audit_parent {
+	struct list_head	ilist;	/* entry in inotify registration list */
+	struct list_head	watches; /* associated watches */
+	struct inotify_watch	wdata;	/* inotify watch data */
+	unsigned		flags;	/* status flags */
+};
+
+/*
+ * audit_parent status flags:
+ *
+ * AUDIT_PARENT_INVALID - set anytime rules/watches are auto-removed due to
+ * a filesystem event to ensure we're adding audit watches to a valid parent.
+ * Technically not needed for IN_DELETE_SELF or IN_UNMOUNT events, as we cannot
+ * receive them while we have nameidata, but must be used for IN_MOVE_SELF which
+ * we can receive while holding nameidata.
+ */
+#define AUDIT_PARENT_INVALID	0x001
+
+/* Audit filter lists, defined in <linux/audit.h> */
 struct list_head audit_filter_list[AUDIT_NR_FILTERS] = {
 	LIST_HEAD_INIT(audit_filter_list[0]),
 	LIST_HEAD_INIT(audit_filter_list[1]),
@@ -41,9 +87,53 @@ #error Fix audit_filter_list initialiser
 #endif
 };
 
+static DEFINE_MUTEX(audit_filter_mutex);
+
+/* Inotify handle */
+extern struct inotify_handle *audit_ih;
+
+/* Inotify events we care about. */
+#define AUDIT_IN_WATCH IN_MOVE|IN_CREATE|IN_DELETE|IN_DELETE_SELF|IN_MOVE_SELF
+
+void audit_free_parent(struct inotify_watch *i_watch)
+{
+	struct audit_parent *parent;
+
+	parent = container_of(i_watch, struct audit_parent, wdata);
+	WARN_ON(!list_empty(&parent->watches));
+	kfree(parent);
+}
+
+static inline void audit_get_watch(struct audit_watch *watch)
+{
+	atomic_inc(&watch->count);
+}
+
+static inline void audit_put_watch(struct audit_watch *watch)
+{
+	if (atomic_dec_and_test(&watch->count)) {
+		WARN_ON(watch->parent);
+		WARN_ON(!list_empty(&watch->rules));
+		kfree(watch->path);
+		kfree(watch);
+	}
+}
+
+static inline void audit_remove_watch(struct audit_watch *watch)
+{
+	list_del(&watch->wlist);
+	put_inotify_watch(&watch->parent->wdata);
+	watch->parent = NULL;
+	audit_put_watch(watch); /* match initial get */
+}
+
 static inline void audit_free_rule(struct audit_entry *e)
 {
 	int i;
+
+	/* some rules don't have associated watches */
+	if (e->rule.watch)
+		audit_put_watch(e->rule.watch);
 	if (e->rule.fields)
 		for (i = 0; i < e->rule.field_count; i++) {
 			struct audit_field *f = &e->rule.fields[i];
@@ -60,6 +150,50 @@ static inline void audit_free_rule_rcu(s
 	audit_free_rule(e);
 }
 
+/* Initialize a parent watch entry. */
+static inline struct audit_parent *audit_init_parent(struct nameidata *ndp)
+{
+	struct audit_parent *parent;
+	s32 wd;
+
+	parent = kzalloc(sizeof(*parent), GFP_KERNEL);
+	if (unlikely(!parent))
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&parent->watches);
+	parent->flags = 0;
+
+	inotify_init_watch(&parent->wdata);
+	/* grab a ref so inotify watch hangs around until we take audit_filter_mutex */
+	get_inotify_watch(&parent->wdata);
+	wd = inotify_add_watch(audit_ih, &parent->wdata, ndp->dentry->d_inode,
+			       AUDIT_IN_WATCH);
+	if (wd < 0) {
+		audit_free_parent(&parent->wdata);
+		return ERR_PTR(wd);
+	}
+
+	return parent;
+}
+
+/* Initialize a watch entry. */
+static inline struct audit_watch *audit_init_watch(char *path)
+{
+	struct audit_watch *watch;
+
+	watch = kzalloc(sizeof(*watch), GFP_KERNEL);
+	if (unlikely(!watch))
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&watch->rules);
+	atomic_set(&watch->count, 1);
+	watch->path = path;
+	watch->dev = (dev_t)-1;
+	watch->ino = (unsigned long)-1;
+
+	return watch;
+}
+
 /* Initialize an audit filterlist entry. */
 static inline struct audit_entry *audit_init_entry(u32 field_count)
 {
@@ -107,6 +241,41 @@ static char *audit_unpack_string(void **
 	return str;
 }
 
+/* Translate an inode field to kernel respresentation. */
+static inline int audit_to_inode(struct audit_krule *krule,
+				 struct audit_field *f)
+{
+	if (krule->listnr != AUDIT_FILTER_EXIT ||
+	    krule->watch || krule->inode_f)
+		return -EINVAL;
+	return 0;
+}
+
+/* Translate a watch string to kernel respresentation. */
+static int audit_to_watch(struct audit_krule *krule, char *path, int len,
+			  u32 op)
+{
+	struct audit_watch *watch;
+
+	if (!audit_ih)
+		return -EOPNOTSUPP;
+
+	if (path[0] != '/' || path[len-1] == '/' ||
+	    krule->listnr != AUDIT_FILTER_EXIT ||
+	    op & ~AUDIT_EQUAL ||
+	    krule->inode_f || krule->watch) /* 1 inode # per rule, for hash */
+		return -EINVAL;
+
+	watch = audit_init_watch(path);
+	if (unlikely(IS_ERR(watch)))
+		return PTR_ERR(watch);
+
+	audit_get_watch(watch);
+	krule->watch = watch;
+
+	return 0;
+}
+
 /* Common user-space to kernel rule translation. */
 static inline struct audit_entry *audit_to_entry_common(struct audit_rule *rule)
 {
@@ -161,6 +330,7 @@ exit_err:
 static struct audit_entry *audit_rule_to_entry(struct audit_rule *rule)
 {
 	struct audit_entry *entry;
+	struct audit_field *f;
 	int err = 0;
 	int i;
 
@@ -175,14 +345,23 @@ static struct audit_entry *audit_rule_to
 		f->type = rule->fields[i] & ~(AUDIT_NEGATE|AUDIT_OPERATORS);
 		f->val = rule->values[i];
 
-		if (f->type & AUDIT_UNUSED_BITS ||
-		    f->type == AUDIT_SE_USER ||
-		    f->type == AUDIT_SE_ROLE ||
-		    f->type == AUDIT_SE_TYPE ||
-		    f->type == AUDIT_SE_SEN ||
-		    f->type == AUDIT_SE_CLR) {
-			err = -EINVAL;
+		err = -EINVAL;
+		if (f->type & AUDIT_UNUSED_BITS)
+			goto exit_free;
+
+		switch(f->type) {
+		case AUDIT_SE_USER:
+		case AUDIT_SE_ROLE:
+		case AUDIT_SE_TYPE:
+		case AUDIT_SE_SEN:
+		case AUDIT_SE_CLR:
+		case AUDIT_WATCH:
 			goto exit_free;
+		case AUDIT_INODE:
+			err = audit_to_inode(&entry->rule, f);
+			if (err)
+				goto exit_free;
+			break;
 		}
 
 		entry->rule.vers_ops = (f->op & AUDIT_OPERATORS) ? 2 : 1;
@@ -199,6 +378,18 @@ static struct audit_entry *audit_rule_to
 		}
 	}
 
+	f = entry->rule.inode_f;
+	if (f) {
+		switch(f->op) {
+		case AUDIT_NOT_EQUAL:
+			entry->rule.inode_f = NULL;
+		case AUDIT_EQUAL:
+			break;
+		default:
+			goto exit_free;
+		}
+	}
+
 exit_nofree:
 	return entry;
 
@@ -213,6 +404,7 @@ static struct audit_entry *audit_data_to
 {
 	int err = 0;
 	struct audit_entry *entry;
+	struct audit_field *f;
 	void *bufp;
 	size_t remain = datasz - sizeof(struct audit_rule_data);
 	int i;
@@ -263,6 +455,35 @@ static struct audit_entry *audit_data_to
 			} else
 				f->se_str = str;
 			break;
+		case AUDIT_WATCH:
+			str = audit_unpack_string(&bufp, &remain, f->val);
+			if (IS_ERR(str))
+				goto exit_free;
+			entry->rule.buflen += f->val;
+
+			err = audit_to_watch(&entry->rule, str, f->val, f->op);
+			if (err) {
+				kfree(str);
+				goto exit_free;
+			}
+			break;
+		case AUDIT_INODE:
+			err = audit_to_inode(&entry->rule, f);
+			if (err)
+				goto exit_free;
+			break;
+		}
+	}
+
+	f = entry->rule.inode_f;
+	if (f) {
+		switch(f->op) {
+		case AUDIT_NOT_EQUAL:
+			entry->rule.inode_f = NULL;
+		case AUDIT_EQUAL:
+			break;
+		default:
+			goto exit_free;
 		}
 	}
 
@@ -346,6 +567,10 @@ static struct audit_rule_data *audit_kru
 			data->buflen += data->values[i] =
 				audit_pack_string(&bufp, f->se_str);
 			break;
+		case AUDIT_WATCH:
+			data->buflen += data->values[i] =
+				audit_pack_string(&bufp, krule->watch->path);
+			break;
 		default:
 			data->values[i] = f->val;
 		}
@@ -381,6 +606,10 @@ static int audit_compare_rule(struct aud
 			if (strcmp(a->fields[i].se_str, b->fields[i].se_str))
 				return 1;
 			break;
+		case AUDIT_WATCH:
+			if (strcmp(a->watch->path, b->watch->path))
+				return 1;
+			break;
 		default:
 			if (a->fields[i].val != b->fields[i].val)
 				return 1;
@@ -394,6 +623,32 @@ static int audit_compare_rule(struct aud
 	return 0;
 }
 
+/* Duplicate the given audit watch.  The new watch's rules list is initialized
+ * to an empty list and wlist is undefined. */
+static inline struct audit_watch *audit_dupe_watch(struct audit_watch *old)
+{
+	char *path;
+	struct audit_watch *new;
+
+	path = kstrdup(old->path, GFP_KERNEL);
+	if (unlikely(!path))
+		return ERR_PTR(-ENOMEM);
+
+	new = audit_init_watch(path);
+	if (unlikely(IS_ERR(new))) {
+		kfree(path);
+		goto out;
+	}
+
+	new->dev = old->dev;
+	new->ino = old->ino;
+	get_inotify_watch(&old->parent->wdata);
+	new->parent = old->parent;
+
+out:
+	return new;
+}
+
 /* Duplicate selinux field information.  The se_rule is opaque, so must be
  * re-initialized. */
 static inline int audit_dupe_selinux_field(struct audit_field *df,
@@ -425,8 +680,11 @@ static inline int audit_dupe_selinux_fie
 /* Duplicate an audit rule.  This will be a deep copy with the exception
  * of the watch - that pointer is carried over.  The selinux specific fields
  * will be updated in the copy.  The point is to be able to replace the old
- * rule with the new rule in the filterlist, then free the old rule. */
-static struct audit_entry *audit_dupe_rule(struct audit_krule *old)
+ * rule with the new rule in the filterlist, then free the old rule.
+ * The rlist element is undefined; list manipulations are handled apart from
+ * the initial copy. */
+static struct audit_entry *audit_dupe_rule(struct audit_krule *old,
+					   struct audit_watch *watch)
 {
 	u32 fcount = old->field_count;
 	struct audit_entry *entry;
@@ -445,6 +703,8 @@ static struct audit_entry *audit_dupe_ru
 	for (i = 0; i < AUDIT_BITMASK_SIZE; i++)
 		new->mask[i] = old->mask[i];
 	new->buflen = old->buflen;
+	new->inode_f = old->inode_f;
+	new->watch = NULL;
 	new->field_count = old->field_count;
 	memcpy(new->fields, old->fields, sizeof(struct audit_field) * fcount);
 
@@ -466,21 +726,288 @@ static struct audit_entry *audit_dupe_ru
 		}
 	}
 
+	if (watch) {
+		audit_get_watch(watch);
+		new->watch = watch;
+	}
+
 	return entry;
 }
 
-/* Add rule to given filterlist if not a duplicate.  Protected by
- * audit_netlink_mutex. */
+/* Update inode info in audit rules based on filesystem event. */
+static inline void audit_update_watch(struct audit_parent *parent,
+				      const char *dname, dev_t dev,
+				      unsigned long ino, unsigned invalidating)
+{
+	struct audit_watch *owatch, *nwatch, *nextw;
+	struct audit_krule *r, *nextr;
+	struct audit_entry *oentry, *nentry;
+	struct audit_buffer *ab;
+
+	mutex_lock(&audit_filter_mutex);
+	list_for_each_entry_safe(owatch, nextw, &parent->watches, wlist) {
+		if (audit_compare_dname_path(dname, owatch->path))
+			continue;
+
+		/* If the update involves invalidating rules, do the inode-based
+		 * filtering now, so we don't omit records. */
+		if (invalidating &&
+		    audit_filter_inodes(current, current->audit_context) == AUDIT_RECORD_CONTEXT)
+			audit_set_auditable(current->audit_context);
+
+		nwatch = audit_dupe_watch(owatch);
+		if (unlikely(IS_ERR(nwatch))) {
+			mutex_unlock(&audit_filter_mutex);
+			audit_panic("error updating watch, skipping");
+			return;
+		}
+		nwatch->dev = dev;
+		nwatch->ino = ino;
+
+		list_for_each_entry_safe(r, nextr, &owatch->rules, rlist) {
+
+			oentry = container_of(r, struct audit_entry, rule);
+			list_del(&oentry->rule.rlist);
+			list_del_rcu(&oentry->list);
+
+			nentry = audit_dupe_rule(&oentry->rule, nwatch);
+			if (unlikely(IS_ERR(nentry)))
+				audit_panic("error updating watch, removing");
+			else {
+				int h = audit_hash_ino((u32)ino);
+				list_add(&nentry->rule.rlist, &nwatch->rules);
+				list_add_rcu(&nentry->list, &audit_inode_hash[h]);
+			}
+
+			call_rcu(&oentry->rcu, audit_free_rule_rcu);
+		}
+
+		ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
+		audit_log_format(ab, "audit updated rules specifying watch=");
+		audit_log_untrustedstring(ab, owatch->path);
+		audit_log_format(ab, " with dev=%u ino=%lu\n", dev, ino);
+		audit_log_end(ab);
+
+		audit_remove_watch(owatch);
+		goto add_watch_to_parent; /* event applies to a single watch */
+	}
+	mutex_unlock(&audit_filter_mutex);
+	return;
+
+add_watch_to_parent:
+	list_add(&nwatch->wlist, &parent->watches);
+	mutex_unlock(&audit_filter_mutex);
+	return;
+}
+
+/* Remove all watches & rules associated with a parent that is going away. */
+static inline void audit_remove_parent_watches(struct audit_parent *parent)
+{
+	struct audit_watch *w, *nextw;
+	struct audit_krule *r, *nextr;
+	struct audit_entry *e;
+
+	mutex_lock(&audit_filter_mutex);
+	parent->flags |= AUDIT_PARENT_INVALID;
+	list_for_each_entry_safe(w, nextw, &parent->watches, wlist) {
+		list_for_each_entry_safe(r, nextr, &w->rules, rlist) {
+			e = container_of(r, struct audit_entry, rule);
+			list_del(&r->rlist);
+			list_del_rcu(&e->list);
+			call_rcu(&e->rcu, audit_free_rule_rcu);
+
+			audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
+				 "audit implicitly removed rule from list=%d\n",
+				  AUDIT_FILTER_EXIT);
+		}
+		audit_remove_watch(w);
+	}
+	mutex_unlock(&audit_filter_mutex);
+}
+
+/* Unregister inotify watches for parents on in_list.
+ * Generates an IN_IGNORED event. */
+static void audit_inotify_unregister(struct list_head *in_list)
+{
+	struct audit_parent *p, *n;
+
+	list_for_each_entry_safe(p, n, in_list, ilist) {
+		list_del(&p->ilist);
+		inotify_rm_watch(audit_ih, &p->wdata);
+		/* the put matching the get in audit_do_del_rule() */
+		put_inotify_watch(&p->wdata);
+	}
+}
+
+/* Get path information necessary for adding watches. */
+static int audit_get_nd(char *path, struct nameidata **ndp,
+			struct nameidata **ndw)
+{
+	struct nameidata *ndparent, *ndwatch;
+	int err;
+
+	ndparent = kmalloc(sizeof(*ndparent), GFP_KERNEL);
+	if (unlikely(!ndparent))
+		return -ENOMEM;
+
+	ndwatch = kmalloc(sizeof(*ndwatch), GFP_KERNEL);
+	if (unlikely(!ndwatch)) {
+		kfree(ndparent);
+		return -ENOMEM;
+	}
+
+	err = path_lookup(path, LOOKUP_PARENT, ndparent);
+	if (err) {
+		kfree(ndparent);
+		kfree(ndwatch);
+		return err;
+	}
+
+	err = path_lookup(path, 0, ndwatch);
+	if (err) {
+		kfree(ndwatch);
+		ndwatch = NULL;
+	}
+
+	*ndp = ndparent;
+	*ndw = ndwatch;
+
+	return 0;
+}
+
+/* Release resources used for watch path information. */
+static inline void audit_put_nd(struct nameidata *ndp, struct nameidata *ndw)
+{
+	if (ndp) {
+		path_release(ndp);
+		kfree(ndp);
+	}
+	if (ndw) {
+		path_release(ndw);
+		kfree(ndw);
+	}
+}
+
+/* Associate the given rule with an existing parent inotify_watch.
+ * Caller must hold audit_filter_mutex. */
+static void audit_add_to_parent(struct audit_krule *krule,
+				struct audit_parent *parent)
+{
+	struct audit_watch *w, *watch = krule->watch;
+	int watch_found = 0;
+
+	list_for_each_entry(w, &parent->watches, wlist) {
+		if (strcmp(watch->path, w->path))
+			continue;
+
+		watch_found = 1;
+
+		/* put krule's and initial refs to temporary watch */
+		audit_put_watch(watch);
+		audit_put_watch(watch);
+
+		audit_get_watch(w);
+		krule->watch = watch = w;
+		break;
+	}
+
+	if (!watch_found) {
+		get_inotify_watch(&parent->wdata);
+		watch->parent = parent;
+
+		list_add(&watch->wlist, &parent->watches);
+	}
+	list_add(&krule->rlist, &watch->rules);
+}
+
+/* Find a matching watch entry, or add this one.
+ * Caller must hold audit_filter_mutex. */
+static int audit_add_watch(struct audit_krule *krule, struct nameidata *ndp,
+			   struct nameidata *ndw)
+{
+	struct audit_watch *watch = krule->watch;
+	struct inotify_watch *i_watch;
+	struct audit_parent *parent;
+	int ret = 0;
+
+	/* update watch filter fields */
+	if (ndw) {
+		watch->dev = ndw->dentry->d_inode->i_sb->s_dev;
+		watch->ino = ndw->dentry->d_inode->i_ino;
+	}
+
+	/* The audit_filter_mutex must not be held during inotify calls because
+	 * we hold it during inotify event callback processing.  If an existing
+	 * inotify watch is found, inotify_find_watch() grabs a reference before
+	 * returning.
+	 */
+	mutex_unlock(&audit_filter_mutex);
+
+	if (inotify_find_watch(audit_ih, ndp->dentry->d_inode, &i_watch) < 0) {
+		parent = audit_init_parent(ndp);
+		if (IS_ERR(parent)) {
+			/* caller expects mutex locked */
+			mutex_lock(&audit_filter_mutex);
+			return PTR_ERR(parent);
+		}
+	} else
+		parent = container_of(i_watch, struct audit_parent, wdata);
+
+	mutex_lock(&audit_filter_mutex);
+
+	/* parent was moved before we took audit_filter_mutex */
+	if (parent->flags & AUDIT_PARENT_INVALID)
+		ret = -ENOENT;
+	else
+		audit_add_to_parent(krule, parent);
+
+	/* match get in audit_init_parent or inotify_find_watch */
+	put_inotify_watch(&parent->wdata);
+	return ret;
+}
+
+/* Add rule to given filterlist if not a duplicate. */
 static inline int audit_add_rule(struct audit_entry *entry,
-				  struct list_head *list)
+				 struct list_head *list)
 {
 	struct audit_entry *e;
+	struct audit_field *inode_f = entry->rule.inode_f;
+	struct audit_watch *watch = entry->rule.watch;
+	struct nameidata *ndp, *ndw;
+	int h, err, putnd_needed = 0;
 
-	/* Do not use the _rcu iterator here, since this is the only
-	 * addition routine. */
+	/* Taking audit_filter_mutex protects from stale rule data. */
+	mutex_lock(&audit_filter_mutex);
 	list_for_each_entry(e, list, list) {
-		if (!audit_compare_rule(&entry->rule, &e->rule))
-			return -EEXIST;
+		if (!audit_compare_rule(&entry->rule, &e->rule)) {
+			err = -EEXIST;
+			mutex_unlock(&audit_filter_mutex);
+			goto error;
+		}
+	}
+	mutex_unlock(&audit_filter_mutex);
+
+	/* Avoid calling path_lookup under audit_filter_mutex. */
+	if (watch) {
+		err = audit_get_nd(watch->path, &ndp, &ndw);
+		if (err)
+			goto error;
+		putnd_needed = 1;
+	}
+
+	mutex_lock(&audit_filter_mutex);
+	if (watch) {
+		/* audit_filter_mutex is dropped and re-taken during this call */
+		err = audit_add_watch(&entry->rule, ndp, ndw);
+		if (err) {
+			mutex_unlock(&audit_filter_mutex);
+			goto error;
+		}
+		h = audit_hash_ino((u32)watch->ino);
+		list = &audit_inode_hash[h];
+	} else if (inode_f) {
+		h = audit_hash_ino(inode_f->val);
+		list = &audit_inode_hash[h];
 	}
 
 	if (entry->rule.flags & AUDIT_FILTER_PREPEND) {
@@ -488,29 +1015,102 @@ static inline int audit_add_rule(struct 
 	} else {
 		list_add_tail_rcu(&entry->list, list);
 	}
+	mutex_unlock(&audit_filter_mutex);
 
-	return 0;
+	if (putnd_needed)
+		audit_put_nd(ndp, ndw);
+
+ 	return 0;
+
+error:
+	if (putnd_needed)
+		audit_put_nd(ndp, ndw);
+	if (watch)
+		audit_put_watch(watch); /* tmp watch, matches initial get */
+	return err;
 }
 
-/* Remove an existing rule from filterlist.  Protected by
- * audit_netlink_mutex. */
-static inline int audit_del_rule(struct audit_entry *entry,
-				 struct list_head *list)
+/* Rule removal helper.
+ * Caller must hold audit_filter_mutex. */
+static inline int audit_do_del_rule(struct audit_entry *entry,
+				    struct list_head *list,
+				    struct list_head *inotify_list)
 {
 	struct audit_entry  *e;
 
-	/* Do not use the _rcu iterator here, since this is the only
-	 * deletion routine. */
 	list_for_each_entry(e, list, list) {
-		if (!audit_compare_rule(&entry->rule, &e->rule)) {
-			list_del_rcu(&e->list);
-			call_rcu(&e->rcu, audit_free_rule_rcu);
-			return 0;
+		struct audit_watch *watch = e->rule.watch;
+
+		if (audit_compare_rule(&entry->rule, &e->rule))
+			continue;
+
+		if (watch) {
+			struct audit_parent *parent = watch->parent;
+
+			list_del(&e->rule.rlist);
+
+			if (list_empty(&watch->rules)) {
+				audit_remove_watch(watch);
+
+				if (list_empty(&parent->watches)) {
+					/* Put parent on the inotify
+					 * un-registration list.  Grab
+					 * a reference before releasing
+					 * audit_filter_mutex, to be released in
+					 * audit_inotify_unregister(). */
+					list_add(&parent->ilist, inotify_list);
+					get_inotify_watch(&parent->wdata);
+				}
+			}
 		}
+
+		list_del_rcu(&e->list);
+		call_rcu(&e->rcu, audit_free_rule_rcu);
+
+		return 0;
 	}
 	return -ENOENT;		/* No matching rule */
 }
 
+/* Remove an existing rule from filterlist. */
+static inline int audit_del_rule(struct audit_entry *entry,
+				 struct list_head *list)
+{
+	int h, ret;
+	struct audit_field *inode_f = entry->rule.inode_f;
+	struct audit_watch *watch = entry->rule.watch;
+	LIST_HEAD(inotify_list);
+
+	if (watch) {
+		mutex_lock(&audit_filter_mutex);
+		/* we don't know the inode number, so must walk entire hash */
+		for (h = 0; h < AUDIT_INODE_BUCKETS; h++) {
+			list = &audit_inode_hash[h];
+			ret = audit_do_del_rule(entry, list, &inotify_list);
+			if (!ret)
+				break;
+		}
+		mutex_unlock(&audit_filter_mutex);
+
+		if (!list_empty(&inotify_list))
+			audit_inotify_unregister(&inotify_list);
+
+		/* match initial get for tmp watch */
+		audit_put_watch(watch);
+
+	} else {
+		if (inode_f) {
+			h = audit_hash_ino(inode_f->val);
+			list = &audit_inode_hash[h];
+		}
+		mutex_lock(&audit_filter_mutex);
+		ret = audit_do_del_rule(entry, list, &inotify_list);
+		mutex_unlock(&audit_filter_mutex);
+	}
+
+	return ret;
+}
+
 /* List rules using struct audit_rule.  Exists for backward
  * compatibility with userspace. */
 static void audit_list(int pid, int seq, struct sk_buff_head *q)
@@ -519,8 +1119,8 @@ static void audit_list(int pid, int seq,
 	struct audit_entry *entry;
 	int i;
 
-	/* The *_rcu iterators not needed here because we are
-	   always called with audit_netlink_mutex held. */
+	/* This is a blocking read, so use audit_filter_mutex instead of rcu
+	 * iterator to sync with list writers. */
 	for (i=0; i<AUDIT_NR_FILTERS; i++) {
 		list_for_each_entry(entry, &audit_filter_list[i], list) {
 			struct audit_rule *rule;
@@ -535,6 +1135,20 @@ static void audit_list(int pid, int seq,
 			kfree(rule);
 		}
 	}
+	for (i = 0; i < AUDIT_INODE_BUCKETS; i++) {
+		list_for_each_entry(entry, &audit_inode_hash[i], list) {
+			struct audit_rule *rule;
+
+			rule = audit_krule_to_rule(&entry->rule);
+			if (unlikely(!rule))
+				break;
+			skb = audit_make_reply(pid, seq, AUDIT_LIST, 0, 1,
+					 rule, sizeof(*rule));
+			if (skb)
+				skb_queue_tail(q, skb);
+			kfree(rule);
+		}
+	}
 	skb = audit_make_reply(pid, seq, AUDIT_LIST, 1, 1, NULL, 0);
 	if (skb)
 		skb_queue_tail(q, skb);
@@ -547,8 +1161,8 @@ static void audit_list_rules(int pid, in
 	struct audit_entry *e;
 	int i;
 
-	/* The *_rcu iterators not needed here because we are
-	   always called with audit_netlink_mutex held. */
+	/* This is a blocking read, so use audit_filter_mutex instead of rcu
+	 * iterator to sync with list writers. */
 	for (i=0; i<AUDIT_NR_FILTERS; i++) {
 		list_for_each_entry(e, &audit_filter_list[i], list) {
 			struct audit_rule_data *data;
@@ -557,7 +1171,21 @@ static void audit_list_rules(int pid, in
 			if (unlikely(!data))
 				break;
 			skb = audit_make_reply(pid, seq, AUDIT_LIST_RULES, 0, 1,
-					 data, sizeof(*data));
+					 data, sizeof(*data) + data->buflen);
+			if (skb)
+				skb_queue_tail(q, skb);
+			kfree(data);
+		}
+	}
+	for (i=0; i< AUDIT_INODE_BUCKETS; i++) {
+		list_for_each_entry(e, &audit_inode_hash[i], list) {
+			struct audit_rule_data *data;
+
+			data = audit_krule_to_data(&e->rule);
+			if (unlikely(!data))
+				break;
+			skb = audit_make_reply(pid, seq, AUDIT_LIST_RULES, 0, 1,
+					 data, sizeof(*data) + data->buflen);
 			if (skb)
 				skb_queue_tail(q, skb);
 			kfree(data);
@@ -602,10 +1230,12 @@ int audit_receive_filter(int type, int p
 		dest->pid = pid;
 		skb_queue_head_init(&dest->q);
 
+		mutex_lock(&audit_filter_mutex);
 		if (type == AUDIT_LIST)
 			audit_list(pid, seq, &dest->q);
 		else
 			audit_list_rules(pid, seq, &dest->q);
+		mutex_unlock(&audit_filter_mutex);
 
 		tsk = kthread_run(audit_send_list, dest, "audit_send_list");
 		if (IS_ERR(tsk)) {
@@ -625,6 +1255,7 @@ int audit_receive_filter(int type, int p
 
 		err = audit_add_rule(entry,
 				     &audit_filter_list[entry->rule.listnr]);
+
 		if (sid) {
 			char *ctx = NULL;
 			u32 len;
@@ -705,7 +1336,39 @@ int audit_comparator(const u32 left, con
 	return 0;
 }
 
+/* Compare given dentry name with last component in given path,
+ * return of 0 indicates a match. */
+int audit_compare_dname_path(const char *dname, const char *path)
+{
+	int dlen, plen;
+	const char *p;
+
+	if (!dname || !path)
+		return 1;
+
+	dlen = strlen(dname);
+	plen = strlen(path);
+	if (plen < dlen)
+		return 1;
+
+	/* disregard trailing slashes */
+	p = path + plen - 1;
+	while ((*p == '/') && (p > path))
+		p--;
+
+	/* find last path component */
+	p = p - dlen + 1;
+	if (p < path)
+		return 1;
+	else if (p > path) {
+		if (*--p != '/')
+			return 1;
+		else
+			p++;
+	}
 
+	return strncmp(p, dname, dlen);
+}
 
 static int audit_filter_user_rules(struct netlink_skb_parms *cb,
 				   struct audit_krule *rule,
@@ -818,32 +1481,65 @@ static inline int audit_rule_has_selinux
 int selinux_audit_rule_update(void)
 {
 	struct audit_entry *entry, *n, *nentry;
+	struct audit_watch *watch;
 	int i, err = 0;
 
-	/* audit_netlink_mutex synchronizes the writers */
-	mutex_lock(&audit_netlink_mutex);
+	/* audit_filter_mutex synchronizes the writers */
+	mutex_lock(&audit_filter_mutex);
 
 	for (i = 0; i < AUDIT_NR_FILTERS; i++) {
 		list_for_each_entry_safe(entry, n, &audit_filter_list[i], list) {
 			if (!audit_rule_has_selinux(&entry->rule))
 				continue;
 
-			nentry = audit_dupe_rule(&entry->rule);
+			watch = entry->rule.watch;
+			nentry = audit_dupe_rule(&entry->rule, watch);
 			if (unlikely(IS_ERR(nentry))) {
 				/* save the first error encountered for the
 				 * return value */
 				if (!err)
 					err = PTR_ERR(nentry);
 				audit_panic("error updating selinux filters");
+				if (watch)
+					list_del(&entry->rule.rlist);
 				list_del_rcu(&entry->list);
 			} else {
+				if (watch) {
+					list_add(&nentry->rule.rlist,
+						 &watch->rules);
+					list_del(&entry->rule.rlist);
+				}
 				list_replace_rcu(&entry->list, &nentry->list);
 			}
 			call_rcu(&entry->rcu, audit_free_rule_rcu);
 		}
 	}
 
-	mutex_unlock(&audit_netlink_mutex);
+	mutex_unlock(&audit_filter_mutex);
 
 	return err;
 }
+
+/* Update watch data in audit rules based on inotify events. */
+void audit_handle_ievent(struct inotify_watch *i_watch, u32 wd, u32 mask,
+			 u32 cookie, const char *dname, struct inode *inode)
+{
+	struct audit_parent *parent;
+
+	parent = container_of(i_watch, struct audit_parent, wdata);
+
+	if (mask & (IN_CREATE|IN_MOVED_TO) && inode)
+		audit_update_watch(parent, dname, inode->i_sb->s_dev,
+				   inode->i_ino, 0);
+	else if (mask & (IN_DELETE|IN_MOVED_FROM))
+		audit_update_watch(parent, dname, (dev_t)-1, (unsigned long)-1, 1);
+	/* inotify automatically removes the watch and sends IN_IGNORED */
+	else if (mask & (IN_DELETE_SELF|IN_UNMOUNT))
+		audit_remove_parent_watches(parent);
+	/* inotify does not remove the watch, so remove it manually */
+	else if(mask & IN_MOVE_SELF) {
+		audit_remove_parent_watches(parent);
+		inotify_remove_watch_locked(audit_ih, i_watch);
+	} else if (mask & IN_IGNORED)
+		put_inotify_watch(i_watch);
+}
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index c7ddb71..4858bdd 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -200,12 +200,13 @@ #if AUDIT_DEBUG
 #endif
 };
 
-
+/* Determine if any context name data matches a rule's watch data */
 /* Compare a task_struct with an audit_rule.  Return 1 on match, 0
  * otherwise. */
 static int audit_filter_rules(struct task_struct *tsk,
 			      struct audit_krule *rule,
 			      struct audit_context *ctx,
+			      struct audit_names *name,
 			      enum audit_state *state)
 {
 	int i, j, need_sid = 1;
@@ -268,7 +269,10 @@ static int audit_filter_rules(struct tas
 			}
 			break;
 		case AUDIT_DEVMAJOR:
-			if (ctx) {
+			if (name)
+				result = audit_comparator(MAJOR(name->dev),
+							  f->op, f->val);
+			else if (ctx) {
 				for (j = 0; j < ctx->name_count; j++) {
 					if (audit_comparator(MAJOR(ctx->names[j].dev),	f->op, f->val)) {
 						++result;
@@ -278,7 +282,10 @@ static int audit_filter_rules(struct tas
 			}
 			break;
 		case AUDIT_DEVMINOR:
-			if (ctx) {
+			if (name)
+				result = audit_comparator(MINOR(name->dev),
+							  f->op, f->val);
+			else if (ctx) {
 				for (j = 0; j < ctx->name_count; j++) {
 					if (audit_comparator(MINOR(ctx->names[j].dev), f->op, f->val)) {
 						++result;
@@ -288,7 +295,10 @@ static int audit_filter_rules(struct tas
 			}
 			break;
 		case AUDIT_INODE:
-			if (ctx) {
+			if (name)
+				result = (name->ino == f->val ||
+					  name->pino == f->val);
+			else if (ctx) {
 				for (j = 0; j < ctx->name_count; j++) {
 					if (audit_comparator(ctx->names[j].ino, f->op, f->val) ||
 					    audit_comparator(ctx->names[j].pino, f->op, f->val)) {
@@ -298,6 +308,12 @@ static int audit_filter_rules(struct tas
 				}
 			}
 			break;
+		case AUDIT_WATCH:
+			if (name && rule->watch->ino != (unsigned long)-1)
+				result = (name->dev == rule->watch->dev &&
+					  (name->ino == rule->watch->ino ||
+					   name->pino == rule->watch->ino));
+			break;
 		case AUDIT_LOGINUID:
 			result = 0;
 			if (ctx)
@@ -354,7 +370,7 @@ static enum audit_state audit_filter_tas
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(e, &audit_filter_list[AUDIT_FILTER_TASK], list) {
-		if (audit_filter_rules(tsk, &e->rule, NULL, &state)) {
+		if (audit_filter_rules(tsk, &e->rule, NULL, NULL, &state)) {
 			rcu_read_unlock();
 			return state;
 		}
@@ -384,8 +400,9 @@ static enum audit_state audit_filter_sys
 		int bit  = AUDIT_BIT(ctx->major);
 
 		list_for_each_entry_rcu(e, list, list) {
-			if ((e->rule.mask[word] & bit) == bit
-					&& audit_filter_rules(tsk, &e->rule, ctx, &state)) {
+			if ((e->rule.mask[word] & bit) == bit &&
+			    audit_filter_rules(tsk, &e->rule, ctx, NULL,
+					       &state)) {
 				rcu_read_unlock();
 				return state;
 			}
@@ -395,6 +412,49 @@ static enum audit_state audit_filter_sys
 	return AUDIT_BUILD_CONTEXT;
 }
 
+/* At syscall exit time, this filter is called if any audit_names[] have been
+ * collected during syscall processing.  We only check rules in sublists at hash
+ * buckets applicable to the inode numbers in audit_names[].
+ * Regarding audit_state, same rules apply as for audit_filter_syscall().
+ */
+enum audit_state audit_filter_inodes(struct task_struct *tsk,
+				     struct audit_context *ctx)
+{
+	int i;
+	struct audit_entry *e;
+	enum audit_state state;
+
+	if (audit_pid && tsk->tgid == audit_pid)
+		return AUDIT_DISABLED;
+
+	rcu_read_lock();
+	for (i = 0; i < ctx->name_count; i++) {
+		int word = AUDIT_WORD(ctx->major);
+		int bit  = AUDIT_BIT(ctx->major);
+		struct audit_names *n = &ctx->names[i];
+		int h = audit_hash_ino((u32)n->ino);
+		struct list_head *list = &audit_inode_hash[h];
+
+		if (list_empty(list))
+			continue;
+
+		list_for_each_entry_rcu(e, list, list) {
+			if ((e->rule.mask[word] & bit) == bit &&
+			    audit_filter_rules(tsk, &e->rule, ctx, n, &state)) {
+				rcu_read_unlock();
+				return state;
+			}
+		}
+	}
+	rcu_read_unlock();
+	return AUDIT_BUILD_CONTEXT;
+}
+
+void audit_set_auditable(struct audit_context *ctx)
+{
+	ctx->auditable = 1;
+}
+
 static inline struct audit_context *audit_get_context(struct task_struct *tsk,
 						      int return_valid,
 						      int return_code)
@@ -408,11 +468,20 @@ static inline struct audit_context *audi
 
 	if (context->in_syscall && !context->auditable) {
 		enum audit_state state;
+
 		state = audit_filter_syscall(tsk, context, &audit_filter_list[AUDIT_FILTER_EXIT]);
+		if (state == AUDIT_RECORD_CONTEXT) {
+			context->auditable = 1;
+			goto get_context;
+		}
+
+		state = audit_filter_inodes(tsk, context);
 		if (state == AUDIT_RECORD_CONTEXT)
 			context->auditable = 1;
+
 	}
 
+get_context:
 	context->pid = tsk->pid;
 	context->ppid = sys_getppid();	/* sic.  tsk == current in all cases */
 	context->uid = tsk->uid;
@@ -1142,37 +1211,20 @@ void __audit_inode_child(const char *dna
 		return;
 
 	/* determine matching parent */
-	if (dname)
-		for (idx = 0; idx < context->name_count; idx++)
-			if (context->names[idx].pino == pino) {
-				const char *n;
-				const char *name = context->names[idx].name;
-				int dlen = strlen(dname);
-				int nlen = name ? strlen(name) : 0;
-
-				if (nlen < dlen)
-					continue;
-				
-				/* disregard trailing slashes */
-				n = name + nlen - 1;
-				while ((*n == '/') && (n > name))
-					n--;
-
-				/* find last path component */
-				n = n - dlen + 1;
-				if (n < name)
-					continue;
-				else if (n > name) {
-					if (*--n != '/')
-						continue;
-					else
-						n++;
-				}
+	if (!dname)
+		goto no_match;
+	for (idx = 0; idx < context->name_count; idx++)
+		if (context->names[idx].pino == pino) {
+			const char *name = context->names[idx].name;
 
-				if (strncmp(n, dname, dlen) == 0)
-					goto update_context;
-			}
+			if (!name)
+				continue;
+
+			if (audit_compare_dname_path(dname, name) == 0)
+				goto update_context;
+		}
 
+no_match:
 	/* catch-all in case match not found */
 	idx = context->name_count++;
 	context->names[idx].name  = NULL;
