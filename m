Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271244AbUJVL7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271244AbUJVL7W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 07:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271240AbUJVL7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 07:59:21 -0400
Received: from neopsis.com ([213.239.204.14]:56968 "EHLO
	matterhorn.neopsis.com") by vger.kernel.org with ESMTP
	id S271244AbUJVL6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 07:58:46 -0400
Message-ID: <4178F5EF.7000503@dbservice.com>
Date: Fri, 22 Oct 2004 13:58:39 +0200
From: Tomas carnecky <tom@dbservice.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Blizbor <kernel@globalintech.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: my opinion about VGA devices
References: <417590F3.1070807@dbservice.com> <200410201318.26430.oliver@neukum.org> <41765A8C.2020309@dbservice.com> <Pine.LNX.4.61.0410200851080.10711@chaos.analogic.com> <417672BF.5040708@dbservice.com> <Pine.LNX.4.61.0410201022370.12062@chaos.analogic.com> <41767DB4.9040008@dbservice.com> <4178F276.2040501@globalintech.pl>
In-Reply-To: <4178F276.2040501@globalintech.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Please contact the ISP for more information
X-Neopsis-MailScanner: Found to be clean
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blizbor wrote:

> Tomas Carnecky wrote:
>
>> Richard B. Johnson wrote:
>>
>>>> Why do you let user-mode programs access the hardware directly?
>>>> You don't do this with network devices (there you have syscalls), 
>>>> you don't do this with sound devices (alsa).
>>>
>>>
>>>
>>>
>>> Any root process can mmap() any of the memory-mapped hardware
>>> including network devices. This isn't normally done because
>>> handling interrupts from such hardware isn't very efficient
>>> in user-mode, and redistributing data meant for another
>>> process would be a nightmare. However, it can be done.
>>>
>>>> IMO it makes a proper power managment implementation impossible.
>>>>
>>>
>>> Wrong. The 'normal' user can't do such I/O, root can. See iopl(), which
>>> sets the I/O privilege level. This has nothing to do with power-
>>> management.
>>
>>
>>
>> Power managment should be done in the kernel, that's why there is 
>> sysfs and the kobjects. But it can't be done properly if some process 
>> from user-mode (even root processes) do access the hardware directly.
>> Power managment isn't the only reason why it shouldn't be done, but 
>> also everything related to the device managment etc. There should 
>> always be a driver between a process and the hardware as a protection.
>>
>>>
>>>> Last time I've tried a LiveCD distro I've seen a nice boot console 
>>>> with background picture, high resolution (1024x768) and nice small 
>>>> font. That means that the framebuffer driver had to be initialized 
>>>> at that time. I don't have framebuffer drivers compiled into my 
>>>> kernel so I don't know at which point these are initialized, but it 
>>>> must be at a quite early point in the boot process.
>>>
>>>
>>>
>>>
>>> Even Fedora, which boots in a 'graphical' mode, really boots standard
>>> text-mode until 'init' gets control. They just hide the console output
>>> by setting the grub command-line parameter, "quiet".
>>>
>>> The kernel messages are still available using `dmesg`. If you want
>>> to eliminate any possibility of losing kernel messages because
>>> the kernel failed to get up all the way, just use /dev/ttyS0 as
>>> your console during boot.
>>
>>
>>
>> Well... that's why I don't understand why we should keep the VGA code 
>> in the kernel. It's very unlikely that the kernel crashes before a 
>> graphics driver can be initialized (if you do this as soon as 
>> possible) unless you have a bad CPU etc.
>>
> I think you're wrong.
> This is not a good idea. In such important (should I say 'critical' ?) 
> software like kernel
> there is no room to developers 'probability sense'. If exists 
> hypotethical situation that
> something will go wrong it should be taken into account and a software 
> way to handle it
> must exist.

I don't think there is any way you can handle a crash at that stage, 
either the kernel starts successfully or not.

>
> 1. What if kernel crashes during graphics driver initialisation ?

Developers can have a serial console attached to the computer and get 
the info from there and any other user don't really care, I don't think 
that the office workers in the Munich government would care about it and 
send a bug report to the LKML.

> 2. What if you move HD to another box with totally diferrent graphics 
> device ?

You could have two drivers compiled in, one very small and simple (VGA) 
for the case that you'll change the computer and a boot parameter to 
change them. But usually people compile a new kernel before putting the 
HD into a new box so I don't see this as a a stong argument.

> 3. What if the kernel DO crash before graph.dev. initialisation ? How 
> many hours you will spend diagnosing ?

Not even a minute, I'd switch to a driver version that worked before. 
And maybe report that the new version doesn't work.

>
> 4. What if before or during graphisc driver initialisation a kind of 
> delayed error in other device will occur ?

Not if you initialize the graph.dev. before any other device, as soon as 
possible, just after the bus(PCI etc.) initialization.

tom

