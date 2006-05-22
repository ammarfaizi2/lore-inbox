Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWEVRBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWEVRBS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 13:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWEVRBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 13:01:18 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24776 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750991AbWEVRBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 13:01:18 -0400
Date: Mon, 22 May 2006 19:00:36 +0200
From: Pavel Machek <pavel@suse.cz>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16.16 Parameter-controlled mmap/stack randomization
Message-ID: <20060522170036.GD1893@elf.ucw.cz>
References: <446E6A3B.8060100@comcast.net> <1148132838.3041.3.camel@laptopd505.fenrus.org> <446F3483.40208@comcast.net> <20060522010606.GC25434@elf.ucw.cz> <44712605.4000001@comcast.net> <20060522083352.GA11923@elf.ucw.cz> <4471E77F.1010704@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4471E77F.1010704@comcast.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>>> On the other hand, some things[1][2][3] may give us the undesirable
> >>>> situation where-- even on an x86-64 with real NX-bit love-- there's an
> >>>> executable stack.  The stack randomization in this case can likely be
> >>>> weakened by, say, 8 bits by padding your shellcode with 1-byte NOPs
> >>>> (there's a zillion of these, like inc %eax) up to 4096 bytes.  This
> >>>> leaves 1 success case for every 2047 fail cases.
> >>> Maybe we can add more bits of randomness when there's enough address
> >>> space -- like in x86-64 case?
> >> Yes but how many?  I set the max in my working copy (by the way, I
> >> patched it into Ubuntu Dapper kernel, built, tested, it works) at 1/12
> >> of TASK_SIZE; on x86-64, that's 128TiB / 12 -> 10.667TiB -> long_log2()
> >> - -> 43 bits -> 8TiB of VMA, which becomes 31 bits mmap() and 39 bits stack.
> >>
> >> That's feasible, it's nice, it's fregging huge.  Can we justify it?  ...
> >> well we can't justify NOT doing it without the ad hominem "We Don't Need
> >> That Because It's Not Necessary", but that's not the hard part around here.
> > 
> > Well, making it configurable and pushing hard decision to the user is
> > not right approach, either. I believe we need different
> > per-architecture defaults, not "make user configure it".
> 
> Yes, different per-architecture defaults is feasible with configuration
> being possible.  I could replace 'int STACK_random_bits=19' with 'int
> mmap_random_bits=ARCH_STACK_RANDOM_BITS_DEFAULT' and that would be
> effective as long as the user doesn't touch it with command line or
> SELinux or whatnot.
> 
> It is still possible that ARCH_STACK_RANDOM_BITS_DEFAULT breaks things.
>  The current kernel default broke emacs at first I heard; I believe
> we

Well, fix emacs then. We definitely do not want 10000 settable knobs
that randomly break things. OTOH per-architecture different randomness
seems like good idea. And if Oracle breaks, fix it.

>  - Disable PF_RANDOMIZE for the binary.  (Already doable)
>  - Decrease randomization system-wide.  (My patch lets you do this)
>  - Decrease randomization for the binary to a point where it works.
> (Adding SELinux hooks and policy to my patch would allow this)

Which immediately makes your patch obsolete.

> Disabling randomization for the binary is much more fine-grained, but
> opens up that binary for attacks.  Oracle breaks with high-order
> entropy; we can disable randomization on Oracle and keep high-order
> entropy, but now the database server is at risk.  This isn't the
> greatest idea in the world either.

So fix Oracle. No need to invent serious infrastructure because Oracle
is broken.

> It appears to me that the best solution is per-policy, but we should
> leave even that up to the user.  This means make a sane default--
> one

No. Current situation is okay as is. It does not need to be
configurable, and it should not be.

Per-architecture ammount of randomness would be welcome, I
believe. That will force Oracle to fix their code, but that's okay,
and you can use disable PF_RANDOMIZE for Oracle in meantime.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
