Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272074AbTHHWYn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 18:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272121AbTHHWYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 18:24:43 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:59396 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S272074AbTHHWYH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 18:24:07 -0400
Date: Sat, 9 Aug 2003 00:22:27 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: [PATCH 8/8] 2.6.0-test2-bk8 - seq_file conversion of /proc/net/atm (cleanup)
Message-ID: <20030809002227.I2699@electric-eye.fr.zoreil.com>
References: <20030809000303.A2699@electric-eye.fr.zoreil.com> <20030809000633.B2699@electric-eye.fr.zoreil.com> <20030809000841.C2699@electric-eye.fr.zoreil.com> <20030809001013.D2699@electric-eye.fr.zoreil.com> <20030809001139.E2699@electric-eye.fr.zoreil.com> <20030809001321.F2699@electric-eye.fr.zoreil.com> <20030809001541.G2699@electric-eye.fr.zoreil.com> <20030809001903.H2699@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030809001903.H2699@electric-eye.fr.zoreil.com>; from romieu@fr.zoreil.com on Sat, Aug 09, 2003 at 12:19:03AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- introduction of the struct array 'atm_proc_ents':
  - removal of code duplication in atm_proc_cleanup();
  - removal of code duplication in atm_proc_init();
  - removal of the macros CREATE_SEQ_ENTRY() and CREATE_ENTRY();
- credits at the top of the file.


 net/atm/proc.c |  156 +++++++++++++++++++++------------------------------------
 1 files changed, 58 insertions(+), 98 deletions(-)

diff -puN net/atm/proc.c~atm-proc-seq-post-conversion-removal net/atm/proc.c
--- linux-2.6.0-test2-bk8/net/atm/proc.c~atm-proc-seq-post-conversion-removal	Fri Aug  8 20:29:33 2003
+++ linux-2.6.0-test2-bk8-fr/net/atm/proc.c	Fri Aug  8 20:29:33 2003
@@ -1,21 +1,13 @@
-/* net/atm/proc.c - ATM /proc interface */
-
-/* Written 1995-2000 by Werner Almesberger, EPFL LRC/ICA */
-
-/*
- * The mechanism used here isn't designed for speed but rather for convenience
- * of implementation. We only return one entry per read system call, so we can
- * be reasonably sure not to overrun the page and race conditions may lead to
- * the addition or omission of some lines but never to any corruption of a
- * line's internal structure.
+/* net/atm/proc.c - ATM /proc interface
+ *
+ * Written 1995-2000 by Werner Almesberger, EPFL LRC/ICA
  *
- * Making the whole thing slightly more efficient is left as an exercise to the
- * reader. (Suggestions: wrapper which loops to get several entries per system
- * call; or make --left slightly more clever to avoid O(n^2) characteristics.)
- * I find it fast enough on my unloaded 266 MHz Pentium 2 :-)
+ * seq_file api usage by romieu@fr.zoreil.com
+ *
+ * Evaluating the efficiency of the whole thing if left as an exercise to
+ * the reader.
  */
 
-
 #include <linux/config.h>
 #include <linux/module.h> /* for EXPORT_SYMBOL */
 #include <linux/string.h>
@@ -52,19 +44,12 @@
 
 static ssize_t proc_dev_atm_read(struct file *file,char *buf,size_t count,
     loff_t *pos);
-static ssize_t proc_spec_atm_read(struct file *file,char *buf,size_t count,
-    loff_t *pos);
 
 static struct file_operations proc_dev_atm_operations = {
 	.owner =	THIS_MODULE,
 	.read =		proc_dev_atm_read,
 };
 
-static struct file_operations proc_spec_atm_operations = {
-	.owner =	THIS_MODULE,
-	.read =		proc_spec_atm_read,
-};
-
 static void add_stats(struct seq_file *seq, const char *aal,
   const struct k_atm_aal_stats *stats)
 {
@@ -927,33 +912,9 @@ static ssize_t proc_dev_atm_read(struct 
 	return length;
 }
 
-
-static ssize_t proc_spec_atm_read(struct file *file,char *buf,size_t count,
-    loff_t *pos)
-{
-	unsigned long page;
-	int length;
-	int (*info)(loff_t,char *);
-	info = PDE(file->f_dentry->d_inode)->data;
-
-	if (count == 0) return 0;
-	page = get_zeroed_page(GFP_KERNEL);
-	if (!page) return -ENOMEM;
-	length = (*info)(*pos,(char *) page);
-	if (length > count) length = -EINVAL;
-	if (length >= 0) {
-		if (copy_to_user(buf,(char *) page,length)) length = -EFAULT;
-		(*pos)++;
-	}
-	free_page(page);
-	return length;
-}
-
-
 struct proc_dir_entry *atm_proc_root;
 EXPORT_SYMBOL(atm_proc_root);
 
-
 int atm_proc_dev_register(struct atm_dev *dev)
 {
 	int digits,num;
@@ -982,72 +943,71 @@ fail1:
 	return error;
 }
 
-
 void atm_proc_dev_deregister(struct atm_dev *dev)
 {
 	remove_proc_entry(dev->proc_name, atm_proc_root);
 	kfree(dev->proc_name);
 }
 
-#define CREATE_SEQ_ENTRY(name) \
-	do { \
-		name = create_proc_entry(#name, S_IRUGO, atm_proc_root); \
-		if (!name) \
-			goto cleanup; \
-		name->proc_fops = &atm_seq_##name##_fops; \
-		name->owner = THIS_MODULE; \
-	} while (0)
-
-#define CREATE_ENTRY(name) \
-    name = create_proc_entry(#name,0,atm_proc_root); \
-    if (!name) goto cleanup; \
-    name->data = atm_##name##_info; \
-    name->proc_fops = &proc_spec_atm_operations; \
-    name->owner = THIS_MODULE
-
-static struct proc_dir_entry *devices = NULL, *pvc = NULL,
-		*svc = NULL, *arp = NULL, *lec = NULL, *vc = NULL;
-
-static void atm_proc_cleanup(void)
-{
-	if (devices)
-		remove_proc_entry("devices",atm_proc_root);
-	if (pvc)
-		remove_proc_entry("pvc",atm_proc_root);
-	if (svc)
-		remove_proc_entry("svc",atm_proc_root);
-	if (arp)
-		remove_proc_entry("arp",atm_proc_root);
-	if (lec)
-		remove_proc_entry("lec",atm_proc_root);
-	if (vc)
-		remove_proc_entry("vc",atm_proc_root);
-	remove_proc_entry("net/atm",NULL);
+static struct atm_proc_entry {
+	char *name;
+	struct file_operations *proc_fops;
+	struct proc_dir_entry *dirent;
+} atm_proc_ents[] = {
+	{ .name = "devices",	.proc_fops = &atm_seq_devices_fops },
+	{ .name = "pvc",	.proc_fops = &atm_seq_pvc_fops },
+	{ .name = "svc",	.proc_fops = &atm_seq_svc_fops },
+	{ .name = "vc",		.proc_fops = &atm_seq_vc_fops },
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
+	{ .name = "arp",	.proc_fops = &atm_seq_arp_fops },
+#endif
+#if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
+	{ .name = "lec",	.proc_fops = &atm_seq_lec_fops },
+#endif
+	{ .name = NULL,		.proc_fops = NULL }
+};
+
+static void atm_proc_dirs_remove(void)
+{
+	static struct atm_proc_entry *e;
+
+	for (e = atm_proc_ents; e->name; e++) {
+		if (e->dirent) 
+			remove_proc_entry(e->name, atm_proc_root);
+	}
+	remove_proc_entry("net/atm", NULL);
 }
 
 int __init atm_proc_init(void)
 {
+	static struct atm_proc_entry *e;
+	int ret;
+
 	atm_proc_root = proc_mkdir("net/atm",NULL);
 	if (!atm_proc_root)
-		return -ENOMEM;
-	CREATE_SEQ_ENTRY(devices);
-	CREATE_SEQ_ENTRY(pvc);
-	CREATE_SEQ_ENTRY(svc);
-	CREATE_SEQ_ENTRY(vc);
-#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
-	CREATE_SEQ_ENTRY(arp);
-#endif
-#if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
-	CREATE_SEQ_ENTRY(lec);
-#endif
-	return 0;
+		goto err_out;
+	for (e = atm_proc_ents; e->name; e++) {
+		struct proc_dir_entry *dirent;
+
+		dirent = create_proc_entry(e->name, S_IRUGO, atm_proc_root);
+		if (!dirent)
+			goto err_out_remove;
+		dirent->proc_fops = e->proc_fops;
+		dirent->owner = THIS_MODULE;
+		e->dirent = dirent;
+	}
+	ret = 0;
+out:
+	return ret;
 
-cleanup:
-	atm_proc_cleanup();
-	return -ENOMEM;
+err_out_remove:
+	atm_proc_dirs_remove();
+err_out:
+	ret = -ENOMEM;
+	goto out;
 }
 
-void atm_proc_exit(void)
+void __exit atm_proc_exit(void)
 {
-	atm_proc_cleanup();
+	atm_proc_dirs_remove();
 }

_
