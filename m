Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWGRMnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWGRMnZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 08:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWGRMnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 08:43:24 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:42512 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751352AbWGRMnY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 08:43:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 18 Jul 2006 12:43:21.0967 (UTC) FILETIME=[C0CD47F0:01C6AA67]
Content-class: urn:content-classes:message
Subject: Re: [patch 5/6] s390: .align 4096 statements in head.S
Date: Tue, 18 Jul 2006 08:43:21 -0400
Message-ID: <Pine.LNX.4.61.0607180825240.11870@chaos.analogic.com>
In-Reply-To: <20060718115622.GE20884@skybase>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 5/6] s390: .align 4096 statements in head.S
Thread-Index: AcaqZ8DWTRQvr1pNTrK84meTAoX45g==
References: <20060718115622.GE20884@skybase>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <heiko.carstens@de.ibm.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Jul 2006, Martin Schwidefsky wrote:

> From: Heiko Carstens <heiko.carstens@de.ibm.com>
>
> [S390] .align 4096 statements in head.S
>
> SLES9 binutils don't like .align 4096 statements in head.S. Work around this
> by using .org statements.
>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
>
> arch/s390/kernel/head31.S |    4 ++--
> arch/s390/kernel/head64.S |    4 ++--
> 2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff -urpN linux-2.6/arch/s390/kernel/head31.S linux-2.6-patched/arch/s390/kernel/head31.S
> --- linux-2.6/arch/s390/kernel/head31.S	2006-07-18 13:40:23.000000000 +0200
> +++ linux-2.6-patched/arch/s390/kernel/head31.S	2006-07-18 13:40:46.000000000 +0200
> @@ -273,7 +273,7 @@ startup_continue:
> .Lbss_end:  .long _end
> .Lparmaddr: .long PARMAREA
> .Lsccbaddr: .long .Lsccb
> -	.align	4096
> +	.org	0x12000
> .Lsccb:
> 	.hword	0x1000			# length, one page
> 	.byte	0x00,0x00,0x00
> @@ -290,7 +290,7 @@ startup_continue:
> .Lscpincr2:
> 	.quad	0x00
> 	.fill	3984,1,0
> -	.align	4096
> +	.org	0x13000
>
> #ifdef CONFIG_SHARED_KERNEL
> 	.org	0x100000
> diff -urpN linux-2.6/arch/s390/kernel/head64.S linux-2.6-patched/arch/s390/kernel/head64.S
> --- linux-2.6/arch/s390/kernel/head64.S	2006-07-18 13:40:23.000000000 +0200
> +++ linux-2.6-patched/arch/s390/kernel/head64.S	2006-07-18 13:40:46.000000000 +0200
> @@ -268,7 +268,7 @@ startup_continue:
> .Lparmaddr:
> 	.quad	PARMAREA
>
> -	.align 4096
> +	.org	0x12000
> .Lsccb:
> 	.hword 0x1000			# length, one page
> 	.byte 0x00,0x00,0x00
> @@ -285,7 +285,7 @@ startup_continue:
> .Lscpincr2:
> 	.quad 0x00
> 	.fill 3984,1,0
> -	.align 4096
> +	.org	0x13000
>
> #ifdef CONFIG_SHARED_KERNEL
> 	.org   0x100000
> -

Hardcoading like that can cause hard to find errors. It looks like
you wrote something in 'C' and tried to use its assembly code. You
should know that you don't need ".fill" if you have correctly allocated
data.

The following will align objects on a 0x1000 boundary:

.section	.data
foo:	.word	0
.org	(. + 0x1000) & -0x1000
bar:	.word	0
.org	(. + 0x1000) & -0x1000
xxx:	.word	0
.org	(. + 0x1000) & -0x1000
yyy:	.word	0
.end

The 'gas' assembler is very powerful and even allows macros:

.macro	ALIGN val
.org	(. + \val) & -\val
.endm

.section	.data
foo:	.word	0
ALIGN	0x1000
bar:	.word	0
ALIGN	0x1000
xxx:	.word	0
ALIGN	0x1000
yyy:	.word	0
ALIGN	0x1000
qqq:	.word	0
.end

This generates:
Disassembly of section .data:

00000000 <foo>:
 	...
00001000 <bar>:
 	...
00002000 <xxx>:
 	...
00003000 <yyy>:
 	...
00004000 <qqq>:
 	...

Note the alignment.


You might want to use this kind of construction because it will
eliminate alignment errors. If you add something that's out-of-range
'gas' will generate an error (like attempt of a negative origin).

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.63 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
