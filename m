Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317328AbSGRMxD>; Thu, 18 Jul 2002 08:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318042AbSGRMxD>; Thu, 18 Jul 2002 08:53:03 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7554 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317328AbSGRMxC>; Thu, 18 Jul 2002 08:53:02 -0400
Date: Thu, 18 Jul 2002 08:57:44 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org
Subject: Re: HZ, preferably as small as possible
In-Reply-To: <Pine.LNX.4.44.0207171359000.6820-100000@home.transmeta.com>
Message-ID: <Pine.LNX.3.95.1020718084908.15746A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2002, Linus Torvalds wrote:

> 
> 
> On Wed, 17 Jul 2002, Richard B. Johnson wrote:
> >
> > It is hardly novel and I can't imagine how Bresenham or whomever
> > could make such a claim to the obvious. Even the DOS writer(s) used
> > this technique to get one-second time intervals from the 18.206
> > ticks/per second.
> 
> Ehh.. Look at _existing_ linux code to do exactly the same.
> 
> See update_wall_time_one_tick() and second_overflow() (which does a lot
> more besides, but it does largely boil down to this "average fractions
> using basic integer math" thing.
> 
> 		Linus
> 
Maybe you see something in the code I don't. In fact, the hardware
apprears to have been programmed to interrupt at the HZ rate
using the constant, CLOCK_TICK_RATE, defined in ../asm/timex.h.
Maybe the hardware can't be programmed to interrupt at HZ so the
real ticks are adjusted by 'average fractions' code, but it is
very unclear if this is being done.

Here is a 20 year-old source snippit of some synthetic division
code used to correct the DOS time by substituting part of INT 08.

The dividend, DIVIDEND, was cached in a variable called _pll,
(accessible from 'C' code as pll). This could be tuned to slowly
adjust the time to make it as exact as you wanted. I replaced
the actual time-keeping code with a CALL ONE_SEC to shorten
this example. It executes at 1 second intervals. The history
in the comments is interesting.


Old-fashion Intel DEST <--- SOURCE

DIVIDEND	EQU	18206			; 18.206
DIVISOR		EQU	1000			; 18206/1000 = 18.206

_pll	DW	DIVIDEND
_false	DW	0
;
;	This is the local timer tick.
;
;	The timer tick used to interrupt at 18.206 ticks/second. When
;	the AT got redone, this was changed to 18.158 because the
;	clock to timer channel 0 got changed to 1.190 MHz and the
;	requirement of using a 3.579545 MHz (color subcarrier) crystal
;	was eliminated.
;
;	Was:	3.579545 / 3 = 1.193181667 / 65536 = 18.206
;	Now:	1.190 / 65536 = 18.158
;	Also:	1.934 / 65536 = 18.210
;
;	As usual, things are not well in AT-Land. The 'C' runtime library
;	and MS-DOS still think that the proper divisor is 18.206. So we
;	have to use that value or the time-stamps on the hour will be
;	about 1/2 second in error. This means that the AT-Time is wrong
;	by about 1/2 seconds per hour!
;
;
EVEN
TIMER	PROC	FAR
	SAV_REG	AX, DS				; Save registers used
	MOV	AX,DGROUP			; Local data area
	MOV	DS,AX				; Set segment
	MOV	AL,01001011B
;                  ||||||||_____ Select in-service register
;                  ||||||_______ No poll
;                  |||||________ Always 1
;                  ||||_________ Always 0
;                  |||__________ Standard mask
;                  |____________ Always 0
	OUT	INT_CTL,AL			; Select OCW3
	IN	AL,INT_CTL			; Get results
	AND	AL,00000001B			; Is interrupt pending?
	JNZ	OKAY				; Yes
	INC	WORD PTR _false			; Not good, record
OKAY:	MOV	AL,SPC_EOI			; Specific EOI
	OUT	INT_CTL,AL			; Reset controller
	SUB	WORD PTR [LCL_SECONDS],DIVISOR	; Subtract 1000 ticks
	JNC	NOSEC				; 1 second is not up yet
	MOV	AX,WORD PTR [_pll]		; Get loop variable
	ADD	WORD PTR [LCL_SECONDS],AX	; Synth div = 1000/18206
	CALL	ONE_SEC				; Dummy
;
NOSEC:	RES_REG	AX, DS				; Restore registers used
	IRET					; Done
TIMER	ENDP
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

