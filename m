Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbUKOXMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUKOXMm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 18:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbUKOXMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 18:12:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:43178 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261582AbUKOXK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 18:10:59 -0500
Date: Mon, 15 Nov 2004 15:10:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Brian Gerst <bgerst@quark.didntduck.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Regparm for x86 machine check handlers
In-Reply-To: <41992590.4060004@osdl.org>
Message-ID: <Pine.LNX.4.58.0411151501080.2222@ppc970.osdl.org>
References: <4198EA70.202@quark.didntduck.org> <Pine.LNX.4.58.0411151201580.2222@ppc970.osdl.org>
 <41992590.4060004@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Nov 2004, Randy.Dunlap wrote:
> 
> and omit "asmlinkage.*sys_xyz".  that leaves a handful of functions
> which are <asm>, like:
> 
> acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state);
> csum_partial(), csum_partial_copy_generic(),
> schedule_tail(), aes_enc_blk(), aes_dec_blk().

The schedule_tail() usage seems a bit suspect. The asm code on x86 seems 
to play it safe, and pass the argument _both_ on the stack and in 
registers. So it looks correct, but a bit schitzo.

The others should probably be changed to use register calling conventions,
but it might not be worth doing so right now, and at least they seem to
agree on how to pass arguments in callers and callee's. The csum functions
are certainly performance-critical, but it's not like the argument passing 
convention is likely to make _that_ big of a difference, and they are 
"asmcall" not because they are called from asm, but because they are 
_implemented_ in asm (so unlike the other cases, these guys don't have
the problem with the callee thinking it owns the argument frame).

> I don't see others than need to be fixed, but a script
> would be a safer way to check, so I'm trying to nail down
> the requirements ... and what tool to use, like is there
> already a PERL [or python or xyz] script that parses C,
> or would you *coff* recommend sparse?

Sparse can't look into the asm code, but it could certainly be made to 
report on functions that use "regparm(0)". But it would be good to have 
something that matches up the functions with the asm code and verifies 
that they agree on passing convention.

There doesn't seem to be enough of them to bother with a tool, though.

		Linus
