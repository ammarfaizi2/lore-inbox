Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267370AbUIOU2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267370AbUIOU2n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267382AbUIOU1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:27:20 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:36300 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267370AbUIOUYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:24:18 -0400
Date: Wed, 15 Sep 2004 13:20:12 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: george anzinger <george@mvista.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
In-Reply-To: <1095274131.29408.2990.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0409151314350.1401@schroedinger.engr.sgi.com>
References: <1095265942.29408.2847.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0409150940420.1249@schroedinger.engr.sgi.com> 
 <1095268408.29408.2918.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0409151025090.3219@schroedinger.engr.sgi.com>
 <1095274131.29408.2990.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004, john stultz wrote:

> On Wed, 2004-09-15 at 10:30, Christoph Lameter wrote:
> > On Wed, 15 Sep 2004, john stultz wrote:
> >
> > > Well, not all time sources have that feature. Both TSC, and cyclone
> > > don't. You'd have to do something else for those. This is why my
> > > proposal has absolutely nothing to do with interrupt generation. It has
> > > a single hook that needs to be called only every once in a while, which
> > > can be done however any architecture wants.
> > >
> > > Interrupt generation has more to do with soft-timers and scheduling then
> > > time of day anyway.
> >
> > Hmm... I think this is a serious issue. The ability to exactly time an
> > interrupt and therefore specific actions is important. Maybe we can have a
> > fall back to soft interrupts if interrupt_at == NULL?
>
> Oh, its an issue, but one the time of day subsystem shouldn't solve. The
> code that manages interval (be it timer or whatever) interrupts should
> use the time of day subsystem to ensure they are triggering accurately,
> and manipulate the intervals as needed.

Huh? These are time related events. They cannot be managed effectively
outside of the time subsystem. You need at least a regularly interrupting
time source even for the current tick based approach.

> I think the functionality is essential, but that it doesn't belong in the time of day code.

Hmm. I was thinking all of this was about managing
the various time sources not only the time of day code.

> Basically we have two things we're trying to do:
>
> 1. Keep accurate time
> 2. Generate hardware interrupts accurately
>
> While frequently the same hardware can do both, not all hardware is
> usable for both functions. Thus I believe we should cleanly split these
> two subsystems. My proposal only provided the keep accurate time part,
> however one could using that functionality, to then manipulate hardware
> interrupts to ensure accuracy in the timer subsystem.

These two are intrisincally related and all modern hardware that I know
of does both. In a sense the regularly occuring  timer tick is also a
yet another form of time source but not does provide a counter (unless
simulated by jiffies). The timer subsystem needs to manage all
the available time sources of the system effectively and provide time
services to other subsystems.

