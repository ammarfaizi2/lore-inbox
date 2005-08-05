Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262858AbVHEFQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262858AbVHEFQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 01:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbVHEFQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 01:16:29 -0400
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:58835 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262858AbVHEFQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 01:16:28 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Date: Fri, 5 Aug 2005 15:12:18 +1000
User-Agent: KMail/1.8.1
Cc: Jan De Luyck <lkml@kcore.org>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org, tony@atomide.com, tuukka.tikkanen@elektrobit.com
References: <200508031559.24704.kernel@kolivas.org> <200508031624.00319.lkml@kcore.org> <20050804150341.GA10282@ucw.cz>
In-Reply-To: <20050804150341.GA10282@ucw.cz>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_yUv8CUP3JOPYPXo"
Message-Id: <200508051512.18500.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_yUv8CUP3JOPYPXo
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 5 Aug 2005 01:03 am, Vojtech Pavlik wrote:
> On Wed, Aug 03, 2005 at 04:23:59PM +0200, Jan De Luyck wrote:
> > On Wednesday 03 August 2005 14:14, Con Kolivas wrote:
> > > On Wed, 3 Aug 2005 21:54, Jan De Luyck wrote:
> > > > On Wednesday 03 August 2005 07:59, Con Kolivas wrote:
> > > > > This is the dynamic ticks patch for i386 as written by Tony Lindgen
> > > > > <tony@atomide.com> and Tuukka Tikkanen
> > > > > <tuukka.tikkanen@elektrobit.com>. Patch for 2.6.13-rc5
> > > >
> > > > Compiles and runs ok here.
> > > >
> > > > Is there actually any timer frequency that's advisable to set as
> > > > maximum? (in the kernel config)
> > >
> > > I'd recommend 1000.
> >
> > Thanks. Currently the system - under X, KDE, no artsd, bottoms at around
> > 300HZ. In total single mode with every module unloaded that I can unload
> > it stops around 22HZ.
> >
> > I guess I'll have to go hunting whatever thing is causing the pollings.
> > no timertop yet, I guess? :P
>
> i8042 runs a steady periodic 20Hz timer. You can make it slower to get
> even the total low lower, and it will not affect performance under
> normal (sane hardware) circumstances.

Indeed and this patch (safely tried at home but serves no useful purpose 
really) confirms a reasonable drop without problems. After this, only fbcon 
polls at a similar rate (HZ/5).

Of interest to those using an ondemand scaling governor, now that we have 
timertop, I have found that the default ondemand settings lead to 
delayed_work_timer_fn at about 140Hz and this can be dropped substantially by 
slowing the rate of polling (and subsequently slowing the speed with which 
the ondemand governor responds) down to <25 by

echo 100000 > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_rate

(the default is 10000 and the value is confusing as the rate goes down as you 
increase this value).

Cheers,
Con

--Boundary-00=_yUv8CUP3JOPYPXo
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="i8042_slowpoll.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="i8042_slowpoll.patch"

Index: linux-2.6.13-rc5-ck2/drivers/input/serio/i8042.h
===================================================================
--- linux-2.6.13-rc5-ck2.orig/drivers/input/serio/i8042.h	2005-07-06 16:56:52.000000000 +1000
+++ linux-2.6.13-rc5-ck2/drivers/input/serio/i8042.h	2005-08-05 15:03:49.000000000 +1000
@@ -44,7 +44,7 @@
  * polling.
  */
 
-#define I8042_POLL_PERIOD	HZ/20
+#define I8042_POLL_PERIOD	HZ/5
 
 /*
  * Status register bits.

--Boundary-00=_yUv8CUP3JOPYPXo--
