Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbTLJCGQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 21:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbTLJCGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 21:06:16 -0500
Received: from blood.actrix.co.nz ([203.96.16.160]:19840 "EHLO
	blood.actrix.co.nz") by vger.kernel.org with ESMTP id S262558AbTLJCGL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 21:06:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Charles Manning <manningc2@actrix.gen.nz>
Reply-To: manningc2@actrix.gen.nz
To: Pavel Machek <pavel@ucw.cz>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: partially encrypted filesystem
Date: Wed, 10 Dec 2003 15:13:04 +1300
X-Mailer: KMail [version 1.3.1]
Cc: Phillip Lougher <phillip@lougher.demon.co.uk>,
       Matthew Wilcox <willy@debian.org>, Erez Zadok <ezk@cs.sunysb.edu>,
       =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>,
       Kallol Biswas <kbiswas@neoscale.com>, linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20031205191447.GC29469@parcelfarce.linux.theplanet.co.uk> <1070883425.31993.80.camel@hades.cambridge.redhat.com> <20031210000759.GA618@elf.ucw.cz>
In-Reply-To: <20031210000759.GA618@elf.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20031210020607.500755679@blood.actrix.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 December 2003 13:07, Pavel Machek wrote:
>
> > Even if you were going to admit to having a block size of 64KiB to the
> > layers above you, you just can't _do_ atomic replacement of blocks,
> > which is required for normal file systems to operate correctly.
>
> Are those assumptions needed for something else than recovery after
> crash/powerdown? [i.e., afaics 64K ext2 should work on flash, but fsck
> might have some troubles...]

The main reason for this in JFFSx and YAFFS (but particularly JFFSx on NOR) 
is that flash memory cannot be arbitrarily overwritten without an erase and 
an erase takes a long time.

Eg:  NOR flash typically takes around 1 second to erase a block (typically 
64kB in size) and approx 10usec or so per byte/word to program. So to  change 
a single byte in a block in place would typically require something like:
1.  Read into buffer 
2. Erase block [1 second].
3. Reprogram [0.6 seconds]

+ do that all over again for the update to the file info.

On NAND flash, where erase is far faster, the cost is far less. Still in a 
comparison of YAFFS (which uses log structuring for the same reasons as 
JFFS2) and FAT + block driver for NAND, YAFFS could sustain a write speed of 
approx 10 times the FAT + block driver solution on the same hardware.

Then there are issues like wear levelling (because flash has a limited 
lifetime) and bad block handling etc... but performance (and crash recovery) 
are the main issues.

-- Charles


