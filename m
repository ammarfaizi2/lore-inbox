Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130058AbRBZA3p>; Sun, 25 Feb 2001 19:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130059AbRBZA3h>; Sun, 25 Feb 2001 19:29:37 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:26245 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130058AbRBZA3W>;
	Sun, 25 Feb 2001 19:29:22 -0500
Date: Sun, 25 Feb 2001 19:29:21 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jens Axboe <axboe@suse.de>
cc: Nate Eldredge <neldredge@hmc.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-ac3: loop threads in D state
In-Reply-To: <20010226012430.V7830@suse.de>
Message-ID: <Pine.GSO.4.21.0102251927170.26808-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Feb 2001, Jens Axboe wrote:

> On Sun, Feb 25 2001, Alexander Viro wrote:
> > Jens, you have a race in lo_clr_fd() (loop-6). I've put the fixed
> > variant on ftp.math.psu.edu/pub/viro/loop-S2.gz. Diff and you'll
> > see - it's in the very beginning of the lo_clr_fd().
> 
> Oops yeah you are right. Here's a diff of my current loop stuff
> against -ac4, Alan could you apply? Andrea suggested removing
> the loop private slab cache for buffer heads and just using the
> bh_cachep pool, and it seems like a good idea to me.

Erm... Jens, it really should be
	if (atomic_dec_and_test(...))
		up(...);
not just
	atomic_dec(...);
	up(...);

Otherwise you can end up with too early exit of loop_thread. Normally
it would not matter, but in pathological cases...

