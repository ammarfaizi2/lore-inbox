Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283001AbRLMCQl>; Wed, 12 Dec 2001 21:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283002AbRLMCQb>; Wed, 12 Dec 2001 21:16:31 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:29106 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S283001AbRLMCQS>;
	Wed, 12 Dec 2001 21:16:18 -0500
Date: Wed, 12 Dec 2001 21:16:15 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "David C. Hansen" <haveblue@us.ibm.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Change locking in block_dev.c:do_open()
In-Reply-To: <3C17F8B2.6080700@us.ibm.com>
Message-ID: <Pine.GSO.4.21.0112122101350.17470-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Dec 2001, David C. Hansen wrote:

> I've been looking at how the BKL is used throughout the kernel.  My end
> goal is to eliminate the BKL, but I don't have any fanciful ideas that I
> can get rid of it myself, or do it in a short period of time.  Right
> now, I'm looking for interesting BKL uses and examining alternatives.
> 
> Lately, I've been examining do_open() in block_dev.c.  This particular
> nugget of code uses the BKL for a couple of things.  First,
> get_blkfops() can call request_module(), which requires the BKL.
> Secondly, there needs to be protection so that the module isn't removed
> between the get_blkfops() and the __MOD_INC_USE_COUNT().  Lastly, the
> bd_op->open() calls expect the BKL to be held while they are called.  Is
> this it?  Anybody know of more reasons?

Sigh...  First of all, the right thing to do is to call try_inc_mod_count()
_in_ get_blkfops().  No need to reinvent the wheel.  But real problem with
that area is not BKL.  It's *!@& damn devfs=only mess and code that does
direct assignment of ->bd_op before calling blkdev_get().  Until it's solved
(and the only decent way I see is to remove this misfeature) I'd seriously
recommend to leave the damn thing as is.

If you can think of a decent way to handle that problem - you are very
welcome.  _If_ we remove devfs=only I have a patchset that moves BKL to
the area immediately around the call of ->open() - see
ftp.math.psu.edu/pub/viro/*-S14-pre5.

