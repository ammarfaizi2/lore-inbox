Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWBOVl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWBOVl4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 16:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWBOVlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 16:41:55 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:42247 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751302AbWBOVlz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 16:41:55 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <43F39500.8060008@cfl.rr.com>
X-OriginalArrivalTime: 15 Feb 2006 21:41:48.0281 (UTC) FILETIME=[9FA9D690:01C63278]
Content-class: urn:content-classes:message
Subject: Re: RFC: disk geometry via sysfs
Date: Wed, 15 Feb 2006 16:41:37 -0500
Message-ID: <Pine.LNX.4.61.0602151606540.10924@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RFC: disk geometry via sysfs
thread-index: AcYyeJ+zr0Y7tgaMQmyXglheFe1xTg==
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com> <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com> <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com> <43F2E8BA.90001@bfh.ch> <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com> <1140019615.14831.22.camel@localhost.localdomain> <43F354E9.2020900@cfl.rr.com> <1140024754.14831.31.camel@localhost.localdomain> <43F3764C.8080503@cfl.rr.com> <Pine.LNX.4.61.0602151411130.9546@chaos.analogic.com> <43F39500.8060008@cfl.rr.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Phillip Susi" <psusi@cfl.rr.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Seewer Philippe" <philippe.seewer@bfh.ch>,
       "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Feb 2006, Phillip Susi wrote:

> linux-os (Dick Johnson) wrote:
>> If the disc is a modern disk, and the BIOS is modern as well,
>> it won't care. For instance, if we attempt to seek to cylinder
>> 10, sector 10, and there are only 9 sectors, then the supplied
>> head number is incremented, the sector to be read becomes 1
>> (dumb ones based), and everything is fine. If the head number
>> can't be incremented, it wraps to 0. Problems occur if the BIOS
>> has been set to "physical" mode for access. In this mode, the
>> CHS are absolute and "you can't get there from here." In the
>> physical mode, you can't have more than 1024 cylinders because
>> they need to fit into 10 bits.
>>
>> As long as the BIOS is set for LBA, the boot sequence should not
>> care.
>>
>
> Are you sure?  Do all bioses perform this auto correction?  I would have
> thought that they would simply fail the request because you asked for a
> sector or head that is outside the valid range.  Even if some bioses
> will accept illegal values and auto translate, I doubt that they all do.
>
> And what if you error in the other direction?  If the MBR lists a LOWER
> number of heads than the bios thinks there is?  In that case you're
> going to ask the bios for a larger cylinder number, and it will happily
> read a sector from the disk that is further from the start than you
> intended.

Heads start at 0. Sectors start at 1. Cylinders start at 0.
A "lower head" than allowed would be 0xff so the BIOS wouldn't
know it was "lower". The BIOS doesn't look at the MBR for
normal read/write access! Only while booting does it
read the first sector of the master boot record (MBR) into
the appropriate physical place (0x7c00). Then it checks to see
if there is an 0xaa55 as the last word in the sector. If so,
it executes code starting at offset zero. Modern BIOS don't
even check the "boot flag" because it may be wrong, preventing
a boot.

Now, during the boot sequence, the BIOS via INT 0x13 or 0x40
will be called upon to read data into memory from various
offsets on the media. If the offsets are calculated in the
same way that they were calculated when the disk was initialized
as a boot disk, then everything is okay. The calculations of
offsets do not require the same C/H/S phony variables! One
only has to follow the correct rules. The rules are that
heads increment from 0, as do cylinders, and sectors start
at 1. Also "sectors" must be 512-byte intervals even though
the physical media may have 16 kilobyte sectors. Given
these rules, there are zillions of ways for one to arrive
at the correct offset. The interpretation will be correct
IFF the number of cylinders are extracted first, then the
number of heads (tracks), then the number of sectors, always
using the largest number that will fit into the BIOS
registers used to make that access.

In the case of "large media" access, the cylinders are
set to 0xffff. This triggers additional logic that invents
a new virtual sector length to accommodate.

The following is the __entire__ boot code for an IBM/PC
compatible BIOS! Constant "DISKS" is 0x13.

;
ALIGN	4
INT_19H:
 	STI
 	PUSH	DS
 	PUSH	ES
 	XOR	DX,DX			; Get a zero
 	MOV	DS,DX			; Set segments
 	MOV	ES,DX			; DS = ES = 0
 	MOV	CX,256			; The IBM/AT bios clears 256 WORDS
 	MOV	DI,7C00H		; Boot location
 	XOR	AX,AX			; Get a zero
 	REP	STOSW			; Clear that area.
 	XOR	DX,DX			; Reset any floppy disk
 	XOR	AX,AX			; Reset Disk subsystem
 	INT	DISKS			; Ignore any error
 	MOV	AX,0201H		; Read one sector
 	MOV	BX,7C00H		; DS:BX points to buffer
 	MOV	CX,1			; First sector
 	XOR	DX,DX			; First floppy disk
 	INT	DISKS			; Disk vector
 	JC	SHORT FAIL		; Can't read it
IPL:	CMP	WORD PTR [BX+1FEH],0AA55H
 	JNZ	SHORT FAIL		; IPL bad
 	DB	0EAH			; Jmp FAR
 	DW	7C00H			; Offset
 	DW	0			; Segment
FAIL:	POP	ES			; Restore segments
 	POP	DS
 	IRET


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
