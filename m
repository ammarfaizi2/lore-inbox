Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbWECB7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbWECB7t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 21:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbWECB7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 21:59:48 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:20206 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965070AbWECB7s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 21:59:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RBbR+FmcNVqP1F4bTe6BUz1Y8YHeSzch2edXwQBSRB4uVe6HSSPOWnaNjOSdG7xbnPUTyz45R99SRsdowOwcfkg61z7cNT6EbhDnT29WkzAuu6TE22gBXwYhVIFbDbTMQqtu0P/IN+Kdgge6bX+63NYqfuqM5nJA8X+E5ygvl+Q=
Message-ID: <6934efce0605021859u55131e63xd8dab3d4396d7f56@mail.gmail.com>
Date: Tue, 2 May 2006 18:59:47 -0700
From: "Jared Hulbert" <jaredeh@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [RFC] Advanced XIP File System
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200605030200.29141.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
	 <200605030200.29141.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nice, this is the first time I heard of anyone using filemap_xip on MTD.

Actually we don't use the MTD.  Well, we may use it to provide the
physical address of the volume, thats not really _using_ it.

> ext2fs does have XIP of applications, but of course only works on
> block devices, not MTD. Is there more missing than an implementation
> of block_device_operations::direct_access for mtd_blktrans_ops?

It works on very specific block devices to be clear.  Yeah, as I
understand it, the hardware to enable it is missing.

> Why can't you get the same result with a combination of cramfs for
> data files and ext2 with -o xip for your mmapped binaries?

Not having the block device driver is by design.  In this case I don't
need a block device because the entire "disk" or binary image is in
readonly memory already.  I don't need to fetch blocks.  This is
readonly so I don't need to write blocks either.  A block device
driver would do what for me?

Also ext2 doesn't do compression, and it doesn't let me pick out
specific pages in files to XIP or compress.

> Is that a fundamental problem of cramfs, or rather a problem of the
> implementation of the linear XIP patches for it?

A little of both.  The architecture of cramfs doesn't lend itself to
the page by page XIP without really changing the fundamental layout of
cramfs.  Why mess with it?

>IOW, can't you just
> do a better patch to add filemap_xip support to cramfs?

I started out with that goal.  This seemed like the best option after
we did the deep dive into how to go about it.

>> - Design allows for tighter packing of data and higher performance
>> than XIP cramfs
>
> why? by how much?

Data packing:
1) When mkcramfs is writing files to the image it mixes compress and
XIP files.  XIP files are page aligned.  Compressed files are not.  I
think it was about 3.3% wasted I measured on an actual production
linux phone.
2) Choosing page by page to XIP or compress means you can save space,
but it depends on what is more precious, RAM or Flash, given real
designs (ie - you don't buy 36MiB of RAM you get 32MiB or 64MiB)

Performance:
1) The way we are storing the metadata should make for quicker access.
2) Being able to store specific pages of RO data from an otherwise XIP
file such that they end up in RAM has speed thing up for us a great
deal in the lab.
