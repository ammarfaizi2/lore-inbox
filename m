Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135209AbRDLPrL>; Thu, 12 Apr 2001 11:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135208AbRDLPrG>; Thu, 12 Apr 2001 11:47:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17928 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S135207AbRDLPq0>;
	Thu, 12 Apr 2001 11:46:26 -0400
Date: Thu, 12 Apr 2001 17:46:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Josh McKinney <forming@home.com>
Cc: linux-kernel@vger.kernel.org, Priit Randla <priit.randla@eyp.ee>
Subject: Re: scheduler went mad?
Message-ID: <20010412174608.O498@suse.de>
In-Reply-To: <3AD46930.B6CC9565@eyp.ee> <20010411134602.A4328@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010411134602.A4328@home.com>; from forming@home.com on Wed, Apr 11, 2001 at 01:46:02PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11 2001, Josh McKinney wrote:
> I had the almost exact same thing happen to me just yesterday, I started up
> xcdroast, and cdda2wav and kswapd went crazy, backed out of X and all was 
> well, and still is.
> 
> Same kernel as you too.

I can tell you why this happens. Earlier kernels allocated one cd frame
worth of data for cdda ripping, but it was recently bumped to allow as
many as the ripping program asks for (up to 8). This requires a 4-5 page
allocation on x86, which is of course not reliable. cdrom.c adjusts for
failed allocations and drops to fewer number of frames (8 -> 4 -> 2 and
then just 1), but apparently the vm isn't handling this too well if
kswapd is going crazy.

I can switch to a static 8 frame allocation, but IMHO the vm should be
able to handle situations like this. It's not that unusual for a driver
to ask for a bigger chunk of memory if it can go faster that way, and
then be prepared to settle for less if need be. For cdda ripping, it
really does make a difference.

However, I can change ide-cd to do scatter gather in this case. It's the
nicer thing to do anyway. Does cdda2wav have some sort of 'do X number
of frames at the time' option? If so, use 1 and there should be no
problems.

-- 
Jens Axboe

