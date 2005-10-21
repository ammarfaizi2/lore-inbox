Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbVJUGUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbVJUGUI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 02:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbVJUGUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 02:20:08 -0400
Received: from mail.dvmed.net ([216.237.124.58]:179 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964882AbVJUGUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 02:20:06 -0400
Message-ID: <4358887C.6020200@pobox.com>
Date: Fri, 21 Oct 2005 02:19:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dougg@torque.net
CC: andrew.patterson@hp.com, Luben Tuikov <luben_tuikov@adaptec.com>,
       Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attached
 PHYs)
References: <91888D455306F94EBD4D168954A9457C048F0E34@nacos172.co.lsil.com>	 <20051020160155.GA14296@lst.de> <4357CB03.4020400@adaptec.com>	 <20051020170330.GA16458@lst.de>  <4357F7DE.7050004@adaptec.com> <1129852879.30258.137.camel@bluto.andrew> <43583A53.2090904@pobox.com> <43587F74.6080600@torque.net>
In-Reply-To: <43587F74.6080600@torque.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert wrote:
> ioctls represent the most direct, unimpeded (by OS
> policy) route between the user space and a driver,
> potentially a few levels down a driver stack.

With the inevitable result that most ioctl code is poorly written, and 
causes bugs and special case synchronization problems :)  Driver writers 
love to stuff way too much stuff into ioctls, without thinking about 
overall design.


> I see it as a control issue, in one corner there are
> Microsoft and Linux while in the other there are
> the hardware vendors. OS vendors come out with
> ioctl replacements but can't resist enforcing policy.
> 
> As for type safety in linux, I stopped taking that
> seriously when practicality of having C++ code
> in the kernel was killed by "struct class".

C++ was never ever meant to work with the kernel.


>>>Yes, CSMI should have had more Linux input when it was developed.  The
>>>no-new IOCTL policy certainly came as a surprise to the authors. Still,
>>>there doesn't seem to be any other usable cross-platform interface that
>>>is acceptable to the linux community (or at least to Christoph)'s corner
>>
>>
>>Beyond Linus's rant, ioctls have a practical limitation, too:  because
>>they are untyped, we have to deal with stuff like the 32<->64 compat
>>ioctl thunking.
> 
> 
> Do you know where there are some clear guidelines
> on the use of pointers in a structure passed to an
> ioctl to lessen (or bypass) 32<->64 compat ioctl
> thunking?

Its impossible.  If you pass pointers, you need to thunk.  (Not even 
passing pointers via sysfs can avoid this.)  Consider running a 32-bit 
app (with 32-bit pointers and 32-bit ABI) on a 64-bit kernel.


>>Consider what an ioctl is, overall:  a domain-specific "do this
>>operation" interface.  Which, further, is nothing but a wrapping of a
>>"send message" + "receive response" interface.  There are several ways
>>to do this in Linux:
>>
>>* block driver.  a block driver is nothing but a message queue.  This is
>>why James has suggested implementing SMP as a block driver.  People get
>>stuck into thinking "block driver == block device", which is wrong.  The
>>Linux block layer is nothing but a message queueing interface.
>>
>>* netlink.  You connect to <an object> and send/receive messages.  Not
>>strictly limited to networking, as this is used in some areas of the
>>kernel now for generic event delivery.
>>
>>* char driver.  Poor man's netlink.  Unless its done right, it suffers
>>from the same binary problems as ioctls.  I don't recommend this path.
>>
>>* sysfs.  This has no inherent message/queue properties by itself, and
>>is less structured than blockdrvr or netlink, so dealing with more than
>>one outstanding operation at a time requires some coding.
>>
>>sysfs's attractiveness is in its ease of use.  It works with standard
>>Unix filesystem tools.  You don't need to use a library to read
>>information, cat(1) often suffices.  sysfs, since its normal ASCII
>>(UTF8), also has none of the annoying 32<->64 compatibility issues that
>>ioctls suffer from.
> 
> 
> ... and on the other side for sysfs are the loss of
> layered error reporting,

Only for the most simple interfaces.  sysfs is for exporting kernel data 
structures to userspace, using read(2) and write(2).  You can quite 
literally accomplish anything with that.  sysfs could export an event 
directory entry, and a response directory entry.  The response dirent 
could provide all the error reporting you could ever want.  That's just 
a 2-second off-the-cuff example.


> inability to supply auxiliary
> attributes such as a request timeout and the possibility
> that write()s will either be limited in size or segmented.

This entirely depends on the interface you define.  These problems are 
all surmountable.

Note, I'm _not_ suggesting this is the best route for an SMP interface, 
just stating sysfs generalities.  sysfs is flexible enough that it could 
completely replace SG_IO (though that would not be a wise idea).

	Jeff


