Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbVCOANc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbVCOANc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 19:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVCOALu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 19:11:50 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:12242 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S262151AbVCOAJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 19:09:50 -0500
Message-ID: <42362527.6010005@utah-nac.org>
Date: Mon, 14 Mar 2005 16:58:31 -0700
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Devices/Partitions over 2TB
References: <200503141644.j2EGiVh0000022634@mudpuddle.cs.wustl.edu> <d14vc7$8cu$2@news.cistron.nl>
In-Reply-To: <d14vc7$8cu$2@news.cistron.nl>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You have to ignore the partition table contents for ending cylinder. Use 
the following instead. You also
have to write your own FS or modify the partition code in Linux or you 
won't be able to use the storage. This
config option listed in the previous post only enables 64 bit LBA 
addressing, it does not fix the busted fdisk program
or the problems you will see with the partition tables.

i.e.

SystemDisk[j]->BytesPerSector = bdev_hardsect_size(bdev);
SystemDisk[j]->driveSectors = (LONGLONG)bdev->bd_disk->capacity;
SystemDisk[j]->driveSize = (LONGLONG)
((LONGLONG)bdev->bd_disk->capacity *
SystemDisk[j]->BytesPerSector);
SystemDisk[j]->max_sg_elements = bio_get_nr_vecs(bdev);

the bd_disk->capacity reports the actual drive size, but fdisk ignores it.

Good Luck.

Jeff


Miquel van Smoorenburg wrote:

>In article <200503141644.j2EGiVh0000022634@mudpuddle.cs.wustl.edu>,
>Berkley Shands  <berkley@cs.wustl.edu> wrote:
>  
>
>>I have not found any documentation of efforts to overcome the 2TB
>>partition limit,
>>    
>>
>
>config LBD
>        bool "Support for Large Block Devices"
>        depends on X86 || MIPS32 || PPC32 || ARCH_S390_31 || SUPERH
>        help
>          Say Y here if you want to attach large (bigger than 2TB) discs to
>          your machine, or if you want to have a raid or loopback device
>          bigger than 2TB.  Otherwise say N.
>
>Mike.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

