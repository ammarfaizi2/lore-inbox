Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271335AbTHHNX6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 09:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271336AbTHHNX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 09:23:58 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:50924 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S271335AbTHHNX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 09:23:56 -0400
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bernd Eckenfels <ecki@lina.inka.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1059320952.13191.12.camel@dhcp22.swansea.linux.org.uk>
References: <E19gnTj-00005f-00@calista.inka.de>
	 <1059320952.13191.12.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Message-Id: <1060349031.25209.361.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.1 (dwmw2) 
Date: Fri, 08 Aug 2003 14:23:51 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-07-27 at 16:49, Alan Cox wrote:
> Flash cards are -slow-. Also jffs2 is mostly synchronous so it writes
> the long bit by bit. The flash wear is on erase not write. You could
> certainly teach jffs2 a bit more about batching writes. The other issue
> with jffs2 is startup because it is a log you have to read the entire
> log to know what state you are in

Startup in 2.5 is a _lot_ better than in 2.4 -- we stopped checking the
crc32 on every node during mount, and do it later instead. We also use a
pointer directly into the flash if it's possible, rather than memcpying
every node we look at during the mount.

The amount of state we need to rebuild during the mount isn't huge -- if
you ignore nlink for the moment, all we really need to do is build up a
list of
	{ physical address, length, inode # to which it belongs }
tuples for each log entry on the medium -- for larger media, we could
add tailers to each eraseblock with a condensed version of that
information, to prevent the need to scan the whole of each block during
mount to work it out.

I suspect we're going to have to do that for the larger NAND devices,
including DiskOnChip, in the fairly near future. It takes 30 seconds to
mount a 144MiB DiskOnChip with JFFS2. 

We already do some form of write batching on NAND flash too -- since we
can't always write more than once to any given 512-byte 'page' on the
flash, we have to have a write-back buffer and coalesce writes. 

The other fairly simple thing we can do to improve runtime performance
and device lifetime is start being more intelligent about garbage
collection -- we should GC ancient and unchanged data to separate blocks
on the flash, rather than mixing it in with new writes; then we will end
up with more fully-clean eraseblocks (which can be ignored except for
once in a blue moon when we decide to GC them for wear levelling
purposes) and more mostly-dirty eraseblocks (on which we make rapid GC
progress since not a lot needs to be copied before the block can be
erased) -- and fewer of the 50%-dirty blocks we tend to see at the
moment.

-- 
dwmw2

