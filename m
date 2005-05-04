Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVEDSpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVEDSpg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 14:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVEDSpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 14:45:36 -0400
Received: from verein.lst.de ([213.95.11.210]:23787 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261352AbVEDSon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 14:44:43 -0400
Date: Wed, 4 May 2005 20:44:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: paulus@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] move /proc/ppc_htab creating self-contained in arch/ppc/ code
Message-ID: <20050504184439.GA20671@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

additional benefit is cleaning up the ifdef mess in ppc_htab.c


Signed-off-by: Christoph Hellwig <hch@lst.de>


Index: arch/ppc/kernel/ppc_htab.c
===================================================================
--- b023d524fb0a3b71aa0b957ce7c5540611497370/arch/ppc/kernel/ppc_htab.c  (mode:100644 sha1:ca810025993f3a9ab882fb46722cd46543b6e85e)
+++ uncommitted/arch/ppc/kernel/ppc_htab.c  (mode:100644)
@@ -32,9 +32,6 @@
 #include <asm/system.h>
 #include <asm/reg.h>
 
-static int ppc_htab_show(struct seq_file *m, void *v);
-static ssize_t ppc_htab_write(struct file * file, const char __user * buffer,
-			      size_t count, loff_t *ppos);
 extern PTE *Hash, *Hash_end;
 extern unsigned long Hash_size, Hash_mask;
 extern unsigned long _SDR1;
@@ -46,19 +43,7 @@
 extern unsigned int primary_pteg_full;
 extern unsigned int htab_hash_searches;
 
-static int ppc_htab_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ppc_htab_show, NULL);
-}
-
-struct file_operations ppc_htab_operations = {
-	.open		= ppc_htab_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.write		= ppc_htab_write,
-	.release	= single_release,
-};
-
+#ifdef CONFIG_PROC_FS
 static char *pmc1_lookup(unsigned long mmcr0)
 {
 	switch ( mmcr0 & (0x7f<<7) )
@@ -132,6 +117,16 @@
 		return 0;
 	}
 
+	seq_printf(m, "PTE Hash Table Information\n"
+		      "Size\t\t: %luKb\n"
+		      "Buckets\t\t: %lu\n"
+ 		      "Address\t\t: %08lx\n"
+		      "Entries\t\t: %lu\n",
+                      (unsigned long)(Hash_size>>10),
+		      (Hash_size/(sizeof(PTE)*8)),
+		      (unsigned long)Hash,
+		      Hash_size/sizeof(PTE));
+
 #ifndef CONFIG_PPC64BRIDGE
 	for (ptr = Hash; ptr < Hash_end; ptr++) {
 		unsigned int mctx, vsid;
@@ -146,32 +141,16 @@
 		else
 			uptes++;
 	}
-#endif
 
-	seq_printf(m,
-		      "PTE Hash Table Information\n"
-		      "Size\t\t: %luKb\n"
-		      "Buckets\t\t: %lu\n"
- 		      "Address\t\t: %08lx\n"
-		      "Entries\t\t: %lu\n"
-#ifndef CONFIG_PPC64BRIDGE
-		      "User ptes\t: %u\n"
+	seq_printf(m, "User ptes\t: %u\n"
 		      "Kernel ptes\t: %u\n"
-		      "Percent full\t: %lu%%\n"
-#endif
-                      , (unsigned long)(Hash_size>>10),
-		      (Hash_size/(sizeof(PTE)*8)),
-		      (unsigned long)Hash,
-		      Hash_size/sizeof(PTE)
-#ifndef CONFIG_PPC64BRIDGE
-                      , uptes,
+		      "Percent full\t: %lu%%\n",
+		      uptes,
 		      kptes,
-		      ((kptes+uptes)*100) / (Hash_size/sizeof(PTE))
+		      ((kptes+uptes)*100) / (Hash_size/sizeof(PTE)));
 #endif
-		);
 
-	seq_printf(m,
-		      "Reloads\t\t: %lu\n"
+	seq_printf(m, "Reloads\t\t: %lu\n"
 		      "Preloads\t: %lu\n"
 		      "Searches\t: %u\n"
 		      "Overflows\t: %u\n"
@@ -180,20 +159,19 @@
 		      primary_pteg_full, htab_evicts);
 #endif /* CONFIG_PPC_STD_MMU */
 
-	seq_printf(m,
-		      "Non-error misses: %lu\n"
+	seq_printf(m, "Non-error misses: %lu\n"
 		      "Error misses\t: %lu\n",
 		      pte_misses, pte_errors);
 	return 0;
 }
 
+#ifdef CONFIG_PPC_STD_MMU
 /*
  * Allow user to define performance counters and resize the hash table
  */
 static ssize_t ppc_htab_write(struct file * file, const char __user * ubuffer,
 			      size_t count, loff_t *ppos)
 {
-#ifdef CONFIG_PPC_STD_MMU
 	unsigned long tmp;
 	char buffer[16];
 
@@ -312,12 +290,43 @@
 	}
 
 	return count;
+}
 #else /* CONFIG_PPC_STD_MMU */
+static ssize_t ppc_htab_write(struct file * file, const char __user * ubuffer,
+			      size_t count, loff_t *ppos)
+{
 	return 0;
+}
 #endif /* CONFIG_PPC_STD_MMU */
+
+static int ppc_htab_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ppc_htab_show, NULL);
 }
 
-int proc_dol2crvec(ctl_table *table, int write, struct file *filp,
+static struct file_operations ppc_htab_operations = {
+	.open		= ppc_htab_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.write		= ppc_htab_write,
+	.release	= single_release,
+};
+
+static int __init ppc_htab_proc_init(void)
+{
+	struct proc_dir_entry *entry;
+
+	entry = create_proc_entry("ppc_htab", S_IRUGO|S_IWUSR, NULL);
+	if (entry)
+		entry->proc_fops = &ppc_htab_operations;
+
+	return 0;
+}
+__initcall(ppc_htab_proc_init);
+#endif
+
+#ifdef CONFIG_SYSCTL
+static int proc_dol2crvec(ctl_table *table, int write, struct file *filp,
 		  void __user *buffer_arg, size_t *lenp, loff_t *ppos)
 {
 	int vleft, first=1, len, left, val;
@@ -437,7 +446,6 @@
 	return 0;
 }
 
-#ifdef CONFIG_SYSCTL
 /*
  * Register our sysctl.
  */
Index: fs/proc/proc_misc.c
===================================================================
--- b023d524fb0a3b71aa0b957ce7c5540611497370/fs/proc/proc_misc.c  (mode:100644 sha1:a60a3b3d8a7b1c31870dee3d947fe119a5787a5d)
+++ uncommitted/fs/proc/proc_misc.c  (mode:100644)
@@ -609,12 +609,4 @@
 	if (entry)
 		entry->proc_fops = &proc_sysrq_trigger_operations;
 #endif
-#ifdef CONFIG_PPC32
-	{
-		extern struct file_operations ppc_htab_operations;
-		entry = create_proc_entry("ppc_htab", S_IRUGO|S_IWUSR, NULL);
-		if (entry)
-			entry->proc_fops = &ppc_htab_operations;
-	}
-#endif
 }
