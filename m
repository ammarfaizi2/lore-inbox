Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264880AbTGBJeC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 05:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264876AbTGBJeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 05:34:02 -0400
Received: from fc.capaccess.org ([151.200.199.53]:28428 "EHLO fc.capaccess.org")
	by vger.kernel.org with ESMTP id S264870AbTGBJdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 05:33:46 -0400
Message-id: <fc.0010c7b200947c110010c7b200947c11.947c14@capaccess.org>
Date: Wed, 02 Jul 2003 05:50:07 -0400
Subject: Heh. It works. I wrote a pmode pico-kernel in shell script assembly.
To: linux-assembly@vger.kernel.org, linux-kernel@vger.kernel.org
From: "Rick A. Hohensee" <rickh@capaccess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got various burblers going on the screen in various timescales.
There's an INT 100 that gets called in the main endless loop, and that
churns the fastest. There's a couple of blinking characters courtesy of
VGA. The endless loop also polls the keyboard and changes a couple
characters based on the current or latest scancode. There's another
burbler for Ye Olde Dos Jiffy, and that of course is slower than the
endless-loop burbler, so I use a big increment to make it look nicer.

The really fun one though is all IRQs besides 0 use the same burbler cell
on the screen, so that's acting as a keyboard character counter. It comes
up ! on boot from the left-over floppy IRQ I guess, and then when you hit
keys it increments up through the ROM font.

Rick Hohensee
Precision Mojo Engineer





00000000  00...                         ALLOT 0x7C00
00007c00  270 28 02                     = 552 to A
00007c03  271 01 00                     = 1 to C
00007c06  31 322                        XOR D with D
00007c08  8e 302                        = D to ES
00007c0a  273 00 7c                     = 0x7c00 to B
00007c0d  cd 13                         submit 0x13
00007c0f  fa                    nosurprises
00007c10  270 00 b8                     = 0xb800 to A
00007c13  8e 330                        = A to DS
00007c15  270 48 68                     = 0x6848 to A
00007c18  89 006 20 02                  = A to @ 544
00007c1c  31 300                        XOR A with A
00007c1e  8e 330                        = A to DS
00007c20  0f 01 16 61 7d                        setGDT initial_gdtr
00007c25  270 00 b8                     = 0xb800 to A
00007c28  8e 330                        = A to DS
00007c2a  270 61 61                     = 0x6161 to A
00007c2d  89 006 c0 02                  = A to @ 704
00007c31  270 01 00                     = 1 to A        0f 01 f0
00007c37  e9 00 00                      jump PMODE16
00007c3a                (O) PMODE16
00007c3a  270 33 f2                     = 0xf233 to A
00007c3d  89 006 60 03                  = A to @ 864
00007c41  ea 46 7c 10 00                        far jump addr./GDTindex ptr
00007c46                (O) BIG_CS
00007c46  270 4e 33 73 27                       = 0x2773334e to A
00007c4b  89 005 00 04 00 00                    = A to @ 1024
00007c51  270 18 00 00 00                       = 0x18 to A
00007c56  8e 330                        = A to DS
00007c58                (O) BIG_DS
00007c58  270 21 3a 6d 27                       = 0x276d3a21 to A
00007c5d  89 005 a0 84 0b 00                    = A to @ 754848
00007c63  31 300                        XOR A with A
00007c65  8e 300                        = A to ES
00007c67  8e 340                        = A to FS
00007c69  8e 350                        = A to GS
00007c6b                (O) nullifiedextrasegments
00007c6b  270 75 84 74 00                       = 0x748475 to A
00007c70  89 005 60 88 0b 00                    = A to @ 755808
00007c76  270 18 00 00 00                       = 0x18 to A
00007c7b  8e 320                        = A to SS
00007c7d  274 00 40 10 00                       = 0x104000 to SP
00007c82  270 df 00 00 00                       = 0xdf to A
00007c87  272 64 00 00 00                       = 0x64 to D
00007c8c  ee                    send byte
00007c8d  270 03 00 00 00                       = 0x3 to A
00007c92  e8 5a 02 00 00                        call writekeyboardwires
00007c97                (O) defaultallvectors
00007c97  31 377                        XOR DI with DI
00007c99                (O) perIDTvector
00007c99  60                    pushcore
00007c9a  270 37 7e 00 00                       = twitch to A
00007c9f  e8 5b 01 00 00                        call install
00007ca4  61                    pullcore
00007ca5  107                   1+ DI
00007ca6  81 377 7f 00 00 00                    -test 127 with DI
00007cac  0f 85 e7 ff ff ff   when not zero perIDTvector
00007cb2                (O) defaultallIRQs
00007cb2  277 20 00 00 00                       = 0x20 to DI
00007cb7                (O) perIRQvector
00007cb7  60                    pushcore
00007cb8  270 47 7e 00 00                       = IRQtwitch to A
00007cbd  e8 3d 01 00 00                        call install
00007cc2  61                    pullcore
00007cc3  107                   1+ DI
00007cc4  81 377 30 00 00 00                    -test 0x30 with DI
00007cca  0f 85 e7 ff ff ff   when not zero perIRQvector
00007cd0  277 20 00 00 00                       = 0x20 to DI
00007cd5  60                    pushcore
00007cd6  270 6a 7e 00 00                       = IRQ0twitch to A
00007cdb  e8 1f 01 00 00                        call install
00007ce0  61                    pullcore
00007ce1  0f 01 1d 92 7e 00 00                  setIDT 32402
00007ce8                (O) PICprogram
00007ce8  270 11 00 00 00                       = 17 to A
00007ced  272 20 00 00 00                       = 0x20 to D
00007cf2  ee                    send byte
00007cf3  272 a0 00 00 00                       = 0xa0 to D
00007cf8  ee                    send byte
00007cf9  270 20 00 00 00                       = 0x20 to A
00007cfe  272 21 00 00 00                       = 0x21 to D
00007d03  ee                    send byte
00007d04  270 28 00 00 00                       = 0x28 to A
00007d09  272 a1 00 00 00                       = 0xa1 to D
00007d0e  ee                    send byte
00007d0f  270 04 00 00 00                       = 4 to A
00007d14  272 21 00 00 00                       = 0x21 to D
00007d19  ee                    send byte
00007d1a  270 02 00 00 00                       = 2 to A
00007d1f  272 a1 00 00 00                       = 0xa1 to D
00007d24  ee                    send byte
00007d25  270 01 00 00 00                       = 1 to A
00007d2a  272 21 00 00 00                       = 0x21 to D
00007d2f  ee                    send byte
00007d30  272 a1 00 00 00                       = 0xa1 to D
00007d35  ee                    send byte
00007d36  fb                    surprises
00007d37                (O) theloop
00007d37  272 60 00 00 00                       = 0x60 to D
00007d3c  ec                    recieve byte
00007d3d  0d 00 43 22 33                        OR 0x33224300 to A
00007d42  89 005 00 81 0b 00                    = A to @ 753920
00007d48  272 64 00 00 00                       = 0x64 to D
00007d4d  ec                    recieve byte
00007d4e  0d 00 43 87 23                        OR 0x23874300 to A
00007d53  89 005 04 81 0b 00                    = A to @ 753924
00007d59  cd 33                         submit 0x33
00007d5b  e9 d7 ff ff ff                        jump theloop
00007d60  f4                    halt
00007d61                (O) initial_gdtr
00007d61  00 04 67 7d 00 00
00007d67                (O) GDT
00007d67  00 00 00 00 00 00 00 00                       0 NULL, required
00007d6f
00007d6f                (O) ringN
00007d6f  ff ff 00 00 00 89 cf 00                       1 stackstack
00007d77
00007d77                (O) ring0
00007d77  ff ff 00 00 00 9a cf 00                       2 CS
00007d7f  ff ff 00 00 00 92 cf 00                       3 ring0 data
00007d87  00 00 00 00 00 00 00 00                       4 spacer
00007d8f  00 00 00 00 00 00 00 00                       5 spacer
00007d97  00 00 00 00 00 00 00 00                       6 spacer
00007d9f  00 00 00 00 00 00 00 00                       7 spacer
00007da7  00 00 00 00 00 00 00 00                       8 spacer
00007daf
00007daf                (O) legmegschweg
00007daf  ff ff 00 00 0e 9a c0 00                       9 RBIOS CS
00007db7  ff ff 00 00 00 92 c0 00                       10 BIOS DS 0
00007dbf  ff ff 00 00 0d 9a c0 00                       11 RVBIOS code
00007dc7  ff ff 00 80 0b 92 c0 00                       12 8086 VGA data
00007dcf  ff ff 00 00 08 92 80 00                       13 legmeg SS
00007dd7  00 00 00 00 00 00 00 00                       14 spacer
00007ddf  00 00 00 00 00 00 00 00                       15 spacer
00007de7
00007de7                (O) ring0A
00007de7  ff ff 00 00 00 ba cf 00                       16 RING 0A SS
00007def  ff ff 00 00 00 b2 cf 00                       17 ring 0A data
00007df7  ff ff 00 00 00 ba cf 00                       18 RING 0A SS
00007dff                        ring3 probably will want BGDT
00007dff
00007dff                (O) install
00007dff  273 10 00 00 00                       = 16 to B
00007e04  271 0e 00 00 00                       = 14 to C
00007e09  c1 347 03                     upshift 3 to DI
00007e0c  81 307 00 10 00 00                    + 0x1000 to DI
00007e12                (O) makegate
00007e12  89 302                        = A to D
00007e14  81 342 ff ff 00 00                    AND 0x0000ffff to D
00007e1a  81 312 00 00 10 00                    OR 0x100000 to D
00007e20  89 027                        = D to @ DI
00007e22  c1 341 08                     upshift 8 to C
00007e25  81 311 00 80 00 00                    OR 0x8000 to C
00007e2b  81 340 00 00 ff ff                    AND 0xffff0000 to A
00007e31  09 301                        OR A to C
00007e33  89 117 04                     = C to @ 4 DI
00007e36  c3                    return
00007e37                (O) twitch
00007e37  120                   push A
00007e38  8b 005 32 8a 0b 00                    = @ 756274 to A
00007e3e  100                   1+ A
00007e3f  89 005 32 8a 0b 00                    = A to @ 756274
00007e45  130                   pull A
00007e46  cf                    dismiss
00007e47                (O) IRQtwitch
00007e47  120                   push A
00007e48  8b 005 0e 81 0b 00                    = @ 753934 to A
00007e4e  100                   1+ A
00007e4f  89 005 0e 81 0b 00                    = A to @ 753934
00007e55  122                   push D
00007e56  270 20 00 00 00                       = 32 to A
00007e5b  272 a0 00 00 00                       = 0xa0 to D
00007e60  ee                    send byte
00007e61  272 20 00 00 00                       = 0x20 to D
00007e66  ee                    send byte
00007e67  132                   pull D
00007e68  130                   pull A
00007e69  cf                    dismiss
00007e6a                (O) IRQ0twitch
00007e6a  120                   push A
00007e6b  8b 005 6e 80 0b 00                    = @ 753774 to A
00007e71  81 300 07 b2 01 00                    + 111111 to A
00007e77  89 005 6e 80 0b 00                    = A to @ 753774
00007e7d  122                   push D
00007e7e  270 20 00 00 00                       = 32 to A
00007e83  272 a0 00 00 00                       = 0xa0 to D
00007e88  ee                    send byte
00007e89  272 20 00 00 00                       = 0x20 to D
00007e8e  ee                    send byte
00007e8f  132                   pull D
00007e90  130                   pull A
00007e91  cf                    dismiss
00007e92                (O) initial_IDTreg
00007e92  00 02 00 10 00 00
00007e98                (O) appendages



No concatenated code required. :o)

