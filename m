Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263460AbUJ3DYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbUJ3DYS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 23:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbUJ3DYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 23:24:17 -0400
Received: from mail1.speakeasy.net ([216.254.0.201]:13227 "EHLO
	mail1.speakeasy.net") by vger.kernel.org with ESMTP id S263460AbUJ3DXw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 23:23:52 -0400
Message-ID: <4183093F.9040500@speakeasy.net>
Date: Fri, 29 Oct 2004 23:23:43 -0400
From: Andrew <cmkrnl@speakeasy.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041020)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kay Sievers <kay.sievers@vrfy.org>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] 2.6.10.rc1.bk6 /lib/kobject_uevent.c buffer issues
References: <20041027142925.GA17484@imladris.arnor.me> <20041027152134.GA13991@kroah.com> <417FCD78.6020807@speakeasy.net> <20041029201314.GA29171@kroah.com> <20041029212856.GA12582@vrfy.org> <20041029231319.GA503@kroah.com> <20041030000045.GA13356@vrfy.org> <20041030002523.GA13425@vrfy.org> <20041030025429.GA13757@vrfy.org>
In-Reply-To: <20041030025429.GA13757@vrfy.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kay Sievers wrote:
> On Sat, Oct 30, 2004 at 02:25:23AM +0200, Kay Sievers wrote:
> 
>>On Sat, Oct 30, 2004 at 02:00:45AM +0200, Kay Sievers wrote:
>>
>>>On Fri, Oct 29, 2004 at 06:13:19PM -0500, Greg KH wrote:
>>>
>>>>On Fri, Oct 29, 2004 at 11:28:56PM +0200, Kay Sievers wrote:
>>>>
>>>>>>But there might still be a problem.  With this change, the sequence
>>>>>>number is not sent out the kevent message.  Kay, do you think this is an
>>>>>>issue?  I don't think we can get netlink messages out of order, right?
>>>>>
>>>>>Right, especially not the events with the same DEVPATH, like "remove"
>>>>>beating an "add". But I'm not sure if the number isn't useful. Whatever
>>>>>we may do with the hotplug over netlink in the future, we will only have
>>>>>/sbin/hotplug for the early boot and it may be nice to know, what events
>>>>>we have already handled...
>>>>>
>>>>>
>>>>>>I'll hold off on applying this patch until we figure this out...
>>>>>
>>>>>How about just reserving 20 bytes for the number (u64 will never be
>>>>>more than that), save the pointer to that field, and fill the number in
>>>>>later?
>>>>
>>>>Ah, something like this instead?  I like it, it's even smaller than the
>>>>previous patch.  Compile tested only...
>>>
>>>I like that. How about the following. It will keep the buffer clean from
>>>random chars, cause the kevent does not have the vector and relies on
>>>the '\0' to separate the strings from each other.
>>>I've tested it. The netlink-hotplug message looks like this:
>>>
>>>recv(3, "remove@/class/input/mouse2\0ACTION=remove\0DEVPATH=/class/input/mouse2\0SUBSYSTEM=input\0SEQNUM=961                 \0", 1024, 0) = 113
>>
>>Hmm, these trailing spaces are just bad, sorry. I'll better pass the
>>envp array over to send_uevent() and clean up the keys while copying
>>the env values into the skb buffer. This will make the event payload
>>more safe too. So your first version looks better.
> 
> 
> How about this? We copy over key by key into the skb buffer and the
> netlink message can get the envp array without depending on a single
> continuous buffer.
> 
> The netlink message looks nice like this now:
> 
> recv(3, "
>   add@/devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0\0
>   HOME=/\0
>   PATH=/sbin:/bin:/usr/sbin:/usr/bin\0
>   ACTION=add\0
>   DEVPATH=/devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0\0
>   SUBSYSTEM=usb\0
>   SEQNUM=991\0
>   DEVICE=/proc/bus/usb/003/008\0
>   PRODUCT=46d/c03e/2000\0
>   TYPE=0/0/0\0
>   INTERFACE=3/1/2\0
> ", 1024, 0) = 268
> 

Yeah, sending the envp array instead of buffer to send_uevent() handles
all the cases. Great stuff - Thanks

Andrew
