Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758219AbWK0N7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758219AbWK0N7H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 08:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758221AbWK0N7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 08:59:07 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:38916 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1758219AbWK0N7E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 08:59:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 27 Nov 2006 13:59:01.0906 (UTC) FILETIME=[3157FF20:01C7122C]
Content-class: urn:content-classes:message
Subject: Re: failed 'ljmp' in linear addressing mode
Date: Mon, 27 Nov 2006 08:58:57 -0500
Message-ID: <Pine.LNX.4.61.0611270843500.4092@chaos.analogic.com>
In-Reply-To: <20061122234111.GA8499@srv.junsun.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: failed 'ljmp' in linear addressing mode
thread-index: AccSLDFfxY0e7i58Siikd/2js3Qv8w==
References: <20061122234111.GA8499@srv.junsun.net>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jun Sun" <jsun@junsun.net>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Nov 2006, Jun Sun wrote:

>
> I am plowing along as I am learning about the in'n'outs about i386.  I am
> totally stuck on this one.  I would appreciate any help.
>
> As you can see, the function turns off paging mode (of course it
> runs from identically mapped page) and tries to jump to an absolute
> address at 0x10000000.  It appears the machine would reboot when running
> "ljmp" instruction.
>
> Any pointers?
>
> I was not too certain about the %cs, %ds business and did quite
> a few experiments with different values but with no luck.
>
> Thanks in advance.
>
> Jun
>
> --------------------------
>
> /* [JSUN] we will map this page into identity mapping before execution */
>        .align  4096
> ENTRY(do_os_switching)
> 	/* interrupt is disabled! */
>
>        /* the black magic, some copied form relocate_new_kernel, JSUN */
>        /* Set cr0 to a known state:
>         * 31 0 == Paging disabled
>         * 18 0 == Alignment check disabled
>         * 16 0 == Write protect disabled
>         * 3  0 == No task switch
>         * 2  0 == Don't do FP software emulation.
>         * 0  1 == Proctected mode enabled
>         */
>
>        movl    %cr0, %eax
>        andl    $~((1<<31)|(1<<18)|(1<<16)|(1<<3)|(1<<2)), %eax
>        orl     $(1<<0), %eax
>        movl    %eax, %cr0
>
>
>        /* JSUN, 0x11 was the boot up value for cr0.
>        movl    $0x11, %eax
>        movl    %eax, %cr0
>        */
>
>        /* clear cr4 */
>        movl    $0, %eax
>        movl    %eax, %cr4
>
> 	/* why this? */
>        jmp     1f
> 1:
>
>        /* clear cr3, flush TLB */
>        movl    $0, %eax
>        movl    %eax, %cr3
>
>        /*
>        movl    $(__KERNEL_DS),%eax
>        movl    %eax,%ds
>        movl    %eax,%es
>        movl    %eax,%fs
>        movl    %eax,%gs
>        movl    %eax,%ss
>        */
>
>        ljmp    $(__KERNEL_CS), $0x10000000
>

I think it probably resets the instant that you turn off paging. To
turn off paging, you need to copy some code (properly linked) to an
area where there is a 1:1 mapping between virtual and physical addresses.
A safe place is somewhere below 1 megabyte. Then you need to set up a
call descriptor so you can call that code (you can ljump if you never
plan to get back). You then need to clear interrupts on all CPUs (use a 
spin-lock). Once you are executing from the new area, you reset your
segments to the new area. The call descriptor would have already set
CS, as would have the long-jump. At this time you can turn off paging
and flush the TLB. You are now in linear-address protected mode.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.72 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
