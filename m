Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266825AbSKHRbo>; Fri, 8 Nov 2002 12:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266829AbSKHRbo>; Fri, 8 Nov 2002 12:31:44 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:41116 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266825AbSKHRbl>; Fri, 8 Nov 2002 12:31:41 -0500
Subject: Re: [lkcd-devel] Re: What's left over.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
In-Reply-To: <m14ratepbf.fsf@frodo.biederman.org>
References: <Pine.LNX.4.44.0211052203150.1416-100000@home.transmeta.com> 
	<m14ratepbf.fsf@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Nov 2002 18:01:05 +0000
Message-Id: <1036778465.16626.66.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-07 at 08:50, Eric W. Biederman wrote:
> panic does not call sys_reboot it rolls that functionality by hand.
> And to a certain extent it makes sense for panic to take a different
> path because we know something is badly wrong so we need to be extra
> careful.

However both of them should use the same end point routines and the
hooks should go there

> reboots or panics.   This memory is not accounted for anywhere so no
> one can see that we have it allocated, which makes debugging hard.
> Additionally in locking up megabytes for a long period of time we
> create unsolvable fragmentation issues for the mm layer to deal with.

We have an MMU so if you just n thousand "get me a page" calls its quite
happy.

> In a unified design I can buffer the image in the anonymous pages of a
> user space process just as well as I can in locked down kernel memory.
> So factoring sys_kexec in to load and execute pieces only helps for
> executing the new image on a kernel panic, and that case does not
> actually work.

What if your user space is swapped out - you can't page it back in
safely

> - How should the pages allocated to an early loaded image be accounted
>   for?

Just get_free_page them - if you can handle it over 4Gb then specify
that high pages are fine and kmap them to copy into them - that makes
the VM on giant boxes way happier. For bonus points also adjust the
virtual memory accounting.

> - How do we avoid making life hard for the mm system with an early
>   loaded image?

Not really, especially if you are allowing high pages

> - Is it safe to call sys_reboot from panic?

No but both can call sys_machine_restart or whatever

> - Can we simply factor out the sequence:
> 		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
> 		system_running = 0;
> 		device_shutdown();
>   And place it into it's own subroutine?

Don't do that sequence on a panic IMHO (this is a standing issue, we
should not pass NULL but REBOOT/PANIC/KEXEC/... so the drivers can make
that decision - then we can do it right

Alan

