Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbVJUAql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbVJUAql (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 20:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbVJUAql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 20:46:41 -0400
Received: from mail.dvmed.net ([216.237.124.58]:53168 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964821AbVJUAqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 20:46:40 -0400
Message-ID: <43583A53.2090904@pobox.com>
Date: Thu, 20 Oct 2005 20:46:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andrew.patterson@hp.com
CC: Luben Tuikov <luben_tuikov@adaptec.com>, Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attached
 PHYs)
References: <91888D455306F94EBD4D168954A9457C048F0E34@nacos172.co.lsil.com>	 <20051020160155.GA14296@lst.de> <4357CB03.4020400@adaptec.com>	 <20051020170330.GA16458@lst.de>  <4357F7DE.7050004@adaptec.com> <1129852879.30258.137.camel@bluto.andrew>
In-Reply-To: <1129852879.30258.137.camel@bluto.andrew>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Patterson wrote:
> I believe there is a common understanding that IOCTL's are bad and
> should be avoided. See:
> 
> http://lkml.org/lkml/2001/5/20/81

Yep.  Linus's rant here reflects not only his opinion, but general 
consensus, I feel.


> Yes, CSMI should have had more Linux input when it was developed.  The
> no-new IOCTL policy certainly came as a surprise to the authors. Still,
> there doesn't seem to be any other usable cross-platform interface that
> is acceptable to the linux community (or at least to Christoph)'s corner

Beyond Linus's rant, ioctls have a practical limitation, too:  because 
they are untyped, we have to deal with stuff like the 32<->64 compat 
ioctl thunking.

Consider what an ioctl is, overall:  a domain-specific "do this 
operation" interface.  Which, further, is nothing but a wrapping of a 
"send message" + "receive response" interface.  There are several ways 
to do this in Linux:

* block driver.  a block driver is nothing but a message queue.  This is 
why James has suggested implementing SMP as a block driver.  People get 
stuck into thinking "block driver == block device", which is wrong.  The 
Linux block layer is nothing but a message queueing interface.

* netlink.  You connect to <an object> and send/receive messages.  Not 
strictly limited to networking, as this is used in some areas of the 
kernel now for generic event delivery.

* char driver.  Poor man's netlink.  Unless its done right, it suffers 
from the same binary problems as ioctls.  I don't recommend this path.

* sysfs.  This has no inherent message/queue properties by itself, and 
is less structured than blockdrvr or netlink, so dealing with more than 
one outstanding operation at a time requires some coding.

sysfs's attractiveness is in its ease of use.  It works with standard 
Unix filesystem tools.  You don't need to use a library to read 
information, cat(1) often suffices.  sysfs, since its normal ASCII 
(UTF8), also has none of the annoying 32<->64 compatibility issues that 
ioctls suffer from.

Which is best?  I don't have a good answer.  Largely depends on the 
situation, particularly queueing needs.  Networking and storage are 
rapidly converging into "messaging", so the situation is highly fluid in 
any case.  Coming from a networking background, I sorta lean towards the 
solution noone has attempted yet:  netlink.


> of it).  My personal preference is to hide this stuff in a library, so
> the kernel implementation is hidden. But even a library needs an
> underlying kernel implementation.

Strongly agree here.  libc shelters userspace from [most] kernel 
changes, by exporting syscalls in a standard manner.  alsa-lib was 
created to shelter userspace from current and future changes in the 
kernel audio interface.  libsdi is quite reasonable.

	Jeff


