Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264695AbSJORsN>; Tue, 15 Oct 2002 13:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbSJORr7>; Tue, 15 Oct 2002 13:47:59 -0400
Received: from zola.noos.net ([212.198.2.76]:13372 "EHLO smtp.noos.fr")
	by vger.kernel.org with ESMTP id <S264695AbSJORqP>;
	Tue, 15 Oct 2002 13:46:15 -0400
Date: Tue, 15 Oct 2002 19:39:28 +0200
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: David Brownell <david-b@pacbell.net>
Cc: greg@kroah.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] 2.5.42-ac1, 2.5.42, 2.5.41 boot hang with CONFIG_USB_DEBUG=n
Message-ID: <20021015173928.GA972@rousalka.noos.fr>
References: <20021013172557.GA890@rousalka.noos.fr> <3DAAF67F.1080504@pacbell.net> <20021014212000.GA1002@rousalka.noos.fr> <3DAC4BE8.6080109@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3DAC4BE8.6080109@pacbell.net>; from david-b@pacbell.net on mar, oct 15, 2002 at 19:10:00 +0200
X-Mailer: Balsa 2.0.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002.10.15 19:10 David Brownell wrote:
>> Procedure was following :
>> 1. reboot the computer (software reboot if ok kernel, else reset)
>> 2. go through bios (long initiation with memory testing)
>> 3. when the bootloader shows up (might hang just before, my disks 
>> really do not like being stopped before reboot) / when the system 
>> hangs, press reset
>> 4. go through bios initialization (bis)
>> 5. when grub shows up, play a bit in the menus (up-down...) then 
>> choose a kernel
>> 
>> With this protocol I got a 100% boot rate on the original kernel and 
>> an almost-always hang with the kernel where debuging was undefed in 
>> drivers/usb/host/ohci-hcd.c. It did boot two times (out of maybe 
>> 10-15 tries) but that doesn't count since both times the keyboard 
>> was dead.
> 
> Well, I've seen USB getting annoyingly flakey results in recent 
> kernels.
> That's a little bit outside the bounds of the inconsistency I've seen,
> but (I hate to say) not unrealistically so, since you're kicking init
> sequences in different ways.  That makes troubleshooting harder!

Well, I knew AMD 756 + USB was a bit risky, guess I was too much in a 
2.5 mood when I bought this keyboard.

> There are some one-liners floating around that make it a lot better,
> like making drivers/base/core.c found_match() "return error != 0"
> (true == matched) instead of "return error" (true == failed).  That
> one might not be your issue at all, but I've seen it to fix failures
> that closely resemble your "dead devices" mode.

I"ll try this.

>> No such luck. It really looks like ohci is the culprit:(
> 
> Maybe not, given that you did report (in an earlier note):
> 
> > + ... Unfortunately I've found out today not even CONFIG_USB_DEBUG
> > + was sufficient, since I had a boot hand (cold boot) with my debug
> > + kernel today (warm boot afterwards was ok, though).
> 
> Even if it isn't one of the bugs causing generic flakiness, a
> warm-vs-cold boot problem that's ohci-specific isn't something
> that should have appeared in recent kernels.  I'd be curious.
> Was 2.5.38 behaving OK for you?  Or earlier 2.5 kernels?

I'm afraid I didn't try any 2.5 kernel before 2.5.41.
If you have a particular version you'd like me tot test, I'll do it 
(provided it's not one of the disk-eating ones).

I *think* there is a problem in 2.5, and cold booting make it worse, 
enabling usb debug makes it better.
*If* I had not both RH8 2.4.18 and w2k booting happily on my hardware 
(both cold and warm boots) I would suspect it but that's not the case.

>> P.S.
>> 
>>     I don't know if it's important, but I had to enable usb keyboard 
>> legacy mode in the bios to have keyboard support in the bootloader 
>> stage. I had a bad feeling about the option though, a good bios is a 
>> lean bios.
> 
> Unless your boot loader has a small USB stack, leave that emulation
> enabled in the bios.  Linux will disable it when you bring up USB.
> 
> But it'd be worth seeing if there were any problems with that.  In 
> fact,
> in drivers/usb/host/ohci-hcd.c there is one dbg() that could affect
> init timing.  Experiment:  leave all debug messages off, but change
> the first dbg() call in hc_reset() into an err() call.  Does that make
> things better?

I'll do this now, then the found_match thing, and post the results.

Thanks for the suggestions,

--
Nicolas Mailhot
