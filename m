Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261487AbSITI1f>; Fri, 20 Sep 2002 04:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261679AbSITI1e>; Fri, 20 Sep 2002 04:27:34 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:1782 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261487AbSITI1d>;
	Fri, 20 Sep 2002 04:27:33 -0400
Message-ID: <3D8ADD05.999E4A5C@mvista.com>
Date: Fri, 20 Sep 2002 01:32:05 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: Daniel Jacobowitz <dan@debian.org>, Brian Gerst <bgerst@didntduck.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       dvorak <dvorak@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: Syscall changes registers beyond %eax, on linux-i386
References: <24181C771D3@vcnet.vc.cvut.cz>
		<3D8A11BB.4090100@didntduck.org>
		<20020919192434.GA3286@nevyn.them.org> <15754.12963.763811.307755@kim.it.uu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> 
> Daniel Jacobowitz writes:
>  > That's not going to help.  As Richard said, the memory in question
>  > belongs to the called function.  GCC knows this.  It can freely modify
>  > it.  The fact that the value of the parameter is const is a
>  > language-level, semantic thing.  It doesn't say anything about the
>  > const-ness of that memory.  Only the ABI does.
> 
> Does Linux/x86 even have a proper ABI document? I've never seen one.
> The closest I've seen would be the SVR4 i386 psABI, but it
> deliberately doesn't define the raw syscall interface, only the
> each-syscall-is-a-C-function one implemented by the C library,
> and that interface doesn't suffer from the current issue.
> 
> IOW, the kernel may not be at fault if user-space code invokes int
> $0x80 directly and then sees clobbered registers.

Ah, that, indeed is the issue.  As far as C is concerned,
the call is NOT a call, but a bit of asm.  If the asm is
correctly written the problem goes away, not because the
register is not modified, but because C is on notice that it
MIGHT be modified and thus not to count on it.

As a practical matter, ebx is used to pass arg1 to the
kernel so it must be changed by the asm code, the further
listing of it beyond the third ":" in the asm inline, will
cause the compiler to not rely on it being further
modified.  The same is true of all the registers used to
pass parameters.  (These are: arg1 ebx, arg2 ecx, arg3 edx,
arg4 esi, arg5 edi, and arg6 ebp.)

So, is there a problem?  Yes, neither the call stub macros
in asm/unistd.h nor those in glibc bother to list the used
registers beyond the third ":".  And, if I understand this
right, the glibc code to save ebx in another register
suffers from the false assumption that THAT register can be
clobbered, but this is only true if C sees the code as a
function, not an inline asm, but most system calls in glibc
are coded as inline asm, not separate functions (not to be
confused with the C inline, which is a separate function).

At least that is how I see it.  Comments?

-g

> 
> /Mikael
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
