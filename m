Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWBQRk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWBQRk5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 12:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWBQRk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 12:40:56 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:42410 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1750817AbWBQRk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 12:40:56 -0500
Message-ID: <43F617FA.2030609@wolfmountaingroup.com>
Date: Fri, 17 Feb 2006 11:37:46 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: C/H/S from user space
References: <Pine.LNX.4.61.0602171157140.8950@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0602171157140.8950@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dick,

The model Netware uses for large drives for calculating C/H/S addressed 
this problem years ago and
provides more useful output, since C/H/S is converted into a hieristic 
which acts almost like an MD5 hash
and for a given dimension, does provide unique output for even very 
large drives.

Code Attached.

Jeff



ULONG SetPartitionTableGeometry(BYTE *hd, BYTE *sec, BYTE *cyl,
                ULONG LBA, ULONG TracksPerCylinder,
                ULONG SectorsPerTrack)
{
    ULONG offset, cylinders, head, sector;

    if (!cyl || !hd || !sec)
       return -1;

    cylinders = (LBA / (TracksPerCylinder * SectorsPerTrack));
    offset = LBA % (TracksPerCylinder * SectorsPerTrack);
    head = (WORD)(offset / SectorsPerTrack);
    sector = (WORD)(offset % SectorsPerTrack) + 1;

    if (cylinders < 1023)
    {
       *sec = (BYTE)sector;
       *hd = (BYTE)head;
       *cyl = (BYTE)(cylinders & 0xff);
       *sec |= (BYTE)((cylinders >> 2) & 0xC0);
    }
    else
    {
    *sec = (BYTE)(SectorsPerTrack | 0xC0);
    *hd = (BYTE)(TracksPerCylinder - 1);
    *cyl = (BYTE)0xFE;
    }

    return 0;
}

ULONG SetPartitionTableValues(struct PartitionTableEntry *Part,
                  ULONG Type,
                  ULONG StartingLBA,
                  ULONG EndingLBA,
                  ULONG Flag,
                  ULONG TracksPerCylinder,
                  ULONG SectorsPerTrack)
{

    Part->SysFlag = (BYTE) Type;
    Part->fBootable = (BYTE) Flag;
    Part->StartLBA = StartingLBA;
    Part->nSectorsTotal = (EndingLBA - StartingLBA) + 1;

    SetPartitionTableGeometry(&Part->HeadStart, &Part->SecStart, 
&Part->CylStart,
                  StartingLBA, TracksPerCylinder, SectorsPerTrack);

    SetPartitionTableGeometry(&Part->HeadEnd, &Part->SecEnd, &Part->CylEnd,
                  EndingLBA, TracksPerCylinder, SectorsPerTrack);

    return 0;

}




linux-os (Dick Johnson) wrote:

>For those who think that C/H/S translation is useful,
>attached is a simple program that gets whatever the BIOS
>used from user-space. If you have large media (most do),
>you will descover that C/H/S is useless because it is
>always set to "MAX" like this:
>
> 	Disk parameter table(s) at vector 0x41
>Disk0
>     Cylinders = 1024
>       Sectors = 63
>         Heads = 255
>Write precomp = 0
>  Landing zone = 65296
> 	Reserved bit 0 set
> 	Reserved bit 1 set
> 	Reserved bit 2 set
> 	More than 8 heads
> 	Reserved bit 4 set
> 	Defect map present
> 	Disable retries
> 	Disable retries
>Disk1
>     Cylinders = 306
>       Sectors = 1
>         Heads = 4
>Write precomp = 0
>  Landing zone = 12544
> 	Disk parameter table(s) at vector 0x46
>Disk0
>     Cylinders = 306
>       Sectors = 1
>         Heads = 4
>Write precomp = 0
>  Landing zone = 12544
>Disk1
>     Cylinders = 306
>       Sectors = 1
>         Heads = 4
>Write precomp = 0
>  Landing zone = 12544
>
>
>Cheers,
>Dick Johnson
>Penguin : Linux version 2.6.15.4 on an i686 machine (5589.55 BogoMips).
>Warning : 98.36% of all statistics are fiction.
>_
>
>
>
>****************************************************************
>The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.
>
>Thank you.
>

