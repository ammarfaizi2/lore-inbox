Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751578AbWBQUAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbWBQUAm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 15:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbWBQUAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 15:00:42 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:17755 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751072AbWBQUAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 15:00:41 -0500
Message-ID: <43F62B1D.7090907@cfl.rr.com>
Date: Fri, 17 Feb 2006 14:59:25 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
CC: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: C/H/S from user space
References: <Pine.LNX.4.61.0602171157140.8950@chaos.analogic.com> <43F617FA.2030609@wolfmountaingroup.com>
In-Reply-To: <43F617FA.2030609@wolfmountaingroup.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Feb 2006 20:01:52.0086 (UTC) FILETIME=[FE7A9760:01C633FC]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14274.000
X-TM-AS-Result: No--21.300000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Other than generate CHS addresses that are invalid due to having S > 62, 
what is this code supposed to do?


Jeff V. Merkey wrote:
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

