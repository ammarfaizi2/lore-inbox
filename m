Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271728AbTGXUot (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 16:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271729AbTGXUos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 16:44:48 -0400
Received: from fmr05.intel.com ([134.134.136.6]:44510 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S271728AbTGXUoj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 16:44:39 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] 2.4.22-pre7 : ACPI poweroff fix
Date: Thu, 24 Jul 2003 13:59:45 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A847E97074@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.4.22-pre7 : ACPI poweroff fix
Thread-Index: AcNR507kBzSh8pFwTZmogLq9uAyxJwAPwjaw
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>,
       "Willy Tarreau" <willy@w.ods.org>
Cc: "lkml" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Jul 2003 20:59:45.0742 (UTC) FILETIME=[830D2EE0:01C35226]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo (and Willy),

Sorry if I've been unresponsive. Looks good to me.

Thanks -- Regards -- Andy

> -----Original Message-----
> From: Marcelo Tosatti [mailto:marcelo@conectiva.com.br] 
> Sent: Thursday, July 24, 2003 6:23 AM
> To: Willy Tarreau; Grover, Andrew
> Cc: lkml
> Subject: Re: [PATCH] 2.4.22-pre7 : ACPI poweroff fix
> 
> 
> 
> Andrew,
> 
> What is your opinion on this patch?
> 
> On Wed, 23 Jul 2003, Willy Tarreau wrote:
> 
> > Hi Marcelo,
> >
> > [ this is a resend, there has been a delivery failure at 
> conectiva. If
> >   you want, I can forward you the copy from the mailer daemon ]
> >
> > here are those fixes again. I have received a second report that it
> > fixed the ACPI poweroff bug (this time, for <cijoml@volny.cz>).
> > IIRC, when you unroll the code, it's obviously buggy because a
> > function (of which I don't remember the name, it's 3 months old) is
> > called explicitely for state=S5, but avoids this value within the
> > tests !
> >
> > Please apply it, or ask Andrew for some feedback. It seems as if he
> > doesn't receive my emails, I've sent him these patches 2 or 3 times
> > since, including one on the acpi-devel list, but never got any
> > feedback (or I had no luck and mailed him during his hollidays) :-(
> >
> > Unfortunately, I have not kept the original mail containing my
> > analysis of the problem at this time.
> >
> > Thanks in advance,
> > Willy
> >
> > ----- Forwarded message from Willy Tarreau <willy@w.ods.org> -----
> >
> > Date: 	Thu, 10 Jul 2003 09:58:50 +0200
> > From: Willy Tarreau <willy@w.ods.org>
> > To: Aschwin Marsman <a.marsman@aYniK.com>
> > Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
> >        lkml <linux-kernel@vger.kernel.org>
> > Subject: Re: Linux 2.4.22-pre4
> > In-Reply-To: 
> <Pine.LNX.4.44.0307100717570.18695-100000@localhost.localdomain>
> > User-Agent: Mutt/1.4i
> > Precedence: bulk
> > X-Mailing-List: 	linux-kernel@vger.kernel.org
> >
> > Hi !
> >
> > On Thu, Jul 10, 2003 at 07:23:32AM +0200, Aschwin Marsman wrote:
> > > On Wed, 9 Jul 2003, Marcelo Tosatti wrote:
> > >
> > > > Hi,
> > > >
> > > > Here goes -pre4. It contains a lot of updates and fixes.
> > > >
> > > > We decided to include this new code quota code which 
> allows usage of
> > > > quotas with 32bit UID/GIDs.
> > > >
> > > > Most Toshibas should work now due to an important ACPI fix.
> > > >
> > > > Please help and test.
> > >
> > > I use -pre3 with succes, only power down is currently not working
> > > (only the discs shutdown, no real poweroff). That's why I disabled
> > > apm and enabled apm in the kernel with -pre4, but that gives:
> >
> > I remember having had problems with ACPI because my power 
> off didn't work.
> > After reading through the code, I noticed that due to 
> erroneous comparisons,
> > some code path would never be executed, and/or some 
> preparatory work before
> > entering S5 would be done twice, or could not recover from 
> error, I don't
> > recall exactly. So I sent the two patches below to the 
> acpi-devel list twice,
> > but never got any reply.
> >
> > I don't even know if they still apply, but you can try them 
> anyway, they're
> > simple.
> >
> > If I recall correctly, the first one should be enough to 
> poweroff with a simple
> > "echo 5 > /proc/acpi/sleep", while the second one allows 
> the system to use this
> > for poweroff.
> >
> > Cheers,
> > Willy
> >
> >
> > --- ./drivers/acpi/system.c-orig	Tue Apr 29 17:39:34 2003
> > +++ ./drivers/acpi/system.c	Tue Apr 29 19:08:09 2003
> > @@ -180,7 +180,7 @@
> >  			return AE_ERROR;
> >  	}
> >
> > -	if (state < ACPI_STATE_S5) {
> > +	if (state <= ACPI_STATE_S5) {
> >  		/* Tell devices to stop I/O and actually save 
> their state.
> >  		 * It is theoretically possible that something 
> could fail,
> >  		 * so handle that gracefully..
> > @@ -277,6 +277,7 @@
> >
> >  	switch (state) {
> >  	case ACPI_STATE_S1:
> > +	case ACPI_STATE_S5:
> >  		barrier();
> >  		status = acpi_enter_sleep_state(state);
> >  		break;
> >
> >
> >
> > --- ./drivers/acpi/system.c-orig	Tue Apr 29 19:09:19 2003
> > +++ ./drivers/acpi/system.c	Tue Apr 29 19:36:08 2003
> > @@ -90,9 +90,7 @@
> >  static void
> >  acpi_power_off (void)
> >  {
> > -	acpi_enter_sleep_state_prep(ACPI_STATE_S5);
> > -	ACPI_DISABLE_IRQS();
> > -	acpi_enter_sleep_state(ACPI_STATE_S5);
> > +	acpi_suspend(ACPI_STATE_S5);
> >  }
> >
> >  #endif /*CONFIG_PM*/
> >
> >
> >
> >
> 
