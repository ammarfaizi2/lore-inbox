Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264670AbSJORCl>; Tue, 15 Oct 2002 13:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264674AbSJORCl>; Tue, 15 Oct 2002 13:02:41 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:32154 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S264670AbSJORCh>; Tue, 15 Oct 2002 13:02:37 -0400
Date: Tue, 15 Oct 2002 10:10:00 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] 2.5.42-ac1, 2.5.42,
 2.5.41 boot hang with CONFIG_USB_DEBUG=n
To: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
Cc: greg@kroah.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-id: <3DAC4BE8.6080109@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <20021013172557.GA890@rousalka.noos.fr>
 <3DAAF67F.1080504@pacbell.net> <20021014212000.GA1002@rousalka.noos.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Procedure was following :
> 1. reboot the computer (software reboot if ok kernel, else reset)
> 2. go through bios (long initiation with memory testing)
> 3. when the bootloader shows up (might hang just before, my disks really 
> do not like being stopped before reboot) / when the system hangs, press 
> reset
> 4. go through bios initialization (bis)
> 5. when grub shows up, play a bit in the menus (up-down...) then choose 
> a kernel
> 
> With this protocol I got a 100% boot rate on the original kernel and an 
> almost-always hang with the kernel where debuging was undefed in 
> drivers/usb/host/ohci-hcd.c. It did boot two times (out of maybe 10-15 
> tries) but that doesn't count since both times the keyboard was dead. 

Well, I've seen USB getting annoyingly flakey results in recent kernels.
That's a little bit outside the bounds of the inconsistency I've seen,
but (I hate to say) not unrealistically so, since you're kicking init
sequences in different ways.  That makes troubleshooting harder!

There are some one-liners floating around that make it a lot better,
like making drivers/base/core.c found_match() "return error != 0"
(true == matched) instead of "return error" (true == failed).  That
one might not be your issue at all, but I've seen it to fix failures
that closely resemble your "dead devices" mode.


> No such luck. It really looks like ohci is the culprit:(

Maybe not, given that you did report (in an earlier note):

 > + ... Unfortunately I've found out today not even CONFIG_USB_DEBUG
 > + was sufficient, since I had a boot hand (cold boot) with my debug
 > + kernel today (warm boot afterwards was ok, though).

Even if it isn't one of the bugs causing generic flakiness, a
warm-vs-cold boot problem that's ohci-specific isn't something
that should have appeared in recent kernels.  I'd be curious.
Was 2.5.38 behaving OK for you?  Or earlier 2.5 kernels?


> P.S.
> 
>     I don't know if it's important, but I had to enable usb keyboard 
> legacy mode in the bios to have keyboard support in the bootloader 
> stage. I had a bad feeling about the option though, a good bios is a 
> lean bios.

Unless your boot loader has a small USB stack, leave that emulation
enabled in the bios.  Linux will disable it when you bring up USB.

But it'd be worth seeing if there were any problems with that.  In fact,
in drivers/usb/host/ohci-hcd.c there is one dbg() that could affect
init timing.  Experiment:  leave all debug messages off, but change
the first dbg() call in hc_reset() into an err() call.  Does that make
things better?

- Dave

