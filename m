Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVFMWmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVFMWmv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 18:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVFMWlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 18:41:53 -0400
Received: from mx1.suse.de ([195.135.220.2]:22489 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261588AbVFMWim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 18:38:42 -0400
Date: Tue, 14 Jun 2005 00:38:36 +0200
From: Andi Kleen <ak@suse.de>
To: Tom Duffy <tduffy@sun.com>
Cc: "Langsdorf, Mark" <mark.langsdorf@amd.com>, discuss@x86-64.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [discuss] [OOPS] powernow on smp dual core amd64
Message-ID: <20050613223835.GH21345@wotan.suse.de>
References: <84EA05E2CA77634C82730353CBE3A84301CFC14C@SAUSEXMB1.amd.com> <1118701245.9114.23.camel@duffman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118701245.9114.23.camel@duffman>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 03:20:45PM -0700, Tom Duffy wrote:
> On Mon, 2005-06-13 at 16:47 -0500, Langsdorf, Mark wrote:
> > Okay, I think I have figured this out.  During initialization,
> > the cpufreq infrastruture only initializes the first core of
> > each processor.  When a request comes into the second core,
> > it's data structre is unitialized and we get the null point
> > dereference.
> > 
> > The solution is to assign the pointer to the data structure for
> > the first core to all the other cores.
> > 
> > Tom, could you try this patch and see if it helps?
> 
> Yes!  It fixed the panic.  I get much further.
> 
> Thanks!
> 
> Unfortunately, after starting cpuspeed daemon, I get this:
> 
> Starting cpuspeed: [  OK  ]
> Starting pcmcia:  Starting PCMCIA services:
> CPU 6: Machine Check Exception:                4 Bank 4: b200000000070f0f
> TSC 4129a3d70d

it is 

CPU 6 4 northbridge
  Northbridge Watchdog error
       bit57 = processor context corrupt
       bit61 = error uncorrected
  bus error 'generic participation, request timed out
      generic error mem transaction
      generic access, level generic'
STATUS b200000000070f0f MCGSTATUS 4

Something tried to access a physical memory address that was not
mapped in the CPU.




> Kernel panic - not syncing: Machine check
>  <1>Unable to handle kernel NULL pointer dereference at 00000000000000ff RIP:
> [<00000000000000ff>]
> PGD 41460067 PUD 3f12c067 PMD 0
> Oops: 0010 [1] SMP
> CPU 6
> Modules linked in: video container button battery ac ohci_hcd ehci_hcd i2c_nforce2 i2c_core shpchp usbnet mii dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod sata_nv libata mptscsih mptbase sd_mod scsi_mod
> Pid: 1672, comm: usb.agent Tainted: G   M  2.6.12-rc6andro
> RIP: 0010:[<00000000000000ff>] [<00000000000000ff>]
> RSP: 0000:ffff81003fe63fa0  EFLAGS: 00010006
> RAX: ffff81007f5b1fd8 RBX: 0000000000000008 RCX: 0000ffff0000ffff
> RDX: 00000000000000ff RSI: 0000000000000008 RDI: 0000ffff0000ffff
> RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000004129a3cf88 R14: ffffffff80370a7d R15: 0000000000000001
> FS:  00002aaaaaae0ee0(0000) GS:ffffffff80498400(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 00000000000000ff CR3: 000000003e7e5000 CR4: 00000000000006e0
> Process usb.agent (pid: 1672, threadinfo ffff81007f5b0000, task ffff81007fddcff0)
> Stack: ffffffff8011ac99 ffffffff80370a7d ffffffff8010f247 ffff81007fea2c88  <EOI>
>        0000000000000005 0000000000000030 00000000000000fa 0000000000000000
>        ffffffff8011a860 0000000000000000
> Call Trace: <IRQ> <ffffffff8011ac99>{smp_call_function_interrupt+73}
>        <ffffffff8010f247>{call_function_interrupt+99}  <EOI>  <#MC> <ffffffff8011a860>{smp_really_stop_cpu+0}
>        <ffffffff8011aa68>{smp_send_stop+72} <ffffffff80136ebc>{panic+140}

Looks like the machine was too confused after the MCE to even
run panic correctly. I will investigate.

But of course fixing that will not fix the cause of the MCE.

-Andi
