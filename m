Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVHBIPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVHBIPa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 04:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVHBIPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 04:15:30 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:48544 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261415AbVHBIP1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 04:15:27 -0400
X-ORBL: [67.117.73.34]
Date: Tue, 2 Aug 2005 01:15:13 -0700
From: Tony Lindgren <tony@atomide.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       tuukka.tikkanen@elektrobit.com, ck@vds.kolivas.org
Subject: Re: [patch] i386 dynamic ticks 2.6.13-rc4 (code reordered)
Message-ID: <20050802081512.GI15903@atomide.com>
References: <200508021443.55429.kernel@kolivas.org> <1122963870.5490.17.camel@mindpipe> <20050802071703.GG15903@atomide.com> <200508021739.20347.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508021739.20347.kernel@kolivas.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Con Kolivas <kernel@kolivas.org> [050802 00:36]:
> On Tue, 2 Aug 2005 05:17 pm, Tony Lindgren wrote:
> > * Lee Revell <rlrevell@joe-job.com> [050801 23:24]:
> > > On Tue, 2005-08-02 at 15:56 +1000, Con Kolivas wrote:
> > > > On Tue, 2 Aug 2005 03:52 pm, Lee Revell wrote:
> > > > > On Tue, 2005-08-02 at 15:49 +1000, Con Kolivas wrote:
> > > > > > As a crude data point of idle system running a full kde desktop
> > > > > > environment on
> > > > > > powersave with minimal backlight and just chatting on IRC I find
> > > > > > it's just
> > > > > > under 10% battery life difference.
> > > > >
> > > > > Have you tried the same test but without artsd, or with it configured
> > > > > to release the sound device after some reasonable time, like 1-2s?
> > > >
> > > > I have it on release after 1 second already.
> > >
> > > Is there any difference in power use between this, and not running artsd
> > > at all?
> >
> > Please have the pmstats from http://www.muru.com/linux/dyntick running
> > in once console with pmstats 5, and then just kill programs to find out
> > which ones use lots of timers. CPU monitors etc.
> >
> > You should get X running at about 25HZ, (which is the PIT limit usually)
> > Higher ticks means means polling somewhere which totally kills any power
> > savings.
> 
> Ok I seem to be bottoming out at 130Hz. I can't seem to kill off anything 
> more.
> 
> >
> > There's still some places in kernel that also do polling as far as I
> > remember:
> >
> > - AT keyboard if no keyboard connected
> > - Netfilter code (Unverified)
> >
> > But this you can verify by booting to single user mode and then running
> > pmstats 5, and if ticks is not below 25HZ, there's something in the kernel
> > polling.
> 
> I'm removing modules and they don't seem to do anything so I'm not sure what 
> else to try.

If you have 130HZ in single user mode, it's some kernel driver.
You could printk the the next timer, then grep for that in System.map:

--- linux-2.6.orig/kernel/timer.c	2005-06-27 07:51:58.000000000 -0700
+++ linux-2.6/kernel/timer.c	2005-06-28 06:57:27.000000000 -0700
@@ -571,6 +571,7 @@
 				expires = nte->expires;
 		}
 	}
+	printk("next: %08x\n", nte->function);
 	spin_unlock(&base->t_base.lock);
 	return expires;
 }

Of course the console will be useless with this patch :)

I really need to do the timertop utility at some point...

Tony
