Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbVJUFkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbVJUFkT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 01:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbVJUFkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 01:40:19 -0400
Received: from zorg.st.net.au ([203.16.233.9]:57003 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S964876AbVJUFkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 01:40:17 -0400
Message-ID: <43587F74.6080600@torque.net>
Date: Fri, 21 Oct 2005 15:41:08 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: andrew.patterson@hp.com, Luben Tuikov <luben_tuikov@adaptec.com>,
       Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attached
 PHYs)
References: <91888D455306F94EBD4D168954A9457C048F0E34@nacos172.co.lsil.com>	 <20051020160155.GA14296@lst.de> <4357CB03.4020400@adaptec.com>	 <20051020170330.GA16458@lst.de>  <4357F7DE.7050004@adaptec.com> <1129852879.30258.137.camel@bluto.andrew> <43583A53.2090904@pobox.com>
In-Reply-To: <43583A53.2090904@pobox.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Andrew Patterson wrote:
> 
>> I believe there is a common understanding that IOCTL's are bad and
>> should be avoided. See:
>>
>> http://lkml.org/lkml/2001/5/20/81
> 
> 
> Yep.  Linus's rant here reflects not only his opinion, but general
> consensus, I feel.

Jeff,
ioctls represent the most direct, unimpeded (by OS
policy) route between the user space and a driver,
potentially a few levels down a driver stack.
I see it as a control issue, in one corner there are
Microsoft and Linux while in the other there are
the hardware vendors. OS vendors come out with
ioctl replacements but can't resist enforcing policy.

As for type safety in linux, I stopped taking that
seriously when practicality of having C++ code
in the kernel was killed by "struct class".

>> Yes, CSMI should have had more Linux input when it was developed.  The
>> no-new IOCTL policy certainly came as a surprise to the authors. Still,
>> there doesn't seem to be any other usable cross-platform interface that
>> is acceptable to the linux community (or at least to Christoph)'s corner
> 
> 
> Beyond Linus's rant, ioctls have a practical limitation, too:  because
> they are untyped, we have to deal with stuff like the 32<->64 compat
> ioctl thunking.

Do you know where there are some clear guidelines
on the use of pointers in a structure passed to an
ioctl to lessen (or bypass) 32<->64 compat ioctl
thunking?

> Consider what an ioctl is, overall:  a domain-specific "do this
> operation" interface.  Which, further, is nothing but a wrapping of a
> "send message" + "receive response" interface.  There are several ways
> to do this in Linux:
> 
> * block driver.  a block driver is nothing but a message queue.  This is
> why James has suggested implementing SMP as a block driver.  People get
> stuck into thinking "block driver == block device", which is wrong.  The
> Linux block layer is nothing but a message queueing interface.
> 
> * netlink.  You connect to <an object> and send/receive messages.  Not
> strictly limited to networking, as this is used in some areas of the
> kernel now for generic event delivery.
> 
> * char driver.  Poor man's netlink.  Unless its done right, it suffers
> from the same binary problems as ioctls.  I don't recommend this path.
> 
> * sysfs.  This has no inherent message/queue properties by itself, and
> is less structured than blockdrvr or netlink, so dealing with more than
> one outstanding operation at a time requires some coding.
> 
> sysfs's attractiveness is in its ease of use.  It works with standard
> Unix filesystem tools.  You don't need to use a library to read
> information, cat(1) often suffices.  sysfs, since its normal ASCII
> (UTF8), also has none of the annoying 32<->64 compatibility issues that
> ioctls suffer from.

... and on the other side for sysfs are the loss of
layered error reporting, inability to supply auxiliary
attributes such as a request timeout and the possibility
that write()s will either be limited in size or segmented.

> Which is best?  I don't have a good answer.  Largely depends on the
> situation, particularly queueing needs.  Networking and storage are
> rapidly converging into "messaging", so the situation is highly fluid in
> any case.  Coming from a networking background, I sorta lean towards the
> solution noone has attempted yet:  netlink.

damn, we agree :-)

All in all, this is a good summary of the options available.

>> of it).  My personal preference is to hide this stuff in a library, so
>> the kernel implementation is hidden. But even a library needs an
>> underlying kernel implementation.
> 
> 
> Strongly agree here.  libc shelters userspace from [most] kernel
> changes, by exporting syscalls in a standard manner.  alsa-lib was
> created to shelter userspace from current and future changes in the
> kernel audio interface.  libsdi is quite reasonable.

Doug Gilbert

