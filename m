Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261701AbTBSVXY>; Wed, 19 Feb 2003 16:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261599AbTBSVXQ>; Wed, 19 Feb 2003 16:23:16 -0500
Received: from [67.99.70.131] ([67.99.70.131]:3589 "EHLO
	peter.integraltech.com") by vger.kernel.org with ESMTP
	id <S261724AbTBSVW4>; Wed, 19 Feb 2003 16:22:56 -0500
Message-ID: <021a01c2d85e$79a30f10$8f00a8c0@integraltech.com>
From: "Rob Murphy" <rmurphy@integraltech.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.18 + 2.4.20 bigmem iounmap bug
Date: Wed, 19 Feb 2003 16:32:59 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0217_01C2D834.90BD9DC0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0217_01C2D834.90BD9DC0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hello all.

I have been having problems using ioremap and iounmap on systems with more
than 1Gb of memory.
My current machine has an athlon processor and 1.5Gb of memory.

I created a driver with the following code:

#define MAXHM 0x1000000 // 16 Mb
int init_module(void)
{
    void *kHighMem;

    printk(KERN_ERR"before ioremap\n");
    kHighMem = ioremap(__pa(high_memory), MAXHM);
    printk(KERN_ERR"ioremap ret: %x\n",kHighMem);
    iounmap(kHighMem);
    printk(KERN_ERR"iounmap passed\n");

    return 0;
}

void cleanup_module(void) {
    printk(KERN_ERR,"module successfully unloaded.\n");
}

I have compiled the code into a module named "test.o" and have added the
append="mem=1280" to lilo for both kernels.
Under 2.4.18:
If I run "insmod test.o" , I get a Segmentation fault (see attached messages
file).

Under 2.4.20:
 I can run "insmod test.o" and "rmmod test" without a problem.  But then it
seems if I run any program that accesses memory (a simple user mode program
that malloc's multiple buffers for example) I get a Kernel Panic and the
computer locks up.  The panic I get is:
Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c012ca6e
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012ca6e>]    Not tainted
EFLAGS: 00010092
eax:   ebx:   ecx:    edx: esi:   edi:   ebp:    esp:  ds:  es:  ss: ...
Process init (pid: 521, stackpage=f6ed1000)
Stack: ...
Call Trace:    ...
Code: 89 50 04 89 02 c7 43 04 00 00 00 00 c7 03 00 00 00 00 d1 6c

I have not yet to tried to trace into the 2.4.20 lockup.

If append="mem=768" or less the problem doesn't happen, but ioremap is
unable to map the entire amount of remaining memory above the kernel and a
boundary is reached of kernel memory + ioremaped memory <= 1Gb (i.e. if
append="mem=384" ioremap can only map up to 640mb).

>From what I can guess, it looks like ioremap may be corrupting the page
tables when the highmem functionality is being used.  I noticed that my
PAGE_OFFSET is still at 0xc0000000 which according to <include/page.h> means
that I will always have only 950MB of virtual address space.  I would have
thought that setting CONFIG_HIGHMEM4G=y would have changed the PAGE_OFFSET
value.
Has anyone experienced similar problems?  Does anyone know a different way
of allocating large contiguous amounts of DMA capable memory other than
using ioremap or vmalloc?

Any help would be appreciated.
Robert Murphy



------=_NextPart_000_0217_01C2D834.90BD9DC0
Content-Type: application/octet-stream;
	name="messages"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="messages"

before ioremap=0A=
ioremap ret: f894a000=0A=
------------[ cut here ]------------=0A=
kernel BUG at page_alloc.c:145!=0A=
invalid operand: 0000=0A=
test fbusmod autofs ne2k-pci 8390 iptable_filter ip_tables ext3 jbd  =0A=
CPU:    0=0A=
EIP:    0010:[<c0136ba9>]    Tainted: GF=0A=
EFLAGS: 00010286=0A=
=0A=
EIP is at __free_pages_ok [kernel] 0xb9 (2.4.18-14)=0A=
eax: 00000000   ebx: c1c5c110   ecx: c1000030   edx: f7985a00=0A=
esi: 00000000   edi: 00000000   ebp: f9000000   esp: f64ade64=0A=
ds: 0018   es: 0018   ss: 0018=0A=
Process insmod.old (pid: 766, stackpage=3Df64ad000)=0A=
Stack: 00000000 00000000 c00b99a0 c03037e0 00000016 c037e069 f64adf18 =
c011ad0f =0A=
       c03037e0 c037e07f 0014f000 f65f753c 00400000 f9000000 c0133a32 =
00001cdf =0A=
       00001cdf 00000282 33000007 00400000 c0101f94 00400000 c0133453 =
c0101f90 =0A=
Call Trace:=0A=
[<c011ad0f>] __call_console_drivers [kernel] 0x5f (0xf64ade80))=0A=
[<c0133a32>] free_area_pte [kernel] 0xf2 (0xf64ade9c))=0A=
[<c0133453>] vmfree_area_pages [kernel] 0x83 (0xf64adebc))=0A=
[<c011b041>] printk [kernel] 0x111 (0xf64adecc))=0A=
[<c01335d8>] vfree [kernel] 0x88 (0xf64adee8))=0A=
[<f893a0a2>] init_module [test] 0x42 (0xf64adefc))=0A=
[<c011bee9>] sys_init_module [kernel] 0x4d9 (0xf64adf1c))=0A=
[<f893a060>] init_module [test] 0x0 (0xf64adf20))=0A=
[<f893a060>] init_module [test] 0x0 (0xf64adf58))=0A=
[<c01090ff>] system_call [kernel] 0x33 (0xf64adfc0))=0A=
=0A=
Code: 0f 0b 91 00 47 5d 25 c0 c6 43 24 05 8b 43 18 89 f9 89 de 83 =0A=

------=_NextPart_000_0217_01C2D834.90BD9DC0--

