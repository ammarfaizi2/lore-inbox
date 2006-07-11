Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWGKXEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWGKXEd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 19:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWGKXEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 19:04:33 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:18851 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751344AbWGKXEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 19:04:33 -0400
Date: Wed, 12 Jul 2006 09:04:17 +1000
From: Nathan Scott <nathans@sgi.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] ramdisk blocksize Kconfig entry
Message-ID: <20060712090417.C1725755@wobbly.melbourne.sgi.com>
References: <20060711171722.E1710004@wobbly.melbourne.sgi.com> <44B415FE.1010700@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <44B415FE.1010700@zytor.com>; from hpa@zytor.com on Tue, Jul 11, 2006 at 02:19:58PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 02:19:58PM -0700, H. Peter Anvin wrote:
> Nathan Scott wrote:
> > This patch makes the ramdisk blocksize configurable at kernel
> > compilation time rather than only at boot or module load time,
> > like a couple of the other ramdisk options.  I found this handy
> > awhile back but thought little of it, until recently asked by a
> > few of the testing folks here to be able to do the same thing
> > for their automated test setups.
> > 
> > The Kconfig comment is largely lifted from comments in rd.c,
> > and hopefully this will increase the chances of making folks
> > aware that the default value often isn't a great choice here
> > (for increasing values of PAGE_SIZE, even moreso).
> 
> This seems a bit odd to me... the sizes of most block devices is set by 
> the filesystem, not hard-coded; the need for this implies something more 
> fundamental is wrong.

The ramdisk driver is using this "blocksize" as what, in some other areas
of the block layer (and in XFS, but thats irrelevent here), is termed the
hard sector size - i.e. minimum IO size allowed to the device.  This gets
used for direct I/O size and alignment checking at the device level (the
block size of the filesystem sitting above the ramdisk has to be equal to
or greater than the device sector size).

The driver also uses this value for i_blkbits on individual block device
inodes (in rd_open), which in turn means buffer_heads attached to the
page cache pages which form the backing store for this device are sized
based on this, which potentially means many buffer_heads to a page. This
may not be what someone using it might have expected/wanted.

But I don't think these things are fundamental problems in the ramdisk
driver, rather design choices, and people using it should be aware of
the tradeoffs... what were you thinking of there in terms of something
more fundamental being wrong?

cheers.

-- 
Nathan
