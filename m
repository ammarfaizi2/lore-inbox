Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbTJHIYN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 04:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTJHIYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 04:24:12 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:24083 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S261214AbTJHIYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 04:24:08 -0400
Date: Wed, 8 Oct 2003 10:23:46 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard repeat speed went nuts since 2.6.0-test5, even in 2.6.0-test6-mm4
Message-ID: <20031008082346.GA1628@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <20031007203316.GA1719@middle.of.nowhere> <20031007204056.GB20844@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031007204056.GB20844@ucw.cz>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vojtech Pavlik <vojtech@suse.cz>
Date: Tue, Oct 07, 2003 at 10:40:56PM +0200
> On Tue, Oct 07, 2003 at 10:33:16PM +0200, Jurriaan wrote:
> > I like my keyboard fast (must be from playing a lot of angband).
> > 
> > In 2.6.0-test5, after '/sbin/kbdrate -r 30 -d 250', I get some 2000
> > characters in a minute (pressing n continuously, stopwatch in hand).
> > In 2.6.0-test6 and 2.6.0-test6-mm4, after '/sbin/kbdrate -r 30 -d 250',
> > I get some 820 characters in a minute.
> > 
> > 30 cps != 800/60 s, that's more like half that rate.
> > 
> > Booting with or without atkbd_softrepeat=1 on the kernel commandline
> > makes no difference at all.
> 
> It's a bug. I have a fix, it went through LKML already, but Linus
> didn't merge it yet. I'll be resending it.
> 
> > It's not only the repeat-speed that has gone down, the delay before
> > repeat kicks in is notably slower as well. This is perhaps even more
> > frustrating, but harder to measure :-(
> > 
> > This is on a plain Chicony KB-7903 PS/2 keyboard. It is connected via a
> > Vista Rose KVM to a VIA KT400 chipset motherboard.
> > 
> > Any patches to test are very welcome here.
> 
> Fix attached.
> 
Sorry, but that fix is already in 2.6.0-test6-mm4; that's why I tested
that version...

Anyway, I added some printk's like this:

                case EV_REP:

                        printk( KERN_INFO "atkbd: atkbd_softrepeat %d\n", atkbd_softrepeat);
                        if (atkbd_softrepeat) return 0;

                        i = j = 0;
                        while (i < 32 && period[i] < dev->rep[REP_PERIOD]) i++;
                        while (j < 4 && delay[j] < dev->rep[REP_DELAY]) j++;
                        dev->rep[REP_PERIOD] = period[i];
                        dev->rep[REP_DELAY] = delay[j];
                        printk( KERN_INFO "atkbd: period %d delay %d\n", period[i], delay[j]);
                        param[0] = i | (j << 5);
                        atkbd_command(atkbd, param, ATKBD_CMD_SETREP);

                        return 0;

And even if my command-line for the kernel looks like this:

Kernel command line: root=/dev/md3 video=matroxfb:xres:1600,yres:1360,depth:16,pixclock:4116,left:304,right:64,upper:46,lower:1,hslen
:192,vslen:3,fv:90,hwcursor=off hdb=scsi apm=power-off atkbd_softrepeat=1

I still see this:

:kbdrate -r 50 -d 100
atkbd: atkbd_softrepeat 0
atkbd: period 33 delay 250
atkbd: atkbd_softrepeat 0
atkbd: period 33 delay 250
Typematic Rate set to 30.3 cps (delay = 250 ms)

and I still get only 800 cpm, which means 14 cps or so.
Why it atkbd_softrepeat still 0 with this command-line?

Kind regards,
Jurriaan
-- 
How should I know if it works?  That's what beta testers are for.  I
only coded it.
	Attributed to Linus Torvalds, somewhere in a posting
Debian (Unstable) GNU/Linux 2.6.0-test6-mm4 4276 bogomips 0.27 0.14
