Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273706AbSISWlV>; Thu, 19 Sep 2002 18:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273713AbSISWlV>; Thu, 19 Sep 2002 18:41:21 -0400
Received: from jalon.able.es ([212.97.163.2]:51646 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S273706AbSISWlS>;
	Thu, 19 Sep 2002 18:41:18 -0400
Date: Fri, 20 Sep 2002 00:46:13 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: root@chaos.analogic.com
Cc: Richard Henderson <rth@twiddle.net>, Brian Gerst <bgerst@didntduck.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, dvorak <dvorak@xs4all.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: Syscall changes registers beyond %eax, on linux-i386
Message-ID: <20020919224613.GA2026@werewolf.able.es>
References: <Pine.LNX.3.95.1020919154730.16046A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.3.95.1020919154730.16046A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Thu, Sep 19, 2002 at 21:53:24 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.09.19 Richard B. Johnson wrote:
>On Thu, 19 Sep 2002, Richard Henderson wrote:
>
[...]
>> > It's really bad code because it could have done:
>> > 
>> > 	incl	$0x04(%esp)
>> > 	incl	$0x08(%esp)
>> > 	incl	$0x1c(%esp)
>> > 	jmp	bar
>> 
[...]
>
>It's a problem with a 'general purpose' compiler that wants to
>be "all things" to all people. If somebody made a gcc-compatible
>compiler, tuned to the ix86 characteristics, I think we could
>cut the extra instructions by at least 1/2, maybe more.
>

Curiosity killed the cat....
Just tried it with gcc-3.2.
C code:
extern void bar(int x, int y, int z);
void foo(const int a, const int b, const int c)
{
        bar(a+1, b+1, c+1);
}

- gcc -S -O0:
        pushl   %ebp
        movl    %esp, %ebp
        subl    $8, %esp
        subl    $4, %esp
        movl    16(%ebp), %eax
        incl    %eax
        pushl   %eax
        movl    12(%ebp), %eax
        incl    %eax
        pushl   %eax
        movl    8(%ebp), %eax
        incl    %eax
        pushl   %eax
        call    bar
        addl    $16, %esp
        leave
        ret

- gcc -S -O1:
        pushl   %ebp
        movl    %esp, %ebp
        subl    $12, %esp
        movl    16(%ebp), %eax
        incl    %eax
        pushl   %eax
        movl    12(%ebp), %eax
        incl    %eax
        pushl   %eax
        movl    8(%ebp), %eax
        incl    %eax
        pushl   %eax
        call    bar
        addl    $16, %esp
        movl    %ebp, %esp
        popl    %ebp
        ret

- gcc -S -O2:
        movl    12(%esp), %eax
        incl    %eax
        movl    %eax, 12(%esp)
        movl    8(%esp), %eax
        incl    %eax
        movl    %eax, 8(%esp)
        movl    4(%esp), %eax
        incl    %eax
        movl    %eax, 4(%esp)
        jmp     bar

- gcc -S -O2 -march=[i686,pentium2,pentium3]:
        incl    4(%esp)
        movl    8(%esp), %eax
        incl    %eax
        movl    %eax, 8(%esp)
        movl    12(%esp), %eax
        incl    %eax
        movl    %eax, 12(%esp)
        jmp     bar

- gcc -S -O2 -march=pentium4:
        movl    8(%esp), %eax
        addl    $1, 4(%esp)
        addl    $1, %eax
        movl    %eax, 8(%esp)
        movl    12(%esp), %eax
        addl    $1, %eax
        movl    %eax, 12(%esp)
        jmp     bar

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (Cooker) for i586
Linux 2.4.20-pre7-jam0 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))
