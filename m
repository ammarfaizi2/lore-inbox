Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937132AbWLDV4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937132AbWLDV4Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 16:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937178AbWLDV4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 16:56:24 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:50462
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S937132AbWLDV4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 16:56:23 -0500
Date: Mon, 04 Dec 2006 13:56:25 -0800 (PST)
Message-Id: <20061204.135625.48528445.davem@davemloft.net>
To: dada1@cosmosbay.com
Cc: akpm@osdl.org, clameter@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SLAB : use a multiply instead of a divide in
 obj_to_index()
From: David Miller <davem@davemloft.net>
In-Reply-To: <45749465.6030601@cosmosbay.com>
References: <200612041918.29682.dada1@cosmosbay.com>
	<20061204114954.165107b6.akpm@osdl.org>
	<45749465.6030601@cosmosbay.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <dada1@cosmosbay.com>
Date: Mon, 04 Dec 2006 22:34:29 +0100

> On a 200 MHz sparcv9 machine, the division takes 64 cycles instead of 1 cycle
> for a multiply.

For UltraSPARC I and II (which is what this 200mhz guy probably is),
it's 4 cycle latency for a multiply (32-bit or 64-bit) and 68 cycles
for a 64-bit divide (32-bit divide is 37 cycles).

UltraSPARC-III and IV are worse, 6 cycles for multiply and 40/71
cycles (32/64-bit) for integer divides.

Niagara is even worse :-)  11 cycle integer multiply and a 72 cycle
integer divide (regardless of 32-bit or 64-bit).

(more details in gcc/config/sparc/sparc.c:{ultrasparc,ultrasparc3,niagara}_cost).

So this change has tons of merit for sparc64 chips at least :-)

Also, the multiply can parallelize with other operations but it
seems that integer divide stalls the pipe for most of the duration
of the calculation.  So this makes the divide even worse.
