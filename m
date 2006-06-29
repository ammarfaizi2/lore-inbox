Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWF2NIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWF2NIq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 09:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWF2NIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 09:08:46 -0400
Received: from cv3.cv.nrao.edu ([192.33.115.2]:48302 "EHLO cv3.cv.nrao.edu")
	by vger.kernel.org with ESMTP id S1750713AbWF2NIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 09:08:45 -0400
Message-ID: <44A3D0CF.8050608@nrao.edu>
Date: Thu, 29 Jun 2006 09:08:31 -0400
From: Rodrigo Amestica <ramestic@nrao.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>
CC: Rodrigo Amestica <ramestic@nrao.edu>, linux-kernel@vger.kernel.org,
       Patrick P Murphy <pmurphy@nrao.edu>
Subject: Re: vmalloc kernel parameter
References: <44A272CA.5000209@nrao.edu> <20060628163339.d2110437.vsu@altlinux.ru> <44A29E85.9000902@nrao.edu>
In-Reply-To: <44A29E85.9000902@nrao.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact postmaster@cv.nrao.edu for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-101.44, required 5,
	autolearn=disabled, ALL_TRUSTED -1.44, USER_IN_WHITELIST -100.00)
X-MailScanner-From: ramestic@nrao.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

the uppermem workaround for grub did not work well for me when I tried to add 
the mem+memmap parameters to the kernel. My machine has 2GB of ram and trying to 
set mem beyond the 1GB limit made the machine unable to boot. Setting mem to a 
value below 1GB allowed the machine to boot but VmallocTotal reported unexpected 
values.

I have switched now to lilo and things seems to work just fine. The following 
lilo config

  image=/boot/vmlinuz
         label=vmalloc
         initrd=/boot/initrd.img
         read-only
         append="root=LABEL=/ vmalloc=256M mem=1899M memmap=128M#1899M"

let's the machine boot just fine reporting the following values in /proc/meminfo

MemTotal:      1925632 kB
VmallocTotal:   245752 kB

Rodrigo

Rodrigo Amestica wrote:
> Hi Sergey, many thanks for the reply.
> 
> I saw those links before but I did not get their full meaning.
> 
> By setting uppermem to 512M it does actually work. However, now I'm 
> trying to reserve RAM for DMA sake. For that I use mem=1899M; where 1899 
> comes from the total memory reported under normal booting less 128M, 
> which are the Megs that I'm trying to reserve.
> 
> It seems that by adding mem to the boot line goes into conflicting with 
> the uppermem+vmalloc arrangement.
> 
> Without providing more details on what's actually happening can you tell 
> that there is something wrong on what I'm trying to do?
> 
> Would switching to lilo help any?
> 
> thanks,
>  Rodrigo
> 
> Sergey Vlasov wrote:
>>
>> This is a known problem with GRUB: it tries to put initrd at the highest
>> possible address in memory, and assumes the standard vmalloc area size.
>> You need to trick GRUB into thinking that your machine has less memory
>> by using "uppermem 524288" (512M) or even lower - then the initrd data
>> will still be accessible for the kernel even with larger vmalloc area.
>>
>> http://lkml.org/lkml/2005/4/4/283
>> http://lists.linbit.com/pipermail/drbd-user/2005-April/002890.html
>>
>>> ps: my kernel version is 2.6.15.2, and my machine is a dual opteron
>>> with 2GB of ram
>>>
>>> title with vmalloc
>>>          root (hd0,0)
>>
>> Add "uppermem 524288" here.
>>
>>>          kernel /boot/vmlinuz ro root=LABEL=/ vmalloc=256M
>>>          initrd /boot/initrd.img
