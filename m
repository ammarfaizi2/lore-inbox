Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261805AbREUHuW>; Mon, 21 May 2001 03:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261867AbREUHuE>; Mon, 21 May 2001 03:50:04 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:16654 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261805AbREUHtC>; Mon, 21 May 2001 03:49:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: ebiederm@xmission.com (Eric W. Biederman), Ben LaHaise <bcrl@redhat.com>
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code in userspace
Date: Sat, 19 May 2001 16:25:47 +0200
X-Mailer: KMail [version 1.2]
Cc: <torvalds@transmeta.com>, <viro@math.psu.edu>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0105190138150.6079-100000@toomuch.toronto.redhat.com> <m14ruhin7d.fsf@frodo.biederman.org>
In-Reply-To: <m14ruhin7d.fsf@frodo.biederman.org>
MIME-Version: 1.0
Message-Id: <01051916254708.00491@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 May 2001 13:37, Eric W. Biederman wrote:
> For creating partitions you might want to do:
> 	cat 1024 2048 > /dev/sda/newpartition

How about:

  # mkpart /dev/sda /dev/mypartition -o size=1024k,type=swap
  # ls /dev/mypartition
  base	size	device	type
  # cat /dev/mypartition/size
  1048576
  # cat /dev/mypartition/device
  /dev/sda
  # mke2fs /dev/mypartition

The information that was specified is persistent in /dev.  We can 
rearrange our physical devices any way we want without affecting
the name we chose in /dev.  When the kernel enumerates devices
at startup, our persistent information better match or we will have
to take some corrective action.

Generally, we shouldn't care which order the kernel enumerates
devices in or which device number gets assigned internally.  If we
did need to care, we'd just do:

  # echo 666 >/dev/mypartition/number

setting a persistent device minor number.  The major number is
inherited via the partition's /device property.

To set the minor number back to 'don't care':

  # rm /dev/mypartition/number

By taking the physical device off the top of the food chain we
gain the flexibility of being able to move the device from bus to 
bus for example, and only the partition's device property
changes, nothing in our fstab.  It's no great leap to set things
up so that not even the /device property would need to
change.

Note that we can have a heirarchy of partitions this way if 
we want to, since /dev/mypartition is just another block
device.

--
Daniel
