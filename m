Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263138AbUEGRP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263138AbUEGRP4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 13:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUEGRP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 13:15:56 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:49101 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263138AbUEGRPy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 13:15:54 -0400
Subject: Re: kernel BUG at fs/ext3/balloc.c:942!
From: Mingming Cao <cmm@us.ibm.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405051729140.2284@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0405051729140.2284@montezuma.fsmlabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 May 2004 10:23:20 -0700
Message-Id: <1083950602.15980.18416.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-05 at 14:31, Zwane Mwaikambo wrote:
> Shout at me if you need something else, right now i need to reboot my
> workstation.

Thanks for working this problem with us.  

The problem is that the reservation window is being discard too early in
ext3_release_file(). ext3_release_file() calls
ext3_discard_resercation() on the last file_close().  It is possible for
two process who open same file for write, while one process discarded a
reservation window when it is the last one closed it's own filp,  while
another process is in the middle of using that reservation window for
block allocation on that inode.

We should really discard the reservation window on the last writer on
the inode, instead of the last writer on the filp.

Here is the patch to fix this issue.

This should fix a reservation window race between multiple processes when one process closed the file while another one is in the middle of block allocation using the inode's reservation window. reservation window should be discard on the last writer on the inode, not the last writer on the filp. 


---

 src-ming/fs/ext3/file.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN fs/ext3/file.c~ext3_reservation_discard_race_fix fs/ext3/file.c
--- src/fs/ext3/file.c~ext3_reservation_discard_race_fix	2004-05-06 22:46:44.338842592 -0700
+++ src-ming/fs/ext3/file.c	2004-05-07 00:48:58.059947520 -0700
@@ -33,7 +33,8 @@
  */
 static int ext3_release_file (struct inode * inode, struct file * filp)
 {
-	if (filp->f_mode & FMODE_WRITE)
+	/* if we are the last writer on the inode, drop the block reservation */
+	if (filp->f_mode & FMODE_WRITE && (atomic_read(&inode->i_writecount) == 1))
 		ext3_discard_reservation(inode);
 	if (is_dx(inode) && filp->private_data)
 		ext3_htree_free_dir_info(filp->private_data);

_

