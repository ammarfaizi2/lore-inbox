Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283726AbRLEEEC>; Tue, 4 Dec 2001 23:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283729AbRLEEDw>; Tue, 4 Dec 2001 23:03:52 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:23780 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S283726AbRLEEDf>;
	Tue, 4 Dec 2001 23:03:35 -0500
Date: Tue, 4 Dec 2001 23:03:33 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "David C. Hansen" <haveblue@us.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Moving BKL from generic code into drivers
In-Reply-To: <3C0D928F.8080904@us.ibm.com>
Message-ID: <Pine.GSO.4.21.0112042258220.21188-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Dec 2001, David C. Hansen wrote:

> As a first step toward removing the BKL from some block device drivers, 
> I'm planning on moving the BKL out of the generic code and into the 
> drivers themselves.
> 
> I plan on doing this indiscriminately.  All block devices will have a 
> lock_kernel() at the top of their open() and an unlock_kernel() at the 
> bottom.  Later on, we can remove it from individual drivers as we see fit.
> 
> Now the big question:
> In block_dev.c:do_open(), the BKL is held in addition to bdev->bd_sem. 
> Why is the BKL held here, other than to protect all of the drivers' open 
> functions?  What doesn't the semaphore provide?

get_blkfops() and module {un,}loading.

Please, don't step into that mess right now - there's a bunch of bad races
in devfs-related side of ->bd_op handling and the last thing we need is
additional set of complications.

Naive fix won't work due to devfs mess and correct one will take serious
massage of generic code _and_ devfs.

Besides, for block devices ->open() and ->release() are absolutely not
interesting wrt BKL contention.  Just how often are they called?

