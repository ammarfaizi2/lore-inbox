Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbUBKL5g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 06:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264291AbUBKL5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 06:57:36 -0500
Received: from mx2.elte.hu ([157.181.151.9]:38276 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264288AbUBKL5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 06:57:23 -0500
Date: Wed, 11 Feb 2004 12:58:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Alexander Viro <viro@math.psu.edu>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: open-scale-2.6.2-A0
Message-ID: <20040211115828.GA13868@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


i've attached an obvious scalability improvement for write()s. We in
essence used a system-global lock for every open(WRITE) - argh!

Compiles & boots fine on x86 SMP.

	Ingo

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="inode-scale-2.6.2-A0"

--- linux/fs/namei.c.orig2	
+++ linux/fs/namei.c	
@@ -238,30 +238,34 @@ int permission(struct inode * inode,int 
  * except for the cases where we don't hold i_writecount yet. Then we need to
  * use {get,deny}_write_access() - these functions check the sign and refuse
  * to do the change if sign is wrong. Exclusion between them is provided by
- * spinlock (arbitration_lock) and I'll rip the second arsehole to the first
- * who will try to move it in struct inode - just leave it here.
+ * the inode->i_lock spinlock.
  */
-static spinlock_t arbitration_lock = SPIN_LOCK_UNLOCKED;
+
 int get_write_access(struct inode * inode)
 {
-	spin_lock(&arbitration_lock);
+	spin_lock(&inode->i_lock);
 	if (atomic_read(&inode->i_writecount) < 0) {
-		spin_unlock(&arbitration_lock);
+		spin_unlock(&inode->i_lock);
 		return -ETXTBSY;
 	}
 	atomic_inc(&inode->i_writecount);
-	spin_unlock(&arbitration_lock);
+	spin_unlock(&inode->i_lock);
+
 	return 0;
 }
+
 int deny_write_access(struct file * file)
 {
-	spin_lock(&arbitration_lock);
-	if (atomic_read(&file->f_dentry->d_inode->i_writecount) > 0) {
-		spin_unlock(&arbitration_lock);
+	struct inode *inode = file->f_dentry->d_inode;
+
+	spin_lock(&inode->i_lock);
+	if (atomic_read(&inode->i_writecount) > 0) {
+		spin_unlock(&inode->i_lock);
 		return -ETXTBSY;
 	}
-	atomic_dec(&file->f_dentry->d_inode->i_writecount);
-	spin_unlock(&arbitration_lock);
+	atomic_dec(&inode->i_writecount);
+	spin_unlock(&inode->i_lock);
+
 	return 0;
 }
 

--pf9I7BMVVzbSWLtt--
