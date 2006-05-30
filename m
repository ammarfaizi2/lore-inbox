Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWE3WlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWE3WlH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 18:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbWE3WlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 18:41:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21947 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932533AbWE3WlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 18:41:06 -0400
Date: Tue, 30 May 2006 15:45:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm1
Message-Id: <20060530154521.d737cc65.akpm@osdl.org>
In-Reply-To: <adawtc34364.fsf@cisco.com>
References: <20060530022925.8a67b613.akpm@osdl.org>
	<adawtc34364.fsf@cisco.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006 14:24:03 -0700
Roland Dreier <rdreier@cisco.com> wrote:

> I'm seeing problems with MSI-X interrupts on 2.6.17-rc5-mm1.  I'll try
> to debug the MSI patches in -mm further in the next day or so, but for
> now I'll post the symptoms.
> 
> When I load the ib_mthca driver with MSI-X interrupts enabled, I get
> the following crash as soon as the first interrupt is generated.

do_IRQ() did a jump-to-zero.  So there's no handler installed.

> [  329.979089] Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP:
> [  329.995487]  [<0000000000000000>]
> <8>[  330.012818] PGD 119477067 PUD 119b48067 PMD 0
> [  330.027009] Oops: 0010 [1] SMP
> [  330.036503] last sysfs file: /class/net/ib2/address
> <8>[  330.051084] CPU 0
> <8>[  330.057932] Modules linked in: ib_mthca ib_srp ib_cm ib_ipoib ib_sa ib_mad ib_core nfs lockd nfs_acl sunrpc ipv6 thermal fan button processor ac battery dm_mod ide_generic ide_disk evdev usbhid ide_cd cdrom amd74xx psmouse serio_raw e1000 pcspkr generic ohci_hcd ehci_hcd ide_core
> <8>[  330.134158] Pid: 0, comm: idle Not tainted 2.6.17-rc5-mm1 #7
> <8>[  330.151851] RIP: 0010:[<0000000000000000>]  [<0000000000000000>]
> <8>[  330.170116] RSP: 0000:ffffffff805d4f98  EFLAGS: 00010016
> <8>[  330.187344] RAX: 0000000000005200 RBX: ffffffff80873eb8 RCX: 0000000000000000
> <8>[  330.209448] RDX: ffffffff80873eb8 RSI: ffffffff80863e80 RDI: 0000000000000052
> <8>[  330.231552] RBP: ffffffff805d4fb0 R08: 0000000000000001 R09: ffffffff804380f7
> <8>[  330.253656] R10: ffff81007adc6000 R11: 0000000000000000 R12: 0000000000000052
> <8>[  330.275762] R13: 0000000000090000 R14: 0000000000000000 R15: 0000000000000000
> <8>[  330.297867] FS:  00002b9e555966d0(0000) GS:ffffffff8085c000(0000) knlGS:0000000000000000
> <8>[  330.322823] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> <8>[  330.340777] CR2: 0000000000000000 CR3: 0000000119bd7000 CR4: 00000000000006e0
> <8>[  330.362882] Process idle (pid: 0, threadinfo ffffffff80872000, task ffffffff804baa00)
> <8>[  330.387061] Stack: ffffffff8020c693 ffffffff80207c93 0000000000000100 ffffffff80873ee0
> <8>[  330.411423]        ffffffff80209b89  <EOI> ff6500230f54e8fa 65c900000020250c 00000010250c8b48
> <8>[  330.438222]        f700001fd8e98148 7400000003582444
> <8>[  330.454231] Call Trace:
> <8>[  330.462870]  <IRQ> [<ffffffff8020c693>] do_IRQ+0x5e/0x6f
> <8>[  330.479631]  [<ffffffff80207c93>] default_idle+0x0/0x9b
> <8>[  330.496080]  [<ffffffff80209b89>] ret_from_intr+0x0/0xf
> <8>[  330.512526]  <EOI>Unable to handle kernel paging request at ffffffff82800000 RIP:
> [  332.136320]  [<ffffffff8020ad6e>] show_trace+0x145/0x195
> <8>[  332.159591] PGD 203027 PUD 205027 PMD 0
> [  332.172226] Oops: 0000 [2] SMP
> [  332.181720] last sysfs file: /class/net/ib2/address
> <

The possibly-relevant patches are:

box:/usr/src/25> grep msi series 
gregkh-pci-pci-msi-abstractions-and-support-for-altix.patch
gregkh-pci-pci-altix-msi-support.patch
allow-msi-to-work-on-kexec-kernel.patch
pci-disable-msi-mode-in-pci_disable_device.patch
x86_64-msi-apic-build-fix.patch

But this bug seems to be at a higher level - I'd be more suspecting the
genirq patches forgot to install a handler somehow.


