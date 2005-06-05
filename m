Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVFEUGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVFEUGr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 16:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVFEUGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 16:06:47 -0400
Received: from isilmar.linta.de ([213.239.214.66]:60857 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261604AbVFEUGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 16:06:43 -0400
Date: Sun, 5 Jun 2005 19:05:11 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: john stultz <johnstul@us.ibm.com>
Cc: Parag Warudkar <kernel-stuff@comcast.net>,
       Nishanth Aravamudan <nacc@us.ibm.com>, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       David Mosberger <davidm@hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
Message-ID: <20050605170511.GC12338@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	john stultz <johnstul@us.ibm.com>,
	Parag Warudkar <kernel-stuff@comcast.net>,
	Nishanth Aravamudan <nacc@us.ibm.com>, Andi Kleen <ak@suse.de>,
	lkml <linux-kernel@vger.kernel.org>,
	Tim Schmielau <tim@physik3.uni-rostock.de>,
	George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
	Christoph Lameter <clameter@sgi.com>,
	David Mosberger <davidm@hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
	paulus@samba.org, schwidefsky@de.ibm.com,
	keith maanthey <kmannth@us.ibm.com>,
	Chris McDermott <lcm@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
	mahuja@us.ibm.com, Darren Hart <darren@dvhart.com>,
	"Darrick J. Wong" <djwong@us.ibm.com>,
	Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
	benh@kernel.crashing.org
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net> <200506021905.08274.kernel-stuff@comcast.net> <1117754453.17804.51.camel@cog.beaverton.ibm.com> <200506021950.35014.kernel-stuff@comcast.net> <1117812275.3674.2.camel@leatherman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117812275.3674.2.camel@leatherman>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 08:24:35AM -0700, john stultz wrote:
> On Thu, 2005-06-02 at 19:50 -0400, Parag Warudkar wrote:
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
> Yea, that would be nice to only do the triple read on the affected
> systems. Although outside of the comment I don't have any real data as
> to which system suffer from the issue.

IIRC (from the comment above) several chipsets suffer from this
inconsistency, namely the widely used PIIX4(E) and ICH(4 only? or also other
ICH-ones?). Therefore, we'd need at least some sort of boot-time check to
decide which method to use... and based on the method, we can adjust the
priority maybe?

Thanks,
	Dominik
