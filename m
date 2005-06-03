Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVFCQah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVFCQah (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 12:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVFCQag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 12:30:36 -0400
Received: from mx1.suse.de ([195.135.220.2]:61629 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261380AbVFCQaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 12:30:21 -0400
Date: Fri, 3 Jun 2005 18:30:10 +0200
From: Andi Kleen <ak@suse.de>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: john stultz <johnstul@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
Message-ID: <20050603163010.GR23831@wotan.suse.de>
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net> <200506021905.08274.kernel-stuff@comcast.net> <1117754453.17804.51.camel@cog.beaverton.ibm.com> <200506021950.35014.kernel-stuff@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506021950.35014.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 07:50:33PM -0400, Parag Warudkar wrote:
> On Thursday 02 June 2005 19:20, john stultz wrote:
> > Could you see if the slowness you're feeling is correlated to the
> > acpi_pm timesource?
> 
> Speaking of which, the below code from arch/i386/timer_pm.c looks particularly 
> more taxing to me - 3 times read from ioport in a loop - not sure how many 
> time that executes. 
> 
> static inline u32 read_pmtmr(void)
> {
>         u32 v1=0,v2=0,v3=0;
>         /* It has been reported that because of various broken
>          * chipsets (ICH4, PIIX4 and PIIX4E) where the ACPI PM time
>          * source is not latched, so you must read it multiple
>          * times to insure a safe value is read.
>          */
>         do {
>                 v1 = inl(pmtmr_ioport);
>                 v2 = inl(pmtmr_ioport);
>                 v3 = inl(pmtmr_ioport);
>         } while ((v1 > v2 && v1 < v3) || (v2 > v3 && v2 < v1)
>                         || (v3 > v1 && v3 < v2));
> 
> Shouldn't that loop be limited to the broken chipsets - why would correct 
> people with correctly working chipsets carry this extra burden? (Or is it 
> insignificant?)

It is not insignificant and makes a lot of difference. On the x86-64
version of pmtimer I dropped it completely and so far nobody 
complained.

However I wonder why this new time system is using pmtimer by default
at all. That is very broken because pmtimer is one of the slowest.
I would suggest to duplicate the time source selection I have
in the latest x86-64 (-rc5) time.c, that is optimal for all machines
I know about (except that you might need to add cyclone and a non TSC
fallback for i386)

-Andi
