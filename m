Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263239AbTFDNe4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 09:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbTFDNe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 09:34:56 -0400
Received: from ns.suse.de ([213.95.15.193]:55820 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263239AbTFDNez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 09:34:55 -0400
Date: Wed, 4 Jun 2003 15:48:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: shmctl(SHM_LOCK/UNLOCK) deadlock
Message-ID: <20030604134828.GZ3412@x30.school.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch fixes an SMP deadlock that triggered in some production
usage:

--- xxx/mm/shmem.c.~1~	2003-06-01 19:14:07.000000000 +0200
+++ xxx/mm/shmem.c	2003-06-04 02:17:23.000000000 +0200
@@ -808,9 +808,9 @@ void shmem_lock(struct file * file, int 
 	struct inode * inode = file->f_dentry->d_inode;
 	struct shmem_inode_info * info = SHMEM_I(inode);
 
-	down(&info->sem);
+	spin_lock(&info->lock);
 	info->locked = lock;
-	up(&info->sem);
+	spin_unlock(&info->lock);
 }
 
 int shmem_make_bigpage_mmap(struct file * file, struct vm_area_struct * vma)

you can merge it in 21-final IMHO (even dropping the lock enterely would
been ok, the reader is out of order anyways and that's atomic stuff in C
no matter the architecture)

Andrea
