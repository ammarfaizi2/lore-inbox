Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVCVMVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVCVMVR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 07:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVCVMVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 07:21:17 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42215 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261155AbVCVMVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 07:21:00 -0500
Date: Tue, 22 Mar 2005 13:20:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, rjw@sisk.pl,
       lkml <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>
Subject: Re: 2.6.12-rc1-mm1: Kernel BUG at pci:389
Message-ID: <20050322122041.GA1414@elf.ucw.cz>
References: <16A54BF5D6E14E4D916CE26C9AD3057501731439@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD3057501731439@pdsmsx402.ccr.corp.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> > Yes, but it is needed. There are many drivers, and they look at
> >> > numerical value of PMSG_*. I'm proceeding in steps. I hopefully
> killed
> >> > all direct accesses to the constants, and will switch constants to
> >> > something else... But that is going to be tommorow (need some
> sleep).
> >> The patches are going to acquire correct PCI device sleep state for
> >> suspend/resume. We discussed the issue several months ago. My plan is
> we
> >> first introduce 'platform_pci_set_power_state', then merge the
> >> 'platform_pci_choose_state' patch after Pavel's pm_message_t
> conversion
> >> finished. Maybe Len mislead my comments.
> >>
> >> Anyway for the callback, my intend is platform_pci_choose_state
> accept
> >> the pm_message_t parameter, and it return an 'int', since platform
> >> method possibly failed and then pci_choose_state translate the return
> >> value to pci_power_t.
> >
> >You can't just retype around like that. You may want it take
> >pci_power_t * as an argument, and then return 0/-ENODEV or something
> >like that. But you can't retype between int and pm_message_t...
> No, taking pci_power_t as an argument is meaningless. For ACPI, we
> should know the exact sleep state, pm_message_t will tell us. But I'm ok
> to let it return a pci_power_t, and the failure case returns
> -ENODEV.

You can't put -ENODEV into pci_power_t ... but maybe we should create
PCI_ERROR and pass it in cases like this one?

> >> > Could you just revert those two patches? First one is very
> >> > wrong. Second one might be fixed, but... See comments below.
> >> I think the platform_pci_set_power_state should be ok, did you see it
> >> causes oops?
> >
> >No its just ugly and uses __force in "creative" way. That one can be
> >recovered.
> Do you mean this?
> 
> > +	static int state_conv[] = {
> > +		[0] = 0,
> > +		[1] = 1,
> > +		[2] = 2,
> > +		[3] = 3,
> > +		[4] = 3
> > +	};
> > +	int acpi_state = state_conv[(int __force) state];
> 
> The table should be
> 		[PCI_D0] = 0,
> 
> I'm not sure, but then could we use state_conv[state] directly? It seems

I think so. Of course it is wrong, but it is less wrong than forcing
it to integer than index, without using macros at all.

Or perhaps you should do

switch (state) {
case PCI_D0: ...
}

...and handle default case somehow.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
