Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267963AbTAHXGJ>; Wed, 8 Jan 2003 18:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267964AbTAHXGJ>; Wed, 8 Jan 2003 18:06:09 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:47089 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S267963AbTAHXGH>;
	Wed, 8 Jan 2003 18:06:07 -0500
Message-ID: <3E1CA2C0.10CA007E@mvista.com>
Date: Wed, 08 Jan 2003 14:14:24 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Roets, Chris (Tru64&Linux support)" <Chris.Roets@hp.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux i386 stack trace
References: <224CFA9643B4CE4BA18137CF73DB2F32010F2CD0@broexc01.emea.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Roets, Chris (Tru64&Linux support)" wrote:
> 
> I known nothing about i386 calling conventions, but I would like to analyse a kernel stack.
> 
> I have the following stack trace :

It would help a great deal if you turned on frame pointers. 
In the 2.5 kernel this is a configure option.  In 2.4 you
may have to modify the Makefile.

In general the function arguments are pushed on the stack
(right to left) followed by the call which pushes the return
address.  If frame pointers are used, the called function
then pushes ebp and then loads ebp with the current stack
address.  This allows you to, given ebp, walk back the the
stack to each function.  Locals pushed on the stack after
the ebp reg....

But some functions don't save the frame pointer even if
turned on, notably the interrupt and asm code around
interrupt and trap handling.

-g
> 
> STACK TRACE FOR TASK: 0xc4cb6000(vi)
> 
>  0 schedule+770 [0xc01130e2]
>  1 schedule_timeout+18 [0xc0112d42]
>  2 do_select+513 [0xc0140a11]
>  3 sys_select+820 [0xc0140db4]
>  4 system_call+44 [0xc0106f14]
>    ebx: 00000001   ecx: bffff700   edx: 00000000   esi: bffff680
>    edi: 00000000   ebp: bffff798   eax: 0000008e   ds:  002b
>    es:  002b       eip: 4010e0ee   cs:  0023       eflags: 00000202
>    esp: bffff630   ss:  002b
> ================================================================
> 
> >> dump -x 3301670612 40
> 0xc4cb7ed4:       c4cb7f00
>                   c4cb6000
>                   00000000
>                   c29f3000
> 0xc4cb7ee4:       c4cb6000
>                   00000000
>                   c0274000
>                   c02b2540
> 0xc4cb7ef4:       7fffffff
>                   7fffffff
>                   00000000
>                   c4cb7f30
> 0xc4cb7f04:       c0112d47 schedule_timeout+23
>                   c29f3000
>                   cc75e914
>                   c4cb7f54
> 0xc4cb7f14:       00000000
>                   c8dde7c4
>                   00000001
>                   c4cb7f90
> 0xc4cb7f24:       00000000
>                   00000000
>                   7fffffff
>                   00000000
> 0xc4cb7f34:       c0140a16 do_select+518
>                   c4cb7f54
>                   00000001
>                   c4cb6000
> 0xc4cb7f44:       7fffffff
>                   00000001
>                   00000000
>                   00000001
> 0xc4cb7f54:       00000000
>                   c730f000
>                   00000001
>                   bffff684
> 0xc4cb7f64:       c17d83ec
>                   00000001
>                   c0140db9 sys_select+825
>                   00000001
> 
> can anybody point me out where the arguments and the local variables are ?
> take for example
>     int do_select(int n, fd_set_bits *fds, long *timeout)
>     {
>             poll_table table, *wait;
>             int retval, i, off;
>             long __timeout = *timeout;
> 
>            ......
> I t has 3 arguments and tree local variable
> I would be nice to have the same for ia64
> 
> Chris
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
