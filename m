Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVANA2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVANA2R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 19:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVANAWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 19:22:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:13474 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261743AbVANAS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 19:18:28 -0500
Date: Thu, 13 Jan 2005 16:23:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave <dave.jiang@gmail.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, smaurer@teja.com,
       linux@arm.linux.org.uk, dsaxena@plexity.net, drew.moseley@intel.com,
       mporter@kernel.crashing.org
Subject: Re: [PATCH 1/5] Convert resource to u64 from unsigned long
Message-Id: <20050113162309.2a125eb1.akpm@osdl.org>
In-Reply-To: <8746466a050113152636f49d18@mail.gmail.com>
References: <8746466a050113152636f49d18@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave <dave.jiang@gmail.com> wrote:
>
> ere's my first attempt of trying to convert the struct resource
> start/end to u64 per blessed by Linus =) This is to support >32bit
> physical address on 32bit archs such as some of the newer ARMv6 and
> XSC3 based platforms and perhaps IA32 PAE.  I left the PCI stuff alone
> functionally. Supporting 64bit PCI BAR on 32bit archs is for another
> day. I fixed most of the core stuff I can think of, fixed ARM and i386
> hopefully and a few of the device drivers as examples. I have tested
> on an IQ31244 XScale IOP (ARM) platform and a dual-xeon platform for
> i386. Matt Porter has graciously sent me PPC fixes that he tested on.

OK, well Greg KH will be the main target of this work..

Can you do something a bit more friendly than application/octet-stream
encoding, btw?

+#if BITS_PER_LONG == 64
+#define U64FMT "016lx"
+#else
+#define U64FMT "016Lx"
+#endif

We've avoided doing this.  We prefer to do

	printk("%llx", (unsigned long long)foo);

which is tidier, although a little more runtime-costly.

Your approach assumes that all 64-bit architectures implement u64 as
unsigned long (as opposed to unsigned long long, which I guess is legal?) I
don't know if that's a problem or not.

Also, the patches introduce tons of ifdefs such as:

+#if BITS_PER_LONG == 64			
	return (void __iomem *)pci_resource_start(pdev, PCI_ROM_RESOURCE);
+#else
+	return (void __iomem *)(u32)pci_resource_start(pdev, PCI_ROM_RESOURCE);
+#endif

We really should find a way of avoiding this.  Even if it is

#if BITS_PER_LONG == 64
#define resource_to_ptr(r) ((void *)(r))
#else
#define resource_to_ptr(r) ((void *)((u32)r))
#endif

in a header file somewhere.  Open-coding the decision all over the place is
unsightly.

