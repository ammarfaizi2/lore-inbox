Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265921AbUAEVTX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 16:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265922AbUAEVTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 16:19:23 -0500
Received: from fmr05.intel.com ([134.134.136.6]:60630 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S265921AbUAEVTM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 16:19:12 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: FW: [PATCH] MSI broke voyager build
Date: Mon, 5 Jan 2004 13:19:02 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502401541952@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FW: [PATCH] MSI broke voyager build
Thread-Index: AcPT0YrFACJS2TTAQVyBxtAPsjbkDg==
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: <akpm@osdl.org>, "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 05 Jan 2004 21:19:04.0964 (UTC) FILETIME=[8C292C40:01C3D3D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wednesday, December 31, 2003 2:59 PM, James Bottomley wrote:
> The author made the arch/i386 compile depend on NR_VECTORS being
> defined.
> 
> This symbol, however, was put only into mach-default/irq_vectors.h
> 
> The attached patch adds it to voyager; visws and pc9800 however, are
> still broken.
> 
> The code that breaks is this (in arch/i386/kernel/i8259.c):
> 
>  	 * us. (some of these will be overridden and become
>  	 * 'special' SMP interrupts)
>  	 */
> -	for (i = 0; i < NR_IRQS; i++) {
> +	for (i = 0; i < (NR_VECTORS - FIRST_EXTERNAL_VECTOR); i++) {
>  		int vector = FIRST_EXTERNAL_VECTOR + i;
> +		if (i >= NR_IRQS)
> +			break;
>  		if (vector != SYSCALL_VECTOR)
>  			set_intr_gate(vector, interrupt[i]);
> 
> as far as I can see, with NR_VECTORS set at 256, FIRST_EXTERNAL_VECTOR
> at 32 and NR_IRQS set at 224 the two forms of the loop are identical.
> The only case it would make a difference would be for NR_IRQ >
> NR_VECTORS + FIRST_EXTERNAL_VECTOR which doesn't seem to make any
> sense.  Perhaps just backing this change out of i8259.c would be
> better?  NR_VECTORS seems to have no other defined use in the MSI code.

>> It would make a significant difference when CONFIG_PCI_USE_VECTOR is 
>> set to "Y" by users to enable MSI support. The setting of 
>> CONFIG_PCI_USE_VECTOR to "Y" sets NR_IRQS at 239 (FIRST_SYSTEM_VECTOR)
>> instead of 224.


> ===== include/asm-i386/mach-voyager/irq_vectors.h 1.4 vs edited =====
> --- 1.4/include/asm-i386/mach-voyager/irq_vectors.h	Wed Oct 22 11:34:51
> 2003
> +++ edited/include/asm-i386/mach-voyager/irq_vectors.h	Wed Dec 31
> 16:30:15 2003
> @@ -55,6 +55,7 @@
>  #define VIC_CPU_BOOT_CPI		VIC_CPI_LEVEL0
>  #define VIC_CPU_BOOT_ERRATA_CPI		(VIC_CPI_LEVEL0 + 8)
> 
> +#define NR_VECTORS 256
>  #define NR_IRQS 224
>  #define NR_IRQ_VECTORS NR_IRQS
> 

>> Thanks for providing a fix. The fix looks fine to me.

Thanks,
Long
