Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271695AbRHQRRj>; Fri, 17 Aug 2001 13:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271696AbRHQRR3>; Fri, 17 Aug 2001 13:17:29 -0400
Received: from chaos.analogic.com ([204.178.40.224]:12160 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S271695AbRHQRRV>; Fri, 17 Aug 2001 13:17:21 -0400
Date: Fri, 17 Aug 2001 13:16:56 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Adrian Cox <adrian@humboldt.co.uk>
cc: Holger Lubitz <h.lubitz@internet-factory.de>, linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
In-Reply-To: <3B7D4F30.5090302@humboldt.co.uk>
Message-ID: <Pine.LNX.3.95.1010817130849.2216A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2001, Adrian Cox wrote:

> Richard B. Johnson wrote:
> > Errrm no. All BIOS that anybody would use write all memory found when
> > initializing the SDRAM controller. They need to because nothing,
> > refresh, precharge, (or if you've got it, parity/crc) will work
> > until every cell is exercised. A "warm-boot" is different. However,
> > if you hit the reset or the power switch, nothing in RAM survives.
> 
> This does not match my experience building SDRAM based embedded systems. 
> Initialising SDRAM simply tells the chips what CAS latency to use, and 
> does not erase the contents. SDRAM is fully functional before you have 
> written to every cell.
> 
> It's possible that JEDEC standards recommend that boot firmware should 
> erase the contents, and it is certainly necessary to erase before 
> enabling ECC or parity error detection.
> 

Snippet from SDRAM initialization in BIOS........

;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
;
;	This is a cold boot so set up the SDRAM Controller. I do not
;	do "auto-sizing" because the size of the installed RAM is known.
;
	XOR	EAX,EAX				; Zero
	MOV	SS,AX				; Clear segment registers
	MOV	ES,AX				; except DS = MCR_SEG
	MOV	FS,AX
	MOV	GS,AX
	MOV	EBP,EAX				; SS=EBP=EAX=0
	MOV	SP,0FFFEH			; Just park it somewere
	MOV	BYTE PTR DS:[DRCCTL],01H	; Refresh disable
	MOV	[EBP],EAX			; This forces the command out
	MOV	BYTE PTR DS:[DRCCTL],02H	; All banks precharge
	MOV	[EBP],EAX			; This forces the command out

** At this instant, you just killed everything in RAM with precharge **

;
IF	(RAM_SIZE EQ 128)
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
;
;	All banks enabled, 64 meg size each (128 megabytes).
;
	MOV	 BYTE PTR DS:[DRCTMCTL], 01EH
	MOV	 WORD PTR DS:[DRCCFG], 09999H
	MOV	DWORD PTR DS:[DRCBENDADR], 0A0989088H
ELSEIF	(RAM_SIZE EQ 64)
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
;
;	One bank enabled, 64 meg size.
;
	MOV	 BYTE PTR DS:[DRCTMCTL], 01EH
	MOV	 WORD PTR DS:[DRCCFG], 00909H
	MOV	DWORD PTR DS:[DRCBENDADR], 000900088H

ELSEIF	(RAM_SIZE EQ 32)
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
;
;	Analogic memory mezzanine, 32 meg size.
;	Eight, 4 megabyte blocks.
;
	MOV	 BYTE PTR DS:[DRCTMCTL], 01EH
	MOV	 WORD PTR DS:[DRCCFG], 08888H
	MOV	DWORD PTR DS:[DRCBENDADR], 08884H
ELSE
	%OUT	RAM Size not correctly defined.
	.ERR1
ENDIF
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
;
;	Two auto-refreshes.
;
	MOV	BYTE PTR DS:[DRCCTL],04H
	MOV	[EBP],EAX
	MOV	[EBP],EAX
;
;	Load mode register command.
;
	MOV	BYTE PTR DS:[DRCCTL],03H
	MOV	[EBP],EAX			; This forces the command out
;
;	Back to normal mode, refresh enable 15.6 us.
;
	MOV	BYTE PTR DS:[DRCCTL],18H
	MOV	[EBP],EAX			; This forces the command out
;
;	Okay, RAM should be working. Clear low 1 megabyte and try it.
;


I think you forgot what you did when setting up the SDRAM controller.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


