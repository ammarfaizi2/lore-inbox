Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbVIOI65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbVIOI65 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 04:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbVIOI65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 04:58:57 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:5248 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932258AbVIOI65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 04:58:57 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 15 Sep 2005 09:58:47 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Bas Vermeulen <bvermeul@blackstar.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc1 - kernel BUG at fs/ntfs/aops.c:403
In-Reply-To: <1126769362.5358.3.camel@laptop.blackstar.nl>
Message-ID: <Pine.LNX.4.60.0509150954290.29921@hermes-1.csi.cam.ac.uk>
References: <1126769362.5358.3.camel@laptop.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Sep 2005, Bas Vermeulen wrote:
> I get a kernel BUG when mounting my (dirty) NTFS volume.
> 
> Sep 12 18:54:47 laptop kernel: [4294708.961000] NTFS volume version 3.1.
> Sep 12 18:54:47 laptop kernel: [4294708.961000] NTFS-fs error (device
> sda2): load_system_files(): Volume is dirty.  Mounting read-only.  Run
> chkdsk and mount in Windows.
> Sep 12 18:54:47 laptop kernel: [4294709.063000] ------------[ cut
> here ]------------
> Sep 12 18:54:47 laptop kernel: [4294709.063000] kernel BUG at
> fs/ntfs/aops.c:403!

Ouch.  )-:  Could you do two things for me so I can figure out what is 
going on?

1) Apply this patch to fs/ntfs/aops.c:

--- aops.c.old	2005-09-15 09:51:30.000000000 +0100
+++ aops.c	2005-09-15 09:53:53.000000000 +0100
@@ -400,6 +400,10 @@ retry_readpage:
 		}
 		/* Compressed data streams are handled in compress.c. */
 		if (NInoNonResident(ni) && NInoCompressed(ni)) {
+			ntfs_error(ni->vol->sb, "Eeek!  i_ino = 0x%lx, "
+					"type = 0x%x, name_len = 0x%x.",
+					VFS_I(ni)->i_ino, ni->type,
+					ni->name_len);
 			BUG_ON(ni->type != AT_DATA);
 			BUG_ON(ni->name_len);
 			return ntfs_read_compressed_block(page);

2) Enable ntfs debugging in the kernel configuration.

Recompile the ntfs module (or the kernel if ntfs is built in).

Then load the new module (if not built in).

Then enable debug output (as root do):

	echo 1 > /proc/sys/fs/ntfs-debug

Now do the mount and send me the resulting dmesg output.  That should 
hopefully enable me to fix it.

Thanks!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
