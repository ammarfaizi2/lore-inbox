Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTGOGRG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 02:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263738AbTGOGRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 02:17:01 -0400
Received: from fc.capaccess.org ([151.200.199.53]:8460 "EHLO fc.capaccess.org")
	by vger.kernel.org with ESMTP id S263590AbTGOGQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 02:16:24 -0400
Message-id: <fc.0010c7b200979cdc0010c7b200979cdc.979ec2@capaccess.org>
Date: Tue, 15 Jul 2003 02:33:15 -0400
Subject: 386+ Forreal Mode. Flat 32-bit unprotected. Demo appended.
To: linux-kernel@vger.kernel.org, linux-assembly@vger.kernel.org
From: "Rick A. Hohensee" <rickh@capaccess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The appendage below, if I cut/pasted it right (check the address column),
is the gas -a equivalent of my osimplay compembler for a little boot demo
called "forreal". It boots, makes a flat 32-bit ring0-only pmode, does
some other things not important to this demo like setting up an IDT, and
then turns off protection. Just turns it off. Just above the GDT data
you'll see

XOR A with A
= A to CR0

Then it loads a quad (32 bits) to VGA using a flat quad address for the
screen, 0xb8800. And there they are; two characters and two attributes in
one load, burbling happily. Runs in flat 32-bit with protection off, in
other words. I also forgot to use a short loop, so you'll see that it's a
quad relative jump.

IRQs are off. It looks like for a 32-bit unprotected OS you need
8086-style intvecs in the IDT. That's the only real annoyance I see at
this point. This occured to me because I had been assuming rmode vectors
off 0 like an 8086. So Squeal Mode is still on the slab, but Forreal Mode
is up and geekin.

Forreal Mode. Part of this complete Squeal Mode.

INT is rated faster for real mode than pmode, but that might just be
because they are talking about a 16 bit return addy. If not, Forreal Mode
should be interesting for realtime stuff and truly sophistry-free
operating systems like AmigaDos. INT I think is rated 37 clocks rmode, 59
pmode or thereabouts.

What happens when you load DS with 0xb800 or something is LAAETTR. And of
course, I wouldn't be seen in the same convention hall with a paged
Forreal Mode. Or a true 32-bit Minix.

In other words, what INTeL says you're supposed to do when going to real
mode is to be suffixed with "if you're trying to run Dos." Which was quite

legitimate concern in 1986. Conversely, aspects of a segent descriptor
persist if you flip PE after setting up the segment. Like USE32 is USE32
in real or pmode. Once USE32 is set for your code segment, rmode can't
unset it. Hence the recommended INTeL ceremonies.



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
00007c20  0f 01 16 7e 7d                        setGDT initial_gdtr
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
00007c58  8e 300                        = A to ES
00007c5a                (O) BIG_DS
00007c5a  270 21 3a 6d 27                       = 0x276d3a21 to A
00007c5f  89 005 a0 84 0b 00                    = A to @ 754848
00007c65  31 300                        XOR A with A
00007c67  8e 340                        = A to FS
00007c69  8e 350                        = A to GS
00007c6b                (O) nullifiedextrasegments
00007c6b  270 75 84 74 00                       = 0x748475 to A
00007c70  89 005 60 88 0b 00                    = A to @ 755808
00007c76  270 18 00 00 00                       = 0x18 to A
00007c7b  8e 320                        = A to SS
00007c7d  270 d1 00 00 00                       = 0xd1 to A
00007c82  272 64 00 00 00                       = 0x64 to D
00007c87  ee                    send byte
00007c88  90                    nop
00007c89  90                    nop
00007c8a  90                    nop
00007c8b  90                    nop
00007c8c  90                    nop
00007c8d  90                    nop
00007c8e  90                    nop
00007c8f  90                    nop
00007c90  90                    nop
00007c91  90                    nop
00007c92  270 df 00 00 00                       = 0xdf to A
00007c97  272 60 00 00 00                       = 0x60 to D
00007c9c  ee                    send byte
00007c9d  272 92 00 00 00                       = 0x92 to D
00007ca2  ec                    recieve byte
00007ca3  0d 02 00 00 00                        OR 2 to A
00007ca8  ee                    send byte
00007ca9                (O) a20loop
00007ca9  270 55 55 aa aa                       = 0xaaaa5555 to A
00007cae  89 005 d8 ff 1f 00                    = A to @ 2097112
00007cb4  8b 035 d8 ff 1f 00                    = @ 2097112 to B
00007cba  39 303                        -test A to B
00007cbc  0f 85 e7 ff ff ff   when not zero a20loop
00007cc2  274 f0 ef 00 00                       = 61424 to SP
00007cc7                (O) defaultallvectors
00007cc7  31 377                        XOR DI with DI
00007cc9                (O) perIDTvector
00007cc9  60                    pushcore
00007cca  270 0c 7e 00 00                       = twitch to A
00007ccf  e8 00 01 00 00                        call install
00007cd4  61                    pullcore
00007cd5  107                   1+ DI
00007cd6  81 377 7f 00 00 00                    -test 127 with DI
00007cdc  0f 85 e7 ff ff ff   when not zero perIDTvector
00007ce2                (O) defaultallIRQs
00007ce2  277 20 00 00 00                       = 0x20 to DI
00007ce7                (O) perIRQvector
00007ce7  60                    pushcore
00007ce8  270 1c 7e 00 00                       = IRQtwitch to A
00007ced  e8 e2 00 00 00                        call install
00007cf2  61                    pullcore
00007cf3  107                   1+ DI
00007cf4  81 377 30 00 00 00                    -test 0x30 with DI
00007cfa  0f 85 e7 ff ff ff   when not zero perIRQvector
00007d00  277 20 00 00 00                       = 0x20 to DI
00007d05  60                    pushcore
00007d06  270 3f 7e 00 00                       = IRQ0twitch to A
00007d0b  e8 c4 00 00 00                        call install
00007d10  61                    pullcore
00007d11  0f 01 1d 67 7e 00 00                  setIDT 32359
00007d18                (O) PICprogram
00007d18  270 11 00 00 00                       = 17 to A
00007d1d  272 20 00 00 00                       = 0x20 to D
00007d22  ee                    send byte
00007d23  272 a0 00 00 00                       = 0xa0 to D
00007d28  ee                    send byte
00007d29  270 20 00 00 00                       = 0x20 to A
00007d2e  272 21 00 00 00                       = 0x21 to D
00007d33  ee                    send byte
00007d34  270 28 00 00 00                       = 40 to A
00007d39  272 a1 00 00 00                       = 0xa1 to D
00007d3e  ee                    send byte
00007d3f  270 04 00 00 00                       = 4 to A
00007d44  272 21 00 00 00                       = 0x21 to D
00007d49  ee                    send byte
00007d4a  270 02 00 00 00                       = 2 to A
00007d4f  272 a1 00 00 00                       = 0xa1 to D
00007d54  ee                    send byte
00007d55  270 01 00 00 00                       = 1 to A
00007d5a  272 21 00 00 00                       = 0x21 to D
00007d5f  ee                    send byte
00007d60  272 a1 00 00 00                       = 0xa1 to D
00007d65  ee                    send byte
00007d66  31 300                        XOR A with A
00007d68  0f 20 300                     = A to CR0
00007d6b  270 44 34 19 18                       = 0x18193444 to A
00007d70                (O) fmodeloop
00007d70  89 005 00 88 0b 00                    = A to @ 755712
00007d76  100                   1+ A
00007d77  e9 f4 ff ff ff                        jump fmodeloop
00007d7c  f4                    halt
00007d7d  f4                    halt
00007d7e                (O) initial_gdtr
00007d7e  00 04 84 7d 00 00
00007d84                (O) GDT
00007d84  00 00 00 00 00 00 00 00                       0 the required NULL
00007d8c  ff ff 00 00 00 89 cf 00                       1 0x8 TSS
stackstack
00007d94  ff ff 00 00 00 9a cf 00                       2 0x10 ring0 USE32
CS
00007d9c  ff ff 00 00 00 92 cf 00                       3 0x18 ring0 data
00007da4  ff ff 00 00 00 9a 00 00                       4 0x20 USE16 CS
00007dac  ff ff 00 00 00 92 00 00                       5 0x28 USE16 data
?S
00007db4  00 00 00 00 00 00 00 00                       6 0x30
00007dbc  00 00 00 00 00 00 00 00                       7 0x38
00007dc4  00 00 00 00 00 00 00 00                       8 0x40
00007dcc  00 00 00 00 00 00 00 00                       9 0x48
00007dd4
00007dd4                (O) install
00007dd4  273 10 00 00 00                       = 16 to B
00007dd9  271 0e 00 00 00                       = 14 to C
00007dde  c1 347 03                     upshift 3 to DI
00007de1  81 307 00 10 00 00                    + 0x1000 to DI
00007de7                (O) makegate
00007de7  89 302                        = A to D
00007de9  81 342 ff ff 00 00                    AND 0x0000ffff to D
00007def  81 312 00 00 10 00                    OR 0x100000 to D
00007df5  89 027                        = D to @ DI
00007df7  c1 341 08                     upshift 8 to C
00007dfa  81 311 00 80 00 00                    OR 0x8000 to C
00007e00  81 340 00 00 ff ff                    AND 0xffff0000 to A
00007e06  09 301                        OR A to C
00007e08  89 117 04                     = C to @ 4 DI
00007e0b  c3                    return
00007e0c                (O) twitch
00007e0c  120                   push A
00007e0d  8b 005 32 8a 0b 00                    = @ 756274 to A
00007e13  100                   1+ A
00007e14  89 005 32 8a 0b 00                    = A to @ 756274
00007e1a  130                   pull A
00007e1b  cf                    dismiss
00007e1c                (O) IRQtwitch
00007e1c  120                   push A
00007e1d  8b 005 0e 81 0b 00                    = @ 753934 to A
00007e23  100                   1+ A
00007e24  89 005 0e 81 0b 00                    = A to @ 753934
00007e2a  122                   push D
00007e2b  270 20 00 00 00                       = 32 to A
00007e30  272 a0 00 00 00                       = 0xa0 to D
00007e35  ee                    send byte
00007e36  272 20 00 00 00                       = 0x20 to D
00007e3b  ee                    send byte
00007e3c  132                   pull D
00007e3d  130                   pull A
00007e3e  cf                    dismiss
00007e3f                (O) IRQ0twitch
00007e3f  120                   push A
00007e40  8b 005 6e 80 0b 00                    = @ 753774 to A
00007e46  81 300 07 b2 01 00                    + 111111 to A
00007e4c  89 005 6e 80 0b 00                    = A to @ 753774
00007e52  122                   push D
00007e53  270 20 00 00 00                       = 32 to A
00007e58  272 a0 00 00 00                       = 0xa0 to D
00007e5d  ee                    send byte
00007e5e  272 20 00 00 00                       = 0x20 to D
00007e63  ee                    send byte
00007e64  132                   pull D
00007e65  130                   pull A
00007e66  cf                    dismiss
00007e67                (O) initial_IDTreg
00007e67  00 02 00 10 00 00
00007e6d                (O) Cat


