Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935091AbWKXVwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935091AbWKXVwe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 16:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935093AbWKXVwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 16:52:34 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:37075
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S935091AbWKXVwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 16:52:33 -0500
Date: Fri, 24 Nov 2006 13:52:42 -0800 (PST)
Message-Id: <20061124.135242.35354283.davem@davemloft.net>
To: burman.yan@gmail.com
Cc: stefanr@s5r6.in-berlin.de, linux-kernel@vger.kernel.org,
       trivial@kernel.org, wli@holomorphy.com, sparclinux@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc6] sparc: replace kmalloc+memset with kzalloc
From: David Miller <davem@davemloft.net>
In-Reply-To: <456741DD.6060103@gmail.com>
References: <4566DF0A.3050803@gmail.com>
	<45672D00.8060903@s5r6.in-berlin.de>
	<456741DD.6060103@gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yan Burman <burman.yan@gmail.com>
Date: Fri, 24 Nov 2006 21:02:53 +0200

> Stefan Richter wrote:
> > Yan Burman wrote:
> > ...
> >   
> >> --- linux-2.6.19-rc5_orig/arch/sparc/kernel/sun4d_irq.c	2006-11-09 12:16:21.000000000 +0200
> >> +++ linux-2.6.19-rc5_kzalloc/arch/sparc/kernel/sun4d_irq.c	2006-11-11 22:44:04.000000000 +0200
> >> @@ -545,8 +545,7 @@ void __init sun4d_init_sbi_irq(void)
> >>  	nsbi = 0;
> >>  	for_each_sbus(sbus)
> >>  		nsbi++;
> >> -	sbus_actions = (struct sbus_action *)kmalloc (nsbi * 8 * 4 * sizeof(struct sbus_action), GFP_ATOMIC);
> >> -	memset (sbus_actions, 0, (nsbi * 8 * 4 * sizeof(struct sbus_action)));
> >> +	sbus_actions = kzalloc (nsbi * 8 * 4 * sizeof(struct sbus_action), GFP_ATOMIC);
> >>  	for_each_sbus(sbus) {
> >>  #ifdef CONFIG_SMP	
> >>  		extern unsigned char boot_cpu_id;
> >>     
> >
> > I'm not sure about this ^ hunk, but...
> >
> >   
> >> diff -rubp linux-2.6.19-rc5_orig/arch/sparc/mm/io-unit.c linux-2.6.19-rc5_kzalloc/arch/sparc/mm/io-unit.c
> >> --- linux-2.6.19-rc5_orig/arch/sparc/mm/io-unit.c	2006-11-09 12:16:21.000000000 +0200
> >> +++ linux-2.6.19-rc5_kzalloc/arch/sparc/mm/io-unit.c	2006-11-11 22:44:04.000000000 +0200
> >> @@ -41,9 +41,8 @@ iounit_init(int sbi_node, int io_node, s
> >>  	struct linux_prom_registers iommu_promregs[PROMREG_MAX];
> >>  	struct resource r;
> >>  
> >> -	iounit = kmalloc(sizeof(struct iounit_struct), GFP_ATOMIC);
> >> +	iounit = kzalloc(sizeof(struct iounit_struct), GFP_ATOMIC);
> >>  
> >> -	memset(iounit, 0, sizeof(*iounit));
> >>  	iounit->limit[0] = IOUNIT_BMAP1_START;
> >>  	iounit->limit[1] = IOUNIT_BMAP2_START;
> >>  	iounit->limit[2] = IOUNIT_BMAPM_START;
> >>     
> >
> > ...in this ^, the old code and your update don't check for NULL return.
> >   
> 
> Both of this parts are done at early stages, so it is probably:
> a) Impossible to recover from failure
> b) If you run out of memory at this stage, you are probably in very big 
> trouble anyway
> 
> I could modify it to check and panic if the check fails.
> Would that be better?

Don't panic, call prom_printf() with a suitable message and then
prom_halt() just like all other early-boot failures do on sparc.
