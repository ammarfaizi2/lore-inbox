Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264049AbTDWOPG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264050AbTDWOPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:15:06 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3720 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264049AbTDWOPD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:15:03 -0400
Date: Wed, 23 Apr 2003 10:24:26 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Wanted: A decent assembler
In-Reply-To: <200304230952_MC3-1-35A8-EDA3@compuserve.com>
Message-ID: <Pine.LNX.4.53.0304231019300.23237@chaos>
References: <200304230952_MC3-1-35A8-EDA3@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Apr 2003, Chuck Ebbert wrote:

>
> Chuck Ebbert wrote:
>
> > <mangled asm source>
>
>  Should be:
>
>
> .if NR_IRQS gt 16			# only build this for IO-APIC
> 	.align 8,0x90			# make ENTRY have exact address
> irq_align=8				# start with 8-byte alignment
> ENTRY(high_irq_entries_start)
> .rept NR_IRQS-16			# the rest of the stubs
> 	.align irq_align,0x90
> 1:	pushl $vector-256		# 5-byte instruction
> 	jmp common_interrupt		# 2 or 5 bytes (8 or 32-bit offset)
> 2:
> .if 2b-1b > 8				# offset changed to 32-bit
> 	irq_align=16			# switch to 16-byte alignment
> .endif
> .data
> 	.long 1b
> .text
> vector=vector+1
> .endr
> .endif
>
>
\

Well the source has several errors. I fixed a couple and made
the jump (temporarily) a fixed-length jump. The remaining error
is the improper construction of the label "vector", which needs
to be fixed and I need to take a work-break. I think all you
need to do is pre-define it, i.e., like the following:

NR_IRQS = 32

.if NR_IRQS > 16			# only build this for IO-APIC
	.align 8,0x90			# make ENTRY have exact address
irq_align=8				# start with 8-byte alignment
#ENTRY(high_irq_entries_start)
vector = 0;                             # Define as a variable, not label
.rept NR_IRQS-16			# the rest of the stubs
	.align irq_align,0x90
1:	pushl $vector		# 5-byte instruction
	ljmp common_interrupt		# 2 or 5 bytes (8 or 32-bit offset)
2:
.if 2b-1b > 8				# offset changed to 32-bit
	irq_align=16			# switch to 16-byte alignment
.endif
.data
	.long 1b
.text
vector=vector+1
.endr
.endif


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

