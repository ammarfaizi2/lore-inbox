Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbVCXBdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbVCXBdJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 20:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbVCXBdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 20:33:09 -0500
Received: from fmr17.intel.com ([134.134.136.16]:53650 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262325AbVCXBcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 20:32:55 -0500
Subject: Re: 2.6.12-rc1-mm1: Kernel BUG at pci:389
From: Li Shaohua <shaohua.li@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, rjw@sisk.pl,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
In-Reply-To: <20050322122041.GA1414@elf.ucw.cz>
References: <20050322122041.GA1414@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1111627799.11775.9.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 24 Mar 2005 09:29:59 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-22 at 20:20, Pavel Machek wrote:
> Hi!
> 
> > >> > Yes, but it is needed. There are many drivers, and they look at
> > >> > numerical value of PMSG_*. I'm proceeding in steps. I hopefully
> > killed
> > >> > all direct accesses to the constants, and will switch constants
> to
> > >> > something else... But that is going to be tommorow (need some
> > sleep).
> > >> The patches are going to acquire correct PCI device sleep state
> for
> > >> suspend/resume. We discussed the issue several months ago. My
> plan is
> > we
> > >> first introduce 'platform_pci_set_power_state', then merge the
> > >> 'platform_pci_choose_state' patch after Pavel's pm_message_t
> > conversion
> > >> finished. Maybe Len mislead my comments.
> > >>
> > >> Anyway for the callback, my intend is platform_pci_choose_state
> > accept
> > >> the pm_message_t parameter, and it return an 'int', since
> platform
> > >> method possibly failed and then pci_choose_state translate the
> return
> > >> value to pci_power_t.
> > >
> > >You can't just retype around like that. You may want it take
> > >pci_power_t * as an argument, and then return 0/-ENODEV or
> something
> > >like that. But you can't retype between int and pm_message_t...
> > No, taking pci_power_t as an argument is meaningless. For ACPI, we
> > should know the exact sleep state, pm_message_t will tell us. But
> I'm ok
> > to let it return a pci_power_t, and the failure case returns
> > -ENODEV.
> 
> You can't put -ENODEV into pci_power_t ... but maybe we should create
> PCI_ERROR and pass it in cases like this one?
That makes sense, please do it.

> 
> > >> > Could you just revert those two patches? First one is very
> > >> > wrong. Second one might be fixed, but... See comments below.
> > >> I think the platform_pci_set_power_state should be ok, did you
> see it
> > >> causes oops?
> > >
> > >No its just ugly and uses __force in "creative" way. That one can
> be
> > >recovered.
> > Do you mean this?
> > 
> > > +   static int state_conv[] = {
> > > +           [0] = 0,
> > > +           [1] = 1,
> > > +           [2] = 2,
> > > +           [3] = 3,
> > > +           [4] = 3
> > > +   };
> > > +   int acpi_state = state_conv[(int __force) state];
> > 
> > The table should be
> >               [PCI_D0] = 0,
> > 
> > I'm not sure, but then could we use state_conv[state] directly? It
> seems
> 
> I think so. Of course it is wrong, but it is less wrong than forcing
> it to integer than index, without using macros at all.
> 
> Or perhaps you should do
> 
> switch (state) {
> case PCI_D0: ...
> }
> 
> ...and handle default case somehow.
That's ok for me. I'll change it later.

Thanks,
Shaohua

