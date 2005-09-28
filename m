Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbVI1VHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbVI1VHi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbVI1VHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:07:38 -0400
Received: from pimout5-ext.prodigy.net ([207.115.63.73]:41663 "EHLO
	pimout5-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S1750906AbVI1VHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:07:37 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=oi1pu+t91Jqf/765rDRqgYNUrXwblEmCuyyU68m/NJx0aAuSzqZxHXHK9wxFzE+P5
	BqwPDmvDTwVRxF3BOIUPQ==
Date: Wed, 28 Sep 2005 14:07:17 -0700
From: David Brownell <david-b@pacbell.net>
To: daniel.ritz@gmx.ch
Subject: Re: [linux-usb-devel] Re: 2.6.13-mm2
Cc: torvalds@osdl.org, rjw@sisk.pl, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, hugh@veritas.com, akpm@osdl.org
References: <20050908053042.6e05882f.akpm@osdl.org>
 <200509282205.49316.daniel.ritz@gmx.ch>
 <20050928202314.54672E3723@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
 <200509282245.30410.daniel.ritz@gmx.ch>
In-Reply-To: <200509282245.30410.daniel.ritz@gmx.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050928210717.5CF71E372B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > ok. i didn't look too close, but i think ohci-hcd does not fully disable
> > > interrupts in it's suspend callback...needs a closer look.
> > > cc:ing linux-usb-devel...
> > 
> > It's handled in hcd-pci.c ... All PCI based HCDs release their IRQs
> > when they suspend.  Including OHCI.  Your diagnosis is incorrect.
>
> would you be kind enough to tell me where?

There's only one free_irq() line, and it gets called the first time
through usb_hcd_pci_suspend().  QED.


> my point is: the test patch i sent to rafael which comments out the
> free_irq-on-suspend thing in hcd-pci.c shows that something is wrong with
> USB (i think only OHCI. UHCI looks ok and about EHCI i have no data). 

Your logic escapes me, since your patch affected all three PCI HCDs.
If that's wrong for one, its wrong for all three.

And as I just commented to Rafael, here are two better things to try
instead of believing a diagnosis that's clearly wrong:

  - 2.6.14-rc2 
  - disabling USB keyboard/mouse/... support in your BIOS

I know there are bugs in the "usb-handoff" PCI quirk code; the folk who've
collected those code fragments didn't bother to match the code in the HCDs,
and the differences can matter [1].  The best way to avoid such stuff is
still to make sure that your BIOS just ignores USB.

- Dave

[1] http://marc.theaimsgroup.com/?l=linux-usb-devel&m=112745488924651&w=2

