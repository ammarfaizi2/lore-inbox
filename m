Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVFCS1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVFCS1x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 14:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVFCS1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 14:27:53 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:14983 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261486AbVFCS1p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 14:27:45 -0400
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Parag Warudkar <kernel-stuff@comcast.net>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
In-Reply-To: <20050603163010.GR23831@wotan.suse.de>
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net>
	 <200506021905.08274.kernel-stuff@comcast.net>
	 <1117754453.17804.51.camel@cog.beaverton.ibm.com>
	 <200506021950.35014.kernel-stuff@comcast.net>
	 <20050603163010.GR23831@wotan.suse.de>
Content-Type: text/plain
Date: Fri, 03 Jun 2005 11:27:37 -0700
Message-Id: <1117823257.17804.60.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-03 at 18:30 +0200, Andi Kleen wrote:
> On Thu, Jun 02, 2005 at 07:50:33PM -0400, Parag Warudkar wrote:
> > On Thursday 02 June 2005 19:20, john stultz wrote:
> > > Could you see if the slowness you're feeling is correlated to the
> > > acpi_pm timesource?
> > 
> > Speaking of which, the below code from arch/i386/timer_pm.c looks particularly 
> > more taxing to me - 3 times read from ioport in a loop - not sure how many 
> > time that executes. 
> > 
> > static inline u32 read_pmtmr(void)
> > {
> >         u32 v1=0,v2=0,v3=0;
> >         /* It has been reported that because of various broken
> >          * chipsets (ICH4, PIIX4 and PIIX4E) where the ACPI PM time
> >          * source is not latched, so you must read it multiple
> >          * times to insure a safe value is read.
> >          */
> >         do {
> >                 v1 = inl(pmtmr_ioport);
> >                 v2 = inl(pmtmr_ioport);
> >                 v3 = inl(pmtmr_ioport);
> >         } while ((v1 > v2 && v1 < v3) || (v2 > v3 && v2 < v1)
> >                         || (v3 > v1 && v3 < v2));
> > 
> > Shouldn't that loop be limited to the broken chipsets - why would correct 
> > people with correctly working chipsets carry this extra burden? (Or is it 
> > insignificant?)
> 
> It is not insignificant and makes a lot of difference. On the x86-64
> version of pmtimer I dropped it completely and so far nobody 
> complained.

Alright, I'll add a single read function and keep the triple read
function around just in case. Maybe we can use some sort of dmi
blacklist to auto-detect known trouble cases.

> However I wonder why this new time system is using pmtimer by default
> at all. That is very broken because pmtimer is one of the slowest.
> I would suggest to duplicate the time source selection I have
> in the latest x86-64 (-rc5) time.c, that is optimal for all machines
> I know about (except that you might need to add cyclone and a non TSC
> fallback for i386)

The priority values may need some tweaking. The acpi-pm timesource is
really useful on laptops that have cpufreq issues, so it has been a
higher priority then the TSC in i386 for awhile. 

How about something like this?

300 TSC 
200 HPET
200 CYCLONE
100 ACPI
050 PIT
010 JIFFIES

Then if the system has TSC issues (unsynced, cpufreq problems, etc), we
can demote the TSC's priority to 50 and it will fall back nicely without
manual intervention.

thanks
-john


