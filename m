Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131190AbQLHH6a>; Fri, 8 Dec 2000 02:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131441AbQLHH6V>; Fri, 8 Dec 2000 02:58:21 -0500
Received: from Nabiki.Mountain.Net ([198.77.1.5]:27019 "EHLO
	nabiki.mountain.net") by vger.kernel.org with ESMTP
	id <S131190AbQLHH6Q>; Fri, 8 Dec 2000 02:58:16 -0500
Message-ID: <3A308D6F.BD99B6F9@mountain.net>
Date: Fri, 08 Dec 2000 02:27:43 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test12 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at buffer.c:827 in test12-pre6 and 7
In-Reply-To: <3A30125D.5F71110D@cheek.com> <90p9kf$5p3$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> It's not a new bug - it's an old bug that apparently is uncovered by a
> new stricter test.
> 
> Apparently loopback unlocks an already unlocked page - which has always
> been a serious offense, but has never been detected before.
> 
> test12-pre6+ detects it, and thus the BUG().
> 
> Your stack trace isn't symbolic (see Documentation/oops-tracing.txt), so
> it's impossible to debug, but it's already interesting information to
> see that it seems to be either loopback of vfat.
> 
> Can you test some more? In particular, I'd love to hear if this happens
> with vfat even without loopback, or with loopback even without vfat
> (make an ext2 filesystem or similar instead). That woul dnarrow down the
> bug further.
> 
>                 Thanks,
>                                 Linus

Hi,

Here is a rather different datapoint. I hope it's different enough to help
nail this.

test12-pre5 + kdb + Serial Console. Sorry, I didn't get the contents of
pointer args.

It's probably worth saying that this kernel was compiled with gcc 2.95.2. I
have the blessed egcs also, will compile pre7 with that and see what
happens.

Cheers,
Tom

from nfs mounted ext2 (2.4.0-test12-pre5):
kernel BUG at buffer.c:827!

Entering kdb (current=0xc2014000, pid 466) Panic: invalid operand
due to panic @ 0xc0130c73
eax = 0x0000001c ebx = 0xc109ebf8 ecx = 0x00000000 edx = 0x00000006 
esi = 0xc2739af0 edi = 0xc2739b38 esp = 0xc2015dd4 eip = 0xc0130c73 
ebp = 0xc2015df4 xss = 0x00000018 xcs = 0xc2010010 eflags = 0x00010046 
xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xc2015da0
kdb> bt
    EBP       EIP         Function(args)
0xc2015df4 0xc0130c73 end_buffer_io_async+0xd3 (0xc2739af0, 0x1)
                               kernel .text 0xc0100000 0xc0130ba0 0xc0130cb0
0xc2015e10 0xc0164756 end_that_request_first+0x66 (0xc11c2c20, 0x1,
0xc031cf04)
                               kernel .text 0xc0100000 0xc01646f0 0xc01647b0
0xc2015e30 0xc018a128 ide_end_request+0x28 (0x1, 0xc11c5060)
                               kernel .text 0xc0100000 0xc018a100 0xc018a180
0xc2015e64 0xc018e614 read_intr+0x104 (0xc031ce20)
                               kernel .text 0xc0100000 0xc018e510 0xc018e650
0xc2015e88 0xc018bad6 ide_intr+0x106 (0xe, 0xc11c5060, 0xc2015ed4, 0x1c0)
                               kernel .text 0xc0100000 0xc018b9d0 0xc018bb30
0xc2015ea8 0xc010ab50 handle_IRQ_event+0x30 (0xe, 0xc2015ed4, 0xc11de2e0)
                               kernel .text 0xc0100000 0xc010ab20 0xc010ab80
0xc2015ecc 0xc010ace2 do_IRQ+0x72 (0xc02f4520, 0xc02a92ac, 0xc201c000,
0xc201c000, 0xfffffc18)
                               kernel .text 0xc0100000 0xc010ac70 0xc010ad30
           0xc01093f0 ret_from_intr
                               kernel .text 0xc0100000 0xc01093f0 0xc0109410
Interrupt registers:
eax = 0x00000019 ebx = 0xc02f4520 ecx = 0xc02a92ac edx = 0xc201c000 
esi = 0xc201c000 edi = 0xfffffc18 esp = 0xc2015f08 eip = 0xc0115816 
ebp = 0xc2015f4c xss = 0x00000018 xcs = 0xc0000010 eflags = 0x00000287 
xds = 0xc2070018 xes = 0xc2070018 origeax = 0xffffff0e &regs = 0xc2015ed4 
           0xc0115816 schedule+0x1b6
                               kernel .text 0xc0100000 0xc0115660 0xc0115b00
0xc2015f70 0xc01155c7 schedule_timeout+0x17 (0xc2014000, 0x1785222)
                               kernel .text 0xc0100000 0xc01155b0 0xc0115650
0xc2015fac 0xc4055753 [sunrpc]svc_recv+0x1a3 (0xc24b2470, 0xc207be00,
0x7fffffff)
                               sunrpc .text 0xc404e060 0xc40555b0 0xc4055940
0xc2015fec 0xc40713f3 [nfsd]nfsd+0x253
                               nfsd .text 0xc4071060 0xc40711a0 0xc40714a0
           0xc0107843 kernel_thread+0x23
                               kernel .text 0xc0100000 0xc0107820 0xc0107860
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
