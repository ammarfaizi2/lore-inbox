Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264961AbUEQLq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbUEQLq4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 07:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264974AbUEQLq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 07:46:56 -0400
Received: from cantor.suse.de ([195.135.220.2]:19360 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264961AbUEQLqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 07:46:53 -0400
Date: Mon, 17 May 2004 13:46:51 +0200
From: Andi Kleen <ak@suse.de>
To: Sean Neakums <sneakums@zork.net>
Cc: davej@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: i810 AGP fails to initialise (was Re: 2.6.6-mm2)
Message-Id: <20040517134651.5444eb54.ak@suse.de>
In-Reply-To: <6ulljrl3gb.fsf@zork.zork.net>
References: <20040513032736.40651f8e.akpm@osdl.org>
	<6usme4v66s.fsf@zork.zork.net>
	<20040513135308.GA2622@redhat.com>
	<20040513155841.6022e7b0.ak@suse.de>
	<6ulljwtoge.fsf@zork.zork.net>
	<20040513174110.5b397d84.ak@suse.de>
	<6u8yfvsbd4.fsf@zork.zork.net>
	<6uk6zeow52.fsf@zork.zork.net>
	<6u65avmo97.fsf@zork.zork.net>
	<20040517100159.GC4903@wotan.suse.de>
	<6ulljrl3gb.fsf@zork.zork.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2004 12:04:36 +0100
Sean Neakums <sneakums@zork.net> wrote:

> Andi Kleen <ak@suse.de> writes:
> 
> > On Mon, May 17, 2004 at 09:49:56AM +0100, Sean Neakums wrote:
> >> Sean Neakums <sneakums@zork.net> writes:
> >> 
> >> > Sean Neakums <sneakums@zork.net> writes:
> >> >
> >> >> Andi Kleen <ak@suse.de> writes:
> >> >>
> >> >>> Sean, can you double check that when you compile the AGP driver as module
> >> >>> that the 7124 PCI ID appears in modinfo intel-agp ? 
> >> >>> And does the module also refuse to load ? 
> >> >>
> >> >> I rebuilt with agpgart, intel-agp and i810 as modules, modprobed them,
> >> >> and it works.
> >> >
> >> > I just realised that I probably forgot to reapply the patch before
> >> > doing this test.  Will check Monday.  Sorry about this.
> >> 
> >> Below is modinfo output.  The module loads but doesn't initialise the
> >> AGP.
> >
> > Someone else reported that it worked modular at least. When you apply
> > the following patch what output do you get in the kernel log when you
> > load the module?
> 
>   Linux agpgart interface v0.100 (c) Dave Jones
>   agp_intel_init
>   agp_intel_probe device 7124
>   no cap

Thanks for testing.

Ok. This patch should fix it then. Revert the debug patch first. 
Apparently some of the devices listed don't have a AGP capability. Maybe they're only AGPv1 
compliant?

Dave, please apply.

-Andi

--- linux-2.6.6-work/drivers/char/agp/intel-agp.c.~3~	2004-05-17 13:45:26.000000000 +0200
+++ linux-2.6.6-work/drivers/char/agp/intel-agp.c	2004-05-17 13:46:15.000000000 +0200
@@ -1264,8 +1264,6 @@
 	struct resource *r;
 
 	cap_ptr = pci_find_capability(pdev, PCI_CAP_ID_AGP);
-	if (!cap_ptr)
-		return -ENODEV;
 
 	bridge = agp_alloc_bridge();
 	if (!bridge)
