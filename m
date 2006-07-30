Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWG3Lfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWG3Lfc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 07:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWG3Lfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 07:35:31 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:55940 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932279AbWG3Lfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 07:35:30 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: swsusp regression (s2dsk) [Was: 2.6.18-rc2-mm1]
Date: Sun, 30 Jul 2006 13:34:38 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-pm@osdl.org,
       alsa-devel@alsa-project.org, mingo@elte.hu
References: <20060727015639.9c89db57.akpm@osdl.org> <200607301128.04395.rjw@sisk.pl> <44CC8FD3.5030403@gmail.com>
In-Reply-To: <44CC8FD3.5030403@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607301334.38704.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 July 2006 12:54, Jiri Slaby wrote:
> Uncc: linux-mm
> Cc: alsa-devel
> Cc: mingo
> 
> Rafael J. Wysocki wrote:
> > On Sunday 30 July 2006 10:08, Jiri Slaby wrote:
> >> Rafael J. Wysocki napsal(a):
> >>> On Sunday 30 July 2006 02:06, Pavel Machek wrote:
> >>>> Hi!
> >>>>
> >>>>>>>>> I have problems with swsusp again. While suspending, the very last thing kernel
> >>>>>>>>> writes is 'restoring higmem' and then hangs, hardly. No sysrq response at all.
> >>>>>>>>> Here is a snapshot of the screen:
> >>>>>>>>> http://www.fi.muni.cz/~xslaby/sklad/swsusp_higmem.gif
> >>>>>>>>>
> >>>>>>>>> It's SMP system (HT), higmem enabled (1 gig of ram).
> >>>>>>>> Most probably it hangs in device_power_up(), so the problem seems to be
> >>>>>>>> with one of the devices that are resumed with IRQs off.
> >>>>>>>>
> >>>>>>>> Does vanila .18-rc2 work?
> >>>>>>> Yup, it does.
> >>>>>> Can you try up kernel, no highmem? (mem=512M)?
> >>>>> It writes then:
> >>>>> p16v: status 0xffffffff, mask 0x00001000, pvoice f7c04a20, use 0
> >>>>> in endless loop when resuming -- after reading from swap.
> >>>> Okay, so we have two different problems here.
> 
> [snip]
> 
> >>>> and one is probably driver problem with p16v (whatever it is).
> >>>>
> >>>> /data/l/linux/sound/pci/emu10k1/irq.c:
> >>>> snd_printk(KERN_ERR "p16v: status: 0x%08x, mask=0x%08x, pvoice=%p,
> >>>> use=%d\n", status2, mask, pvoice, pvoice->use);
> >>>>
> >>>> ...aha, so you may want to unload emu10k1 for testing.
> >> Sure, this helped.
> > 
> > So, we have two different regressions here.
> > 
> > Please try to revert git-alsa.patch and see if the emu10k1-related problem
> > goes away.
> 
> Wow, it didn't helped, I find out there is a difference between in-kernel and 
> modules version of the driver. When compiled as modules (loaded/unloaded) 
> suspending (and resuming) is working ok (enabled higmem and preempt back -- 
> still no smp), when compiled in-kernel (see the config diff below), it doesn't 
> resume.
> @@ -1263,8 +1263,8 @@
>   CONFIG_SND=y
>   CONFIG_SND_TIMER=y
>   CONFIG_SND_PCM=y
> -CONFIG_SND_HWDEP=m
> -CONFIG_SND_RAWMIDI=m
> +CONFIG_SND_HWDEP=y
> +CONFIG_SND_RAWMIDI=y
>   CONFIG_SND_SEQUENCER=y
>   # CONFIG_SND_SEQ_DUMMY is not set
>   CONFIG_SND_OSSEMUL=y
> @@ -1282,8 +1282,8 @@
>   #
>   # Generic devices
>   #
> -CONFIG_SND_AC97_CODEC=m
> -CONFIG_SND_AC97_BUS=m
> +CONFIG_SND_AC97_CODEC=y
> +CONFIG_SND_AC97_BUS=y
>   # CONFIG_SND_DUMMY is not set
>   # CONFIG_SND_VIRMIDI is not set
>   # CONFIG_SND_MTPAV is not set
> @@ -1347,7 +1347,7 @@
>   # CONFIG_SND_INDIGO is not set
>   # CONFIG_SND_INDIGOIO is not set
>   # CONFIG_SND_INDIGODJ is not set
> -CONFIG_SND_EMU10K1=m
> +CONFIG_SND_EMU10K1=y
>   # CONFIG_SND_EMU10K1X is not set
>   # CONFIG_SND_ENS1370 is not set
>   # CONFIG_SND_ENS1371 is not set

If the driver is compiled in, its .suspend() routine gets called before the
suspend image is restored and puts the card in a state that confuses
the .resume() called after the image has been restored.

I think snd_emu10k1_suspend() should reset the device if state == PMSG_PRETHAW .

> > As far as the first one is concerned, the genirq-* patches look suspicious.
> 
> Hmm, what to do?

I would try to revert them altogether and see what happens.  If that doesn't
help, the only thing that comes to mind is to carry out a binary search for
the offending patch. :-(

Greetings,
Rafael
