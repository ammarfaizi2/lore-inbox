Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314072AbSDVHEB>; Mon, 22 Apr 2002 03:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314074AbSDVHEA>; Mon, 22 Apr 2002 03:04:00 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:32780 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S314072AbSDVHD7>;
	Mon, 22 Apr 2002 03:03:59 -0400
Date: Mon, 22 Apr 2002 16:02:42 +0900 (JST)
Message-Id: <20020422.160242.21920993.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: [PATCH][BUG] nfsd may deadlock (linux-2.5.8)
From: Hirokazu Takahashi <taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I fixed a nfsd bug.
KNFSDs will deadlock in nfsd_symlink() as they try to grab i_sem doubly,
though the i_sem is already grabbed by fh_lock().


Thank you,
Hirokazu Takahashi.

--- linux/fs/nfsd/vfs.c.ORG	Sat Apr 20 09:09:30 2002
+++ linux/fs/nfsd/vfs.c	Mon Apr 22 06:08:51 2002
@@ -1127,9 +1135,7 @@
 				iap->ia_valid |= ATTR_CTIME;
 				iap->ia_mode = (iap->ia_mode&S_IALLUGO)
 					| S_IFLNK;
-				down(&dentry->d_inode->i_sem);
 				err = notify_change(dnew, iap);
-				up(&dentry->d_inode->i_sem);
 				if (!err && EX_ISSYNC(fhp->fh_export))
 					write_inode_now(dentry->d_inode, 1);
 		       }
