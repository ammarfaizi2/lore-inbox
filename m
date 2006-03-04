Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWCDLmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWCDLmc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 06:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWCDLmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 06:42:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64201 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751487AbWCDLmb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 06:42:31 -0500
Date: Sat, 4 Mar 2006 03:40:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: anemo@mba.ocn.ne.jp, clameter@engr.sgi.com, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org, johnstul@us.ibm.com, rth@twiddle.net
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64
 aliasing problem)
Message-Id: <20060304034050.40f29251.akpm@osdl.org>
In-Reply-To: <20060304112010.GA94875@muc.de>
References: <20060303.114406.64806237.nemoto@toshiba-tops.co.jp>
	<20060302190408.1e754f12.akpm@osdl.org>
	<20060303.133125.106438890.nemoto@toshiba-tops.co.jp>
	<20060304.013153.71086081.anemo@mba.ocn.ne.jp>
	<20060304001834.0476e8e9.akpm@osdl.org>
	<20060304112010.GA94875@muc.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> > b) On 64-bit machines jiffies and jiffies_64 always have the same
> >    address (don't they?) Is the compiler really going to move a read of an
> >    absolute address ahead of a modification of the same address?
> > 
> >    <looks>
> > 
> >    The address of jiffies isn't known until link time, so yup, the risk
> >    is there.
> 
> Yes maybe it would be better to just use  #define there.
> jiffies_64 always was a bit too clever.

hm.   It's actually rather hard.

One could do something like:

extern u64 __jiffy_data jiffies_64;
#define jiffies (*(u32 *)((long)&jiffies_64 + 2))

or


#if BITS_PER_LONG == 64
extern u64 __jiffy_data jiffies;
#define jiffies_64 jiffies
#else
extern union jiffy_thing {
#ifdef BIG_ENDIAN
	struct {
		u32 pad;
		u32 jiffies;
	},
	u64 jiffies_64;
#else
	u64 jiffies_64;
	struct {
		u32 pad;
		u32 jiffies;
	},
#endif
} __jiffy_data jiffies_thing;
#define jiffies_64 jiffies_thing.jiffies_64
#define jiffies jiffies_thing.jiffies
#endif

But then any code which uses `jiffies' as a local variable will explode.  I
guess we should rename those anyway.  include/linux/cyclades.h is one such.

Making `jiffies_64' a #define is less risky, but that doesn't work for
32-bit.

> > 
> > c) jiffies is declared volatile.  In practice, if I know my gcc, it's
> >    just not going to play these reordering games with a volatile.
> > 
> >    If that's true, and if some standard (presumably c99) says that it
> >    must be true then I don't think we need the patch.
> 
> The standards definition of volatile is unfortunately quite vague,
> so at least from this side you cannot rely on much.

Yup.

> Also I assume Atsushi-san did the patch because he saw a real problem?

I don't know.  I suspect its only observeable effect would be an
off-by-one-tick in wall_jiffies which will cancel out whereever anyone
takes a delta.

