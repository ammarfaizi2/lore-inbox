Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265482AbUGCAWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265482AbUGCAWi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 20:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUGCAWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 20:22:38 -0400
Received: from av5-1-sn4.m-sp.skanova.net ([81.228.10.112]:58820 "EHLO
	av5-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S265482AbUGCAWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 20:22:33 -0400
Date: Sat, 3 Jul 2004 02:22:24 +0200 (CEST)
From: Peter Osterlund <petero2@telia.com>
X-X-Sender: petero@best.localdomain
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DVD+RW support for 2.6.7-bk13
In-Reply-To: <20040702162028.28765ce1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0407030216490.2799@telia.com>
References: <m2hdsr6du0.fsf@telia.com> <20040701161620.GA2939@animx.eu.org>
 <m2u0wr4f0v.fsf@telia.com> <20040701232955.GA3682@animx.eu.org>
 <m21xju4fsm.fsf@telia.com> <20040702162028.28765ce1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jul 2004, Andrew Morton wrote:

> It wasn't obvious whether or not I was supposed to apply this, but I
> did.

Yes, I wanted you to apply it, thanks.

> What's it do?

It implements packet writing for DVD+RW and DVD-RW discs. Hopefully this
patch makes it more clear:


Added information about packet writing for DVD+RW and DVD-RW media.

Signed-off-by: Peter Osterlund <petero2@telia.com>

---

 linux-petero/Documentation/cdrom/packet-writing.txt |   66 ++++++++++++++++++++
 1 files changed, 66 insertions(+)

diff -puN Documentation/cdrom/packet-writing.txt~packet-doc-update Documentation/cdrom/packet-writing.txt
--- linux/Documentation/cdrom/packet-writing.txt~packet-doc-update	2004-07-03 01:37:28.573726096 +0200
+++ linux-petero/Documentation/cdrom/packet-writing.txt	2004-07-03 02:15:32.680489088 +0200
@@ -20,3 +20,69 @@ Getting started quick

 - Now you can mount /dev/pktcdvd0 and copy files to it. Enjoy!
 	# mount /dev/pktcdvd0 /cdrom -t udf -o rw,noatime
+
+
+Packet writing for DVD-RW media
+-------------------------------
+
+DVD-RW discs can be written to much like CD-RW discs if they are in
+the so called "restricted overwrite" mode. To put a disc in restricted
+overwrite mode, run:
+
+	# dvd+rw-format /dev/hdc
+
+You can then use the disc the same way you would use a CD-RW disc:
+
+	# pktsetup /dev/pktcdvd0 /dev/hdc
+	# mount /dev/pktcdvd0 /cdrom -t udf -o rw,noatime
+
+
+Packet writing for DVD+RW media
+-------------------------------
+
+According to the DVD+RW specification, a drive supporting DVD+RW discs
+shall implement "true random writes with 2KB granularity", which means
+that it should be possible to put any filesystem with a block size >=
+2KB on such a disc. For example, it should be possible to do:
+
+	# mkudffs /dev/hdc
+	# mount /dev/hdc /cdrom -t udf -o rw,noatime
+
+However, some drives don't follow the specification and expect the
+host to perform aligned writes at 32KB boundaries. Other drives does
+follow the specification, but suffer bad performance problems if the
+writes are not 32KB aligned.
+
+Both problems can be solved by using the pktcdvd driver, which always
+generates aligned writes.
+
+	# pktsetup /dev/pktcdvd0 /dev/hdc
+	# mkudffs /dev/pktcdvd0
+	# mount /dev/pktcdvd0 /cdrom -t udf -o rw,noatime
+
+
+Notes
+-----
+
+- CD-RW media can usually not be overwritten more than about 1000
+  times, so to avoid unnecessary wear on the media, you should always
+  use the noatime mount option.
+
+- Defect management (ie automatic remapping of bad sectors) has not
+  been implemented yet, so you are likely to get at least some
+  filesystem corruption if the disc wears out.
+
+- Since the pktcdvd driver makes the disc appear as a regular block
+  device, you can put any filesystem you like on the disc. For
+  example, run:
+
+	# /sbin/mke2fs /dev/pktcdvd0
+
+  to create an ext2 filesystem on the disc.
+
+
+Links
+-----
+
+See http://fy.chalmers.se/~appro/linux/DVD+RW/ for more information
+about DVD writing.
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
