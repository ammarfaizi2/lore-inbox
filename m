Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268713AbUHTUM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268713AbUHTUM1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 16:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268719AbUHTUM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 16:12:27 -0400
Received: from mail.cs.umn.edu ([128.101.34.202]:42202 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id S268713AbUHTUKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 16:10:39 -0400
Date: Fri, 20 Aug 2004 15:10:32 -0500
From: Dave C Boutcher <sleddog@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: paulus@samba.org, akpm@osdl.org, ipseries-list@redhat.com
Subject: [PATCH] ppc64 mf_proc file position fix
Message-ID: <20040820201032.GA14005@cs.umn.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org, paulus@samba.org,
	akpm@osdl.org, ipseries-list@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, 

arch/ppc64/kernel/mf_proc.c uses a bad interface for moving 
along file position in a proc_write routine.  This quit working
altogether in 2.6.8.  Patch to fix.  And I did a quick scan of the
kernel to see if anyone else was similarly broken...apparantly not :-)

Fixes a broken update of f_pos in a proc file write routine.

Signed off by: Dave Boutcher <sleddog@us.ibm.com>

--- linux-2.6.8.1/arch/ppc64/kernel/mf_proc.c.orig	2004-08-20 10:37:09.000000000 -0500
+++ linux-2.6.8.1/arch/ppc64/kernel/mf_proc.c	2004-08-20 14:16:01.000000000 -0500
@@ -168,22 +168,29 @@
 	return count;			
 }
 
-static int proc_mf_change_vmlinux(struct file *file, const char *buffer,
-		unsigned long count, void *data)
+static ssize_t proc_mf_change_vmlinux(struct file *file, 
+				      const char __user *buf,
+				      size_t count, loff_t *ppos)
 {
+	struct inode * inode = file->f_dentry->d_inode;
+	struct proc_dir_entry * dp = PDE(inode);
 	int rc;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
-	rc = mf_setVmlinuxChunk(buffer, count, file->f_pos, (u64)data);
+	rc = mf_setVmlinuxChunk(buf, count, *ppos, (u64)dp->data);
 	if (rc < 0)
 		return rc;
 
-	file->f_pos += count;
+	*ppos += count;
 
 	return count;			
 }
 
+static struct file_operations proc_vmlinux_operations = {
+	.write		= proc_mf_change_vmlinux,
+};
+
 static int __init mf_proc_init(void)
 {
 	struct proc_dir_entry *mf_proc_root;
@@ -219,20 +226,7 @@
 			return 1;
 		ent->nlink = 1;
 		ent->data = (void *)(long)i;
-#if 0
-		if (i == 3) {
-			/*
-			 * if we had a 'D' vmlinux entry, it would only
-			 * be readable.
-			 */
-			ent->read_proc = proc_mf_dump_vmlinux;
-			ent->write_proc = NULL;
-		} else
-#endif
-		{
-			ent->write_proc = proc_mf_change_vmlinux;
-			ent->read_proc = NULL;
-		}
+		ent->proc_fops = &proc_vmlinux_operations;
 	}
 
 	ent = create_proc_entry("side", S_IFREG|S_IRUSR|S_IWUSR, mf_proc_root);




-- 
Dave Boutcher
