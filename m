Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267162AbSK2Wod>; Fri, 29 Nov 2002 17:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267166AbSK2Woc>; Fri, 29 Nov 2002 17:44:32 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1291 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267162AbSK2Wob>; Fri, 29 Nov 2002 17:44:31 -0500
Date: Fri, 29 Nov 2002 22:51:52 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: Georg Nikodym <georgn@somanetworks.com>, linux-kernel@vger.kernel.org
Subject: Re: v2.4.19-rmk4 slab.c: /proc/slabinfo uses broken instead of slab labels
Message-ID: <20021129225152.C4496@flint.arm.linux.org.uk>
Mail-Followup-To: Manfred Spraul <manfred@colorfullife.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Georg Nikodym <georgn@somanetworks.com>,
	linux-kernel@vger.kernel.org
References: <3DE699EC.9060600@colorfullife.com> <20021128224028.F27234@flint.arm.linux.org.uk> <3DE7B0C2.7050301@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DE7B0C2.7050301@colorfullife.com>; from manfred@colorfullife.com on Fri, Nov 29, 2002 at 07:24:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2002 at 07:24:02PM +0100, Manfred Spraul wrote:
> Russell King wrote:
> >On Thu, Nov 28, 2002 at 11:34:20PM +0100, Manfred Spraul wrote:
> >  
> >
> >>On i386, it's possible to skip set_fs() and use __get_user() - but 
> >>that's i386 specific. For example the i386 oops code uses that.
> >>    
> >>
> >
> >That isn't actually an x86 specific feature - it is a requirement across
> >all architectures that get_user() and friends can access kernel areas
> >after set_fs(get_ds())
> >  
> >
> It's i386 specific that
>     __get_user().
> is equivalent to
>     set_fs(KERNEL_DS)
>     get_user()
> arch/i386/kernel/traps.c uses that in the fault code.
> 
> Portable code must use set_fs()/get_user(), i386 specific code can 
> continue to use __get_user().

That seems broken to me.  IIRC, when all this uaccess stuff went in back
in 2.1 times, the original intention was that __get_user() would fault
even when used from kernel mode, unless set_fs(KERNEL_DS) was in effect.

__get_user() at that time was always meant to be used as a faster version
of get_user(), even by generic code, and relied solely on the TLB protection
mechanisms, whereas get_user() verified the address.

Gah, I _really_ wish that we had a method to notify architecture maintainers
when this type of stuff changes.  Are we supposed to re-read the x86
implementation of everything for each kernel release to try to discover
what subtle semantics have changed?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

