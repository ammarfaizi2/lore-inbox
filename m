Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129188AbQKQSh3>; Fri, 17 Nov 2000 13:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129216AbQKQShT>; Fri, 17 Nov 2000 13:37:19 -0500
Received: from chaos.analogic.com ([204.178.40.224]:64640 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129188AbQKQShE>; Fri, 17 Nov 2000 13:37:04 -0500
Date: Fri, 17 Nov 2000 13:06:30 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Russell King <rmk@arm.linux.org.uk>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        mj@suse.cz
Subject: Re: VGA PCI IO port reservations
In-Reply-To: <200011171720.RAA01403@raistlin.arm.linux.org.uk>
Message-ID: <Pine.LNX.3.95.1001117125211.20635A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2000, Russell King wrote:

> Richard B. Johnson writes:
> > This can't be.
> 
> Richard,  before I read any further, I suggest that you get some
> documentation on a few PCI VGA cards and read up on the register
> addresses.  You may want to change your assumptions about what can and
> can't be. ;)
> 
> And I can definitely say that if you don't allow access to these "extended"
> VGA ports, BIOSes either enter infinite loops or else terminate without
> initialising the card.  Trust me; I've been successfully running various
> PCI VGA card BIOSes under an x86 emulator on an ARM machine for the past
> few months.

If a board has the capability of snooping their own special addresses,
you don't have to do anything about them. They snoop <period>.

If you look as how I showed that the resources are allocated, you
will see that it works. The I/O addresses that are used (for everything),
start at the lowest __unaliased__ address. This means that if a board
is already snooping an address, it will appear to be aliased.

The code necessary to find the lowest unaliased address looks like
this:

;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
;
;	This initializes memory and port allocation space for PCI
;	device resource allocation.
;
ALIGN	4
INIT_PCI_RES:
	PUSH	DS			; Save segment
	MOV	AX,PCI_OBJ_ALLOC	; Segment address for storage
	MOV	DS,AX			; Set segment
	MOV	DWORD PTR DS:[PCI_MEM],(INSTALLED_MEM SHL 14H) ; For PCI
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
;
;	Find the lowest port address (above PCI_OFF) that doesn't have
;	any devices responding at possible aliases.
;
	MOV	EDX,0000F002H		; Highest possible even port
FPRT:	SUB	DX,02H			; Keep on a WORD boundary
	IN	AX,DX			; See if anything there
	SLOW_IO				; Bus settle time for slow devices
	INC	AX			; 0FFFFH -> 0000H
	JNZ	SHORT PRTFND		; We found an alias
	CMP	DX,PCI_OFF		; Lowest port
	JNC	FPRT			; Continue
PRTFND:	ADD	DX,02H			; Last good port
	MOV	DWORD PTR DS:[PCI_PRT], EDX
	POP	DS			; Restore segment
	RET


The code necesary to allocate resources looks like this:

;
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
;
;	This allocates PCI-bus memory-space. Upon entry EAX contains
;	the DWORD read from the PCI-bus memory address register. This
;	can be zero (no memory to reserve). Upon exit, EAX contains
;	the value to be written back to this register, including possibly
;	zero.
;
ALIGN	4
ALLOC_PCI_ADDR:
	PUSH	EBX				; Save nonvolatile registers
	PUSH	DS				; Save segment
	PUSH	PCI_OBJ_ALLOC			; Where we save last result
	POP	DS				; DS = PCI_OBJ_ALLOC
	TEST	EAX,1				; IO port?
	JZ	SHORT NOTIOP			; Not an IO port
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
;
;	This allocates an I/O port for the device. They are allocated on
;	16-byte boundaries even if we don't need the space.
;
	AND	EAX,(NOT 3)			; Mask port/reserved bits
	JZ	SHORT NOALOC			; No space required
	MOV	ECX,EAX				; Start with first address bit
	NEG	ECX				; ECX = length required
	CMP	ECX,000000010H			; At least 16 bytes?
	JNC	SHORT WAS16			; Yes
	MOV	ECX,000000010H			; At least 16 bytes
WAS16:	MOV	EBX,ECX				; Save allocation length
	MOV	EAX,DWORD PTR DS:[PCI_PRT]	; Get present value
	ADD	EAX,ECX				; New offset value
	DEC	EAX				; Adjust for previous math
	NEG	ECX				; Create a mask
	AND	EAX,ECX				; N-byte boundary
	ADD	EBX,EAX				; EBX = for this allocation
	MOV	DWORD PTR DS:[PCI_PRT],EBX	; Ready next
	JMP	SHORT NOALOC			; We are done
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
;
;	This allocates I/O memory-space. A defect (feature) of the
;	PCI addressing scheme is that a N-byte allocation must start
;	on a N-byte boundary. This means that a 4 megabyte allocation
;	for a PCI screen-card wastes nearly 4 megabytes of address-space.
;
NOTIOP:	AND	EAX,0FFFFFFF0H			; Clear non-address bits
	JZ	SHORT NOALOC			; No memory required
	MOV	ECX,EAX				; Start with first address bit
	NEG	ECX				; ECX = length required
	MOV	EBX,ECX				; Save allocation length
	MOV	EAX,DWORD PTR DS:[PCI_MEM]	; Get present value
	ADD	EAX,ECX				; New offset value
	DEC	EAX				; Adjust for previous math
	NEG	ECX				; Create a mask
	AND	EAX,ECX				; N-byte boundary
	ADD	EBX,EAX				; EBX = for this allocation
	MOV	DWORD PTR DS:[PCI_MEM],EBX	; Ready next
NOALOC:	NEG	ECX				; Return with length
	POP	DS				; Restore segment
	POP	EBX
	RET
;
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
;
;	This attempts to set up the PCI bus. This does  a PCI
;	snoop, finding PnP devices, allocating memory, and enabling
;	them. Note that this machine has only one bridge so we
;	don't have to check for bridges behind bridges.
;
ALIGN	4
SET_PCI:
	XOR	SI,SI			; Start at device zero, the bridge.
	READ_PCI SI, 0			; See if the bridge is there
	INC	EAX			; 0xffffffff becomes zero
	JNZ	SHORT BRIDGE		; There is a bridge
	RET				; Forget it, no bridge
;
BRIDGE:	READ_PCI  SI, PCI_CMD_STA	; Get command/status register
	OR	AX,07H			; Enable I/O, Memory, Master
	WRITE_PCI SI, PCI_CMD_STA, EAX	; Enable it.
;
	READ_PCI  SI, PCI_AMD		; AMD Specific PCI retry count
	MOV	AL,80H			; Recommended value
	WRITE_PCI SI, PCI_AMD, EAX	; Set timeout value
;
	READ_PCI  SI,PCI_LAT_CACHE	; Latency, etc.
	MOV	AX,4008H		; Latency / cache line size
	WRITE_PCI SI, PCI_LAT_CACHE,EAX	; Set it (if possible)
;
PCIDEV:	INC	SI			; Ready next device
	READ_PCI SI, 0			; Get device ID
	INC	EAX			; Anybody home? 0xffffffff becomes 0
	JZ	PCINXT			; Nope
;
	READ_PCI  SI, PCI_CMD_STA	; Get command/status register
	OR	AX,7			; Enable I/O, Memory, Bus master
	WRITE_PCI SI, PCI_CMD_STA, EAX	; Enable it.
;
	READ_PCI  SI,PCI_LAT_CACHE	; Latency, etc.
	MOV	AX,4008H		; Latency / cache line size
	WRITE_PCI SI, PCI_LAT_CACHE,EAX	; Set it (if possible)
;
	MOV	DI,PCI_BASE0		; First base address offset
PCIRES:	MOV	EAX,0FFFFFFFFH		; All bits set
	WRITE_PCI SI, DI, EAX		; Try to set all bits
	READ_PCI  SI, DI		; Get the results
	CALL	ALLOC_PCI_ADDR		; Allocate resources
	WRITE_PCI SI, DI, EAX		; Write base address (could be zero)
	INC	DI			; Ready next base address
	CMP	DI,PCI_CARDBUS		; Check limits
	JC	PCIRES			; Next possible address
;
	READ_PCI  SI, PCI_INTER		; Interrupt pin
	TEST	AX,0F00H		; Isolate interrupt pin
	JZ	SHORT PCINOI		; No interrupt required
	CALL	GET_IRQ			; Get IRQ value from table
PCINOI:	OR	EAX,18180000H		; Could be writable
	WRITE_PCI SI, PCI_INTER, EAX	; Set IRQ (could be zero)
PCINXT:	CMP	SI,PCI_MAX		; End of devices?
	JC	PCIDEV			; Nope
	PARK_PCI			; Park on the bridge
	RET
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=



Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
