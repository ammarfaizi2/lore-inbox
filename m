Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbVI1WHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbVI1WHa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 18:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbVI1WHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 18:07:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:13525 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751111AbVI1WHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 18:07:30 -0400
X-Authenticated: #2813124
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: 2.6.13-mm2
Date: Thu, 29 Sep 2005 00:07:33 +0200
User-Agent: KMail/1.7.2
Cc: torvalds@osdl.org, rjw@sisk.pl, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, hugh@veritas.com, akpm@osdl.org
References: <20050908053042.6e05882f.akpm@osdl.org> <200509282245.30410.daniel.ritz@gmx.ch> <20050928210717.5CF71E372B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
In-Reply-To: <20050928210717.5CF71E372B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509290007.33686.daniel.ritz@gmx.ch>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 September 2005 23.07, David Brownell wrote:
> > > > ok. i didn't look too close, but i think ohci-hcd does not fully disable
> > > > interrupts in it's suspend callback...needs a closer look.
> > > > cc:ing linux-usb-devel...
> > > 
> > > It's handled in hcd-pci.c ... All PCI based HCDs release their IRQs
> > > when they suspend.  Including OHCI.  Your diagnosis is incorrect.
> >
> > would you be kind enough to tell me where?
> 
> There's only one free_irq() line, and it gets called the first time
> through usb_hcd_pci_suspend().  QED.

errm yes. that's the one my test patch commented out. but that was really
not what i was asking/telling. so again:
to me it looks like ohci-hcd does not fully disable interrupts on suspend.
disable (read: tell the hardware not to generate interrupts anymore), not
releasing the handler.

> 
> 
> > my point is: the test patch i sent to rafael which comments out the
> > free_irq-on-suspend thing in hcd-pci.c shows that something is wrong with
> > USB (i think only OHCI. UHCI looks ok and about EHCI i have no data). 
> 
> Your logic escapes me, since your patch affected all three PCI HCDs.
> If that's wrong for one, its wrong for all three.

to me it seems there is code in uhci-hcd that tells the hardware not
to generate interrupts anymore. for ohci i think this is missing and
for ehci i simply didn't bother to check at all.

> 
> And as I just commented to Rafael, here are two better things to try
> instead of believing a diagnosis that's clearly wrong:
> 
>   - 2.6.14-rc2 
>   - disabling USB keyboard/mouse/... support in your BIOS
> 
> I know there are bugs in the "usb-handoff" PCI quirk code; the folk who've
> collected those code fragments didn't bother to match the code in the HCDs,
> and the differences can matter [1].  The best way to avoid such stuff is
> still to make sure that your BIOS just ignores USB.
> 
> - Dave
> 
> [1] http://marc.theaimsgroup.com/?l=linux-usb-devel&m=112745488924651&w=2
> 
> 
rgds
-daniel
