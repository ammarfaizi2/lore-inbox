Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263928AbTEOJyF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 05:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbTEOJyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 05:54:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30146 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263928AbTEOJyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 05:54:03 -0400
Date: Thu, 15 May 2003 12:06:53 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] 2.4 laptop mode
Message-ID: <20030515100653.GF15261@suse.de>
References: <20030514093504.GE17033@suse.de> <20030515085912.GV1253@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030515085912.GV1253@admingilde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15 2003, Martin Waitz wrote:
> hi :)
> 
> On Wed, May 14, 2003 at 11:35:04AM +0200, Jens Axboe wrote:
> > Now, this isn't the prettiest patch in the world. But it does allow me
> > to get good spin down times on my laptop hard drive. It was somewhat
> > inspired by the 2.5.early version akpm did. Basically, it adds:
> 
> if you are interested in spinning down hard drives, you might want to read
> http://www4.informatik.uni-erlangen.de/Publications/pdf/Weissel-Beutel-Bellosa-OSDI-CoopIO.pdf
> 

Interesting, I did not know about this paper. A lot of what my patch
does is identical to what they describe, I stop at the OS level though
and haven't (and don't really want to) extend it to applications. I
think that we can get 'pretty good' power saves without going that extra
mile.

Note that I also operate outside of the 4 ide power states described,
sleep -> standby -> idle -> active. I chose to disregard sleep, because
it requires a reset and drive program when transitioning from sleep to
idle. It's my feeling that most drives do the idle -> active transition
(and vice versa) on their own. So for me, that just leaves on
interesting operating mode (idle-active :). However, I added the
acoustic management in-between that. So when the drive is considered
'active' (ie serving requests), the amount of io will determine how fast
the seeks go by switching between the acoustic levels.

So with my patch, we are pretty close to the ECU level described in the
paper. With the laptop patch, we handle the writeout of dirty data at
appropriate times (when reads spin up the disk, etc) as well.

> they describe strategies to get maximum sleep times for drives by
> bundling accesses to hard discs.

I bundle writes with reads (slighly postponed), doing more would require
the added new syscalls.

> they even go a little bit faster and allow user space to give hints
> about when they need data.
> i only had a brief look at the sources but i guess this could be folded
> into the aio interface.
> (CoopIO as described above adds its own system calls)

Yeah, using aio would make it a lot easier and wouldn't require many
changes to the existing aio interface.

> it would be great if somethink like that could be ported to 2.5...

What's stopping you?

-- 
Jens Axboe

