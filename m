Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVD0Phr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVD0Phr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 11:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVD0Phc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 11:37:32 -0400
Received: from alog0087.analogic.com ([208.224.220.102]:22178 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261760AbVD0Pf3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 11:35:29 -0400
Date: Wed, 27 Apr 2005 11:34:45 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: k8 s <uint32@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Doubt Regarding Multithreading and Device Driver
In-Reply-To: <699a19ea050427080545fb1676@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0504271123001.21751@chaos.analogic.com>
References: <699a19ea050427080545fb1676@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2005, k8 s wrote:

> hello,
>
> I have a doubt regarding user space threads and device drivers
> implementation issue.
>
> I have a device driver for /dev/skn
> It implements basic driver operations skn_open,skn_release, skn_ioctl.
>
> I am storing something into struct file*filp->private_data.
> As this is not shared across processes I am not doing any locking
> stuff while accessing or putting anything into it.
>
> Will There be a race condition in a multithreaded program in the ioctl
> call on smp kernel accessing filp->private_data.
>

Of course. But that's not the only race. You need to make certain that
any shared resource (your driver) only allows a single execution-
thread anywhere there is shared data or the hardware itself. This
is generally accomplished with semaphore(s), a.k.a, down() and up().

Note that each open() call provides its own 'struct file' pointer.
The kernel won't get them mixed up. You can use your private-data
pointer available in this structure in each open() and use that
for private data in each access. You can free such private data
in a close(). But, that's just the obvious stuff. User-mode threads
share open files!

That means that your driver has no way of isolating such access
except by using semaphores.

> S.Kartikeyan


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
