Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267001AbUBRXEf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267153AbUBRXEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:04:35 -0500
Received: from intra.cyclades.com ([64.186.161.6]:36838 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S267001AbUBRXEW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:04:22 -0500
Date: Wed, 18 Feb 2004 20:42:15 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Christian Kujau <evil@g-house.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-crypto@nl.linux.org,
       Daniel Brahneborg <daniel.com@wtnord.net>, Jens Axboe <axboe@suse.de>
Subject: Re: 2.4.24 + cryptoloop: __alloc_pages: 5-order allocation failed
In-Reply-To: <40317785.3060509@g-house.de>
Message-ID: <Pine.LNX.4.58L.0402182037320.11790@logos.cnet>
References: <40317785.3060509@g-house.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004, Christian Kujau wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> hi,
>
> today i played around with some benchmarks i do from time to time [1]
> this time with 2.4.24 and the cryptoloop patch
> (patch-cryptoloop-jari-2.4.22.0, applies to 2.4.24 too) when using this
> machine (powerpc)
>
> http://www.nerdbynature.de/bits/sheep/2.4.24-benh/ver_linux
>
> in short: i have a 700 MB file, losetup a loop device with a cipher
> (aes,cast5,cast6,blowfish,serpent,twofish), create an ext3 fs on it.
> then test with "tiobench" (size is only about 100MB). but the benchmarks
> did not last very long, i have these messages in my syslog:
>
> Dec 21 23:42:45 sheep kernel: __alloc_pages: 0-order allocation failed
> (gfp=0x1d2/0)
> Dec 21 23:42:45 sheep kernel: VM: killing process nmbd
> Dec 21 23:43:07 sheep kernel: __alloc_pages: 0-order allocation failed
> (gfp=0x1d2/0)
> [...]
> Dec 23 22:26:37 sheep kernel: __alloc_pages: 5-order allocation failed
> (gfp=0x20/0)
> Dec 23 22:26:39 sheep kernel: __alloc_pages: 5-order allocation failed
> (gfp=0x20/0)
> Dec 23 22:26:40 sheep kernel: __alloc_pages: 5-order allocation failed
> (gfp=0x20/0)
> Dec 23 22:26:41 sheep kernel: __alloc_pages: 5-order allocation failed
> (gfp=0x20/0)
> [...]
> Feb 16 15:17:21 sheep kernel: __alloc_pages: 0-order allocation failed
> (gfp=0x30/0)
>
> full log excerpt on:
> http://www.nerdbynature.de/bits/sheep/2.4.24/messages-alloc_pages
>
> i am then able to sysrq-S, but not all partitions can be synced, then i
> try sysrq-E / -I / -U with no luck, nothing seems to be written/read
> to/from the disk, sysrq-B works :-)
>
> i did manage to make earlier tests with different filesystems [2] and
> linux 2.4.22 and have never had these messages.

Christian, Daniel,

Please do

echo 1 > /proc/sys/vm/vm_gfp_debug

This will print additional information when the "%d-order allocation
failures" messages happen. Please post that information along with the
System.map for the running kernel.

Daniel is seeing a similar problem but running with RAID1 over loop (which
doesnt sound like a good idea to me - but should work anyway).

I suspect the problem is loop allocates its buffers in a way so that the
allocator can't sleep waiting for IO, which in turn overloads the memory
and causes the failures.

