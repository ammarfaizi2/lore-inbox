Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbWBHBEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWBHBEi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 20:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbWBHBEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 20:04:38 -0500
Received: from scl-ims.phoenix.com ([216.148.212.222]:12512 "EHLO
	scl-exch2k.phoenix.com") by vger.kernel.org with ESMTP
	id S1030339AbWBHBEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 20:04:37 -0500
Subject: Re: [linux-usb-devel] Re: ATI RS480-based motherboard: stuck while
	 booting with kernel >= 2.6.15 rc1
From: Aleksey V Gorelov <aleksey_gorelov@phoenix.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       "Carlo E. Prelz" <fluido@fluido.as>, linux-kernel@vger.kernel.org
In-Reply-To: <200602071405.49462.david-b@pacbell.net>
References: <0EF82802ABAA22479BC1CE8E2F60E8C3B01A40@scl-exch2k3.phoenix.com>
	 <200602071405.49462.david-b@pacbell.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 07 Feb 2006 17:04:36 -0800
Message-Id: <1139360676.14882.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
X-OriginalArrivalTime: 08 Feb 2006 01:04:36.0900 (UTC) FILETIME=[A16BBE40:01C62C4B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-07 at 14:05 -0800, David Brownell wrote:
> On Monday 06 February 2006 6:03 pm, Aleksey Gorelov wrote:
> > Hi Dave,
> > 
> > >....
> > >
> > >I think what happened is the "always run quirks" code got turned into
> > >the default too early, before the EHCI "quirk" version of the handoff
> > >code got checked against what most systems have been using for the past
> > >several years.
> > >
> > >I noticed at least one suspicous thing:  it enables an SMI IRQ.
> > 
> >   As far as I recall, some BIOSes can be stuck at handoff forever
> > waiting for SMI if this is not enabled. No doubt BIOS bug, and seems
> > like work around brakes some other systems, grrr...
> 
> I gathered as much and that's why I preserved that behavior.
> 
> But it would be nice to know _which_ BIOS versions have that bug;
> it's clearly a BIOS bug, and given the other problems we've seen,
> it might be better to have that "turn on the SMI" be keyed by some
> "real" quirk logic or kernel parameters.

  Agree with this. At the time the code was written I did not run into
any issues with it, hence it was the default. Unfortunately, I do not
remember exact platforms. (yes, platforms, not BIOS versions -
unfortunately, lots of bugs are introduced during tailoring BIOS to
particular platform). 

> 
> (The fact that USB handoff is being driven by "quirk" logic, even
> when it's not a quirk, also raises little warning flags...)

Frankly, we are still not doing it early enough. On some platforms it
causes huge delays during some of ACPI code, and quirks are working
afterward... Moving handoff earlier resolves the issue, but this may be
a bit of extreme...

> 
> 
> > >Even in cases when the boot firmware says it's not using EHCI ...
> >
> >   That's what I do not understand. SOOE is enabled only if BIOS ownes
> > EHCI - check for ECHI_USBLEGSUP_BIOS in previous 'if' statement. Am I
> > missing something ?
> 
> That's how it works now, but it didn't do that before.  Previously it
> always turned on the SMI, and then never turned it off, causing issues
> on various platforms.

No, it's been like this all the time. Compare 'switch' and 'if'
statements in the patch against single original 'if' but with 2
conditions. Your patch is actually different in the following ways:
- it goes over all possible capabilities instead of processing just
first one - right thing to do;
- it always sets OS ownership, even if BIOS did not have it.
- it always disables SMI, not just in case when handoff failed. This
probably right way to cleanup after BIOS which does handoff, but does
not disable SMI afterward.

  In other words, it does stop doing what previous code was doing, it
just extends it. And according to Greg, it extends it in right way ;-)

> 
> Of course, the BIOS that Carlo is struggling with seems terminally
> broken, and is blatantly ignoring the spec for how those handoff
> flags are supposed to work.

Agree.

Aleks.

> 
> - Dave
> 
> 
