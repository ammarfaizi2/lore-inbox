Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272728AbTG1I2I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 04:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272733AbTG1I2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 04:28:03 -0400
Received: from fc.capaccess.org ([151.200.199.53]:27402 "EHLO fc.capaccess.org")
	by vger.kernel.org with ESMTP id S272728AbTG1I1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 04:27:34 -0400
Message-id: <fc.0010c7b2009ebbbf0010c7b2009ebbbf.9ebbc6@capaccess.org>
Date: Mon, 28 Jul 2003 04:44:56 -0400
Subject: The Well-Factored 386
To: linux-kernel@vger.kernel.org, linux-assembly@vger.kernel.org
From: "Rick A. Hohensee" <rickh@capaccess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The four actual main modes of the 386

Operation of the INTeL 80386 is clearly much more flexible than currently
used, as far as the basic states the machine can run in. "Real Mode" and
"Protected Mode" are two possibilities out of several that are concievably
useful. It can be seen from things that are possible in "Real Mode", such
as "Unreal Mode", use of 386-era instructions and so on, that the
canonical modes are not monolithic entities, but are cases of various
combinations of discrete state switches. There is no 8086 in a 386.
Canonical Wake-up Real Mode, which I will refer to as CWR Mode, seems to
be how these several state switches are set at machine reset, but are
semantically just settings of independant things, and clearly CWR Mode can
be set up from individual settings available to the user. This is also
much more evident from a careful traversal of the detailed instruction
specs in the INTeL Programmer's Reference (386INTEL.TXT) for the 80386.

I'd say the two most global switches in the machine are the PE bit,
Protection Enabled, quite sensibly placed at bit 0 in control register 0,
and the D bit of the active code segment descriptor affiliated with CS,
the Default Bit. Two bits gives four possible states. All four are capable
of being the default mode of a system. Two are used as such; CWR Mode and
Protected Mode. Here's a breakdown and some neologizing...


        PE=0    Dbit=0          (un)Real Mode
        PE=0    Dbit=1          Forreal Mode
        PE=1    Dbit=0          Veal Mode  (BKA "286 task")
        PE=1    Dbit=1          Protected Mode


The documented modes are the outside cases in a binary-count listing,
where PE=Dbit. There's a very good reason for that. IRET is sensitive to
Dbit, whereas interrupts push a stack frame of operands sized in
accordance with PE. This is some of INTeL's* description of the action of
INT, which represents all interrupts in this regard, when PE=0...

IF PE = 0
THEN GOTO REAL-ADDRESS-MODE;

REAL-ADDRESS-MODE:
   Push (FLAGS);
   IF <! 0; (* Clear interrupt flag *)
   TF <! 0; (* Clear trap flag *)
   Push(CS);
   Push(IP);
   (* No error codes are pushed *)
   CS <! IDT[Interrupt number * 4].selector;
   IP <! IDT[Interrupt number * 4].offset;


That is, IP is pushed if PE=0, not EIP. FLAGS is also a dual (a "word" in
INTeLese, 16 bits). Thus if, for example, you are in Forreal Mode, you get
a 6-byte stack push of FLAGS, CS and then IP on an interrupt, and the
corresponding IRET will later pop 12 bytes for basically the same 3
registers, and the system streaks off to the big bitbucket in the sky.

HOW ever, IRET is only PARTIALLY sensitive to Dbit. What I didn't say a
moment ago is that IRET is really sensitive to the current effective code
size, of which the D bit is just one component. If we prefix the IRET in a
Forreal Mode interrupt handler with 0x66, the other-operand-size prefix,
it will pop duals in a use32 CS. The interrupt occuring with PE=0 pushed
duals. It works. The inside cases of Veal Mode and Forreal Mode simply
need thier IRETs un-default-sized. In Veal Mode you coerce IRET into using
quads in a use16 code segment, and in Forreal Mode the same prefix in a
use32 code segment will coerce the IRET pops to duals. In Veal Mode, where
PE=1 when an interrupt occurs, you also have the option of handling the
interrupt with a Dbit=1 segment for the pertinent interrupt handler, in
which case it can IRET back to Veal Mode with a naked IRET. I suppose you
can also segregate Veal Mode segments with thier descriptor bases and
limits. In all the quirkiness of the 386, the broad orthogonality of the
other-sizing prefixes is quite refreshing, and even works on stuff like
POPA.

This is from the blow-by-blow description of IRET...

   IF OperandSize = 32 (* Instruction = IRETD *)
   THEN EIP <! Pop();
   ELSE (* Instruction = IRET *)
      IP <! Pop();

Again, OperandSize is Dbit as effected by a possible prefix.

This is why INTeL only mentions Veal Mode as "286 tasks". Tasks don't
IRET. Most of what a 386 provides big facilities for, like tasks, can also
be done piecemeal, as would be the case running a system in straight
Forreal Mode.

Canonical Wake-up Real Mode and Unreal Mode are two flavors of the same
basic setting of PE and Dbit. The difference is in segment limits. This
points up a basic concept here. 8086-style segments are a lightweight
layer that may or may not be active, but 386 segments are always active.
PE=0 does not turn them off. PE=0 means you can't change them until you
turn PE back to 1. PE should be called "PCE, Protections Changes Enabled".

This means the four basic modes have a state diagram about like so...


                         _______________
                        |    WAKE-UP    |
                        |canonical rmode|
                        |  PE=0 use16   |
                        |_______________|
                            A        |set PE to 1
                            |        |
                 set PE to 0|        |
                         ___|________V__
                        |     Veal      |
                        |     Mode      |
                        |   PE=1 use16  |
                        |_______________|
                            A       |far xfer
                            |       | to use32 CS
                far xfer to |       |
                    use16 CS|       |
                         ___|_______V___
                        |   Protected   |
                        |      Mode     |
                        |   PE=1 use32  |
                        |_______________|
                            A        |set PE to 1
                            |        |
                 set PE to 0|        |
                         ___|________V__
                        |  Forreal Mode |
                        |      Mode     |
                        |   PE=0 use32  |
                        |_______________|


Interesting. Forreal Mode is the furthest from Wake-up, and you can only
get to Forreal Mode from pmode. Forreal Mode is like a back room off of
pmode. You can interrupt between pmode and Veal Mode. Conversely, events
in rmode or Forreal Mode (PE=0) have to be handled in the mode they occur
in.

The above diagram does not account for different segment limits and bases
than those in effect in WakeUp Rmode, so e.g. unreal mode is not shown.
This chart also does not account for V86 Mode, which basically requires
386 task-switch constructs. The above modes and transitions do NOT need a
TSS, or paging. I suspect V86 could run off Veal Mode OR pmode.

Veal Mode is a protected mode. That means it's a quick switch to good old
use32 Protected Mode. It may afford some better code density, and thus
speed. Forreal Mode is unprotected, which means interrupts are handled
somewhat faster, which benefits realtime services. Either can be
incorporated into a multi-mode system. Forreal Mode also doesn't seem to
have any analogy at all in current use, other than the INTeL "flat model",
which is a simplified pmode, but that similarity is rather superficial.

For the 386 to do what it does, and particularly to have pulled it off in
the mid-eighties, things have to be fairly simple. You can figure that
whatever the 386 does, it's implemented as simply as possible. The modes
of the machine are composites of simple switches, and various effects,
such as loaded descriptors, tend to persist until changed. This has always
been the case with e.g. 8086 segment registers. In the 386, however,
8086-style "segments" are not alternates of 386 segments, they are a
superficiality on top of them. With that in mind, the states one goes
through simply getting from real mode to pmode start to make more sense.

The following (osimplay) code demonstrates the superficiality of 8086
"schmegments" vis-a-vis 386 segments, even when PE=0...

<from flat pmode>
. global/flipPE         # Welcome to Forreal Mode
                        # cell still 4

= 4 to A                # 32-bit schmegmented addressing demo
= A to ES               # proving we got PE = to 0.
= 9348539 to A
= A to @ $((0xb8a00))
ES
= A to @ $((0xb8a00))

That code causes two identical attribute-glyph pairs to appear on the VGA
text screen 32 charcells displaced from each other. That is the 4 in ES,
times 16 as per 8086, divided by two since each charcell is 2 bytes. Plus
a flat 32-bit address to put it on the screen. Forreal Mode thus does
32-bit 8086 schmegmented address computation. What is this type of
addressing useful for? Precious little. In Forreal mode you've got 32 bits
to start with. The point is you have the big flat segments left over from
pmode. The 8086 address-math does prove we're not in pmode any more,
however. Otherwise the ES prefix of 4 would have GPFed.


Rick Hohensee
Precision Mojo Engineer

*
 I've converted my 386INTEL.TXT to 7-bit ASCII-art, not to mention
op-source-dest and other unINTeLifications, and "<!" is the right-to-left
assignment operator in the instruction description code, helpfully
pronounced "becomes".


The appended hex/octal/listing appears to be handling INT 35 in Forreal
Mode, ala
                otheroperandsize
                dismiss

It also demos the 32-bit schmegmented addressing mentioned earlier, and it
keeps it's IDT in the VGA text buffer. The hex/octal input editor in
osimplay needed to type it in is Left As An Excercize To The Reader.


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
00007c15  270 93 0d                     = 3475 to A
00007c18  89 006 2c 01                  = A to @ 300
00007c1c  31 300                        XOR A with A
00007c1e  8e 330                        = A to DS
00007c20  0f 01 16 37 7d                        setGDT IGDTRpointer
00007c25  270 00 b8                     = 0xb800 to A
00007c28  8e 330                        = A to DS
00007c2a  270 94 0d                     = 3476 to A
00007c2d  89 006 30 01                  = A to @ 304
00007c31  66                    otheroperandsize
00007c32  31 300                        XOR A with A
00007c34  100                   1+ A
00007c35  0f 22 300                     = A to CR0
00007c38  e9 00 00                      jump hvfnvkfv
00007c3b                (O) hvfnvkfv
00007c3b  89 006 34 01                  = A to @ 308
00007c3f  89 006 35 01                  = A to @ 309
00007c43  0f 20 300                     = CR0 to A
00007c46  89 006 36 01                  = A to @ 310
00007c4a  89 006 37 01                  = A to @ 311
00007c4e  ea 53 7c 10 00
00007c53                (O) u32
00007c53  270 18 00 00 00                       = 0x18 to A
00007c58  8e 330                        = A to DS
00007c5a  270 57 65 67 13                       = 325543255 to A
00007c5f  89 005 d4 00 00 00                    = A to @ 212
00007c65  89 005 d8 80 0b 00                    = A to @ 753880
00007c6b  89 005 78 81 0b 00                    = A to @ 754040
00007c71  89 005 18 82 0b 00                    = A to @ 754200
00007c77  270 18 00 00 00                       = 0x18 to A
00007c7c  8e 330                        = A to DS
00007c7e  8e 300                        = A to ES
00007c80  8e 320                        = A to SS
00007c82  31 300                        XOR A with A
00007c84  8e 340                        = A to FS
00007c86  8e 350                        = A to GS
00007c88  270 d1 00 00 00                       = 0xd1 to A
00007c8d  272 64 00 00 00                       = 0x64 to D
00007c92  ee                    send byte
00007c93  90                    nop
00007c94  90                    nop
00007c95  90                    nop
00007c96  90                    nop
00007c97  90                    nop
00007c98  90                    nop
00007c99  90                    nop
00007c9a  90                    nop
00007c9b  90                    nop
00007c9c  90                    nop
00007c9d  270 df 00 00 00                       = 0xdf to A
00007ca2  272 60 00 00 00                       = 0x60 to D
00007ca7  ee                    send byte
00007ca8  272 92 00 00 00                       = 0x92 to D
00007cad  ec                    recieve byte
00007cae  0d 02 00 00 00                        OR 2 to A
00007cb3  ee                    send byte
00007cb4                (O) a20loop
00007cb4  270 55 55 aa aa                       = 0xaaaa5555 to A
00007cb9  89 005 d8 ff 1f 00                    = A to @ 2097112
00007cbf  8b 035 d8 ff 1f 00                    = @ 2097112 to B
00007cc5  39 303                        -test A to B
00007cc7  0f 85 e7 ff ff ff   when not zero a20loop
00007ccd  274 f0 ef 00 00                       = 61424 to SP
00007cd2  31 377                        XOR DI with DI
00007cd4                (O) perFMIDTvector
00007cd4  60                    pushcore
00007cd5  270 aa 7d 00 00                       = twitch32unP to A
00007cda  e8 ae 00 00 00                        call install32unP
00007cdf  61                    pullcore
00007ce0  107                   1+ DI
00007ce1  81 377 ff 00 00 00                    -test 255 with DI
00007ce7  75 eb   when not zero short perFMIDTvector
00007ce9  0f 01 1d bb 7d 00 00                  setIDT IDT32unPpointer
00007cf0  31 333                        XOR B with B
00007cf2  103                   1+ B
00007cf3  0f 20 300                     = CR0 to A
00007cf6  31 330                        XOR B to A
00007cf8  0f 22 300                     = A to CR0
00007cfb  270 04 00 00 00                       = 4 to A
00007d00  8e 300                        = A to ES
00007d02  270 bb a5 8e 00                       = 9348539 to A
00007d07  89 005 00 8a 0b 00                    = A to @ 756224
00007d0d  26                    ES
00007d0e  89 005 00 8a 0b 00                    = A to @ 756224
00007d14  66                    otheroperandsize
00007d15  9c                    pushflags
00007d16  66                    otheroperandsize
00007d17  68 00 00                      push 0
00007d1a  66                    otheroperandsize
00007d1b  e8 8c 00                      call twitch32unP
00007d1e                (O) theloop
00007d1e  8b 005 88 88 0b 00                    = @ 755848 to A
00007d24  100                   1+ A
00007d25  89 005 88 88 0b 00                    = A to @ 755848
00007d2b  cd 23                         submit 35
00007d2d  90                    nop
00007d2e  90                    nop
00007d2f  90                    nop
00007d30  90                    nop
00007d31  e9 e8 ff ff ff                        jump theloop
00007d36  f4                    halt
00007d37                (O) IGDTRpointer
00007d37  00 04 3d 7d 00 00
00007d3d                (O) GDT
00007d3d  00 00 00 00 00 00 00 00                       0 the required NULL
00007d45  ff ff 00 00 00 89 cf 00                       1 0x8 TSS
stackstack
00007d4d  ff ff 00 00 00 9a cf 00                       2 0x10 ring0 USE32
CS
00007d55  ff ff 00 00 00 92 cf 00                       3 0x18  ring0 data
00007d5d  ff ff 00 00 00 9a 00 00                       4 0x20 USE16 CS
00007d65  ff ff 00 00 00 92 00 00                       5 0x28 USE16 data
?S
00007d6d  00 00 00 00 00 00 00 00                       6 0x30
00007d75  00 00 00 00 00 00 00 00                       7 0x38
00007d7d  00 00 00 00 00 00 00 00                       8 0x40
00007d85  00 00 00 00 00 00 00 00                       9 0x48
00007d8d
00007d8d                (O) install32unP
00007d8d  c1 347 02                     upshift 2 to DI
00007d90  81 307 00 80 0b 00                    + IDT32unP to DI
00007d96  89 007                        = A to @ DI
00007d98  c3                    return
00007d99                (O) install16
00007d99  c1 347 02                     upshift 2 to DI
00007d9c  81 307 00 84 0b 00                    + IDT16 to DI
00007da2  e8 1a 00 00 00                        call schmegment
00007da7  89 007                        = A to @ DI
00007da9  c3                    return
00007daa                (O) twitch32unP
00007daa  120                   push A
00007dab  8b 005 50 8a 0b 00                    = @ 756304 to A
00007db1  100                   1+ A
00007db2  89 005 50 8a 0b 00                    = A to @ 756304
00007db8  130                   pull A
00007db9  66                    otheroperandsize
00007dba  cf                    dismiss
00007dbb                (O) IDT32unPpointer
00007dbb  00 04 00 80 0b 00
00007dc1                (O) schmegment
00007dc1  123                   push B
00007dc2  89 303                        = A to B
00007dc4  c1 353 10                     downshift 16 to B
00007dc7  81 340 ff ff 00 00                    AND 65535 to A
00007dcd  c1 343 1c                     upshift 28 to B
00007dd0  09 330                        OR B to A
00007dd2  133                   pull B
00007dd3  c3                    return


