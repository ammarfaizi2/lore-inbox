Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265885AbUFDR0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265885AbUFDR0R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 13:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265894AbUFDR0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 13:26:17 -0400
Received: from [141.156.69.115] ([141.156.69.115]:44160 "EHLO
	mail.infosciences.com") by vger.kernel.org with ESMTP
	id S265885AbUFDRZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 13:25:23 -0400
Message-ID: <40C0B082.5020509@infosciences.com>
Date: Fri, 04 Jun 2004 13:25:22 -0400
From: nardelli <jnardelli@infosciences.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Abbott <abbotti@mev.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] Memory leak in visor.c and ftdi_sio.c
References: <40C08E6D.8080606@infosciences.com> <c9q8a6$hga$1@sea.gmane.org>
In-Reply-To: <c9q8a6$hga$1@sea.gmane.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Abbott wrote:
> On 04/06/2004 15:59, nardelli wrote:
> 
>> Note that I have not verified any of the below on
>> hardware associated with drivers/usb/serial/ftdi_sio.c,
>> only with drivers/usb/serial/visor.c.  If anyone has
>> hardware for this device, I would appreciate your comments.
>>
>> A memory leak occurs in both drivers/usb/serial/ftdi_sio.c
>> and drivers/usb/serial/visor.c when the usb device is
>> unplugged while data is being written to the device.  This
>> patch should clear that up.
> 
> 
> The change to ftdi_sio.c looks correct to me.
> 
> I made the original change to ftdi_sio.c to allocate the write urbs and 
> their transfer buffers dynamically (instead of using a preallocated 
> pool) and I copied that technique from visor.c!
> 
> A related problem with the current implementation is that is easy to run 
> out of memory by running something similar to this:
> 
>  # cat /dev/zero > /dev/ttyUSB0
> 
> That affects both the ftdi_sio and visor drivers.
> 

I believe that I have seen something similiar, but possibly not identical.
When writing alot (I used /dev/urandom instead of /dev/zero), it looks
like a very large percentage of buffers that are being allocated during
writes are not being freed.  One test I did indicated that 95% of buffers
were not being freed!  I briefly mention some info in
http://lkml.org/lkml/2004/5/25/72, but I wasn't going to go into detail
until I'd found out more info, and verified that my test procedure was
adequate.

My test is pretty simple, print out the address every time a buffer is
allocated, and print out the address every time a buffer is freed.  In
this case there is only one location where it is being allocated, but 3
(4 with patch I submitted) where it is being freed.  It's simply a matter
of running a command like the one below, and looking to see which addresses
are in there an odd number of times (i.e. allocated, but not freed).  Not a
perfect test, but hopefully not embarrassingly bad either.

cat /var/log/messages | egrep 'Allocated|Freed' | tr -s ' ' | cut -d ' ' -f 7 | sort | uniq -c | sort -n

I'm not sure why such a high percentage would not be freed, but hopefully I'll
figure it out in the next week or two, time permitting.

-- 
Joe Nardelli
jnardelli@infosciences.com
