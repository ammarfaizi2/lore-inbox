Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWG3J25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWG3J25 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 05:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWG3J25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 05:28:57 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:6788 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932140AbWG3J25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 05:28:57 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: swsusp regression (s2dsk) [Was: 2.6.18-rc2-mm1]
Date: Sun, 30 Jul 2006 11:28:04 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-pm@osdl.org, linux-mm@kvack.org
References: <20060727015639.9c89db57.akpm@osdl.org> <200607300931.07679.rjw@sisk.pl> <44CC68EE.1080208@gmail.com>
In-Reply-To: <44CC68EE.1080208@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607301128.04395.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 July 2006 10:08, Jiri Slaby wrote:
> Rafael J. Wysocki napsal(a):
> > On Sunday 30 July 2006 02:06, Pavel Machek wrote:
> >> Hi!
> >>
> >>>>>>> I have problems with swsusp again. While suspending, the very last thing kernel
> >>>>>>> writes is 'restoring higmem' and then hangs, hardly. No sysrq response at all.
> >>>>>>> Here is a snapshot of the screen:
> >>>>>>> http://www.fi.muni.cz/~xslaby/sklad/swsusp_higmem.gif
> >>>>>>>
> >>>>>>> It's SMP system (HT), higmem enabled (1 gig of ram).
> >>>>>> Most probably it hangs in device_power_up(), so the problem seems to be
> >>>>>> with one of the devices that are resumed with IRQs off.
> >>>>>>
> >>>>>> Does vanila .18-rc2 work?
> >>>>> Yup, it does.
> >>>> Can you try up kernel, no highmem? (mem=512M)?
> >>> It writes then:
> >>> p16v: status 0xffffffff, mask 0x00001000, pvoice f7c04a20, use 0
> >>> in endless loop when resuming -- after reading from swap.
> >> Okay, so we have two different problems here.
> >>
> >> One is "hang during suspend" with smp/highmem mode,
> > 
> > That one is "interesting".  I've no idea why the restoration of highmem would
> > have caused the box to hang like that.  Jiri, could you please post the output
> > of dmesg after a fresh boot?
> 
> higmem is ok. ioapic0 is the culprit -- its class resume dies:
>         if (cls->resume)
>                 cls->resume(dev); <----
> in __sysdev_resume

Ah, so my first guess was actually correct. :-)

> >> and one is probably driver problem with p16v (whatever it is).
> >>
> >> /data/l/linux/sound/pci/emu10k1/irq.c:
> >> snd_printk(KERN_ERR "p16v: status: 0x%08x, mask=0x%08x, pvoice=%p,
> >> use=%d\n", status2, mask, pvoice, pvoice->use);
> >>
> >> ...aha, so you may want to unload emu10k1 for testing.
> 
> Sure, this helped.

So, we have two different regressions here.

Please try to revert git-alsa.patch and see if the emu10k1-related problem
goes away.

As far as the first one is concerned, the genirq-* patches look suspicious.

Greetings,
Rafael
