Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbTEDSmj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 14:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbTEDSmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 14:42:39 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:1285 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id S261570AbTEDSmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 14:42:33 -0400
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200305041843.TAA04564@gw.chygwyn.com>
Subject: Re: Remains of seq_file conversion for DECnet, plus fixes
To: acme@conectiva.com.br (Arnaldo Carvalho de Melo)
Date: Sun, 4 May 2003 19:43:51 +0100 (BST)
Cc: davem@redhat.com (David S. Miller), hch@infradead.org,
       linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20030502015409.GC5356@conectiva.com.br> from "Arnaldo Carvalho de Melo" at May 01, 2003 10:54:10 PM
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

Now that I'm back again, here is the first patch again with kfree_release
renamed as suggested to seq_release_private,

Steve.
-----------------------------------------------------------------------------
diff -Nru linux-2.5.68-bk12/fs/seq_file.c linux/fs/seq_file.c
--- linux-2.5.68-bk12/fs/seq_file.c	Sat Apr 19 19:50:30 2003
+++ linux/fs/seq_file.c	Sun May  4 11:45:16 2003
@@ -338,3 +338,13 @@
 	kfree(op);
 	return res;
 }
+
+int seq_release_private(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq = file->private_data;
+
+	kfree(seq->private);
+	seq->private = NULL;
+	return seq_release(inode, file);
+}
+
diff -Nru linux-2.5.68-bk12/include/linux/proc_fs.h linux/include/linux/proc_fs.h
--- linux-2.5.68-bk12/include/linux/proc_fs.h	Sat Apr 19 19:48:46 2003
+++ linux/include/linux/proc_fs.h	Sun May  4 11:45:16 2003
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
diff -Nru linux-2.5.68-bk12/include/linux/seq_file.h linux/include/linux/seq_file.h
--- linux-2.5.68-bk12/include/linux/seq_file.h	Sat Apr 19 19:51:18 2003
+++ linux/include/linux/seq_file.h	Sun May  4 11:45:16 2003
@@ -60,5 +60,6 @@
 
 int single_open(struct file *, int (*)(struct seq_file *, void *), void *);
 int single_release(struct inode *, struct file *);
+int seq_release_private(struct inode *, struct file *);
 #endif
 #endif
diff -Nru linux-2.5.68-bk12/kernel/ksyms.c linux/kernel/ksyms.c
--- linux-2.5.68-bk12/kernel/ksyms.c	Sun May  4 11:37:41 2003
+++ linux/kernel/ksyms.c	Sun May  4 11:45:16 2003
@@ -540,6 +540,7 @@
 EXPORT_SYMBOL(seq_lseek);
 EXPORT_SYMBOL(single_open);
 EXPORT_SYMBOL(single_release);
+EXPORT_SYMBOL(seq_release_private);
 
 /* Program loader interfaces */
 #ifdef CONFIG_MMU
