Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283311AbRLEH2d>; Wed, 5 Dec 2001 02:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283337AbRLEH2X>; Wed, 5 Dec 2001 02:28:23 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:39433 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S283311AbRLEH2O>;
	Wed, 5 Dec 2001 02:28:14 -0500
Date: Wed, 5 Dec 2001 02:28:13 -0500 (EST)
Message-Id: <200112050728.fB57SDO230728@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org
Subject: USB audio w/ "D" state
Cc: sailer@ife.ee.ethz.ch, alan@lxorguk.ukuu.org.uk,
        linuxppc-dev@lists.linuxppc.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I did "cat /bin/sh >> /dev/audio" and hit ^C to stop the noise.
The "cat" process gets stuck in "D" state with the WCHAN indicating
that the process is stuck 1/3 the way through the usbout_stop()
function.

hardware:  Mac Cube and the normal spherical speakers
kernel:    plain 2.4.16 from www.kernel.org
compiler:  gcc version 2.95.4 20011006 (Debian prerelease)

In case PPC assembly is useful to somebody, I've marked the instruction
where the process gets stuck. The surrounding "bl" instructions look
like infinite loops to me, but maybe I'm reading this wrong. The assembly
is from:   objdump -dl --start-address=0x1728 audio.o

usbout_stop():
    1728:       94 21 ff d0     stwu    r1,-48(r1)
    172c:       7c 08 02 a6     mflr    r0
    1730:       7d 80 00 26     mfcr    r12
    1734:       bf 81 00 20     stmw    r28,32(r1)
    1738:       90 01 00 34     stw     r0,52(r1)
    173c:       91 81 00 1c     stw     r12,28(r1)
    1740:       3b e3 03 98     addi    r31,r3,920
    1744:       3b c0 00 01     li      r30,1
    1748:       3b a1 00 08     addi    r29,r1,8
    174c:       7f a3 eb 78     mr      r3,r29
    1750:       48 00 00 01     bl      1750 <usbout_stop+0x28>
    1754:       48 00 00 01     bl      1754 <usbout_stop+0x2c>
    1758:       83 9f 00 24     lwz     r28,36(r31)
    175c:       57 80 07 34     rlwinm  r0,r28,0,28,26
    1760:       90 1f 00 24     stw     r0,36(r31)
    1764:       80 61 00 08     lwz     r3,8(r1)
    1768:       48 00 00 01     bl      1768 <usbout_stop+0x40>
    176c:       73 80 00 0f     andi.   r0,r28,15
    1770:       41 82 00 98     beq     1808 <usbout_stop+0xe0>
    1774:       31 3e ff ff     addic   r9,r30,-1
    1778:       7d 29 49 10     subfe   r9,r9,r9
    177c:       38 09 00 01     addi    r0,r9,1
    1780:       55 29 07 bc     rlwinm  r9,r9,0,30,30
    1784:       2e 1e 00 00     cmpwi   cr4,r30,0
    1788:       7d 29 03 78     or      r9,r9,r0
    178c:       91 22 00 00     stw     r9,0(r2)
    1790:       38 60 00 01     li      r3,1
    1794:       48 00 00 01     bl      1794 <usbout_stop+0x6c>
--> 1798:       7f a3 eb 78     mr      r3,r29
    179c:       48 00 00 01     bl      179c <usbout_stop+0x74>
    17a0:       48 00 00 01     bl      17a0 <usbout_stop+0x78>
    17a4:       83 9f 00 24     lwz     r28,36(r31)
    17a8:       80 61 00 08     lwz     r3,8(r1)
    17ac:       48 00 00 01     bl      17ac <usbout_stop+0x84>
    17b0:       41 92 ff bc     beq     cr4,176c <usbout_stop+0x44>
    17b4:       80 02 00 08     lwz     r0,8(r2)
    17b8:       2c 00 00 00     cmpwi   r0,0
    17bc:       41 82 ff b0     beq     176c <usbout_stop+0x44>
    17c0:       73 80 00 01     andi.   r0,r28,1
    17c4:       41 82 00 0c     beq     17d0 <usbout_stop+0xa8>
    17c8:       38 7f 00 28     addi    r3,r31,40
    17cc:       48 00 00 01     bl      17cc <usbout_stop+0xa4>
    17d0:       73 80 00 02     andi.   r0,r28,2
    17d4:       41 82 00 0c     beq     17e0 <usbout_stop+0xb8>
    17d8:       38 7f 00 cc     addi    r3,r31,204
    17dc:       48 00 00 01     bl      17dc <usbout_stop+0xb4>
    17e0:       73 80 00 04     andi.   r0,r28,4
    17e4:       41 82 00 0c     beq     17f0 <usbout_stop+0xc8>
    17e8:       38 7f 01 70     addi    r3,r31,368
    17ec:       48 00 00 01     bl      17ec <usbout_stop+0xc4>
    17f0:       73 80 00 08     andi.   r0,r28,8
    17f4:       41 82 00 0c     beq     1800 <usbout_stop+0xd8>
    17f8:       38 7f 02 14     addi    r3,r31,532
    17fc:       48 00 00 01     bl      17fc <usbout_stop+0xd4>
    1800:       3b c0 00 00     li      r30,0
    1804:       4b ff ff 68     b       176c <usbout_stop+0x44>
    1808:       3b a0 00 00     li      r29,0
    180c:       93 a2 00 00     stw     r29,0(r2)
    1810:       80 7f 00 4c     lwz     r3,76(r31)
    1814:       2c 03 00 00     cmpwi   r3,0
    1818:       41 82 00 08     beq     1820 <usbout_stop+0xf8>
    181c:       48 00 00 01     bl      181c <usbout_stop+0xf4>
    1820:       80 7f 00 f0     lwz     r3,240(r31)
    1824:       2c 03 00 00     cmpwi   r3,0
    1828:       41 82 00 08     beq     1830 <usbout_stop+0x108>
    182c:       48 00 00 01     bl      182c <usbout_stop+0x104>
    1830:       80 7f 01 94     lwz     r3,404(r31)
    1834:       2c 03 00 00     cmpwi   r3,0
    1838:       41 82 00 08     beq     1840 <usbout_stop+0x118>
    183c:       48 00 00 01     bl      183c <usbout_stop+0x114>
    1840:       80 7f 02 38     lwz     r3,568(r31)
    1844:       2c 03 00 00     cmpwi   r3,0
    1848:       41 82 00 08     beq     1850 <usbout_stop+0x128>
    184c:       48 00 00 01     bl      184c <usbout_stop+0x124>
    1850:       93 bf 00 4c     stw     r29,76(r31)
    1854:       93 bf 02 38     stw     r29,568(r31)
    1858:       93 bf 01 94     stw     r29,404(r31)
    185c:       93 bf 00 f0     stw     r29,240(r31)
    1860:       80 01 00 34     lwz     r0,52(r1)
    1864:       81 81 00 1c     lwz     r12,28(r1)
    1868:       7c 08 03 a6     mtlr    r0
    186c:       bb 81 00 20     lmw     r28,32(r1)
    1870:       7d 80 81 20     mtcrf   8,r12
    1874:       38 21 00 30     addi    r1,r1,48
    1878:       4e 80 00 20     blr
