Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbVI1Moq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbVI1Moq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 08:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbVI1Mo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 08:44:28 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:21897 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751269AbVI1MoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 08:44:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=ETSl9PTMoigafL2W8I33Y5fnlp3AS+Q/Br6M/+UySL6idbNOITD5/MVRH8T4zq6j0MLk1hcabJq40Y/gDSnTsuvPPA+guxXFzEfH2meOaRExEpgcmcqDC1i39wn1XlF+T/RxKt/4+zS5eANHYTGoltWv5Fs7GBLWPUc/iu+Xi4s=
From: Tejun Heo <htejun@gmail.com>
To: ak@suse.de, gregkh@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050928124148.EBEDFAFE@htj.dyndns.org>
In-Reply-To: <20050928124148.EBEDFAFE@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6 03/03] i386_and_x86_64: check broken_dac to x86_64 dma_supported()
Message-ID: <20050928124148.47752BE1@htj.dyndns.org>
Date: Wed, 28 Sep 2005 21:44:21 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

03_i386_and_x86_64_add-broken-dac-check-to-x86_64.patch

	check for broken_dac in x86-64 dma_supported() routine.  This
	disables 64-bit DMA for devices hanging off broken bridges.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 arch/x86_64/kernel/pci-gart.c  |    5 +++++
 arch/x86_64/kernel/pci-nommu.c |    7 +++++++
 include/asm-x86_64/proto.h     |    3 +++
 3 files changed, 15 insertions(+)

Index: linux-work/arch/x86_64/kernel/pci-gart.c
===================================================================
--- linux-work.orig/arch/x86_64/kernel/pci-gart.c	2005-09-28 21:41:46.000000000 +0900
+++ linux-work/arch/x86_64/kernel/pci-gart.c	2005-09-28 21:41:46.000000000 +0900
@@ -645,6 +645,11 @@ int dma_supported(struct device *dev, u6
 		return 0; 
 	}
 
+	/* Check if there is any bridge with broken DAC support
+	   between the device and memory.  Declared in asm/proto.h */
+	if (mask > 0xffffffff && dma_broken_dac(dev))
+		return 0;
+
 	return 1;
 } 
 
Index: linux-work/arch/x86_64/kernel/pci-nommu.c
===================================================================
--- linux-work.orig/arch/x86_64/kernel/pci-nommu.c	2005-09-28 21:41:46.000000000 +0900
+++ linux-work/arch/x86_64/kernel/pci-nommu.c	2005-09-28 21:41:46.000000000 +0900
@@ -71,6 +71,13 @@ int dma_supported(struct device *hwdev, 
         if (mask < 0x00ffffff)
                 return 0;
 
+	/*
+	 * Check if there is any bridge with broken DAC support
+	 * between the device and memory.  Declared in asm/proto.h
+	 */
+	if (mask > 0xffffffff && dma_broken_dac(hwdev))
+		return 0;
+
 	return 1;
 } 
 EXPORT_SYMBOL(dma_supported);
Index: linux-work/include/asm-x86_64/proto.h
===================================================================
--- linux-work.orig/include/asm-x86_64/proto.h	2005-09-28 21:41:46.000000000 +0900
+++ linux-work/include/asm-x86_64/proto.h	2005-09-28 21:41:46.000000000 +0900
@@ -116,6 +116,9 @@ extern void smp_local_timer_interrupt(st
 
 long do_arch_prctl(struct task_struct *task, int code, unsigned long addr);
 
+struct device;
+extern int dma_broken_dac(struct device *dev);	/* arch/i386/kernel/quirks.c */
+
 #define round_up(x,y) (((x) + (y) - 1) & ~((y)-1))
 #define round_down(x,y) ((x) & ~((y)-1))
 

