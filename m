Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265408AbRFVSoY>; Fri, 22 Jun 2001 14:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265471AbRFVSoE>; Fri, 22 Jun 2001 14:44:04 -0400
Received: from zeus.kernel.org ([209.10.41.242]:10938 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S265408AbRFVSoB>;
	Fri, 22 Jun 2001 14:44:01 -0400
Message-ID: <3B33918D.1CF642B4@mvista.com>
Date: Fri, 22 Jun 2001 11:42:21 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: signal dequeue ...
In-Reply-To: <XFMail.20010622110507.davidel@xmailserver.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> I'm just trying to figure out the reason why signal must be delivered one at a
> time instead of building a frame with multiple calls with only the last one
> chaining back to the kernel.
> All previous calls instead of calling the stub that jump back to the kernel
> will call a small stub like ( Ix86 ) :
> 
> stkclean_stub:
>         add $frame_size, %esp
>         cmp %esp, $end_stubs
>         jae $sigreturn_stub
>         ret
> sigreturn_stub:
>         mov __NR_sigreturn, %eax
>         int $0x80
> end_stubs:
> 
> ...
> | context1
> * $stkclean_stub
> * sigh1_eip
> | context0
> * $stkclean_stub
> * sigh0_eip
> 
> When sigh0 return, it'll call stkclean_stub that will clean context0 and if
> we're at the end it'll call the jump-back-to-kernel stub, otherwise the it'll
> execute the  ret  the will call sigh1 handler ... and so on.
> 
And if the user handler does a long_jmp?  

Actually some systems have code in long_jmp to notify the system that it
will not be returning (these are systems that deliver signals to user
land with context on the kernel stack and need to know when to unwind
the kernel stack).

George
