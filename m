Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751587AbWBQUEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbWBQUEm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 15:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbWBQUEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 15:04:42 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:31503 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751585AbWBQUEl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 15:04:41 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <43F617FA.2030609@wolfmountaingroup.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
x-originalarrivaltime: 17 Feb 2006 20:04:38.0511 (UTC) FILETIME=[61AD07F0:01C633FD]
Content-class: urn:content-classes:message
Subject: Re: C/H/S from user space
Date: Fri, 17 Feb 2006 15:04:38 -0500
Message-ID: <Pine.LNX.4.61.0602171452520.4290@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: C/H/S from user space
Thread-Index: AcYz/WG0m1CYRNPpQB6/32/HGsEiVg==
References: <Pine.LNX.4.61.0602171157140.8950@chaos.analogic.com> <43F617FA.2030609@wolfmountaingroup.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Feb 2006, Jeff V. Merkey wrote:

>
> Dick,
>
> The model Netware uses for large drives for calculating C/H/S addressed
> this problem years ago and
> provides more useful output, since C/H/S is converted into a hieristic
> which acts almost like an MD5 hash
> and for a given dimension, does provide unique output for even very
> large drives.
>
> Code Attached.
>
> Jeff
>
>
>
> ULONG SetPartitionTableGeometry(BYTE *hd, BYTE *sec, BYTE *cyl,
>                ULONG LBA, ULONG TracksPerCylinder,
>                ULONG SectorsPerTrack)
> {
>    ULONG offset, cylinders, head, sector;
>
>    if (!cyl || !hd || !sec)
>       return -1;
>
>    cylinders = (LBA / (TracksPerCylinder * SectorsPerTrack));
>    offset = LBA % (TracksPerCylinder * SectorsPerTrack);
>    head = (WORD)(offset / SectorsPerTrack);
>    sector = (WORD)(offset % SectorsPerTrack) + 1;
>
>    if (cylinders < 1023)
>    {
>       *sec = (BYTE)sector;
>       *hd = (BYTE)head;
>       *cyl = (BYTE)(cylinders & 0xff);
>       *sec |= (BYTE)((cylinders >> 2) & 0xC0);
>    }
>    else
>    {
>    *sec = (BYTE)(SectorsPerTrack | 0xC0);
>    *hd = (BYTE)(TracksPerCylinder - 1);
>    *cyl = (BYTE)0xFE;
>    }
>
>    return 0;
> }
>
> ULONG SetPartitionTableValues(struct PartitionTableEntry *Part,
>                  ULONG Type,
>                  ULONG StartingLBA,
>                  ULONG EndingLBA,
>                  ULONG Flag,
>                  ULONG TracksPerCylinder,
>                  ULONG SectorsPerTrack)
> {
>
>    Part->SysFlag = (BYTE) Type;
>    Part->fBootable = (BYTE) Flag;
>    Part->StartLBA = StartingLBA;
>    Part->nSectorsTotal = (EndingLBA - StartingLBA) + 1;
>
>    SetPartitionTableGeometry(&Part->HeadStart, &Part->SecStart,
> &Part->CylStart,
>                  StartingLBA, TracksPerCylinder, SectorsPerTrack);
>
>    SetPartitionTableGeometry(&Part->HeadEnd, &Part->SecEnd, &Part->CylEnd,
>                  EndingLBA, TracksPerCylinder, SectorsPerTrack);
>
>    return 0;
>
> }
>
>
>
[SNIPPED...]

Yes, it's a very good model, in fact what I've been talking about.
However, several people who refused to read or understand, insisted
upon obtaining the exact same C/H/S that the machine claimed to
use when it was booted.

So, since Linux doesn't destroy that information remaining in
the BIOS tables, I show how to make it available to a 'root' user.
Observation over several machines will show that the BIOS always
uses the same stuff for large media and, in fact, it has no choice.
Basically, this means that the first part of the boot-code, the
stuff that needs to be translated to fit into the int 0x13 registers,
needs to be below 1024 cylinders, 63 sectors-track, and 256 heads.
Trivial... even LILO was able to do that! Once the machine boots
past the requirement to use the BIOS services, it's a CHS=NOP.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.53 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
