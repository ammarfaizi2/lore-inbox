Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVHASS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVHASS4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 14:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVHASSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 14:18:46 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:30905 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261672AbVHASRt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 14:17:49 -0400
X-ORBL: [69.107.32.110]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=CsGvRJlB3RuWi/jL4VhJQBjNdjyOqohm8YHR1SIMhgjfDK73XP0lECWjxPTxqERIE
	aLCa8WtzVM5EPC13J+blA==
Date: Mon, 01 Aug 2005 11:17:27 -0700
From: david-b@pacbell.net
To: greg@kroah.com, Aleksey_Gorelov@Phoenix.com
Subject: Re: [linux-usb-devel] Re: 2.6.13-rc4-mm1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       iogl64nx@gmail.com, akpm@osdl.org
References: <0EF82802ABAA22479BC1CE8E2F60E8C341E41B@scl-exch2k3.phoenix.com>
In-Reply-To: <0EF82802ABAA22479BC1CE8E2F60E8C341E41B@scl-exch2k3.phoenix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050801181727.49313C0F07@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> On Sun, Jul 31, 2005 at 11:25:10AM -0700, david-b@pacbell.net wrote:
> >> > I think that "continuing" codepath came from someone at 
> >> > Phoenix, FWIW;
>
> That was me.

Thanks.  It's good to have BIOS experts involved too.  :)


> >> > the problem is that I see the PCI quirks code has evolved 
> >even farther
> >> > from the main copy of the init code in the USB tree.  Sigh.
> >>
> >> I don't like that either, but can't think of a way to make 
> >it easier to
> >> keep them in sync.  Can you?
>
> Major problem here is that handoff may be necessary even if whole 
> USB support is disabled in config. I was thinking of integrating them
> into USB code somehow, but did not have enough time for it, sorry :(

So now would seem to be the time to start ... 


> >Sure.  The problem as I see it is that there are two copies, and one
> >of them isn't in the USB part of the tree.  So just move it, and cope
> >with the consequences during the 2.6.14 cycle:
> >
> >  (a) Move the USB quirks out of the generic PCI drivers directory
> >      into the USB HCD directory (see the attached patch);
> >
> >  (b) foreach HCD in (ehci ohci uhci) do:
> >  
> >      (1) Merge the two different routines:  HCD internal init/reset
> >          and the PCI quirk code are identical in intent, but they
> >	     each address different sets of quirks.
> >
> >      (2) Then the HCD reset() and PCI quirk() code will call those
> >          single shared routine. 
> >
>
> Agree, but at least:
>  - drivers/Makefile & drivers/usb/Makefile have to be modified as well
>    to include quirks on CONFIG_PCI

I was more thinking that when CONFIG_PCI it should just always
descend into the relevant USB dirs; right now it only does it
when CONFIG_USB, and that shouldn't matter.

This is a reason to update that (a) patch before merging.


>  - Constants like EHCI_USBCMD_RUN should probably be replaced with
> 'native' usb code ones.

Yes.  That would be part of (b.1) patches above.  Ditto for UHCI, OHCI;
the resulting routine would be exported to HCDs given CONFIG_USB.

It's probably too early to talk about whether the driver model
should include platform-specific device reset() methods, though
that could be handy in some other board customization cases.  :)

- Dave



> Thanks,
> Aleks.
>
> >
> >At OLS, Vojtech mentioned wanting to make "usb-handoff" be the default.
> >That's seem plausible (USB has more than its fair share of 
> >BIOS issues!)
> >but should only kick in sometime after we merge the two different sets
> >of quirk handling logic.
> >
> >- Dave
> >
