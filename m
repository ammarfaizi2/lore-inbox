Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283603AbRLDXzh>; Tue, 4 Dec 2001 18:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283604AbRLDXz1>; Tue, 4 Dec 2001 18:55:27 -0500
Received: from colorfullife.com ([216.156.138.34]:30992 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S283603AbRLDXzM>;
	Tue, 4 Dec 2001 18:55:12 -0500
Message-ID: <3C0D37E0.5382B42E@colorfullife.com>
Date: Tue, 04 Dec 2001 21:53:52 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] improve spinlock debugging
In-Reply-To: <3C0BDC33.6E18C815@colorfullife.com> <3C0D3283.4DA4DD2B@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> Manfred Spraul wrote:
> >
> > CONFIG_DEBUG_SPINLOCK only adds spinlock tests for SMP builds. The
> > attached patch adds runtime checks for uniprocessor builds.
> >
> > Tested on i386/UP, but it should work on all platforms. It contains
> > runtime checks for:
> >
> > - missing initialization
> > - recursive lock
> > - double unlock
> > - incorrect use of spin_is_locked() or spin_trylock() [both function
> > do not work as expected on uniprocessor builds]
> > The next step are checks for spinlock ordering mismatches.
> 
> What do you consider an order mismatch?  I would like to see this:
>
	spin_lock(a);
	spin_lock(b);

and somewhere else
	spin_lock(b);
	spin_lock(a);

> 
> Run time checks for xxx_irq when irq is already off seem reasonable.
> The implication is that the xxx_unlockirq will then turn it on, which
> most likely is an error.  Also, see above about rolling assumptions in
> to the macro name.
>
Unfortuantely there are still a few special cases where spin_lock_irq()
with already disabled interrupts is both intentional and correct^wnot
buggy (search for sleep_on and cli() through the lkml archives).

And there are optimizations such as
	spin_lock_bh(a);
	spin_unlock(b);
	spin_lock(b);
	spin_unlock_bh(b);

--
	Manfred
