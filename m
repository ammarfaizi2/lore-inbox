Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbTEAUiY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 16:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbTEAUiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 16:38:24 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:59407 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id S262451AbTEAUiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 16:38:19 -0400
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200305012052.VAA19274@gw.chygwyn.com>
Subject: Re: Remains of seq_file conversion for DECnet, plus fixes
To: davem@redhat.com (David S. Miller)
Date: Thu, 1 May 2003 21:52:01 +0100 (BST)
Cc: linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20030501.060909.26990580.davem@redhat.com> from "David S. Miller" at May 01, 2003 06:09:09 AM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've split the patch into three. Any further splitting/changes will have to
wait until next week when I'll have time to work on it again.

 - Part 1. Things outside DECnet
 - Part 2. seq_file & fixes for DECnet depending on part 1
 - Part 3. Addition of the DECnet routing grabulator (does not depend on other
   patches)

Below is part 1 with the following features:

  o Introduce kfree_release() in seq_file.c for use of DECnet and eventually
    IP as well (and other things...?)
  o Added proc_net_fops_create() like proc_net_create() but with file_operations    argument to use with seq_file code (cleans up some #ifdefs). If there are
    no objections, I'll send a patch for IPv4/6 shortly.

Steve.


--------------------------------------------------------------------------
diff -Nru linux-2.5.68-bk10/fs/seq_file.c linux/fs/seq_file.c
--- linux-2.5.68-bk10/fs/seq_file.c	Sun Apr 20 03:27:58 2003
+++ linux/fs/seq_file.c	Mon Apr 21 14:40:35 2003
@@ -338,3 +338,13 @@
 	kfree(op);
 	return res;
 }
+
+int kfree_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq = file->private_data;
+
+	kfree(seq->private);
+	seq->private = NULL;
+	return seq_release(inode, file);
+}
+
diff -Nru linux-2.5.68-bk10/include/linux/proc_fs.h linux/include/linux/proc_fs.h
--- linux-2.5.68-bk10/include/linux/proc_fs.h	Wed Jan  1 19:20:49 2003
+++ linux/include/linux/proc_fs.h	Tue Apr 22 01:32:43 2003
@@ -163,6 +163,15 @@
 	return create_proc_info_entry(name,mode,proc_net,get_info);
 }
 
+static inline struct proc_dir_entry *proc_net_fops_create(const char *name,
+	mode_t mode, struct file_operations *fops)
+{
+	struct proc_dir_entry *res = create_proc_entry(name, mode, proc_net);
+	if (res)
+		res->proc_fops = fops;
+	return res;
+}
+
 static inline void proc_net_remove(const char *name)
 {
 	remove_proc_entry(name,proc_net);
@@ -171,7 +180,7 @@
 #else
 
 #define proc_root_driver NULL
-
+#define proc_net_fops_create(name,mode,fops) do {} while(0)
 static inline struct proc_dir_entry *proc_net_create(const char *name, mode_t mode, 
 	get_info_t *get_info) {return NULL;}
 static inline void proc_net_remove(const char *name) {}
diff -Nru linux-2.5.68-bk10/include/linux/seq_file.h linux/include/linux/seq_file.h
--- linux-2.5.68-bk10/include/linux/seq_file.h	Wed Jan  1 19:23:19 2003
+++ linux/include/linux/seq_file.h	Mon Apr 21 14:41:12 2003
@@ -60,5 +60,6 @@
 
 int single_open(struct file *, int (*)(struct seq_file *, void *), void *);
 int single_release(struct inode *, struct file *);
+int kfree_release(struct inode *, struct file *);
 #endif
 #endif
diff -Nru linux-2.5.68-bk10/kernel/ksyms.c linux/kernel/ksyms.c
--- linux-2.5.68-bk10/kernel/ksyms.c	Thu May  1 03:00:23 2003
+++ linux/kernel/ksyms.c	Thu May  1 03:00:48 2003
@@ -539,6 +539,7 @@
 EXPORT_SYMBOL(seq_lseek);
 EXPORT_SYMBOL(single_open);
 EXPORT_SYMBOL(single_release);
+EXPORT_SYMBOL(kfree_release);
 
 /* Program loader interfaces */
 #ifdef CONFIG_MMU
