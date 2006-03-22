Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWCVPDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWCVPDz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbWCVPDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:03:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:12929 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751265AbWCVPD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:03:29 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC PATCH 10/35] Add a new head.S start-of-day file for booting on Xen.
Date: Wed, 22 Mar 2006 14:43:53 +0100
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063748.490176000@sorel.sous-sol.org>
In-Reply-To: <20060322063748.490176000@sorel.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221443.54119.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +	/* get vendor info */
> +	xorl %eax,%eax			# call CPUID with 0 -> return vendor ID
> +	cpuid
> +	movl %eax,X86_CPUID		# save CPUID level
> +	movl %ebx,X86_VENDOR_ID		# lo 4 chars
> +	movl %edx,X86_VENDOR_ID+4	# next 4 chars
> +	movl %ecx,X86_VENDOR_ID+8	# last 4 chars
> +
> +	movl $1,%eax		# Use the CPUID instruction to get CPU type
> +	cpuid
> +	movb %al,%cl		# save reg for future use
> +	andb $0x0f,%ah		# mask processor family
> +	movb %ah,X86
> +	andb $0xf0,%al		# mask model
> +	shrb $4,%al
> +	movb %al,X86_MODEL
> +	andb $0x0f,%cl		# mask mask revision
> +	movb %cl,X86_MASK
> +	movl %edx,X86_CAPABILITY

Can you make the CPU detection a common subfunction with the normal head.S ?


> +/*
> + * BSS section
> + */
> +.section ".bss.page_aligned","w"
> +ENTRY(swapper_pg_dir)
> +	.fill 1024,4,0
> +ENTRY(empty_zero_page)
> +	.fill 4096,1,0
> +
> +/*
> + * This starts the data section.
> + */
> +.data
> +
> +	ALIGN
> +	.word 0				# 32 bit align gdt_desc.address
> +	.globl cpu_gdt_descr
> +cpu_gdt_descr:
> +	.word GDT_SIZE
> +	.long cpu_gdt_table
> +
> +	.fill NR_CPUS-1,8,0		# space for the other GDT descriptors
> +
> +/*
> + * The Global Descriptor Table contains 28 quadwords, per-CPU.
> + */
> +	.align PAGE_SIZE_asm
> +ENTRY(cpu_gdt_table)

GDT and empty_zero_page should be shared (they're identical right?) Put them into a 
new separate common file.

> + * __xen_guest information
> + */
> +.macro utoa value
> + .if (\value) < 0 || (\value) >= 0x10
> +	utoa (((\value)>>4)&0x0fffffff)
> + .endif
> + .if ((\value) & 0xf) < 10
> +  .byte '0' + ((\value) & 0xf)
> + .else
> +  .byte 'A' + ((\value) & 0xf) - 10
> + .endif
> +.endm

Interesting macro abuse.

-Andi
