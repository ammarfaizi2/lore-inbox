Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270820AbTGVNFZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 09:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270815AbTGVNFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 09:05:25 -0400
Received: from web41504.mail.yahoo.com ([66.218.93.87]:4724 "HELO
	web41504.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270820AbTGVNFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 09:05:16 -0400
Message-ID: <20030722132019.42790.qmail@web41504.mail.yahoo.com>
Date: Tue, 22 Jul 2003 06:20:19 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: Re: 2.6: marking individual directories as synchronous? 
To: linux-kernel@vger.kernel.org
Cc: dbehman@hotmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grepping around in 2.6.0-test1 src I found:

include/linux/fs.h:
105 #define MS_DIRSYNC 128 /* Directory modifications are synchronous */
138 #define S_DIRSYNC  128 /* Directory modifications are synchronous */

Therefore, study the definitions and uses of those flags as well as
IS_DIRSYNC(), EXT3_DIRSYNC_FL, ext3_ioctl() & ext3_set_inode_flags().

For example:
[linux-2.6.0-test1]$ cscope -d -L -3 IS_DIRSYNC
...
fs/ext2/dir.c     ext2_commit_chunk  71    if  (IS_DIRSYNC(dir))
fs/ext3/ialloc.c  ext3_new_inode     585   if  (IS_DIRSYNC(inode))
fs/ext3/namei.c   ext3_create        1638  if  (IS_DIRSYNC(dir))
fs/ext3/namei.c   ext3_mknod         1665  if  (IS_DIRSYNC(dir))
fs/ext3/namei.c   ext3_mkdir         1697  if  (IS_DIRSYNC(dir))
fs/ext3/namei.c   ext3_rmdir         1981  if  (IS_DIRSYNC(dir))
fs/ext3/namei.c   ext3_unlink        2033  if  (IS_DIRSYNC(dir))
fs/ext3/namei.c   ext3_symlink       2089  if  (IS_DIRSYNC(dir))
fs/ext3/namei.c   ext3_link          2139  if  (IS_DIRSYNC(dir))
fs/minix/dir.c    dir_commit_chunk   53    if  (IS_DIRSYNC(dir))
fs/sysv/dir.c     dir_commit_chunk   46    if  (IS_DIRSYNC(dir))
fs/ufs/dir.c      ufs_set_link       359   if  (IS_DIRSYNC(dir))
fs/ufs/dir.c      ufs_add_link       458   if  (IS_DIRSYNC(dir))
fs/ufs/dir.c      ufs_delete_entry   507   if  (IS_DIRSYNC(inode))
...

I haven't actually played with the application of this, but it would appear
to be some combination of ioctl's and/or mount flags.  Check the source for
chattr(1) to see if and how it uses the ioctl.
