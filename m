Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbTEHI2u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 04:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbTEHI2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 04:28:50 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:36755 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261219AbTEHI2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 04:28:47 -0400
Date: Thu, 8 May 2003 10:41:01 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Jonathan Lundell <linux@lundell-bros.com>, root@chaos.analogic.com,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
Message-ID: <20030508084101.GE1469@wohnheim.fh-wedel.de>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305071008080.11871@chaos> <p05210601badeeb31916c@[207.213.214.37]> <3EB957FA.4080900@us.ibm.com> <20030507200647.GB3166@wohnheim.fh-wedel.de> <3EB96916.7080900@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3EB96916.7080900@us.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003 13:14:14 -0700, Dave Hansen wrote:
> Jörn Engel wrote:
> >>The stack overflow checking in -mjb uses gcc's mcount mechanism to
> >>detect overflows.  It should get called on every single function call.
> > 
> > Nice trick.  Do you have better documentation on that machanism than
> > man gcc?  The paragraph to -p is quite short and I cannot make the
> > connection to the rest of the patch immediately.
> 
> It is a nice trick, but I didn't write it :)  I stole the code from Ben
> LaHaise, around 2.5.20.  All that I've needed to know to maintain the
> patch is that a "jmp mcount" gets placed in the critical places.

Sure.  But exactly that information is not contained in the manpage (as
of Debians 3.2.3).  I guess I'll have to dig deeper.

> I've attached a fairly recent version of the stack check patch.  If you
> need some more examples, check out kernprof's use of it.  It's acg
> functionality used mcount as well.

Oh, kernprof was too advanced already.  It basically worked out of the
box for me, porting it to ppc took maybe one hour, not counting a
linker problem that was loosely related to that patch.  Never bothered
to really understand what it does. :(

> diff -Nru a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
> --- a/arch/i386/kernel/process.c	Mon Jan 27 11:40:03 2003
> +++ b/arch/i386/kernel/process.c	Mon Jan 27 11:40:03 2003
> @@ -159,7 +159,22 @@
>  
>  __setup("idle=", idle_setup);
>  
> -void show_regs(struct pt_regs * regs)
> +void stack_overflow(unsigned long esp, unsigned long eip)
> +{
> +	int panicing = ((esp&(THREAD_SIZE-1)) <= STACK_PANIC);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +	if (panicing)
> +		print_symbol("stack overflow from %s\n", eip);
> +	else
> +		print_symbol("excessive stack use from %s\n", eip);
> +	printk("esp: %p\n", (void*)esp);
> +	show_trace((void*)esp);
> +	
> +	if (panicing)
> +		panic("stack overflow\n");
> +}
> +
> +asmlinkage void show_regs(struct pt_regs * regs)
>  {
>  	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L;
>  
> diff -Nru a/include/asm-i386/thread_info.h b/include/asm-i386/thread_info.h
> --- a/include/asm-i386/thread_info.h	Mon Jan 27 11:40:03 2003
> +++ b/include/asm-i386/thread_info.h	Mon Jan 27 11:40:03 2003
> @@ -63,6 +63,8 @@
>   */
>  #define THREAD_ORDER 1 
>  #define INIT_THREAD_SIZE       THREAD_SIZE
> +#define STACK_PANIC		0x200ul
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +#define STACK_WARN		((THREAD_SIZE)>>1)
>  
>  #ifndef __ASSEMBLY__

If I read this correctly, your patch doesn't catch everything, if
there are functions remaining that use stack frames >0x200ul.  Ok,
tell me I'm wrong and should go through the assembler code first.

Jörn

-- 
Fantasy is more important than knowlegde. Knowlegde is limited,
while fantasy embraces the whole world.
-- Albert Einstein
