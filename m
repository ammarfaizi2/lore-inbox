Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWDKT2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWDKT2P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 15:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWDKT2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 15:28:15 -0400
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:59282 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750971AbWDKT2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 15:28:14 -0400
Message-ID: <443C0410.4080306@tmr.com>
Date: Tue, 11 Apr 2006 15:31:28 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9a1) Gecko/20060410 SeaMonkey/1.5a
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 40% IDE performance regression going from FC3 to FC5 with same
 kernel
References: <5a4c581d0604080747w61464d48k5480391d98b2bc47@mail.gmail.com>
In-Reply-To: <5a4c581d0604080747w61464d48k5480391d98b2bc47@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Suardi wrote:
> I'll be filing a FC5 performance bug for this but would like an opinion
>  from the IDE kernel people just in case this has already been seen...
> 
> I just upgraded my home K7-800, 512MB RAM box from FC3 to FC5
>  and noticed a disk performance slowdown while copying files around.
> 
> System has two 160GB disks, a Samsung SP1604N 2MB cache and
>  a Maxtor 6Y160P0 8MB cache; both disks appear to be almost 2x
>  slower both on hdparm -t tests (17-19MB/s against 33/35 MB/s) and
>  on dd tests, like this:
> 
> FC3
> [root@donkey tmp]# time dd if=/dev/hda of=/dev/null skip=200 bs=1024k count=200
> 200+0 records in
> 200+0 records out
> 
> real    0m4.623s
> user    0m0.004s
> sys     0m1.308s
> 
> FC5
> [root@donkey tmp]#  time dd if=/dev/hda of=/dev/null skip=200 bs=1024k count=200
> 200+0 records in
> 200+0 records out
> 209715200 bytes (210 MB) copied, 9.67808 seconds, 21.7 MB/s
> 
> real    0m9.683s
> user    0m0.008s
> sys     0m1.400s
> 
> 
> The initial tests were my last FC3 self-compiled kernel (2.6.16-rc5-git8)
>  vs FC5's 2.6.16-1.2080_FC5 kernel; so just to be sure, I copied over
>  from my FC3 partition the 2.6.16-rc5-git8 kernel and its config file,
>  and rebuilt it under FC5, with just a few differences for the new USB
>  2.0 disk I added to a PCI controller I just put in, namely
> 
> [root@donkey linux-2.6.16-rc5-git8]# diff .config
> /fc3/usr/src/linux-2.6.16-rc5-git8/.config
> 4c4
> < # Fri Apr  7 03:58:23 2006
> ---
>> # Mon Mar  6 22:49:32 2006
> 1110,1112c1110
> < CONFIG_USB_EHCI_HCD=m
> < CONFIG_USB_EHCI_SPLIT_ISO=y
> < CONFIG_USB_EHCI_ROOT_HUB_TT=y
> ---
>> # CONFIG_USB_EHCI_HCD is not set
> 1115c1113
> < CONFIG_USB_UHCI_HCD=m
> ---
>> CONFIG_USB_UHCI_HCD=y
> 1218d1215
> < # CONFIG_USB_SISUSBVGA is not set
> 
> The result is unexpected - performance delta is still there. Concatenating
>  output from hdparm -i /dev/hda and hdparm /dev/hda for the same kernel
>  under FC3 and FC5, the only difference is
> 
> [root@donkey ~]# diff /tmp/hdparm.out.2616rc2git8-fc5
> /tmp/hdparm.out.2616rc2git8
> 14c14
> <  Drive conforms to: (null):  ATA/ATAPI-1 ATA/ATAPI-2 ATA/ATAPI-3
> ATA/ATAPI-4 ATA/ATAPI-5 ATA/ATAPI-6 ATA/ATAPI-7
> ---
>>  Drive conforms to: (null):
> 27c27
> <  geometry     = 19457/255/63, sectors = 312581808, start = 0
> ---
>>  geometry     = 19457/255/63, sectors = 160041885696, start = 0
> 
> I'll try now and rebuild a 2.6.16-rc5-git8 kernel under FC5 with the
>  FC3 GCC and see whether that is responsible for the performance
>  drop... of course if anyone has any idea about what's going on, I
>  will be happy to try out stuff. Attaching hdparm output from the FC5
>  2.6.16-rc5-git8 just to show that there is DMA etc. all configured fine.

Could you look at params with hdparm, and display the readahead with
"blockdev --getra" and see if this is read or write limited?
