Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267507AbTBPVil>; Sun, 16 Feb 2003 16:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267515AbTBPVil>; Sun, 16 Feb 2003 16:38:41 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60486 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267507AbTBPVii>; Sun, 16 Feb 2003 16:38:38 -0500
To: Corey Minyard <minyard@acm.org>
Cc: Corey Minyard <cminyard@mvista.com>,
       Werner Almesberger <wa@almesberger.net>,
       Zwane Mwaikambo <zwane@holomorphy.com>, suparna@in.ibm.com,
       Kenneth Sumrall <ken@mvista.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
References: <3E4914CA.6070408@mvista.com> <m1of5ixgun.fsf@frodo.biederman.org>
	<3E4A578C.7000302@mvista.com> <m13cmty2kq.fsf@frodo.biederman.org>
	<3E4A70EA.4020504@mvista.com> <20030214001310.B2791@almesberger.net>
	<3E4CFB11.1080209@mvista.com> <20030214151001.F2092@almesberger.net>
	<3E4D3419.1070207@mvista.com>
	<Pine.LNX.4.50.0302141420220.3518-100000@montezuma.mastecende.com>
	<20030214164436.H2092@almesberger.net> <3E4D4ADF.3070109@mvista.com>
	<m17kc26pxs.fsf@frodo.biederman.org> <3E4FBAD0.4040808@acm.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Feb 2003 14:48:26 -0700
In-Reply-To: <3E4FBAD0.4040808@acm.org>
Message-ID: <m1y94f6gnp.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard <minyard@acm.org> writes:

> Eric W. Biederman wrote:
> 
> |Corey Minyard <cminyard@mvista.com> writes:
> |
> |>|
> |>|(So adding a special mode to the power management code may
> |>|be too much overhead. Besides, sometimes, you can just pull
> |>|a reset line, and don't have to do anything even remotely
> |>|related to power management.)
> |>
> |>True, I didn't mean the high-level power management code directly.  But the
> |>PCI API defines a suspend operation that could take a special mode for this.
> |
> |
> |The generic device api has a shutdown method for this.  And in the non panic
> |case we use it.  Not a lot of devices have it implemented but it exists.
> |
> |And except that it doesn't have a restriction that it can't block is pretty
> |much what you want.
> 
> That's a pretty big restriction.  Plus, you can't claim spinlocks.
> 
> The panic shutdown is different from an orderly shutdown.  What the current
> shutdown does is probably not what you want.

I do not see a large difference between the desired semantics of an
orderly shutdown, and the desired semantics of a panic shutdown.

> |>Or maybe a new field in the PCI structure (and equivalent for other things, if
> 
> |>there are any).  But the suspend and resume operations should at least give
> |>a good idea where its needed and how to use it.
> |
> |
> |The API is already done...
> 
> The API is not done for panics.  There's no call that has the proper semantics.

device->shutdown() is new enough and unimplemented enough that adding a restriction
against blocking is a reasonable additional, restriction.  If that is a reasonable
thing to do.

> |
> |
> |We just don't trust the dying kernel enough to use it during a panic.
> 
> I don't understand this.  If you can't trust a dying kernel to properly shut
> down devices, how can you trust it to boot a new kernel?

The kernel started during panic has one purpose, to record the state of
the system for analysis.  So it need not support a fully functioning
user space.

By definition if a panic has happened something bad has happened, we assume
it is a software problem.

> And (much worse) if
> you don't shut down the devices, how can you trust the new kernel to execute
> properly?

Because the kernel to handle the panic only initializes those devices
it can reliably initialize from any state.   And it is living in an
area of memory the old kernel did not allow DMA to.

>  I know there are levels of trust here, but I'd much rather have the
> kernel lockup during the reboot than have a chance of a new kernel booting that
> could behave incorrectly. 

The kexec on panic thing is not to replace a reboot.  It is to
reliably capture the system state when something nasty happens, which
you cannot do after a reboot.  

If the system can be made robust enough to use for other purposes
great, but that is not the goal.

> In general, the chance of behaving incorrectly is
> MUCH worse than a sure lockup, especially in systems that must be
> reliable.

Basically the panic logic does not change:
if (...) {
        machine_kexec();
}
else {
        machine_restart();
}

After an event like that you may need to restart the machine to be
100% reliable.  Or much more likely it was a hardware failure and
hardware needs to be replaced.  

But if it is a software failure kexec'ing a new kernel should provide
the capability so the software state at the failure can be captured so
the problem does not need to be reproduced for the developers.
Allowing the software to be corrected more quickly, and hopefully
correcting the problem before it would reoccur naturally.

Eric

