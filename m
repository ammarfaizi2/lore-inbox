Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbVLUSft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbVLUSft (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 13:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbVLUSft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 13:35:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23768 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964790AbVLUSfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 13:35:48 -0500
Date: Wed, 21 Dec 2005 10:35:19 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] handle module ref count on sysctl tables.
Message-ID: <20051221103520.258ced08@dxpl.pdx.osdl.net>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right now there is a hole in the module ref counting system because
there is no proper ref counting for sysctl tables used by modules.
This means that if an application is holding /proc/sys/foo open and
module that created it is unloaded, then the application touches the
file the kernel will oops.

This patch fixes that by maintaining source compatibility via macro.
I am sure someone already thought of this, it just doesn't appear to
have made it in yet.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

--- net-2.6.16.orig/include/linux/sysctl.h
+++ net-2.6.16/include/linux/sysctl.h
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/module.h>
 
 struct file;
 struct completion;
@@ -973,9 +974,13 @@ struct ctl_table_header
 	struct completion *unregistering;
 };
 
-struct ctl_table_header * register_sysctl_table(ctl_table * table, 
-						int insert_at_head);
-void unregister_sysctl_table(struct ctl_table_header * table);
+extern struct ctl_table_header *__register_sysctl_table(ctl_table * table,
+							struct module *owner,
+							int insert_at_head);
+#define register_sysctl_table(table, insert_at_head) \
+	__register_sysctl_table(table, THIS_MODULE, insert_at_head)
+
+extern void unregister_sysctl_table(struct ctl_table_header * table);
 
 #else /* __KERNEL__ */
 
--- net-2.6.16.orig/kernel/sysctl.c
+++ net-2.6.16/kernel/sysctl.c
@@ -169,7 +169,8 @@ struct file_operations proc_sys_file_ope
 
 extern struct proc_dir_entry *proc_sys_root;
 
-static void register_proc_table(ctl_table *, struct proc_dir_entry *, void *);
+static void register_proc_table(ctl_table *, struct proc_dir_entry *, void *,
+				struct module *);
 static void unregister_proc_table(ctl_table *, struct proc_dir_entry *);
 #endif
 
@@ -1036,7 +1037,7 @@ static void start_unregistering(struct c
 void __init sysctl_init(void)
 {
 #ifdef CONFIG_PROC_FS
-	register_proc_table(root_table, proc_sys_root, &root_table_header);
+	register_proc_table(root_table, proc_sys_root, &root_table_header, NULL);
 	init_irq_proc();
 #endif
 }
@@ -1279,8 +1280,9 @@ int do_sysctl_strategy (ctl_table *table
  * This routine returns %NULL on a failure to register, and a pointer
  * to the table header on success.
  */
-struct ctl_table_header *register_sysctl_table(ctl_table * table, 
-					       int insert_at_head)
+struct ctl_table_header *__register_sysctl_table(ctl_table * table,
+						 struct module *owner,
+						 int insert_at_head)
 {
 	struct ctl_table_header *tmp;
 	tmp = kmalloc(sizeof(struct ctl_table_header), GFP_KERNEL);
@@ -1297,7 +1299,7 @@ struct ctl_table_header *register_sysctl
 		list_add_tail(&tmp->ctl_entry, &root_table_header.ctl_entry);
 	spin_unlock(&sysctl_lock);
 #ifdef CONFIG_PROC_FS
-	register_proc_table(table, proc_sys_root, tmp);
+	register_proc_table(table, proc_sys_root, tmp, owner);
 #endif
 	return tmp;
 }
@@ -1328,7 +1330,8 @@ void unregister_sysctl_table(struct ctl_
 #ifdef CONFIG_PROC_FS
 
 /* Scan the sysctl entries in table and add them all into /proc */
-static void register_proc_table(ctl_table * table, struct proc_dir_entry *root, void *set)
+static void register_proc_table(ctl_table * table, struct proc_dir_entry *root,
+				void *set, struct module *owner)
 {
 	struct proc_dir_entry *de;
 	int len;
@@ -1366,12 +1369,13 @@ static void register_proc_table(ctl_tabl
 				continue;
 			de->set = set;
 			de->data = (void *) table;
+			de->owner = owner;
 			if (table->proc_handler)
 				de->proc_fops = &proc_sys_file_operations;
 		}
 		table->de = de;
 		if (de->mode & S_IFDIR)
-			register_proc_table(table->child, de, set);
+			register_proc_table(table->child, de, set, owner);
 	}
 }
 
@@ -2414,8 +2418,9 @@ int proc_doulongvec_ms_jiffies_minmax(ct
     return -ENOSYS;
 }
 
-struct ctl_table_header * register_sysctl_table(ctl_table * table, 
-						int insert_at_head)
+struct ctl_table_header * __register_sysctl_table(ctl_table * table,
+						  struct module *owner,
+						  int insert_at_head)
 {
 	return NULL;
 }
@@ -2438,7 +2443,7 @@ EXPORT_SYMBOL(proc_dointvec_ms_jiffies);
 EXPORT_SYMBOL(proc_dostring);
 EXPORT_SYMBOL(proc_doulongvec_minmax);
 EXPORT_SYMBOL(proc_doulongvec_ms_jiffies_minmax);
-EXPORT_SYMBOL(register_sysctl_table);
+EXPORT_SYMBOL(__register_sysctl_table);
 EXPORT_SYMBOL(sysctl_intvec);
 EXPORT_SYMBOL(sysctl_jiffies);
 EXPORT_SYMBOL(sysctl_ms_jiffies);
