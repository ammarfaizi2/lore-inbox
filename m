Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWFQXC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWFQXC3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 19:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWFQXC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 19:02:29 -0400
Received: from aun.it.uu.se ([130.238.12.36]:31206 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1750871AbWFQXC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 19:02:29 -0400
Date: Sun, 18 Jun 2006 01:02:21 +0200 (MEST)
Message-Id: <200606172302.k5HN2LdD004446@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: w@1wt.eu
Subject: Re: [PATCH 2.4.33-rc1] repair __ide_dma_no_op breakage
Cc: linux-kernel@vger.kernel.org, marcelo@kvack.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2006 23:26:12 +0200, Willy Tarreau wrote:
>> This patch to ide-dma.c defines a function 'int __ide_dma_no_op(void)'
>> and stores its address in function pointer fields with type
>> 'int (*)(ide_drive_t*)'. Thus callers will call __ide_dma_no_op() with
>> more parameters than it expects.
>>
>> This is invalid C and it will break horribly in some valid calling
>> conventions (in particular, when parameters are passed on the stack
>> and the callee not the caller pops them).
>
>I 100% agree with your analysis and you fix, but just out of curiosity,
>when could we encounter such circumstances ? On specific archs or when
>functions are declared in a certain manner ?

I suspect that no currently supported architecure is affected as long
as default calling conventions are used, but i386 would be affected if
__attribute__((stdcall)) is in effect. I suspect m68k is in a similar
situation as i386.

> I've always learned that
>in C, it's always the caller which pops, reason why var args are possible
>and the args type checking is very loose.

What you describe is the typical implementation, but it is a historical
accident and not necessarily the best choice from a performance
perspective. Before ANSI-C introduced prototypes, there was no way to
distinguish variadic from non-variadic functions. Thus all functions
had to use the same conventions, which typically were caller-pops since
that's what's needed for variadic functions. With prototypes it's usually
better to use a callee-pops convention, since that tends to reduce code
space and it allows for tailcalls without blowing the stack. Unfortunately
binary compatibility with pre-ANSI-C object code meant that most if not
all ABIs kept their pre-ANSI-C rules, i.e. caller-pops.

/Mikael
