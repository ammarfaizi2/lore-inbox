Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbTEABJV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 21:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbTEABJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 21:09:21 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63249 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262620AbTEABJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 21:09:20 -0400
Date: Wed, 30 Apr 2003 18:21:52 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix prefetch patching in 2.5-bk
In-Reply-To: <20030501001511.GA2890@averell>
Message-ID: <Pine.LNX.4.44.0304301814010.20283-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 1 May 2003, Andi Kleen wrote:
> 
> If your machine BUG()s in apply_alternatives at booting 
> or module loading you need this patch.

I applied it, but I don't have to like it..

How about doing this differently, and having something like this:

	#define nop_alternative(newinstr, feature)		\
		".section .altinstructions,\"a\"\n"		\
		"  .align 4\n"
		"    .long 660f\n"
		"    .long 663f\n"
		"    .byte %c0\n"
		"    .byte 0\n"
		"    .byte 664f-663f\n"
		".previous\n"
		".section .altinstr_replacement",\"ax\"\n"
		"663:\n\t" newinstr "\n664:\n"
		".previous"
		"660:\n\t"
		".rept  664b-663b, 0x90\n\t"

and making "sourcelen==0" a special case for replacement (replace with the 
proper destination length nop, instead of having that "0x90 0x90 0x90" 
sequence).

This allows you to use arbitrary-sized things without having to worry 
about having to have the size right, or without having to use 
unnecessarily long nop-sequences. You'll always get the right-size nop.

		Linus

