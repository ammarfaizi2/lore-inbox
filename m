Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266568AbUF3GMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266568AbUF3GMk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 02:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266570AbUF3GMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 02:12:40 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:28176 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266568AbUF3GKe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 02:10:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Do x86 NX and AMD prefetch check cause page fault infinite loop?
Date: Wed, 30 Jun 2004 09:10:16 +0300
X-Mailer: KMail [version 1.4]
References: <20040630013824.GA24665@mail.shareable.org>
In-Reply-To: <20040630013824.GA24665@mail.shareable.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200406300910.16396.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 June 2004 04:38, Jamie Lokier wrote:
> I was looking at the code which checks for prefetch instructions in
> the page fault path on x86 and x86-64, due to the AMD bug where
> prefetch sometimes causes unwanted faults.
>
> I wondered if simply returning when *EIP points to a prefetch
> instruction could cause an infinite loop of page faults, instead of
> the wanted SIGSEGV or SIGBUS.  I know we went over it before, but I
> had another look.
>
> AMD already confirmed that the erroneous fault won't reoccur when a
> prefetch instruction is returned to from the fault handler.  So a loop
> can only occur if it's _not_ an erroneous fault, but instead the
> __is_prefetch() code is preventing a normal signal from being ever
> raised.
[snip]
> But... what if the page is not executable?  When NX is enabled on
> 32-bit x86, and all x86-64 kernels, or even the exec-shield patch's
> changes to the USER_CS limit (that limit isn't checked in
> __is_prefetch) - those conditions all allow __is_prefetch() to read a
> prefetch instruction, cause the fault handler to return, and repeat.
>
> This can only happen when something branches to a page with PROT_EXEC
> _not_ set, on a kernel which honours that, and the target address is a
> prefetch instruction.

Well. To be safe, just skip prefetch instruction, always.
Hm. An attacker can supply us with whole gigabyte of
prefetches back-to-back... Better skip all prefetches,
with resheduling between every 1000 of them.
-- 
vda
