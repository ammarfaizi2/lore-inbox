Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbVBSVNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVBSVNL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 16:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVBSVNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 16:13:10 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:60141 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261837AbVBSVNG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 16:13:06 -0500
From: David Brownell <david-b@pacbell.net>
To: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: [PATCH] ohci1394: dma_pool_destroy while in_atomic() && irqs_disabled()
Date: Sat, 19 Feb 2005 13:13:00 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, scjody@modernduck.com
References: <200502191136.05584.david-b@pacbell.net> <200502191550.15929.kernel-stuff@comcast.net>
In-Reply-To: <200502191550.15929.kernel-stuff@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200502191313.00531.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 February 2005 12:50 pm, Parag Warudkar wrote:
> On Saturday 19 February 2005 02:36 pm, David Brownell wrote:
> > The cost of creating the dma_pool is the cost of one small kmalloc()
> > plus (the expensive part) the /sys/devices/.../pools sysfs attribute
> > is created along with the first pool.  (Use that instead of slabinfo
> > for those pool allocations.)  That's why the normal spot to create and
> > destroy dma pools is in driver probe() and remove() methods.
> 
> What's the format of /sys/devices/.../pools (Name of pool, ? ? ? ?) ?  Can the 
> memory consumption be derived from it? 

See what drivers/base/dmapool.c tells you; yes that
consumption can be derived from the pool statistics.


> Here is what the ohci pools look during data read (Kino->Capture) and after 
> closing Kino -
> 
> During Kino Capture
> [root@localhost pci0000:00]# cat ./0000:00:0a.0/0000:02:00.0/pools
> poolinfo - 0.1
> ohci1394 rcv prg   16  256   16  1 ------------------> This one is in question
> ohci1394 trm prg   32   64   64  1
> ohci1394 trm prg   32   64   64  1
> ohci1394 rcv prg    4  256   16  1
> ohci1394 rcv prg    4  256   16  1

I suggest you get rid of the spaces in those names, to make it
easier to use things like "awk" to massage those numbers.  The
"ohci1394" is implied by the fact that no other driver could
be bound to that device, for example.

In this case, other than the fact that you've created multiple
pools with the same names (!), that line translates to 16 blocks
in use out of 256 available, 16 bytes per block, just one page.

I suspect that on some systems it should be bumping up the minimum
block size to match the CPU cacheline size.

- Dave
