Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbTL1Pab (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 10:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbTL1Pab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 10:30:31 -0500
Received: from faraday.dhtns.com ([64.246.11.56]:13290 "EHLO faraday.dhtns.com")
	by vger.kernel.org with ESMTP id S261563AbTL1Pa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 10:30:29 -0500
Date: Sun, 28 Dec 2003 10:30:28 -0500
From: lkml@dhtns.com
To: linux-kernel@vger.kernel.org
Cc: lkml@dhtns.com
Subject: JFS resize=0 problem in 2.6.0
Message-ID: <20031228153028.GB22247@faraday.dhtns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let me know if I'm missing the goal of the code here, but lines 261-273
of linux-2.6.0/fs/jfs/super.c are:

case Opt_resize:
{
	char *resize = args[0].from;
	if (!resize || !*resize) {    /* LINE 264 HERE */
		*newLVSize = sb->s_bdev->bd_inode->i_size >>
			sb->s_blocksize_bits;
		if (*newLVSize == 0)
			printk(KERN_ERR
			"JFS: Cannot determine volume size\n");
	} else
		*newLVSize = simple_strtoull(resize, &resize, 0);
	break;
}

It seems to me that line 264 is attempting to test for the mount 
paramater "resize=0", and when it comes across this, resize to the full
size of the volume.  However, this doesn't work.  I believe it should
test for the char '0'  (*resize=='0'), not against literal zero.  

Let me know if I'm way off base here.  But the below patch does allow a
$ mount -o remount,resize=0 /mnt/test    
to resize the jfs filesystem to the full size of the volume.


Ok, I've never submitted a patch before, but here goes:



--- linux-2.6.0/fs/jfs/super.c  2003-12-28 10:16:00.000000000 -0500
+++ linux/fs/jfs/super.c        2003-12-28 10:15:34.000000000 -0500
@@ -261,7 +261,7 @@
		case Opt_resize:
		{
			char *resize = args[0].from;
-			if (!resize || !*resize) {
+			if (!resize || !*resize || *resize=='0') {
				*newLVSize = sb->s_bdev->bd_inode->i_size >>
					sb->s_blocksize_bits;
				if (*newLVSize == 0)



-Elliott Bennett
lkml@dhtns.com
