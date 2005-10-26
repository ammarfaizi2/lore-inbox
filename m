Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbVJZHaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbVJZHaI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 03:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbVJZHaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 03:30:08 -0400
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:31165 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932582AbVJZHaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 03:30:07 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Wed, 26 Oct 2005 08:30:04 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, zippel@linux-m68k.org,
       prw@ceiriog1.demon.co.uk
Subject: [2.6-git PATCH] Fix for HFSPlus, should go in before 2.6.14!
Message-ID: <Pine.LNX.4.64.0510260817360.3412@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Roman Zippel the HFS/HFS+ maintainer seems to not be responding to email 
or lkml posts...

I reported a bug with HFS+ which causes deleting files not to free up the 
space they occupy randomly (at least when run on i386).

Peter Wainwright reported he experienced the same problem and he posted a 
fix.  His patch was corrupt so I re-did it against latest git, please find 
it below, together with Peter's explanation of the bug and fix.

Although I have not tested it myself yet (don't have the external hd with 
hfs+ here at work and at the moment it is formated with ntfs anyway), it 
is just a one liner and obviously correct.

Please apply before you release 2.6.14 if at all possible as HFS+ is 
seriously borked without it...  I have now given up waiting for Roman to 
reply given my original mail to him was two weeks ago and you are about 
to release 2.6.14...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

---

[PATCH] Fix HFS+ to free up the space when a file is deleted.

fsck_hfs reveals lots of temporary files accumulating in
the hidden directory "\000\000\000HFS+ Private Data".
According to the HFS+ documentation these are files which
are unlinked while in use.  However, there may be a bug in
the Linux hfsplus implementation which causes this to happen
even when the files are not in use. It looks like the
"opencnt" field is never initialized as (I think) it should
be in hfsplus_read_inode.  This means that a file can appear
to be still in use when in fact it has been closed. This patch
seems to fix it for me.

From: Peter Wainwright <peter.wainwright@hpa-rp.org.uk>
Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index fd0f0f0..452fc1f 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -50,6 +50,7 @@ static void hfsplus_read_inode(struct in
 	init_MUTEX(&HFSPLUS_I(inode).extents_lock);
 	HFSPLUS_I(inode).flags = 0;
 	HFSPLUS_I(inode).rsrc_inode = NULL;
+	atomic_set(&HFSPLUS_I(inode).opencnt, 0);
 
 	if (inode->i_ino >= HFSPLUS_FIRSTUSER_CNID) {
 	read_inode:
