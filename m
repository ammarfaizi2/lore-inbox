Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277165AbRKHRzP>; Thu, 8 Nov 2001 12:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277143AbRKHRzD>; Thu, 8 Nov 2001 12:55:03 -0500
Received: from laas.laas.fr ([140.93.0.15]:17309 "EHLO laas.laas.fr")
	by vger.kernel.org with ESMTP id <S277068AbRKHRyE>;
	Thu, 8 Nov 2001 12:54:04 -0500
Message-ID: <3BEAC6AB.A6A35E73@laas.fr>
Date: Thu, 08 Nov 2001 18:53:47 +0100
From: Tahar <tahar.jarboui@laas.fr>
Reply-To: jarboui@laas.fr
Organization: LAAS-CNRS
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.5.1 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: David Chandler <chandler@grammatech.com>,
        Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Bug Report: Dereferencing a bad pointer
In-Reply-To: <Pine.LNX.3.95.1011108103553.22138A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,

Your explanation shows why the process is not killed with a SIGSEGV, but
it don't points out why the process hangs !

"Richard B. Johnson" wrote:
> 
> On Thu, 8 Nov 2001, David Chandler wrote:
> 
> > Benjamin LaHaise wrote:
> >
> > > On Wed, Nov 07, 2001 at 06:23:13PM -0500, David Chandler wrote:
> > > > The following one-line C program, when compiled by gcc 2.96 without
> > > > optimization, should produce a SIGSEGV segmentation fault (on a machine
> > > > with 3 or less gigabytes of virtual memory, at least):
> > > >
> > > >         int main() { int k  = *(int *)0xc0000000; }
> > > >
> 
> This may not necessarily produce a seg-fault! If this virtual
> address is mapped within the current process (.bss .stack, etc.),
> It's perfectly all right to write to it although you probably
> broke malloc() by doing it. The actual value of the number in
> the pointer depends upon PAGE_OFFSET and other kernel variables.
> If you change the kernel, this number may change. It has nothing
> to do with the size of virtual address space, really.
> 
> Script started on Thu Nov  8 10:44:03 2001
> # cat >xxx.c
> #include <stdio.h>
> int bss;
> int data = 0x100;
> const char cons[]="X";
> 
> main()
> {
>    int stack;
> 
>    printf("main() = %p\n", main);
>    printf("stack  = %p\n", &stack);
>    printf("const  = %p\n", cons);
>    printf("  data = %p\n", &data);
>    printf("   bss = %p\n", &bss);
>    return 0;
> 
> }
> 
> # gcc -o xxx xxx.c
> # ./xxx
> main() = 0x80484cc
> stack  = 0xbffff6fc
> const  = 0x8048584
>   data = 0x80495d4
>    bss = 0x80496b8
> # exit
> exit
> 
> Script done on Thu Nov  8 10:44:27 2001
> 
> All this stuff you "own". You can write to most all of it because
> the kernel has allocated it for you. Whether or not 'const' is
> really read-only is "implementation dependent".
> 
> In your case, it looks as though you scribbled over the top of
> your user stack, in some harmless place.
> 
> You cannot presume that a program that doesn't seg-fault is
> memory-error free. Protection is in pages, not bytes, and you
> already own a lot of address-space that you may think that
> you don't. FYI, if you allocate a lot of memory using malloc(),
> it sets the break address to acquire more memory. Then if you
> free that memory, it does not necessarily give back the memory.
> 
> You may be able to write to freed memory without a seg-fault.
> However, subsequent calls to malloc() may fail because you have
> ticked-off malloc() and it's gonna get even.
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).
> 
>     I was going to compile a list of innovations that could be
>     attributed to Microsoft. Once I realized that Ctrl-Alt-Del
>     was handled in the BIOS, I found that there aren't any.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
