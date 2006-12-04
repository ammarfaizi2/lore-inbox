Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758522AbWLDWpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758522AbWLDWpO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 17:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759741AbWLDWpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 17:45:14 -0500
Received: from sp604001mt.neufgp.fr ([84.96.92.60]:54924 "EHLO Smtp.neuf.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758522AbWLDWpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 17:45:12 -0500
Date: Mon, 04 Dec 2006 23:45:28 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] SLAB : use a multiply instead of a divide in obj_to_index()
In-reply-to: <20061204.135625.48528445.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: akpm@osdl.org, clameter@sgi.com, linux-kernel@vger.kernel.org
Message-id: <4574A508.1090805@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <200612041918.29682.dada1@cosmosbay.com>
 <20061204114954.165107b6.akpm@osdl.org> <45749465.6030601@cosmosbay.com>
 <20061204.135625.48528445.davem@davemloft.net>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller a écrit :
> From: Eric Dumazet <dada1@cosmosbay.com>
> Date: Mon, 04 Dec 2006 22:34:29 +0100
> 
>> On a 200 MHz sparcv9 machine, the division takes 64 cycles instead of 1 cycle
>> for a multiply.
> 
> For UltraSPARC I and II (which is what this 200mhz guy probably is),
> it's 4 cycle latency for a multiply (32-bit or 64-bit) and 68 cycles
> for a 64-bit divide (32-bit divide is 37 cycles).

I must have Ultra-2 (running Solaris :( )

         for (ui = 0 ; ui < 100000000 ; ui++)
                 val += reciprocal_divide(ui, reciproc);

    100000cb0:   83 31 20 00     srl  %g4, 0, %g1
    100000cb4:   82 48 40 12     mulx  %g1, %l2, %g1
    100000cb8:   83 30 70 20     srlx  %g1, 0x20, %g1
    100000cbc:   88 01 20 01     inc  %g4
    100000cc0:   80 a1 00 05     cmp  %g4, %g5
    100000cc4:   08 4f ff fb     bleu  %icc, 100000cb0
    100000cc8:   b0 06 00 01     add  %i0, %g1, %i0

I confirm that this block uses 20 cycles/iteration,
while next one uses 72 cycles/iteration

         for (ui = 0 ; ui < 100000000 ; ui++)
                 val += ui / value;

    100000ca8:   83 31 20 00     srl  %g4, 0, %g1
    100000cac:   82 68 40 11     udivx  %g1, %l1, %g1
    100000cb0:   88 01 20 01     inc  %g4
    100000cb4:   80 a1 00 05     cmp  %g4, %g5
    100000cb8:   08 4f ff fc     bleu  %icc, 100000ca8
    100000cbc:   b0 06 00 01     add  %i0, %g1, %i0


> 
> UltraSPARC-III and IV are worse, 6 cycles for multiply and 40/71
> cycles (32/64-bit) for integer divides.
> 
> Niagara is even worse :-)  11 cycle integer multiply and a 72 cycle
> integer divide (regardless of 32-bit or 64-bit).
> 
> (more details in gcc/config/sparc/sparc.c:{ultrasparc,ultrasparc3,niagara}_cost).
> 
> So this change has tons of merit for sparc64 chips at least :-)
> 
> Also, the multiply can parallelize with other operations but it
> seems that integer divide stalls the pipe for most of the duration
> of the calculation.  So this makes the divide even worse.


