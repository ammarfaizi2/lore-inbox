Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131202AbQLDIBZ>; Mon, 4 Dec 2000 03:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131179AbQLDIBP>; Mon, 4 Dec 2000 03:01:15 -0500
Received: from ns1.crl.go.jp ([133.243.3.1]:50646 "EHLO ns1.crl.go.jp")
	by vger.kernel.org with ESMTP id <S131131AbQLDIBA>;
	Mon, 4 Dec 2000 03:01:00 -0500
Date: Mon, 4 Dec 2000 16:30:15 +0900 (JST)
From: Tom Holroyd <tomh@po.crl.go.jp>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Oops in pdev_sort_resources
Message-ID: <Pine.LNX.4.30.0012041607180.10331-100000@holly.crl.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alpha DP264, test12.  Panic during boot.

I copied this from the console (by hand):

swapper(1): Oops 0
 pc = [<fffffc000044a4a4>]  ra = [<fffffc000044a4dc>]  ps = 0000
 v0 = fffffc003ff70300  t0 = 0000000000000001  t1 = 00000000000001f7
 t2 = 00000000000001f0  t3 = 0000000000000000  t4 = 00000000000003f6
 t5 = 00000000000003f6  t6 = 0000000000000001  t7 = fffffc00015f8000
 s0 = 0000000000000000  s1 = fffffc003ff6a8b8  s2 = 0000000000000000
 s3 = 0000000000000000  s4 = 0000000000000000  s5 = 0000000000000000
 s6 = 0000000000000000
 a0 = 0000000000000000  a1 = 0000000000000000  a2 = 0000000000000000
 a3 = 0000000000000000  a4 = 0000000000000000  a5 = 0000000000000000
 t8 = 0000000000000000  t9 = 0000000000000000  t10= 0000000000000000
 t11= 0000000000000000  pv = fffffc000033f260  at = 0000000000000000
 gp = fffffc00004b2000  sp = fffffc00015fbd20
Code: a4ca0010  ldq t5,16(s1)
 a4aa0008  ldq t4,8(s1)
 c3e00003  br .+16
 47ff041f  or zero,zero,zero
 2fe00000  ldq_u zero,0(v0)
 47e9040b  or zero,s0,s2
*a52b0000  ldq s0,0(s2)
 40c50524  subq t5,t4,t3

Trace:310080 310080 310080 310098 310630 310080 310604 3105d8 310604
Kernel panic: Attempted to kill init!

Ksymoops (2.3.5) refused to process it (couldn't find the Code line) but
it did locate this code in pdev_sort_resources() in
drivers/pci/setup-res.c, which was compiled as

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe -mno-fp-regs -ffixed-8
-mcpu=ev6 -Wa,-mev6    -c -o setup-res.o setup-res.c

resulting in:

        ldq $6,16($10)
        ldq $5,8($10)
        br $31,$L911
        .align 4
$L913:
        mov $9,$11		list = list->next
$L911:
        ldq $9,0($11)		ln = list->next
        subq $6,$5,$4

in which $L913: is the top of the loop:

                for (list = head; ; list = list->next) {
                        unsigned long size = 0;
                        struct resource_list *ln = list->next;

                        if (ln)
                                size = ln->res->end - ln->res->start;
                        if (r->end - r->start > size) {
                                tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
                                tmp->next = ln;
                                tmp->res = r;
                                tmp->dev = dev;
                                list->next = tmp;
                                break;
                        }
                }

So, presumably, near the end of the loop list->next is NULL and
the line
                        struct resource_list *ln = list->next;
causes the oops.

Dr. Tom Holroyd
"I am, as I said, inspired by the biological phenomena in which
chemical forces are used in repetitious fashion to produce all
kinds of weird effects (one of which is the author)."
	-- Richard Feynman, _There's Plenty of Room at the Bottom_

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
