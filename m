Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbVCVAxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbVCVAxv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 19:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbVCVAxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 19:53:22 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39861 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262228AbVCVAt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 19:49:27 -0500
Date: Tue, 22 Mar 2005 01:44:56 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm1: Kernel BUG at pci:389
Message-ID: <20050322004456.GB1372@elf.ucw.cz>
References: <20050321025159.1cabd62e.akpm@osdl.org> <200503212343.31665.rjw@sisk.pl> <20050321160306.2f7221ec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321160306.2f7221ec.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > On Monday, 21 of March 2005 11:51, you wrote:
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm1/
> > 
> > I get the following BUG every time I try to suspend my box to disk.
> 
> Pavel, that's the BUG() in pci_choose_state().  I did have some
> reject-fixing to do on that wrt a change in Greg's tree, so maybe there was
> some incompatible intent in there.
> 
> I dunno why pci_choose_state() is saying that it received PCI_D1, when
> prepare_devices() is passing down PMSG_FREEZE?

Uf, I don't know what version that was.. I think I have

VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 12
EXTRAVERSION =-rc1-mm1

and that says:

#define PMSG_FREEZE     ((__force pm_message_t) 3)

... I certainly have _FREEZE defined as 1 in my local tree, but I do
not see that change in -mm yet.

Possibly pm.h changes went in faster than pci.c or something like
that?

I reproduced it here.. I do not know who introduced
platform_pci_choose_state, but it is *very* wrong. It returns
it. Should it return pci_power_t? It probably should to match
pci_choose_state, but that int is retyped to pm_message_t. Oops.

								Pavel


> 
> 
> > Greets,
> > Rafael
> > 
> > 
> > Stopping tasks: ===================================================================|
> > Freeing memory... done (66711 pages freed)
> > They asked me for state 1
> > ----------- [cut here ] --------- [please bite here ] ---------
> > Kernel BUG at pci:389
> > invalid operand: 0000 [1]
> > CPU 0
> > Modules linked in: usbserial parport_pc lp parport thermal processor fan button battery ac soundcore snd_page_alloc ipt_TOS ipt_LOG ipt_limit v
> > Pid: 9141, comm: do_acpi_sleep Not tainted 2.6.12-rc1-mm1
> > RIP: 0010:[<ffffffff80283a70>] <ffffffff80283a70>{pci_choose_state+96}
> > RSP: 0000:ffff810020fbfd78  EFLAGS: 00010292
> > RAX: 000000000000001d RBX: 0000000000000001 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: 00000000000044e0 RDI: ffffffff8041d140
> > RBP: ffff81002fc151c0 R08: 0000000000000000 R09: ffff81002a535c48
> > R10: 00000000ffffffff R11: 0000000000000000 R12: ffff81002fc151c0
> > R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000080
> > FS:  00002aaaab28b800(0000) GS:ffffffff8055c840(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> > CR2: 00002aaaaaac2000 CR3: 000000001dd8a000 CR4: 00000000000006e0
> > Process do_acpi_sleep (pid: 9141, threadinfo ffff810020fbe000, task ffff810020d527e0)
> > Stack: ffff81002c349628 0000000000000000 ffff81002c349628 ffffffff8032218a
> >        ffff81002fc149a8 0000000000000000 ffff81002fc15230 0000000000000000
> >        ffffffff8048f680 0000000000000003
> > Call Trace:<ffffffff8032218a>{usb_hcd_pci_suspend+74} <ffffffff8028519e>{pci_device_suspend+30}
> >        <ffffffff802ee3d2>{suspend_device+50} <ffffffff802ee4f1>{device_suspend+129}
> >        <ffffffff80166ceb>{prepare_devices+11} <ffffffff80167095>{pm_suspend_disk+21}
> >        <ffffffff80164206>{enter_state+70} <ffffffff8016442d>{state_store+109}
> >        <ffffffff801f275f>{subsys_attr_store+31} <ffffffff801f2c1c>{sysfs_write_file+204}
> >        <ffffffff8019c6c9>{vfs_write+233} <ffffffff8019c863>{sys_write+83}
> >        <ffffffff8010f092>{system_call+126}
> > 
> > Code: 0f 0b 7a 3e 3e 80 ff ff ff ff 85 01 31 d2 66 90 48 8b 5c 24
> > RIP <ffffffff80283a70>{pci_choose_state+96} RSP <ffff810020fbfd78>
> > 
> > 
> > 
> > -- 
> > - Would you tell me, please, which way I ought to go from here?
> > - That depends a good deal on where you want to get to.
> > 		-- Lewis Carroll "Alice's Adventures in Wonderland"

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
