Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265732AbTFXHYp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 03:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265733AbTFXHYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 03:24:45 -0400
Received: from fc.capaccess.org ([151.200.199.53]:52491 "EHLO fc.capaccess.org")
	by vger.kernel.org with ESMTP id S265732AbTFXHYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 03:24:39 -0400
Message-id: <fc.0010c7b2009337a30010c7b2009337a3.9337b2@capaccess.org>
Date: Tue, 24 Jun 2003 03:39:40 -0400
Subject: Alan Cox has been replaced by a sh script
To: mail2news-20030624-alt.os.assembly@anon.lcs.mit.edu,
       linux-kernel@vger.kernel.org
From: "Rick A. Hohensee" <rickh@capaccess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox has been replaced by a sh script. GNU too. I must admit though,
it's a whopping 115k.

I have a 32-bit self-booted program running on my B box that responds to
human input. The B box is a P2 Compaq I just picked up for $125--. I had a
spare monitor. The response from the program I'm working on is prompt and
consistant, but degenerate, and the program is written in a 386 assembler
written in Bash, so I've named the program "Durtro".

When you boot Durtro it puts a few boot-progress characters on the stock
VGA text screen, the cursor is wherever it was, and there's 4 cells of
junk in the upper mid-right of the screen. Those are the output of an
endless loop that polls IO ports 0x60 and 0x64 continuously. Interrupts
are still off, a20 hasn't actually been checked, etc. When you hit
keyboard keys the glyph in the left-most cell changes. I'd have to clean
up the joint to find a spare PS2 mouse, and that's out of the question, so
for now I'm getting my jollies with that left-most cell.

The changes to that cell visibly indicate how the BIOS left the keyboard
controller. The higher-scan-code keys wobble between glyphs when you hold
them down. Stuff like the "s" key doesn't. That's probably due to the
XT-era keys repeating the same byte when they repeat, while MF-2 stuff
sends a couple differing bytes per repeat, which makes for a visual
wobble. It looks like about a half-second delay before repeating. Capslock
is software; no light, just an ordinary glyph-twiddle. What I can see here
that you wouldn't be able to trust in e.g. /dev/port is that the byte in
0x60 just sits there for arbitrary reads until the keyboard sends another
one. And I just like a clean machine for such things. Ya never know unless
ya know.

There's more fun. It seems the PC keyboard controller is fully chording. I
mean FULLY. Well heck, it SHOULD be, having a microcontroller just for the
keyboard and all. Not to mention it's own serial protocol. Just because
they never use all that capability the C64 didn't have doesn't mean it's
not there. You can hold down 5 keys simultaneously with one hand and get
changes to my lovely little output character when you twiddle some sixth
key. It seems to usually work, but the downness of all 5 keys becomes
iffy. What's going on as far as repeating then is not clear. What is clear
is that if you want all the keyboard info fast, it's being produced.

Here's the osimplay analog to   gas -a   of Durtro. The threebies in the
actual-code column are octal. A separate program clips off the 0x7c00
zeros.

00000000  00...                         ALLOT 0x7C00
00007c00  270 50 02                     = 592 to A
00007c03  271 01 00                     = 1 to C
00007c06  31 322                        XOR D with D
00007c08  273 00 7c                     = 0x7c00 to B
00007c0b  cd 13                         submit 0x13
00007c0d  fa                    nosurprises
00007c0e  270 00 b8                     = 0xb800 to A
00007c11  8e 330                        = A to DS
00007c13  270 48 68                     = 0x6848 to A
00007c16  89 006 20 02                  = A to @ 544
00007c1a  31 300                        XOR A with A
00007c1c  8e 330                        = A to DS
00007c1e  0f 01 16 19 7d                        setGDT initial_gdtr
00007c23  270 00 b8                     = 0xb800 to A
00007c26  8e 330                        = A to DS
00007c28  270 61 61                     = 0x6161 to A
00007c2b  89 006 c0 02                  = A to @ 704
00007c2f  270 01 00                     = 1 to A        0f 01 f0
00007c35  e9 00 00                      jump PMODE16
00007c38                (O) PMODE16
00007c38  270 33 f2                     = 0xf233 to A
00007c3b  89 006 60 03                  = A to @ 864
00007c3f  ea 44 7c 08 00                        far jump addr./GDTindex ptr
00007c44                (O) BIG_CS
00007c44  270 4e 33 73 27                       = 0x2773334e to A
00007c49  89 005 00 04 00 00                    = A to @ 1024
00007c4f  270 10 00 00 00                       = 0x10 to A
00007c54  8e 330                        = A to DS
00007c56                (O) BIG_DS
00007c56  270 21 3a 6d 27                       = 0x276d3a21 to A
00007c5b  89 005 a0 84 0b 00                    = A to @ 754848
00007c61  31 300                        XOR A with A
00007c63  8e 300                        = A to ES
00007c65  8e 340                        = A to FS
00007c67  8e 350                        = A to GS
00007c69                (O) nullifiedextrasegments
00007c69  270 75 84 74 00                       = 0x748475 to A
00007c6e  89 005 60 88 0b 00                    = A to @ 755808
00007c74  270 10 00 00 00                       = 0x10 to A
00007c79  8e 320                        = A to SS
00007c7b  274 00 40 00 00                       = 0x4000 to SP
00007c80                (O) A20_fix
00007c80  272 64 00 00 00                       = 0x64 to D
00007c85  ec                    recieve byte
00007c86  a9 02 00 00 00                        ANDtest 2 with A
00007c8b  0f 85 ef ff ff ff   when not zero A20_fix
00007c91                (O) A20_again
00007c91  270 d1 00 00 00                       = 0xd1 to A
00007c96  ee                    send byte
00007c97  ec                    recieve byte
00007c98  a9 02 00 00 00                        ANDtest 2 with A
00007c9d  0f 85 ee ff ff ff   when not zero A20_again
00007ca3  270 df 00 00 00                       = 0xdf to A
00007ca8  272 60 00 00 00                       = 0x60 to D
00007cad  ee                    send byte
00007cae  0f 01 1d 8b 7d 00 00                  setIDT 32139
00007cb5                (O) defaultallvectors
00007cb5  31 377                        XOR DI with DI
00007cb7  270 76 7d 00 00                       = unprepared to A
00007cbc                (O) perIDTvector
00007cbc  60                    pushcore
00007cbd  e8 7d 00 00 00                        call install
00007cc2  61                    pullcore
00007cc3  107                   1+ DI
00007cc4  81 377 7f 00 00 00                    -test 127 with DI
00007cca  0f 85 ec ff ff ff   when not zero perIDTvector
00007cd0                (O) initkeyboard
00007cd0  89 30                         = to A
00007cd2  277 21 00 00 00                       = 0x21 to DI
00007cd7  e8 63 00 00 00                        call install
00007cdc                (O) initNMIvector
00007cdc  277 02 00 00 00                       = 2 to DI
00007ce1  89 30                         = to A
00007ce3  e8 57 00 00 00                        call install
00007ce8                (O) NMIoninCMOS
00007ce8  e4 70                         recieve byte 112
00007cea  0d 80 00 00 00                        OR 0x80 to A
00007cef  e6 70                         send byte 112
00007cf1                (O) theloop
00007cf1  272 60 00 00 00                       = 0x60 to D
00007cf6  ec                    recieve byte
00007cf7  0d 00 43 22 33                        OR 0x33224300 to A
00007cfc  89 005 00 81 0b 00                    = A to @ 753920
00007d02  272 64 00 00 00                       = 0x64 to D
00007d07  ec                    recieve byte
00007d08  0d 00 43 87 23                        OR 0x23874300 to A
00007d0d  89 005 04 81 0b 00                    = A to @ 753924
00007d13  e9 d9 ff ff ff                        jump theloop
00007d18  f4                    halt
00007d19                (O) initial_gdtr
00007d19  00 02 1f 7d 00 00
00007d1f                (O) GDT_templates
00007d1f  00 00 00 00 00 00 00 00
00007d27  ff ff 00 00 00 9a cf 00                       index 1
00007d2f  ff ff 00 00 00 92 cf 00               index 2 *4k BIG f-nybble
00007d37  ff ff 00 30 00 89 9f 00
00007d3f                (O) install
00007d3f  273 01 00 00 00                       = 1 to B
00007d44  271 0e 00 00 00                       = 14 to C
00007d49  c1 347 03                     upshift 3 to DI
00007d4c  03 075 00 00 00 00                    + @ 0 to DI
00007d52                (O) makegate
00007d52  89 302                        = A to D
00007d54  81 342 ff ff 00 00                    AND 0x0000ffff to D
00007d5a  c1 343 13                     upshift 19 to B
00007d5d  09 332                        OR B to D
00007d5f  89 027                        = D to @ DI
00007d61  81 340 00 00 ff ff                    AND 0xffff0000 to A
00007d67  c1 341 08                     upshift 8 to C
00007d6a  81 341 00 80 00 00                    AND 0x8000 to C
00007d70  09 301                        OR A to C
00007d72  89 137 04                     = B to @ 4 DI
00007d75  c3                    return
00007d76                (O) unprepared
00007d76  120                   push A
00007d77  8b 005 62 82 0b 00                    = @ 754274 to A
00007d7d  81 300 6f 00 00 00                    + 111 to A
00007d83  89 005 62 82 0b 00                    = A to @ 754274
00007d89  130                   pull A
00007d8a  cf                    dismiss
00007d8b                (O) initial_IDTreg
00007d8b  00 02 00 00 00 00
00007d91                (O) PIC
00007d91  00...                         ALLOT
00007d91                (O) PICspec
00007d91  31 377                        XOR DI with DI
00007d93  8b 075 91 7d 00 00                    = @ 32145 to DI
00007d99  c1 347 03                     upshift 3 to DI
00007d9c  81 307 43 00 00 00                    + 0x43 to DI
00007da2  8b 005 91 7d 00 00                    = @ 32145 to A
00007da8  c1 340 03                     upshift 3 to A
00007dab  8b 005 91 7d 00 00                    = @ 32145 to A
00007db1  c1 340 02                     upshift 2 to A
00007db4  8b 005 91 7d 00 00                    = @ 32145 to A
00007dba  d3 340                        upshift A
00007dbc  ee                    send byte
00007dbd  c3                    return
00007dbe                (O) writePICcount
00007dbe  31 377                        XOR DI with DI
00007dc0  8b 075 91 7d 00 00                    = @ 32145 to DI
00007dc6  c1 347 03                     upshift 3 to DI
00007dc9  81 307 40 00 00 00                    + 0x40 to DI
00007dcf  03 075 91 7d 00 00                    + @ 32145 to DI
00007dd5  8b 005 91 7d 00 00                    = @ 32145 to A
00007ddb  ee                    send byte
00007ddc  c1 350 08                     downshift 8 to A
00007ddf  ee                    send byte
00007de0  c3                    return
00007de1                (O) ticks
00007de1  00...                         ALLOT 8
00007de9                (O) appendages



This, /Ha3sm/code/TOP, is vaguely analagous to init/main.c, along with
all of Linux's attendant obfuscations...
........................................................................
                                # init flow of control. _start/main()
. boot/fromfloppy

nosurprises
. boot/pmode
. boot/a20                      # compembles, bus not checked yet
. interrupt/IDTinit
. keyboard/init                 # June 2003   no PS/2 mouse yet
. timer/pulse/init


L theloop
        = 0x60 to D
        recieve byte
        OR 0x33224300 to A
        = A to @ $((0xb8100))
        = 0x64 to D
        recieve byte
        OR 0x23874300 to A
        = A to @ $((0xb8104))


                                #. test/churn
jump theloop
halt

#############################################################

                        # outside main(). data and subroutines.
. boot/GDTdata
. interrupt/IDTroutines                         # install, unprepared
. timer/routines
. timer/pulse/ticker


#############################################################

L appendages
                        # wc keyboard/keycoordinates.b = 608

#if test $pass = 2  ;then#
#
#m#v binary inary
#
#cat inary keyboard/keycoordinates.b  > binary
#
#rm inary#
#
#fi

......................................................................

The osimplay on my webpage isn't quite like this one. This one doesn't
have the app stuff like ELF and Linux syscalls, and more notably, the
"allocated" variable in that osimplay is problematic with kernel code.
That's for .bss, and I don't do no .bss.

Rick Hohensee


-- MOST: /owner//Durtro                                     (229,1)
100%--------End of buffer.

