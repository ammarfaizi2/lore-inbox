Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbVKUPxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbVKUPxH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 10:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbVKUPxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 10:53:07 -0500
Received: from waste.org ([64.81.244.121]:58026 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932335AbVKUPxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 10:53:05 -0500
Date: Mon, 21 Nov 2005 07:50:50 -0800
From: Matt Mackall <mpm@selenic.com>
To: Rob Landley <rob@landley.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [PATCH] skip initramfs check
Message-ID: <20051121155050.GK31287@waste.org>
References: <20051117141432.GD9753@logos.cnet> <200511210130.55774.rob@landley.net> <20051121062350.GA24381@logos.cnet> <200511210904.46495.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511210904.46495.rob@landley.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 09:04:46AM -0600, Rob Landley wrote:
> On Monday 21 November 2005 00:23, Marcelo Tosatti wrote:
> > Hi Rob,
> > > Query: is the problem that a big initramfs image is being unpacked more
> > > than once, or is unpacking an empty initramfs image (134 bytes) causing a
> > > significant delay?
> >
> > The problem is a big non-initramfs RAMDISK image (used for root mountpoint
> > on this particular embedded platform), that is decompressed more than once:
> >
> > - during the initramfs check, which fails because it is not initramfs.
> > - during the real RAMDISK decompression to memory.
> >
> > > I'm fairly certain that back in 1990 I could unzip 134 bytes on my 33 mhz
> > > 386 running dos in a fraction of a second.  What's the use case here?
> >
> > So the issue is not the empty initramfs image (which BTW could probably
> > be made unecessary?), but a 10Mb RAMDISK image being decompressed by a
> > 48Mhz PPC, which takes quite a few seconds.
> >
> > Need to rework the patch to use a __setup option as Andrew suggested.
> 
> It sounds to me like is the initial check (which is just giving a thumbs 
> up/thumbs down "is this an initramfs", correct?) only needs to decompress the 
> first page or so of data to make this determination.  A quick glance at the 
> code seems to imply it's just checking the header and the first entry, so 4k 
> should be plenty for that.
> 
> Some variant of lib/zlib_inflate...  Ouch, bit of a mess there.  Hey Matt: you 
> know this area.  Is it feasible to do some kind of:
> 
> deflate_init(whatever)
> deflate_next_x_bytes(source *, dest *, length)
> 
> To grab a the first X bytes from the initramfs image?

Not at the moment. But I think it is feasible to simply move the ramdisk
detection and unpacking inside the ramfs state machine. In other
words, add two new states:

- detecting type
- unpacking ramdisk

When the first few bytes are fed from the decompressor to the state
machine, we either transition to the normal ramfs unpacking or we
treat it as a ramdisk.

-- 
Mathematics is the supreme nostalgia of our time.
