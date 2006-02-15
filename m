Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWBOWo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWBOWo6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 17:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWBOWo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 17:44:58 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:24790 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1750787AbWBOWo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 17:44:57 -0500
Message-ID: <43F3AEAA.4080309@cfl.rr.com>
Date: Wed, 15 Feb 2006 17:43:54 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Seewer Philippe <philippe.seewer@bfh.ch>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: disk geometry via sysfs
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com> <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com> <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com> <43F2E8BA.90001@bfh.ch> <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com> <1140019615.14831.22.camel@localhost.localdomain> <43F354E9.2020900@cfl.rr.com> <1140024754.14831.31.camel@localhost.localdomain> <43F3764C.8080503@cfl.rr.com> <Pine.LNX.4.61.0602151411130.9546@chaos.analogic.com> <43F39500.8060008@cfl.rr.com> <Pine.LNX.4.61.0602151606540.10924@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0602151606540.10924@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2006 22:46:36.0326 (UTC) FILETIME=[AD1E6C60:01C63281]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14270.000
X-TM-AS-Result: No--17.100000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> Heads start at 0. Sectors start at 1. Cylinders start at 0.
> A "lower head" than allowed would be 0xff so the BIOS wouldn't
> know it was "lower". The BIOS doesn't look at the MBR for
> normal read/write access! Only while booting does it
> read the first sector of the master boot record (MBR) into
> the appropriate physical place (0x7c00). Then it checks to see
> if there is an 0xaa55 as the last word in the sector. If so,
> it executes code starting at offset zero. Modern BIOS don't
> even check the "boot flag" because it may be wrong, preventing
> a boot.
> 

I'm talking about the geometry of the disk.  If the disk has 16 sectors 
and 8 heads, then the maximum value allowed for any valid address is 16 
in the sector field and 7 in the heads field.  This influences the 
translation to/from LBA.  A sector with LBA of 1234 would have a CHS 
address using this geometry of 9/5/3.  If the disk reports a geometry of 
x/8/16 but the bios is using a geometry of x/255/63, then when you pass 
9/5/3 to int 13 it will fetch LBA 144902 which is clearly not going to 
give you what you wanted.

This is why you must use the same geometry that the bios exposes, NOT 
what the disk reports in its inquiry command.  It is quite typical for a 
disk to report that it uses 8 heads and has a number of cylinders that 
is > 1024.  The bios will typically present a view of the disk with 255 
heads ( though it very well may use a smaller value ).  If you generate 
CHS addresses when you write the MBR using 8 heads, they will be wrong 
when you try to pass them to the bios.

> Now, during the boot sequence, the BIOS via INT 0x13 or 0x40
> will be called upon to read data into memory from various
> offsets on the media. If the offsets are calculated in the
> same way that they were calculated when the disk was initialized
> as a boot disk, then everything is okay. The calculations of
> offsets do not require the same C/H/S phony variables! One

Yes, they do require the same geometry, see above.

> only has to follow the correct rules. The rules are that
> heads increment from 0, as do cylinders, and sectors start
> at 1. Also "sectors" must be 512-byte intervals even though
> the physical media may have 16 kilobyte sectors. Given
> these rules, there are zillions of ways for one to arrive
> at the correct offset. The interpretation will be correct
> IFF the number of cylinders are extracted first, then the
> number of heads (tracks), then the number of sectors, always
> using the largest number that will fit into the BIOS
> registers used to make that access.
> 

The bios will not accept values that are larger than it's idea of the 
disk's geometry.  If the bios thinks the disk only has 8 heads, you 
can't ask it to fetch a sector on head 17.

> In the case of "large media" access, the cylinders are
> set to 0xffff. This triggers additional logic that invents
> a new virtual sector length to accommodate.
> 
> The following is the __entire__ boot code for an IBM/PC
> compatible BIOS! Constant "DISKS" is 0x13.
> 

<snip>

Not sure why you pasted the example bios code, maybe you could explain?


