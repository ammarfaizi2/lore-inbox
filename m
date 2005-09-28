Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbVI1Wcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbVI1Wcn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 18:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVI1Wcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 18:32:43 -0400
Received: from imap.gmx.net ([213.165.64.20]:47545 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751135AbVI1Wcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 18:32:42 -0400
X-Authenticated: #2813124
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: 2.6.13-mm2
Date: Thu, 29 Sep 2005 00:32:26 +0200
User-Agent: KMail/1.7.2
Cc: rjw@sisk.pl, torvalds@osdl.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, hugh@veritas.com, akpm@osdl.org
References: <20050908053042.6e05882f.akpm@osdl.org> <200509282334.58365.rjw@sisk.pl> <20050928220409.DE48BE3724@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
In-Reply-To: <20050928220409.DE48BE3724@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509290032.26815.daniel.ritz@gmx.ch>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 September 2005 00.04, David Brownell wrote:
> > > My other point still stands though.  The IRQ for all HCDs _are_ freed
> > > on suspend, and re-requested on resume ... so lack of such free/request
> > > calls can't possibly be an issue.
> >
> > Yes it can.  Apparently on my box the call to request_irq() from a USB HCD
> > driver (OHCI or EHCI) causes a screaming interrupt to be generated,
> > which kills any other driver that shares the IRQ with the USB and has not
> > called free_irq() on suspend.
> 
> So it's as I said:  _lack_ of such calls can't be an issue.

yep, but doing the free_irq() on suspend can be. and is in some cases.

> 
> So _which_ device is generating this IRQ??

USB ohci controller having no handler. yenta shares the line, has the
correct handler installer, sees the interrupt, does not handle it since
it was not the cardbus bridge generating the interrupt but ohci.
nobody cares about the interrupt, nobody tells the hardware to stop.
hello interrupt storm. and during reesume...boom.

and yes, doing the free_irq() in yenta works _around_ the problem but
breaks resume with APM where the BIOS is getting in the way. we had
that change, it was a regression (for Hugh), Linus backed it out.

nice reading:
http://marc.theaimsgroup.com/?t=112275164900002&r=1&w=4

> 
> 
> >	Of course this only happens with the patch
> > at http://www.ussg.iu.edu/hypermail/linux/kernel/0507.3/2234.html
> > unapplied, as it masks the problem.
> 
> Hmm, an ACPI patch.  With tabs completely trashed; that
> mail archive needs to learn about <pre>...</pre.  :(
> 
> 
> >		Actually it also depends on the
> > order in which the drivers' resume routines are called, but unfortunately
> > on my box the USB drivers' are called first.
> 
> Suggesting that the issue comes from the non-USB driver
> sharing that IRQ line...

nope, other way around.

> 
> - Dave
> 

btw. i'm still suggesting not doing that free_irq() thing in suspend, at
least not short-term. i was thinking that it is a good idea in the beginning,
but Linus changed my mind...[ patch for usb ready ]

rgds
-daniel
