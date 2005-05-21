Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVEUBLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVEUBLZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 21:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVEUBLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 21:11:24 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:62131 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261614AbVEUBKz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 21:10:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:from:to:cc:references:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole;
        b=d+N90ee6EluoUz3g4yJz67HBiIk2KIm9BUuAtxn2wRTOPnsG/4fq34Slrel8z9o5qIW5/sunIG1kR8irn0dB3eC/Zy+A/BkmUHu2TcElDzVtmG8JMF1JSmmioxTXCKZH82CSX0i1BKepcbv0fnY2VI6Kn7pWpfpD0qjBBNtRlLg=
Message-ID: <00da01c55da1$c65193c0$1a4da8c0@NELSON2>
From: "Gianluca Varenni" <gianluca.varenni@gmail.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       <linux-os@analogic.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
References: <02e801c55ca5$7a9d1000$1a4da8c0@NELSON2> <Pine.LNX.4.61.0505191533590.2987@chaos.analogic.com> <1116634649.5153.157.camel@gaston>
Subject: Re: Problem mapping small PCI memory space.
Date: Fri, 20 May 2005 18:09:43 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin.

The problem was exactly the one you described at the end of the mail: my PCI 
IO memory is not aligned at the beginning of a page, it's right in the 
middle of the page. So my mmap was working perfectly, but I was looking at 
the wrong place at user level (I looked at the beginning of the page, while 
my PCI Io memory was 2k away)....

Thank you for you help!!

Have a nice day
GV


----- Original Message ----- 
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: <linux-os@analogic.com>
Cc: "Gianluca Varenni" <gianluca.varenni@gmail.com>; "Linux kernel" 
<linux-kernel@vger.kernel.org>
Sent: Friday, May 20, 2005 5:17 PM
Subject: Re: Problem mapping small PCI memory space.


> On Thu, 2005-05-19 at 15:43 -0400, Richard B. Johnson wrote:
>> On Thu, 19 May 2005, Gianluca Varenni wrote:
>>
>> > Hi all.
>> >
>> > I'm writing a driver for a PCI board that exposes two memory spaces 
>> > (out of
>> > the 6 IO address regions).
>> >
>> > One of them is 1MB, and I can map it to user level without problems. 
>> > The
>> > other one is only 512 bytes.
>> > If I try to open it with /dev/mem, it returns EINVAL (the 1MB memory 
>> > space
>> > is opened without any problem). If I try to expose it through mmap, 
>> > mmap
>> > succeeds, but I only see garbage at user level. At kernel level, I can
>> > access that 512 bytes memory by using ioremap() on the physical address
>> > returned by pci_resource_start().
>> >
>> > Are there any lower limits on the size of a PCI memory region?
>> >
>> > Have a nice day
>> > GV
>> >
>>
>> You impliment mmap() in your driver. It accesses the first megabyte
>> as 256 pages. Then you tack on the additional page that your 512
>> bytes resides at. mmap() only works with pages. The pages must
>> be ioremap_nocache and they must be reserved. The reserved part
>> is important to have them visible from user-space using mmap.
>
> There are a number of totally bogus statements above.
>
> First of all, you don't have to implement mmap in your driver (though it
> would probably better to do so). You can perfectly map your PCI memory
> space from userland without help of a specific driver (see below).
>
> Then, ioremap has absolutely nothing to do with the mapping done to
> userland (unless there is some gory x86 in there, but I really doubt
> it). ioremap_* has to do with mapping the memory in kernel space, not
> user space. Thus your statement "must be ioremap_nocache" is wrong.
>
> I don't know why you think the pages should be reserved as well, damn,
> he's not mapping RAM, he's mapping PCI MMIO space, do you know what you
> are talking about at all ? There is usually no struct page for PCI MMIO
> space.
>
>> That's IFF you really need to see the stuff in user-mode. Normally,
>> you write a driver that accesses everything using the PCI primatives
>> provided in the kernel, for the kernel.
>
> Oh well, Ginancula, here is what you can do:
>
> - If you want to stick to /dev/mem, which is not recommended and may
> not work on all platforms but is fine for a quick hack, just make sure
> you are mmap'ing a full page. That is, your 512 bytes will be
> 512-bytes-aligned somewhere in a page of 4k on most platforms, maybe
> more. You have to map this entire page, and then take an offset in the
> resulting mapping to the 512 bytes.
> Basically, you use getpagesize() to get the page size, then you mmap
> your base_addr & ~(page_size - 1), and you access your data at the
> resulting address + base_addr & (page_size - 1)
>
> - Best is to use the PCI mmap facility. The "old" one via /proc/bus/pci
> or the "new one" via /sys/...path to your device.../resourceN. You
> directly mmap the resource file you want. HOWEVER, the alignement
> restriction will still be there, thus you should also look at the
> "resource" file to get the actual base address, and deduce the
> alignement, and then map a whole page and add the alignement offset to
> the result as for /dev/mem.
>
> Ben.
>
> 

