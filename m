Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319370AbSIFUUB>; Fri, 6 Sep 2002 16:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319371AbSIFUUB>; Fri, 6 Sep 2002 16:20:01 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:34319 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S319370AbSIFUUA>;
	Fri, 6 Sep 2002 16:20:00 -0400
Message-ID: <3D790F2E.1050306@acm.org>
Date: Fri, 06 Sep 2002 15:25:18 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Version 2 of the Linux IPMI driver
References: <20020906201856.F26580@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:

>>The lanana guy is not available for a while, so I'm not getting a device
>>number in the near future, but I think it's ready for the 2.5 release.
>>Does this need more time, or is it ready for inclusion?
>>    
>>
>
>I don't think you should be using a device number at all.  ioctl is Evil
>(TM) and it's perfectly possible to write an IPMI driver which uses
>neither an ioctl nor a chaacter device.  Voila:
>
>http://ftp.linux.org.uk/pub/linux/willy/patches/bmc.diff
>
>yes, it was stupid to call it BMC instead of IPMI.  i was handed a pile
>of junk that'd been half-heartedly ported from windows.  however, the
>principle is sound, you don't need ioctl, nor a character device.
>
>  
>
You access a device as a filesystem?  That's bizarre.  It's a device, 
and they call them "devices" in the kernel for a reason.  Why would you 
want to do this?  Especially with devfs, the whole device numbering 
problem goes away.  You could easily make it a misc device.

Plus, your patch misses a lot of places where IPMI is going.  Many cards 
have multiple IPMI interfaces (I have one that has three).  In 
multi-card systems, IPMI is used for transport for a lot of 
configuration and control information between cards that may be going to 
different applications both inside the kernel and in userland, so a 
straight BMC interface is not going to get you there.  You really need a 
message handler in the kernel.  You could do a message handler in 
userland, but then it makes implementing watchdog timers and I2C 
interfaces kernel interfaces over IPMI much more difficult, and it's a 
message router hooked directly to a device and it makes some sense to 
put it in the kernel.

I toyed with the idea of making it a network interface, since you have 
addressing that is separate from messaging.  However, it probably wasn't 
worth the work for that.

And it wasn't stupid to call your "driver" BMC.  That's exactly what it 
is.  It's not IPMI, it's a KCS BMC interface (hooked in as a filesystem).

-Corey

