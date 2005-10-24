Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbVJXKtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbVJXKtn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 06:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbVJXKtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 06:49:42 -0400
Received: from mimesweeper.nrpb.org.uk ([194.129.135.162]:9766 "EHLO
	mailgateway.hpa.org.uk") by vger.kernel.org with ESMTP
	id S1750860AbVJXKtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 06:49:42 -0400
Subject: Re: HFSPlus ate my free space!
From: Peter Wainwright <peter.wainwright@hpa-rp.org.uk>
Reply-To: prw@ceiriog1.demon.co.uk
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: HPA RPD
Date: Mon, 24 Oct 2005 11:58:45 +0100
Message-Id: <1130151525.16253.2.camel@desdemona.pd.rpd.hpa.org.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2005 10:49:20.0522 (UTC) FILETIME=[96B05EA0:01C5D888]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi Roman,
>
>I am using hfsplus (journalled) to mount a 10Gb partition on an usb
>attached disk.  I then copy a 3.5Gb file to the partition, then umount,
>and mount again, and then delete it, but the space occupied by the file
>is not freed, and doing that two times in a row ends up filling up the
>space and I get an error that there is no space left.  Here are steps
to
>reproduce:
I have had a similar experience with my (Mac) IPOD.
I am using kernel-2.6.12 from Fedora Core 4 on x86, but it is
just possible that this bug is still around in the latest
development kernels.
fsck_hfs reveals lots of temporary files accumulating in
the hidden directory "\000\000\000HFS+ Private Data".
According to the HFS+ documentation these are files which
are unlinked while in use.  However, there may be a bug in
the Linux hfsplus implementation which causes this to happen
even when the files are not in use. It looks like the
"opencnt" field is never initialized as (I think) it should
be in hfsplus_read_inode.  This means that a file can appear
to be still in use when in fact it has been closed. This patch
seems to fix it for me:

diff -U3 -r linux-2.6.12-old/fs/hfsplus/super.c
linux-2.6.12/fs/hfsplus/super.c
--- linux-2.6.12-old/fs/hfsplus/super.c 2005-06-17 20:48:29.000000000
+0100
+++ linux-2.6.12/fs/hfsplus/super.c     2005-10-23 21:15:24.000000000
+0100
@@ -50,6 +50,7 @@
        init_MUTEX(&HFSPLUS_I(inode).extents_lock);
HFSPLUS_I(inode).flags = 0;
        HFSPLUS_I(inode).flags = 0;        HFSPLUS_I(inode).rsrc_inode =
NULL;
        HFSPLUS_I(inode).rsrc_inode = NULL;+
atomic_set(&HFSPLUS_I(inode).opencnt, 0);
+       atomic_set(&HFSPLUS_I(inode).opencnt, 0);
        if (inode->i_ino >= HFSPLUS_FIRSTUSER_CNID) {
        read_inode:

Caveat: I'm no expert on filesystems (I thought a bit of bug-squishing
would be a learning experience), and this is my first post
to the kernel list, so feel free to flame me gently if this is wrong...
Peter Wainwright




The information contained within this email and any attachments
is confidential and intended solely for the attention and use of
the named addressee(s). It may not be disclosed to any other
person without the express authority of the HPA, the intended
recipient, or both.
If you are not the intended recipient, you must not disclose,
copy, distribute or retain this message or any part of it.
This footnote also confirms that this e-mail has been scanned
for computer viruses, but please re-scan any attachments before
opening or saving them. 

Web site: http://www.hpa.org.uk 
--------------------------------------------
