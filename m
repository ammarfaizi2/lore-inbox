Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbULHCdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbULHCdP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 21:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbULHCdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 21:33:15 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:36526 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S262013AbULHCdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 21:33:11 -0500
Date: Wed, 8 Dec 2004 03:33:06 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Time sliced CFQ io scheduler
Message-ID: <20041208023306.GJ16322@dualathlon.random>
References: <20041202130457.GC10458@suse.de> <20041202134801.GE10458@suse.de> <20041202114836.6b2e8d3f.akpm@osdl.org> <20041202195232.GA26695@suse.de> <20041208003736.GD16322@dualathlon.random> <1102467253.8095.10.camel@npiggin-nld.site> <20041208013732.GF16322@dualathlon.random> <20041207180033.6699425b.akpm@osdl.org> <20041208022020.GH16322@dualathlon.random> <20041207182557.23eed970.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041207182557.23eed970.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2004 at 06:25:57PM -0800, Andrew Morton wrote:
> That's a missing hint in the direct-io code.  This fixes it up:
> 
> --- 25/fs/direct-io.c~a	2004-12-07 18:12:25.491602512 -0800
> +++ 25-akpm/fs/direct-io.c	2004-12-07 18:13:13.661279608 -0800
> @@ -1161,6 +1161,8 @@ __blockdev_direct_IO(int rw, struct kioc
>  	struct dio *dio;
>  	int reader_with_isem = (rw == READ && dio_lock_type == DIO_OWN_LOCKING);
>  
> +	current->flags |= PF_SYNCWRITE;
> +
>  	if (bdev)
>  		bdev_blkbits = blksize_bits(bdev_hardsect_size(bdev));
>  
> @@ -1244,6 +1246,7 @@ __blockdev_direct_IO(int rw, struct kioc
>  out:
>  	if (reader_with_isem)
>  		up(&inode->i_sem);
> +	current->flags &= ~PF_SYNCWRITE;
>  	return retval;
>  }
>  EXPORT_SYMBOL(__blockdev_direct_IO);

that was fast ;) great, thanks!

> I don't think AS will ever meet the performance of CFQ or deadline for the

This is my expectation too, since for these apps write latency is almost
more important than read latency and writes are often sync.
