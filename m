Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbTEIES0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 00:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbTEIES0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 00:18:26 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:27860 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262290AbTEIESY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 00:18:24 -0400
Date: Thu, 8 May 2003 21:31:19 -0700
From: Andrew Morton <akpm@digeo.com>
To: Roland McGrath <roland@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 uaccess to fixmap pages
Message-Id: <20030508213119.58dd490d.akpm@digeo.com>
In-Reply-To: <200305090203.h4923CM11039@magilla.sf.frob.com>
References: <200305090203.h4923CM11039@magilla.sf.frob.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 May 2003 04:30:56.0841 (UTC) FILETIME=[C8E05390:01C315E3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> wrote:
>
> This patch against 2.5.69 makes uaccess (i.e., access_ok and get/put_user)
> to user-accessible fixmap addresses on x86 work.

This doesn't apply against Linus's current tree.

> -#define access_ok(type,addr,size) (__range_ok(addr,size) == 0)
> +#define access_ok(type,addr,size) (__range_ok(addr,size) == 0 || \
> +				   __fixmap_access_ok((unsigned long)(addr), \
> +						      (size), (type)))

Your patch increases the kernel text by nearly 1%.  That's rather a lot for
what is a fairly esoteric feature.


   text    data     bss     dec     hex filename
2805911  592912  732516 4131339  3f0a0b /tmp/vmlinux
2825167  592982  732516 4150665  3f5589 vmlinux

Would it be possible to avoid this by just taking the fault and fixing
things up in the exception handler?

>  #else
>  
> -#define access_ok(type,addr,size) ( (__range_ok(addr,size) == 0) && \
> +#define access_ok(type,addr,size) ((__range_ok(addr,size) == 0) ? \
>  			 ((type) == VERIFY_READ || boot_cpu_data.wp_works_ok || \
> -			  __verify_write((void *)(addr),(size))))
> +			  __verify_write((void *)(addr),(size))) : \
> +			  __fixmap_access_ok((unsigned long)(addr),size,type))

You'll be wanting to parenthesise `size' and `type' here.


For some reason the patch causes gcc-2.95.3 to choke over the

	__put_user(d_off, &lastdirent->d_off);

statement in sys_getdents64().


fs/readdir.c: In function `sys_getdents64':
fs/readdir.c:285: internal error--unrecognizable insn:
(insn 138 212 147 (set (reg:SI 3 %ebx)
        (asm_operands/v ("1:	movl %%eax,0(%2)
2:	movl %%edx,4(%2)
3:
.section .fixup,"ax"
4:	movl %3,%0
	jmp 3b
.previous
.section __ex_table,"a"
	.align 4
	.long 1b,4b
	.long 2b,4b
.previous") ("=r") 0[ 
                (reg:DI 1 %edx)
                (reg:SI 0 %eax)
                (const_int -14 [0xfffffff2])
                (reg:SI 3 %ebx)
            ] 
            [ 
                (asm_input:DI ("A"))
                (asm_input:SI ("r"))
                (asm_input:SI ("i"))
                (asm_input:SI ("0"))
            ]  ("fs/readdir.c") 277)) -1 (insn_list 112 (insn_list 119 (insn_list 137 (nil))))
    (nil))
make[1]: *** [fs/readdir.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [fs] Error 2
