Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263985AbTEFQd6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263981AbTEFQdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:33:16 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25838 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263985AbTEFQcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:32:16 -0400
Date: Tue, 6 May 2003 18:44:41 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andi Kleen <ak@muc.de>
Cc: torvalds@transmeta.com, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix .altinstructions linking failures
Message-ID: <20030506164441.GO9794@fs.tum.de>
References: <20030506063055.GA15424@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506063055.GA15424@averell>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 08:30:55AM +0200, Andi Kleen wrote:
> 
> Some configs didn't link anymore because they got references from
> .altinstructions to __exit functions. Fixing it at the linker level
> is not easily possible. This patch just discards .text.exit at runtime
> instead of link time to avoid this.
> 
> Idea from Andrew Morton.
> 
> It will also fix a related problem with .eh_frame in modern gcc (so far 
> only observed on x86-64, but could happen on i386 too) 
> 
> Index: linux/arch/i386/vmlinux.lds.S
> ===================================================================
> RCS file: /home/cvs/linux-2.5/arch/i386/vmlinux.lds.S,v
> retrieving revision 1.18
> diff -u -u -r1.18 vmlinux.lds.S
> --- linux/arch/i386/vmlinux.lds.S	30 Apr 2003 14:32:05 -0000	1.18
> +++ linux/arch/i386/vmlinux.lds.S	6 May 2003 05:28:28 -0000
> @@ -85,7 +85,10 @@
>    __alt_instructions = .;
>    .altinstructions : { *(.altinstructions) } 
>    __alt_instructions_end = .; 
> - .altinstr_replacement : { *(.altinstr_replacement) }
> + .altinstr_replacement : { *(.altinstr_replacement) } 
> +  /* .exit.text is discard at runtime, not link time, to deal with references
> +     from .altinstructions and .eh_frame */
> +  .exit.text : { *(.exit.text) }
>    . = ALIGN(4096);
>    __initramfs_start = .;
>    .init.ramfs : { *(.init.ramfs) }
> @@ -106,7 +109,6 @@
>  
>    /* Sections to be discarded */
>    /DISCARD/ : {
> -	*(.exit.text)
>  	*(.exit.data)
>  	*(.exitcall.exit)
>  	}
> 

This patch is bogus.

The result are tons of
  undefined reference to `local symbols in discarded section .exit.data'

This problem might be solved by moving the .exit.data, too.

The next thing that breaks are things like the following:
drivers/built-in.o(.exit.text+0x4c25): In function `cpia_exit':
: undefined reference to `proc_cpia_destroy'

The problem is in drivers/media/video/cpia.c:

<--  snip  -->

...
#ifdef MODULE
static void proc_cpia_destroy(void)
{
        remove_proc_entry("cpia", 0);
}
#endif /*MODULE*/
...
static void __exit cpia_exit(void)
{
#ifdef CONFIG_PROC_FS
        proc_cpia_destroy();
#endif
}
...

<--  snip  -->



Please fix all of the problems your changes in 2.5.69 created.


TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

