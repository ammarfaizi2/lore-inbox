Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbVHXNFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbVHXNFF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 09:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbVHXNFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 09:05:05 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:63499 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750921AbVHXNFD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 09:05:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050824124348.44686.qmail@web25807.mail.ukl.yahoo.com>
References: <20050824124348.44686.qmail@web25807.mail.ukl.yahoo.com>
X-OriginalArrivalTime: 24 Aug 2005 13:04:50.0323 (UTC) FILETIME=[693ACE30:01C5A8AC]
Content-class: urn:content-classes:message
Subject: Re: question on memory barrier
Date: Wed, 24 Aug 2005 09:04:15 -0400
Message-ID: <Pine.LNX.4.61.0508240854550.28064@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: question on memory barrier
Thread-Index: AcWorGlCN5FHZTC9QL211FKO+WMu+g==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "moreau francis" <francis_moreau2000@yahoo.fr>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Aug 2005, moreau francis wrote:

> Hi,
>
> I'm currently trying to write a USB driver for Linux. The device must be
> configured by writing some values into the same register but I want to be
> sure that the writing order is respected by either the compiler and the cpu.
>
> For example, here is a bit of driver's code:
>
> """
> #include <asm/io.h>
>
> static inline void dev_out(u32 *reg, u32 value)
> {
>        writel(value, regs);
> }
>
> void config_dev(void)
> {
>        dev_out(reg_a, 0x0); /* first io */
>        dev_out(reg_a, 0xA); /* second io */
> }
>

This should be fine. The effect of the first bit of code
plus all side-effects (if any) should be complete at the
first effective sequence-point (;) but you need to
change the procedure, dev_out, to:

static inline void dev_out(volatile u32 *regs, u32 value)
                            ^^^^^^^^

... or ... just use writel() directly. wmb() just tells
the compiler that memory has been changed. It already knows
that but you must use the keyword, "volatile" so the compiler
doesn't use something stale that's cached in registers.

> void config_dev_fixed(void)
> {
>        dev_out(reg_a, 0x0); /* first io */
>        wmb();
>        dev_out(reg_a, 0xA); /* second io */
>        wmb();
> }
> """
>
> In this case, am I sure that the order will be respected ? can gcc remove
> the first io while optimizing...If so, does "config_dev_fixed" fix it ?
>
> thanks for your answers,
>
>            Francis
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12.5 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
