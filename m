Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVALSTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVALSTm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 13:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVALSTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 13:19:42 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:40199 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261259AbVALSTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 13:19:25 -0500
Date: Wed, 12 Jan 2005 19:19:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Sipos Ferenc <sferi@mail.tvnet.hu>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.6.11-rc1 compile error
Message-ID: <20050112181915.GL29578@stusta.de>
References: <1105514348.11506.1.camel@zeus.city.tvnet.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105514348.11506.1.camel@zeus.city.tvnet.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 08:19:08AM +0100, Sipos Ferenc wrote:

> Hi!
> 
> Compilling the above produces the following error:
> 
> net/built-in.o(.text+0x19c94): In function `tcf_ipt_init':
> : undefined reference to `__ipt_find_target_lock'
> net/built-in.o(.text+0x19ca4): In function `tcf_ipt_init':
> : undefined reference to `__ipt_mutex_up'
> make: *** [.tmp_vmlinux1] Error 1
> 
> Kernel config attached.

Known bug, fix below.

> Feri

cu
Adrian


<--  snip  -->


From: Rusty Russell <rusty@rustcorp.com.au>

Thomas Graf points out that I broke net/sched/ipt.c when I removed
__ipt_find_target_lock.  In fact, those routines don't need to keep the
lock held, so we can simplify them, and expose an interface
(ipt_find_target) which does module loading correctly for net/sched/ipt.c.

As Thomas points out, this also gets the module refcounts right.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/linux/netfilter_ipv4/ip_tables.h |    3 +
 25-akpm/net/ipv4/netfilter/ip_tables.c           |   63 +++++++++++------------
 25-akpm/net/sched/ipt.c                          |   20 ++-----
 3 files changed, 42 insertions(+), 44 deletions(-)

diff -puN include/linux/netfilter_ipv4/ip_tables.h~restore-net-sched-iptc-after-iptables-kmod-cleanup include/linux/netfilter_ipv4/ip_tables.h
--- 25/include/linux/netfilter_ipv4/ip_tables.h~restore-net-sched-iptc-after-iptables-kmod-cleanup	2005-01-05 20:52:10.241670944 -0800
+++ 25-akpm/include/linux/netfilter_ipv4/ip_tables.h	2005-01-05 20:52:10.251669424 -0800
@@ -456,6 +456,9 @@ struct ipt_table
 	struct module *me;
 };
 
+/* net/sched/ipt.c: Gimme access to your targets!  Gets target->me. */
+extern struct ipt_target *ipt_find_target(const char *name, u8 revision);
+
 extern int ipt_register_table(struct ipt_table *table);
 extern void ipt_unregister_table(struct ipt_table *table);
 extern unsigned int ipt_do_table(struct sk_buff **pskb,
diff -puN net/ipv4/netfilter/ip_tables.c~restore-net-sched-iptc-after-iptables-kmod-cleanup net/ipv4/netfilter/ip_tables.c
--- 25/net/ipv4/netfilter/ip_tables.c~restore-net-sched-iptc-after-iptables-kmod-cleanup	2005-01-05 20:52:10.243670640 -0800
+++ 25-akpm/net/ipv4/netfilter/ip_tables.c	2005-01-05 20:52:10.250669576 -0800
@@ -430,62 +430,63 @@ static inline struct ipt_table *find_tab
 	return NULL;
 }
 
-/* Find match, grabs mutex & ref.  Returns ERR_PTR() on error. */
-static inline struct ipt_match *find_match_lock(const char *name, u8 revision)
+/* Find match, grabs ref.  Returns ERR_PTR() on error. */
+static inline struct ipt_match *find_match(const char *name, u8 revision)
 {
 	struct ipt_match *m;
-	int found = 0;
+	int err = 0;
 
 	if (down_interruptible(&ipt_mutex) != 0)
 		return ERR_PTR(-EINTR);
 
 	list_for_each_entry(m, &ipt_match, list) {
 		if (strcmp(m->name, name) == 0) {
-			found = 1;
 			if (m->revision == revision) {
-				if (!try_module_get(m->me))
-					found = 0;
-				else
+				if (try_module_get(m->me)) {
+					up(&ipt_mutex);
 					return m;
-			}
+				}
+			} else
+				err = -EPROTOTYPE; /* Found something. */
 		}
 	}
 	up(&ipt_mutex);
-
-	/* Not found at all?  NULL so try_then_request_module loads module. */
-	if (!found)
-		return NULL;
-
-	return ERR_PTR(-EPROTOTYPE);
+	return ERR_PTR(err);
 }
 
-/* Find target, grabs mutex & ref.  Returns ERR_PTR() on error. */
-static inline struct ipt_target *find_target_lock(const char *name, u8 revision)
+/* Find target, grabs ref.  Returns ERR_PTR() on error. */
+static inline struct ipt_target *find_target(const char *name, u8 revision)
 {
 	struct ipt_target *t;
-	int found = 0;
+	int err = 0;
 
 	if (down_interruptible(&ipt_mutex) != 0)
 		return ERR_PTR(-EINTR);
 
 	list_for_each_entry(t, &ipt_target, list) {
 		if (strcmp(t->name, name) == 0) {
-			found = 1;
 			if (t->revision == revision) {
-				if (!try_module_get(t->me))
-					found = 0;
-				else
+				if (try_module_get(t->me)) {
+					up(&ipt_mutex);
 					return t;
-			}
+				}
+			} else
+				err = -EPROTOTYPE; /* Found something. */
 		}
 	}
 	up(&ipt_mutex);
+	return ERR_PTR(err);
+}
 
-	/* Not found at all?  NULL so try_then_request_module loads module. */
-	if (!found)
-		return NULL;
+struct ipt_target *ipt_find_target(const char *name, u8 revision)
+{
+	struct ipt_target *target;
 
-	return ERR_PTR(-EPROTOTYPE);
+	target = try_then_request_module(find_target(name, revision),
+					 "ipt_%s", name);
+	if (IS_ERR(target) || !target)
+		return NULL;
+	return target;
 }
 
 static int match_revfn(const char *name, u8 revision, int *bestp)
@@ -708,15 +709,14 @@ check_match(struct ipt_entry_match *m,
 {
 	struct ipt_match *match;
 
-	match = try_then_request_module(find_match_lock(m->u.user.name,
-							m->u.user.revision),
+	match = try_then_request_module(find_match(m->u.user.name,
+						   m->u.user.revision),
 					"ipt_%s", m->u.user.name);
 	if (IS_ERR(match) || !match) {
 		duprintf("check_match: `%s' not found\n", m->u.user.name);
 		return match ? PTR_ERR(match) : -ENOENT;
 	}
 	m->u.kernel.match = match;
-	up(&ipt_mutex);
 
 	if (m->u.kernel.match->checkentry
 	    && !m->u.kernel.match->checkentry(name, ip, m->data,
@@ -754,8 +754,8 @@ check_entry(struct ipt_entry *e, const c
 		goto cleanup_matches;
 
 	t = ipt_get_target(e);
-	target = try_then_request_module(find_target_lock(t->u.user.name,
-							  t->u.user.revision),
+	target = try_then_request_module(find_target(t->u.user.name,
+						     t->u.user.revision),
 					 "ipt_%s", t->u.user.name);
 	if (IS_ERR(target) || !target) {
 		duprintf("check_entry: `%s' not found\n", t->u.user.name);
@@ -763,7 +763,6 @@ check_entry(struct ipt_entry *e, const c
 		goto cleanup_matches;
 	}
 	t->u.kernel.target = target;
-	up(&ipt_mutex);
 
 	if (t->u.kernel.target == &ipt_standard_target) {
 		if (!standard_check(t, size)) {
diff -puN net/sched/ipt.c~restore-net-sched-iptc-after-iptables-kmod-cleanup net/sched/ipt.c
--- 25/net/sched/ipt.c~restore-net-sched-iptc-after-iptables-kmod-cleanup	2005-01-05 20:52:10.244670488 -0800
+++ 25-akpm/net/sched/ipt.c	2005-01-05 20:52:10.250669576 -0800
@@ -31,6 +31,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
+#include <linux/kmod.h>
 #include <net/sock.h>
 #include <net/pkt_sched.h>
 #include <linux/tc_act/tc_ipt.h>
@@ -60,32 +61,23 @@ init_targ(struct tcf_ipt *p)
 	struct ipt_target *target;
 	int ret = 0;
 	struct ipt_entry_target *t = p->t;
-	target = __ipt_find_target_lock(t->u.user.name, &ret);
 
+	target = ipt_find_target(t->u.user.name, t->u.user.revision);
 	if (!target) {
 		printk("init_targ: Failed to find %s\n", t->u.user.name);
 		return -1;
 	}
 
 	DPRINTK("init_targ: found %s\n", target->name);
-	/* we really need proper ref counting
-	 seems to be only needed for modules?? Talk to laforge */
-/*      if (target->me)
-              __MOD_INC_USE_COUNT(target->me);
-*/
 	t->u.kernel.target = target;
 
-	__ipt_mutex_up();
-
 	if (t->u.kernel.target->checkentry
 	    && !t->u.kernel.target->checkentry(p->tname, NULL, t->data,
 					       t->u.target_size
 					       - sizeof (*t), p->hook)) {
-/*              if (t->u.kernel.target->me)
-	      __MOD_DEC_USE_COUNT(t->u.kernel.target->me);
-*/
 		DPRINTK("ip_tables: check failed for `%s'.\n",
 			t->u.kernel.target->name);
+		module_put(t->u.kernel.target->me);
 		ret = -EINVAL;
 	}
 
@@ -235,8 +227,12 @@ tcf_ipt_cleanup(struct tc_action *a, int
 {
 	struct tcf_ipt *p;
 	p = PRIV(a,ipt);
-	if (NULL != p)
+	if (NULL != p) {
+		struct ipt_entry_target *t = p->t;
+		if (t && t->u.kernel.target)
+			module_put(t->u.kernel.target->me);
 		return tcf_hash_release(p, bind);
+	}
 	return 0;
 }
 
_
