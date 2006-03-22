Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWCVS6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWCVS6W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 13:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWCVS6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 13:58:22 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:45952 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932339AbWCVS6W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 13:58:22 -0500
Date: Wed, 22 Mar 2006 10:58:36 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 10/35] Add a new head.S start-of-day file for booting on Xen.
Message-ID: <20060322185836.GZ15997@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063748.490176000@sorel.sous-sol.org> <200603221443.54119.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603221443.54119.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@suse.de) wrote:
> > +	/* get vendor info */
> > +	xorl %eax,%eax			# call CPUID with 0 -> return vendor ID
> > +	cpuid
> > +	movl %eax,X86_CPUID		# save CPUID level
> > +	movl %ebx,X86_VENDOR_ID		# lo 4 chars
> > +	movl %edx,X86_VENDOR_ID+4	# next 4 chars
> > +	movl %ecx,X86_VENDOR_ID+8	# last 4 chars
> > +
> > +	movl $1,%eax		# Use the CPUID instruction to get CPU type
> > +	cpuid
> > +	movb %al,%cl		# save reg for future use
> > +	andb $0x0f,%ah		# mask processor family
> > +	movb %ah,X86
> > +	andb $0xf0,%al		# mask model
> > +	shrb $4,%al
> > +	movb %al,X86_MODEL
> > +	andb $0x0f,%cl		# mask mask revision
> > +	movb %cl,X86_MASK
> > +	movl %edx,X86_CAPABILITY
> 
> Can you make the CPU detection a common subfunction with the normal head.S ?

I don't see why not, prefer to share as much as possible.

> > +/*
> > + * BSS section
> > + */
> > +.section ".bss.page_aligned","w"
> > +ENTRY(swapper_pg_dir)
> > +	.fill 1024,4,0
> > +ENTRY(empty_zero_page)
> > +	.fill 4096,1,0
> > +
> > +/*
> > + * This starts the data section.
> > + */
> > +.data
> > +
> > +	ALIGN
> > +	.word 0				# 32 bit align gdt_desc.address
> > +	.globl cpu_gdt_descr
> > +cpu_gdt_descr:
> > +	.word GDT_SIZE
> > +	.long cpu_gdt_table
> > +
> > +	.fill NR_CPUS-1,8,0		# space for the other GDT descriptors
> > +
> > +/*
> > + * The Global Descriptor Table contains 28 quadwords, per-CPU.
> > + */
> > +	.align PAGE_SIZE_asm
> > +ENTRY(cpu_gdt_table)
> 
> GDT and empty_zero_page should be shared (they're identical right?) Put them into a 
> new separate common file.

There's still kernel/user cs/ds in gdt, so it's not all zero.

thanks,
-chris
