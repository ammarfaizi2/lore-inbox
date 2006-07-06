Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965138AbWGFKDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138AbWGFKDa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 06:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbWGFKDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 06:03:30 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:17896 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S965138AbWGFKD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 06:03:29 -0400
Date: Thu, 6 Jul 2006 12:03:19 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
Message-ID: <20060706120319.26b35798@cad-250-152.norway.atmel.com>
In-Reply-To: <20060706021906.1af7ffa3.akpm@osdl.org>
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
	<20060706021906.1af7ffa3.akpm@osdl.org>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2006 02:19:06 -0700
Andrew Morton <akpm@osdl.org> wrote:

> On Thu, 6 Jul 2006 10:52:27 +0200
> Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:
> 
> > Hi everyone,
> > 
> > I've put up an updated set of patches for AVR32 support at
> > http://avr32linux.org/twiki/bin/view/Main/LinuxPatches
> > 
> > The most interesting patch probably is
> > http://avr32linux.org/twiki/pub/Main/LinuxPatches/avr32-arch-2.patch
> > 
> > which, at 544K, is too large to attach here. Please let me know if
> > you want me to do it anyway.
> > 
> > Anyone want to have a look at this? I understand that a full review
> > is a huge job, but I'd appreciate a pointer or two in the general
> > direction that I need to take this in order to get it acceptable for
> > mainline.
> > 
> 
> Looks pretty sane from a quick scan.
> 
> - request_irq() can use GFP_KERNEL?

Probably, but the genirq implementation also uses GFP_ATOMIC.

> - show_interrupts() should use for_each_online_cpu()

Indeed. Haven't really touched that code for a while.

> <wow, kprobes support>
> 
> - do you really need __udivdi3() and friends?  We struggle hard to
> avoid the necessity on x86 and you should be able to leverage that
> advantage.

__avr32_udiv64 has only one caller, in time_init(). I'll see if I can
eliminate it.

The 64-bit shift functions are called from architecture-independent
code, so that will be harder.

> - What are these for?
> 
> 	+EXPORT_SYMBOL(register_dma_controller);
> 	+EXPORT_SYMBOL(find_dma_controller);

An attempt at a DMA controller framework, which is used by our MMC
driver as well as a couple of sound drivers. I can remove it from the
patchset if you want, as I haven't forward-ported any of the users yet.

> 	+EXPORT_SYMBOL(clk_get);
> 	+EXPORT_SYMBOL(clk_put);
> 	+EXPORT_SYMBOL(clk_enable);
> 	+EXPORT_SYMBOL(clk_disable);
> 	+EXPORT_SYMBOL(clk_get_rate);
> 	+EXPORT_SYMBOL(clk_round_rate);
> 	+EXPORT_SYMBOL(clk_set_rate);
> 	+EXPORT_SYMBOL(clk_set_parent);
> 	+EXPORT_SYMBOL(clk_get_parent);

Implementation of the linux/clk.h API. David Brownell convinced me to
implement it for AVR32, as it is used by a lot of ARM drivers,
especially the AT91 ones which could mostly be shared with AVR32.

> - Was there a ./MAINTAINERS patch?  I didn't see one.

Sorry, I missed that one. Appended below.

> - Who stands behind this port?  How do we know this isn't a
> patch-n-run exercise?  How do we know that the code won't rot?

Atmel, or more precisely Atmel Norway, which is the design center
that designed the AVR and AVR32 architectures, stands behind it. Atmel
Applications Engineers have received a fair amount of Linux training
already, so I don't think we'll be dropping this on the floor any time
soon.

> - How does one build a something->avr32 cross-toolchain?

I've started writing up a "Getting Started" guide at
http://avr32linux.org/twiki/bin/view/Main/GettingStarted. It's mostly
complete, although I haven't actually uploaded the toolchain patches.
I'll do that in a couple of minutes.

Håvard

diff --git a/MAINTAINERS b/MAINTAINERS
index 196a31c..f7ab4ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -422,6 +422,23 @@ W:	http://people.redhat.com/sgrubb/audit
 T:	git kernel.org:/pub/scm/linux/kernel/git/dwmw2/audit-2.6.git
 S:	Maintained
 
+AVR32 ARCHITECTURE
+P:	Atmel AVR32 Support Team
+M:	avr32@atmel.com
+P:	Haavard Skinnemoen
+M:	hskinnemoen@atmel.com
+W:	http://www.atmel.com/products/AVR32/
+W:	http://avr32linux.org/
+W:	http://avrfreaks.net/
+S:	Supported
+
+AVR32/AT32AP MACHINE SUPPORT
+P:	Atmel AVR32 Support Team
+M:	avr32@atmel.com
+P:	Haavard Skinnemoen
+M:	hskinnemoen@atmel.com
+S:	Supported
+
 AX.25 NETWORK LAYER
 P:	Ralf Baechle
 M:	ralf@linux-mips.org
