Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268486AbTB1XQU>; Fri, 28 Feb 2003 18:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268487AbTB1XQU>; Fri, 28 Feb 2003 18:16:20 -0500
Received: from vena.lwn.net ([206.168.112.25]:50354 "HELO eklektix.com")
	by vger.kernel.org with SMTP id <S268486AbTB1XQP>;
	Fri, 28 Feb 2003 18:16:15 -0500
Message-ID: <20030228232636.16566.qmail@eklektix.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] restore /proc/ksyms
cc: rusty@rustcorp.com.au
From: Jonathan Corbet <corbet@lwn.net>
Date: Fri, 28 Feb 2003 16:26:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (against 2.5.63) puts /proc/ksyms back on the map, with a format
almost like what used to be there.  It's a quick hack, but should ought to
be good enough.

Of course, this is somebody's cue to tell me that /proc/ksyms is useless
bloat, or some such.  I've occasionally found it useful, though.  Here it
is in case anybody else agrees.

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net


diff -urN -X dontdiff 2.5.63-vanilla/fs/proc/proc_misc.c 2.5.63/fs/proc/proc_misc.c
--- 2.5.63-vanilla/fs/proc/proc_misc.c	Fri Feb 28 11:35:58 2003
+++ 2.5.63/fs/proc/proc_misc.c	Fri Feb 28 13:58:58 2003
@@ -299,6 +299,18 @@
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
+
+extern struct seq_operations ksyms_op;
+static int ksyms_open(struct inode *inode, struct file *file)
+{
+        return seq_open(file, &ksyms_op);
+}
+static struct file_operations proc_ksyms_operations = {
+    	.open		= ksyms_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
 #endif
 
 extern struct seq_operations slabinfo_op;
@@ -582,6 +594,7 @@
 	create_seq_entry("vmstat",S_IRUGO, &proc_vmstat_file_operations);
 #ifdef CONFIG_MODULES
 	create_seq_entry("modules", 0, &proc_modules_operations);
+	create_seq_entry("ksyms", 0, &proc_ksyms_operations);
 #endif
 	proc_root_kcore = create_proc_entry("kcore", S_IRUSR, NULL);
 	if (proc_root_kcore) {
diff -urN -X dontdiff 2.5.63-vanilla/kernel/module.c 2.5.63/kernel/module.c
--- 2.5.63-vanilla/kernel/module.c	Tue Feb 18 16:02:18 2003
+++ 2.5.63/kernel/module.c	Fri Feb 28 17:13:07 2003
@@ -1588,6 +1588,93 @@
 	.show	= m_show
 };
 
+/*
+ * /proc/ksyms.
+ */
+
+struct ksym_position {
+    struct kernel_symbol_group *group;
+    int offset;
+};
+
+static void *m_ks_start(struct seq_file *s, loff_t *pos)
+{
+    	struct ksym_position *kp = kmalloc(sizeof (*pos), GFP_KERNEL);
+	struct kernel_symbol_group *ks;
+	loff_t n = 0;
+
+	/*
+	 * As far as I can tell, we need *both* module_mutex and modlist_lock here.
+	 * A pass through seq_file is currently atomic, so it should be safe to
+	 * hold the lock until m_ks_stop.  Since stop always gets called, we
+	 * always hold the mutex and lock when we return.
+	 */
+	down(&module_mutex);
+	spin_lock_irq(&modlist_lock);
+	
+	if (kp == NULL)
+	    	return NULL;
+	list_for_each_entry(ks, &symbols, list) {
+	    	if ((n + ks->num_syms) > *pos) {
+		    	kp->group = ks;
+			kp->offset = *pos - n;
+			return kp;
+		}
+		n += ks->num_syms;
+	}
+	return NULL;
+}
+
+static void *m_ks_next(struct seq_file *s, void *p, loff_t *pos)
+{
+    	struct ksym_position *kp = (struct ksym_position *) p;
+    
+	(*pos)++;
+	if (++(kp->offset) < kp->group->num_syms)
+	    	return kp;
+	/* Silently skip zero-entry groups */
+	while (kp->group->list.next != &symbols) {
+		kp->group = list_entry(kp->group->list.next,
+				struct kernel_symbol_group, list);
+		if (kp->group->num_syms > 0) {
+			kp->offset = 0;
+			return kp;
+		}
+	}
+	return NULL;
+}
+
+static void m_ks_stop(struct seq_file *s, void *p)
+{
+	spin_unlock_irq(&modlist_lock);
+	up(&module_mutex);
+	if (p)
+	    kfree(p);
+}
+
+static int m_ks_show(struct seq_file *s, void *p)
+{
+    	struct ksym_position *kp = (struct ksym_position *) p;
+	const struct kernel_symbol *sym = kp->group->syms + kp->offset;
+
+	seq_printf(s, "%08lx %-25s", sym->value, sym->name);
+	if (kp->group->owner)
+		seq_printf(s, " [%s]", kp->group->owner->name);
+	if (kp->group->gplonly)
+		seq_printf(s, " [GPLONLY]");
+	seq_printf(s, "\n");
+	return 0;
+}
+
+struct seq_operations ksyms_op = {
+    .start = m_ks_start,
+    .next  = m_ks_next,
+    .stop  = m_ks_stop,
+    .show  = m_ks_show
+};
+
+
+
 /* Given an address, look for it in the module exception tables. */
 const struct exception_table_entry *search_module_extables(unsigned long addr)
 {
