Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbVLOUar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbVLOUar (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 15:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbVLOUaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 15:30:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:65497 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751043AbVLOUaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 15:30:46 -0500
Date: Thu, 15 Dec 2005 12:22:42 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Re: Linux 2.6.13.5
Message-ID: <20051215202242.GB18213@kroah.com>
References: <20051215202204.GA18213@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215202204.GA18213@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 5ce2147..004ecc4 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 13
-EXTRAVERSION = .4
+EXTRAVERSION = .5
 NAME=Woozy Numbat
 
 # *DOCUMENTATION*
diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index c9f2f60..dee6ab5 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -592,12 +592,15 @@ int appldata_register_ops(struct appldat
  */
 void appldata_unregister_ops(struct appldata_ops *ops)
 {
+	void *table;
 	spin_lock(&appldata_ops_lock);
-	unregister_sysctl_table(ops->sysctl_header);
 	list_del(&ops->list);
-	kfree(ops->ctl_table);
+	/* at that point any incoming access will fail */
+	table = ops->ctl_table;
 	ops->ctl_table = NULL;
 	spin_unlock(&appldata_ops_lock);
+	unregister_sysctl_table(ops->sysctl_header);
+	kfree(table);
 	P_INFO("%s-ops unregistered!\n", ops->name);
 }
 /********************** module-ops management <END> **************************/
diff --git a/arch/sparc64/kernel/irq.c b/arch/sparc64/kernel/irq.c
index c9b6916..233526b 100644
--- a/arch/sparc64/kernel/irq.c
+++ b/arch/sparc64/kernel/irq.c
@@ -27,6 +27,7 @@
 #include <asm/atomic.h>
 #include <asm/system.h>
 #include <asm/irq.h>
+#include <asm/io.h>
 #include <asm/sbus.h>
 #include <asm/iommu.h>
 #include <asm/upa.h>
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 0563581..a7b0329 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -66,6 +66,7 @@ struct proc_dir_entry {
 	write_proc_t *write_proc;
 	atomic_t count;		/* use count */
 	int deleted;		/* delete flag */
+	void *set;
 };
 
 struct kcore_list {
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index e82be96..3144ee5 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -24,6 +24,7 @@
 #include <linux/compiler.h>
 
 struct file;
+struct completion;
 
 #define CTL_MAXNAME 10		/* how many path components do we allow in a
 				   call to sysctl?   In other words, what is
@@ -894,6 +895,8 @@ struct ctl_table_header
 {
 	ctl_table *ctl_table;
 	struct list_head ctl_entry;
+	int used;
+	struct completion *unregistering;
 };
 
 struct ctl_table_header * register_sysctl_table(ctl_table * table, 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 3e0bbee..a78ec8a 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -171,7 +171,7 @@ struct file_operations proc_sys_file_ope
 
 extern struct proc_dir_entry *proc_sys_root;
 
-static void register_proc_table(ctl_table *, struct proc_dir_entry *);
+static void register_proc_table(ctl_table *, struct proc_dir_entry *, void *);
 static void unregister_proc_table(ctl_table *, struct proc_dir_entry *);
 #endif
 
@@ -994,10 +994,51 @@ static ctl_table dev_table[] = {
 
 extern void init_irq_proc (void);
 
+static DEFINE_SPINLOCK(sysctl_lock);
+
+/* called under sysctl_lock */
+static int use_table(struct ctl_table_header *p)
+{
+	if (unlikely(p->unregistering))
+		return 0;
+	p->used++;
+	return 1;
+}
+
+/* called under sysctl_lock */
+static void unuse_table(struct ctl_table_header *p)
+{
+	if (!--p->used)
+		if (unlikely(p->unregistering))
+			complete(p->unregistering);
+}
+
+/* called under sysctl_lock, will reacquire if has to wait */
+static void start_unregistering(struct ctl_table_header *p)
+{
+	/*
+	 * if p->used is 0, nobody will ever touch that entry again;
+	 * we'll eliminate all paths to it before dropping sysctl_lock
+	 */
+	if (unlikely(p->used)) {
+		struct completion wait;
+		init_completion(&wait);
+		p->unregistering = &wait;
+		spin_unlock(&sysctl_lock);
+		wait_for_completion(&wait);
+		spin_lock(&sysctl_lock);
+	}
+	/*
+	 * do not remove from the list until nobody holds it; walking the
+	 * list in do_sysctl() relies on that.
+	 */
+	list_del_init(&p->ctl_entry);
+}
+
 void __init sysctl_init(void)
 {
 #ifdef CONFIG_PROC_FS
-	register_proc_table(root_table, proc_sys_root);
+	register_proc_table(root_table, proc_sys_root, &root_table_header);
 	init_irq_proc();
 #endif
 }
@@ -1006,6 +1047,7 @@ int do_sysctl(int __user *name, int nlen
 	       void __user *newval, size_t newlen)
 {
 	struct list_head *tmp;
+	int error = -ENOTDIR;
 
 	if (nlen <= 0 || nlen >= CTL_MAXNAME)
 		return -ENOTDIR;
@@ -1014,20 +1056,30 @@ int do_sysctl(int __user *name, int nlen
 		if (!oldlenp || get_user(old_len, oldlenp))
 			return -EFAULT;
 	}
+	spin_lock(&sysctl_lock);
 	tmp = &root_table_header.ctl_entry;
 	do {
 		struct ctl_table_header *head =
 			list_entry(tmp, struct ctl_table_header, ctl_entry);
 		void *context = NULL;
-		int error = parse_table(name, nlen, oldval, oldlenp, 
+
+		if (!use_table(head))
+			continue;
+
+		spin_unlock(&sysctl_lock);
+
+		error = parse_table(name, nlen, oldval, oldlenp,
 					newval, newlen, head->ctl_table,
 					&context);
 		kfree(context);
+
+		spin_lock(&sysctl_lock);
+		unuse_table(head);
 		if (error != -ENOTDIR)
-			return error;
-		tmp = tmp->next;
-	} while (tmp != &root_table_header.ctl_entry);
-	return -ENOTDIR;
+			break;
+	} while ((tmp = tmp->next) != &root_table_header.ctl_entry);
+	spin_unlock(&sysctl_lock);
+	return error;
 }
 
 asmlinkage long sys_sysctl(struct __sysctl_args __user *args)
@@ -1238,12 +1290,16 @@ struct ctl_table_header *register_sysctl
 		return NULL;
 	tmp->ctl_table = table;
 	INIT_LIST_HEAD(&tmp->ctl_entry);
+	tmp->used = 0;
+	tmp->unregistering = NULL;
+	spin_lock(&sysctl_lock);
 	if (insert_at_head)
 		list_add(&tmp->ctl_entry, &root_table_header.ctl_entry);
 	else
 		list_add_tail(&tmp->ctl_entry, &root_table_header.ctl_entry);
+	spin_unlock(&sysctl_lock);
 #ifdef CONFIG_PROC_FS
-	register_proc_table(table, proc_sys_root);
+	register_proc_table(table, proc_sys_root, tmp);
 #endif
 	return tmp;
 }
@@ -1257,10 +1313,13 @@ struct ctl_table_header *register_sysctl
  */
 void unregister_sysctl_table(struct ctl_table_header * header)
 {
-	list_del(&header->ctl_entry);
+	might_sleep();
+	spin_lock(&sysctl_lock);
+	start_unregistering(header);
 #ifdef CONFIG_PROC_FS
 	unregister_proc_table(header->ctl_table, proc_sys_root);
 #endif
+	spin_unlock(&sysctl_lock);
 	kfree(header);
 }
 
@@ -1271,7 +1330,7 @@ void unregister_sysctl_table(struct ctl_
 #ifdef CONFIG_PROC_FS
 
 /* Scan the sysctl entries in table and add them all into /proc */
-static void register_proc_table(ctl_table * table, struct proc_dir_entry *root)
+static void register_proc_table(ctl_table * table, struct proc_dir_entry *root, void *set)
 {
 	struct proc_dir_entry *de;
 	int len;
@@ -1307,13 +1366,14 @@ static void register_proc_table(ctl_tabl
 			de = create_proc_entry(table->procname, mode, root);
 			if (!de)
 				continue;
+			de->set = set;
 			de->data = (void *) table;
 			if (table->proc_handler)
 				de->proc_fops = &proc_sys_file_operations;
 		}
 		table->de = de;
 		if (de->mode & S_IFDIR)
-			register_proc_table(table->child, de);
+			register_proc_table(table->child, de, set);
 	}
 }
 
@@ -1338,6 +1398,13 @@ static void unregister_proc_table(ctl_ta
 				continue;
 		}
 
+		/*
+		 * In any case, mark the entry as goner; we'll keep it
+		 * around if it's busy, but we'll know to do nothing with
+		 * its fields.  We are under sysctl_lock here.
+		 */
+		de->data = NULL;
+
 		/* Don't unregister proc entries that are still being used.. */
 		if (atomic_read(&de->count))
 			continue;
@@ -1351,27 +1418,38 @@ static ssize_t do_rw_proc(int write, str
 			  size_t count, loff_t *ppos)
 {
 	int op;
-	struct proc_dir_entry *de;
+	struct proc_dir_entry *de = PDE(file->f_dentry->d_inode);
 	struct ctl_table *table;
 	size_t res;
-	ssize_t error;
-	
-	de = PDE(file->f_dentry->d_inode);
-	if (!de || !de->data)
-		return -ENOTDIR;
-	table = (struct ctl_table *) de->data;
-	if (!table || !table->proc_handler)
-		return -ENOTDIR;
-	op = (write ? 002 : 004);
-	if (ctl_perm(table, op))
-		return -EPERM;
+	ssize_t error = -ENOTDIR;
 	
-	res = count;
-
-	error = (*table->proc_handler) (table, write, file, buf, &res, ppos);
-	if (error)
-		return error;
-	return res;
+	spin_lock(&sysctl_lock);
+	if (de && de->data && use_table(de->set)) {
+		/*
+		 * at that point we know that sysctl was not unregistered
+		 * and won't be until we finish
+		 */
+		spin_unlock(&sysctl_lock);
+		table = (struct ctl_table *) de->data;
+		if (!table || !table->proc_handler)
+			goto out;
+		error = -EPERM;
+		op = (write ? 002 : 004);
+		if (ctl_perm(table, op))
+			goto out;
+
+		/* careful: calling conventions are nasty here */
+		res = count;
+		error = (*table->proc_handler)(table, write, file,
+						buf, &res, ppos);
+		if (!error)
+			error = res;
+	out:
+		spin_lock(&sysctl_lock);
+		unuse_table(de->set);
+	}
+	spin_unlock(&sysctl_lock);
+	return error;
 }
 
 static int proc_opensys(struct inode *inode, struct file *file)
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 91bb895..defcf6a 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -79,7 +79,6 @@ static void destroy_nbp(struct net_bridg
 {
 	struct net_device *dev = p->dev;
 
-	dev->br_port = NULL;
 	p->br = NULL;
 	p->dev = NULL;
 	dev_put(dev);
@@ -100,6 +99,7 @@ static void del_nbp(struct net_bridge_po
 	struct net_bridge *br = p->br;
 	struct net_device *dev = p->dev;
 
+	dev->br_port = NULL;
 	dev_set_promiscuity(dev, -1);
 
 	spin_lock_bh(&br->lock);
