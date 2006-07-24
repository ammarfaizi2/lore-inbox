Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWGXRgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWGXRgc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWGXRgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:36:31 -0400
Received: from colin.muc.de ([193.149.48.1]:50693 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932231AbWGXRgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:36:31 -0400
Date: 24 Jul 2006 19:36:29 +0200
Date: Mon, 24 Jul 2006 19:36:29 +0200
From: Andi Kleen <ak@muc.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 5/6] Begin abstraction of sensitive instructions: asm files
Message-ID: <20060724173629.GB50320@muc.de>
References: <200607212326_MC3-1-C5B8-F9ED@compuserve.com> <1153575288.13198.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153575288.13198.16.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2006 at 11:34:48PM +1000, Rusty Russell wrote:
> On Fri, 2006-07-21 at 23:23 -0400, Chuck Ebbert wrote:
> > In-Reply-To:<1153527274.13699.36.camel@localhost.localdomain>
> > 
> > On Sat, 22 Jul 2006 10:14:34 +1000, Rusty Russell wrote:
> > > +#define GET_CR0                      movl %cr0, %eax
> >  
> > Could you change GET_CR0 to MOV_CR0_EAX?  GET_CR0 seems like it's
> > taking a reference or something.
> 
> Hi Chuck,
> 
> 	Agreed: certainly eax should be mentioned.  GET_CR0_INTO_EAX?  MOV is a
> bit close to describing how it's happening (which, on paravirt it might
> not be) so it might lead the reader to unwarranted assumptions.
> 
> ===
> Abstract sensitive instructions in assembler code, replacing them with
> macros (which currently are #defined to the native versions).  We use
> long names: assembler is case-insensitive, so if something goes wrong
> and macros do not expand, it would assemble anyway.
> 
> Resulting object files are exactly the same as before.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> Index: working-2.6.18-rc2-hg-paravirt/arch/i386/kernel/entry.S
> ===================================================================
> --- working-2.6.18-rc2-hg-paravirt.orig/arch/i386/kernel/entry.S	2006-07-21 21:09:22.000000000 +1000
> +++ working-2.6.18-rc2-hg-paravirt/arch/i386/kernel/entry.S	2006-07-22 04:32:25.000000000 +1000
> @@ -76,8 +76,15 @@
>  NT_MASK		= 0x00004000
>  VM_MASK		= 0x00020000
>  
> +/* These are replaces for paravirtualization */
> +#define DISABLE_INTERRUPTS		cli
> +#define ENABLE_INTERRUPTS		sti
> +#define ENABLE_INTERRUPTS_SYSEXIT	sti; sysexit
> +#define INTERRUPT_RETURN		iret
> +#define GET_CR0_INTO_EAX		movl %cr0, %eax

I would rather pass the register to the macro? If you start to
clobber registers you would need to pass in the tmp registers
too I guess.

-Andi

