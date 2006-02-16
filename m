Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030636AbWBPT4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030636AbWBPT4a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030638AbWBPT4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:56:30 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:53130 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1030636AbWBPT43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:56:29 -0500
Message-ID: <43F4D8AB.7020208@cfl.rr.com>
Date: Thu, 16 Feb 2006 14:55:23 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Seewer Philippe <philippe.seewer@bfh.ch>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: disk geometry via sysfs
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com> <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com> <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com> <43F2E8BA.90001@bfh.ch> <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com> <11 <Pine.LNX.4.61.0602161316100.23547@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0602161316100.23547@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Feb 2006 19:57:25.0666 (UTC) FILETIME=[35446020:01C63333]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14272.000
X-TM-AS-Result: No--20.600000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> 
> You sure are interested in arguing. The translation cannot be wrong
> because the BIOS invented the translation which was created when
> the BIOS did a "read capacity." That translation is stored in the
> BIOS as a BPB, not on the disk, and it is accessed by any file-
> systems that use the 16-bit Int 0x13 interface. If the file-
> systems are not broken, they will NOT use the wrong translation
> because they will read the current interpretation by reading
> the BPB from the vector represented by int 0x64, or by executing
> Int 0x13, function code 8 (read drive parameters). These parameters
> are INVENTED upon startup as previously explained.
> 

The BPB is stored in the MBR by fdisk.  The MBR also contains CHS sector 
addresses for the location of the partitions on the disk.  fdisk 
computes those addresses by translating the LBA into CHS using a 
geometry.  If the bios is using a different geometry then those CHS 
addresses that the boot loader will request the bios to load will have a 
completely different meaning, so the loader won't get the intended sector.

> As previously explained, the fake geometry is not geometry at
> all, but rather a translation key that was decided upon
> startup after the capacity was determined. Its sole purpose
> is to get a sector-offset through the limited register-set
> in the 0x13 interface.
> 

Yes, I've been saying it is a translation key the whole time.  The bios 
uses it to figure out what sector you are referencing in int 13, and 
fdisk uses it to figure out what CHS values correspond to a given LBA so 
it can store them in the MBR.  If they don't both use the same 
translation key, they aren't both speaking the same language, and so the 
boot loader will break.

> [FS offset]--->[encode KEY]--->[INT 0x13]--->[decode KEY]--->[drive offset]
>                          |                             |
>                          |-- anything that will fit ---|
> 
> This encode/decode key should have never been let out of its cage.
> Unfortunately some DOS tools put it on the disks in a table
> called the BPB.
> 

And fdisk must also perform the encode so the partition table can 
correctly indicate where the partition begins.  The boot loader passes 
those values to the bios which decodes them.  The encode and decode must 
both be done using the same key.

> DOS creates two software interrupt vectors, int 0x25, and
> int 0x26, (absolute read and write), which perform this
> translation using the stuff in the BPB. This means that
> the caller (the file-system) doesn't have to worry about
> these things.
> 

We aren't talking about dos's filesystem here, we're talking about the 
windows ( or dos ) boot loader which directly uses int 13 and passes the 
CHS values from the MBR.  The meaning of those values is entirely 
dependent on the geometry, so when fdisk writes those values to the MBR 
it has to be using the same geometry that the bios will use to decode 
it, otherwise when the sector address of the partition is encoded using 
one geometry, and decoded using another, it will come out all wrong.

> Since the offsets are directly available when the BIOS is not
> used, this BPB is useless.
> 

The boot loader is directly using the bios.

> Even when using dosemu, where a virtual 0x13 is available, the
> key used to access this resource is obtained by reading the
> capacity of the DOS file-system(s) and building a BPB for
> each (virtual) disk.
> 

