Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265392AbTLHLiS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 06:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265393AbTLHLiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 06:38:13 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:17818 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265392AbTLHLhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 06:37:20 -0500
Subject: Re: partially encrypted filesystem
From: David Woodhouse <dwmw2@infradead.org>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: Matthew Wilcox <willy@debian.org>, Erez Zadok <ezk@cs.sunysb.edu>,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Kallol Biswas <kbiswas@neoscale.com>, linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
In-Reply-To: <3FD127D4.9030007@lougher.demon.co.uk>
References: <20031205191447.GC29469@parcelfarce.linux.theplanet.co.uk>
	 <200312051947.hB5Jlupp030878@agora.fsl.cs.sunysb.edu>
	 <20031205202838.GD29469@parcelfarce.linux.theplanet.co.uk>
	 <3FD127D4.9030007@lougher.demon.co.uk>
Content-Type: text/plain
Message-Id: <1070883425.31993.80.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.1) 
Date: Mon, 08 Dec 2003 11:37:05 +0000
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: dwmw2@infradead.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-12-06 at 00:50 +0000, Phillip Lougher wrote:
> Of course, all this is at the logical file level, and ignores the 
> physical blocks on disk.  All filesystems assume physical data blocks 
> can be updated in place.  With compression it is possible a new physical 
> block has to be found, especially if blocks are highly packed and not 
> aligned to block boundaries.  I expect this is at least partially why 
> JFFS2 is a log structured filesystem.

Not really. JFFS2 is a log structured file system because it's designed
to work on _flash_, not on block devices. You have an eraseblock size of
typically 64KiB, you can clear bits in that 'block' all you like till
they're all gone or you're bored, then you have to erase it back to all
0xFF again and start over.

Even if you were going to admit to having a block size of 64KiB to the
layers above you, you just can't _do_ atomic replacement of blocks,
which is required for normal file systems to operate correctly.

These characteristics of flash have often been dealt with by
implementing a 'translation layer' -- a kind of pseudo-filesystem --
which pretends to be a block device with the normal 512-byte
atomic-overwrite behaviour. You then use a traditional file system on
top of that emulated block device. 

JFFS2 was designed to avoid that inefficient extra layer, and work
directly on the flash. Since overwriting stuff in-place is so difficult,
or requires a whole new translation layer to map 'logical' addresses to
physical addresses, it was decided just to ditch the idea that physical
locality actually means _anything_.

Given that design, compression just dropped into place; it was trivial.

-- 
dwmw2

