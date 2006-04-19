Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWDSKuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWDSKuL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 06:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWDSKuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 06:50:11 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:43411 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750759AbWDSKuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 06:50:09 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Wed, 19 Apr 2006 11:50:00 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: A missing i_mutex in rename? (Linux kernel 2.6.latest)
Message-ID: <Pine.LNX.4.64.0604191102260.17373@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al and other fs developers,

Both sys_unlink()/sys_rmdir() and sys_link() all end up taking the i_mutex 
on all parent directories and source/destination inodes before calling 
into the file system inode operations.

sys_rename() OTOH, does not take i_mutex on the old inode.  It only takes 
i_mutex on the two parent directories and on the target inode if it 
exists.

Why is this?  To me it seems that either sys_rename() must take i_mutex on 
the old inode or sys_unlink()/sys_rmdir(), sys_link(), etc do not need to 
hold the i_mutex.

What am I missing?

ps. I verified my reading of the code by inserting a 
mutex_is_locked(old_dent->d_inode) in ->rename in ntfs and it returns 
negative no matter how I invoke the rename (i.e. it does not matter if 
source is a file or directory or whether a target exists, etc).

pps. If indeed sys_rename() is correct in not needing the mutex and 
sys_unlink()/sys_rmdir(), sys_link(), etc are correct in needing the 
mutex, would it be safe if I just take old_dentry->d_inode->i_mutex on 
entry to ntfs_rename()?  I would assume that there is no deadlock risk 
because the parent is already locked, correct?

Thanks a lot in advance!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
