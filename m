Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318131AbSGWQwO>; Tue, 23 Jul 2002 12:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318138AbSGWQwO>; Tue, 23 Jul 2002 12:52:14 -0400
Received: from [195.223.140.120] ([195.223.140.120]:61970 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318131AbSGWQwN>; Tue, 23 Jul 2002 12:52:13 -0400
Date: Tue, 23 Jul 2002 18:56:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel McNeil <daniel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc2aa1 i_size atomic access
Message-ID: <20020723165602.GV1116@dualathlon.random>
References: <1026949132.20314.0.camel@joe2.pdx.osdl.net> <1026951041.2412.38.camel@IBM-C> <20020718103511.GG994@dualathlon.random> <1027037361.2424.73.camel@IBM-C> <20020719112305.A15517@oldwotan.suse.de> <1027119396.2629.16.camel@IBM-C>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027119396.2629.16.camel@IBM-C>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2002 at 03:56:36PM -0700, Daniel McNeil wrote:
> Here is another approach. I added two version fields to the inode
> structure. The first one is updated before i_size and the 2nd is
> updated after with memory barriers in between.  The i_size_read()
> samples the version fields and i_size and loops until it can read
> i_size without an i_size update happening at the same time.  It is
> not pretty but it does fix the problem and the cache line is not
> written by i_size_read() and it should work on all architechtures.
> I've tested this on a two proc system.

I also considered this possibility before taking the other approch, I
thought it was inferior because it adds branches and it increases the
dcache pressure, so I thought just marking our cacheline dirty and
reading it in one go, with no additional overhead would been a win (the
less possible number of cycles and no branch prediction issues). Of
course the below will allow parallel i_size readers to scale, but again,
I think the fstat benchmark doesn't matter much and true parallel
readers on the same inode (not only i_size readers) will have to collide
on the pagecache_lock anyways (even in 2.5). So I still think the
chmpxchg8b is a win despite it marks the i_size cacheline dirty, but
somebody should try to benchmark it probably to verify the major
bottleneck remains the pagecache_lock.

I actually applied the below but I enabled it only for the non x86 32bit
archs (like s390, ppc) where I have no idea how to code a get_64bit it
in asm. It should be definitely better than a separate spinlock
protecting the i_size.

comments?

Andrea
