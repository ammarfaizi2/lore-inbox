Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262614AbVG2PIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbVG2PIz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 11:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262616AbVG2PIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 11:08:55 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:19469 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S262614AbVG2PIy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 11:08:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050729143726.24317.qmail@science.horizon.com>
References: <20050729143726.24317.qmail@science.horizon.com>
X-OriginalArrivalTime: 29 Jul 2005 15:08:49.0811 (UTC) FILETIME=[6CC51630:01C5944F]
Content-class: urn:content-classes:message
Subject: Re: [PATCH] speed up on find_first_bit for i386 (let compiler do the work)
Date: Fri, 29 Jul 2005 11:08:39 -0400
Message-ID: <Pine.LNX.4.61.0507291053070.14898@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] speed up on find_first_bit for i386 (let compiler do the work)
thread-index: AcWUT2zM9+huJRdDREa2RHXm5nyaEg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: <linux@horizon.com>
Cc: <linux-kernel@vger.kernel.org>, <rostedt@goodmis.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 29 Jul 2005 linux@horizon.com wrote:

>> OK, I guess when I get some time, I'll start testing all the i386 bitop
>> functions, comparing the asm with the gcc versions.  Now could someone
>> explain to me what's wrong with testing hot cache code. Can one
>> instruction retrieve from memory better than others?
>

Yes! Intel has more than 'load' and 'store' instructions. If
memory is in the cache, the following memory operations are
shown fastest to slowest...

 	movl	(%ebx), %eax		# Index-register indirect. Note that
 					# ebx needs to be loaded so the overall
 					# access might be slower. Also some
 					# index registers are faster on
 					# some CPUs (486-> eax is fastest)
 	movl	(mem), %eax		# Direct from memory into register
 	movl	0x04(%ebx), %eax	# Index-register plus displacment
 	movl	(%esi, %ebx), %eax	# Two register indirect
 	movl	0x04(%esi, %ebx), %eax	# Two register plus displacement

When using 'movl (men), %eax', "mem" is a 32-bit word that is fetched
from the instruction stream while 'movl (%ebx), %eax' is only 2 bytes.
Therefore, if an index register can remain loaded with the correct offset
or manipulated with 'lea', then single-register indirect memory
access is fastest on current ix86 processors.

> To add one to Linus' list, note that all current AMD & Intel chips
> record instruction boundaries in L1 cache, either predecoding on
> L1 cache load, or marking the boundaries on first execution.
>
> The P4 takes it to an extreme, but P3 and K7/K8 do it too.
>
> The result is that there are additional instruction decode limits
> that apply to cold-cache code.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
