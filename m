Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269382AbUIYScj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269382AbUIYScj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 14:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269384AbUIYScj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 14:32:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5030 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269382AbUIYSce
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 14:32:34 -0400
Date: Sat, 25 Sep 2004 19:32:34 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: __initcall macros and C token pasting
Message-ID: <20040925183234.GU23987@parcelfarce.linux.theplanet.co.uk>
References: <9e47339104092510574c908525@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339104092510574c908525@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 01:57:37PM -0400, Jon Smirl wrote:
> #define DRM(x) r128_##x
> module_init( DRM(init) );
> 
> #define __define_initcall(level,fn) \
>         static initcall_t __initcall_##fn __attribute_used__ \
>         __attribute__((__section__(".initcall" level ".init"))) = fn
> 
> This gives the error:
> {standard input}: Assembler messages:
> {standard input}:104: Error: junk at end of line, first unrecognized
> character is `('
> 
> I believe this is because the C macro is not being expanded in the
> assembler context of the section with the fn assignment.

BS.  In non-modular case (quoted above) DRM(init) will be expanded _long_
before you get to __define_initcall() expansion.

In the modular case, OTOH, it will _not_.  There you get
module_init(DRM(init))  =>
static inline initcall_t __inittest(void) { return initfn; } int init_module(void) __attribute__((alias("DRM(init)")));
since # suppresses expansion of argument.  Which leaves you with
.globl init_module
	.set init_module, DRM(init)
in assembler output.  Which is not going to make as(1) happy.

> Any ideas on how to fix this?

To fix what, exactly?  Your beliefs?  DRM abuse of cpp?  For the former I'd
suggest learning C (or learning to use -S to see what exactly as(1) gets to
deal with).  For the latter...

#define DRM_abuses_cpp_too_fscking_much(x) module_init(x)
DRM_abuses_cpp_too_fscking_much(DRM(init))

will force the expansion before it gets to module_init(), which will result in
acceptable alias.
