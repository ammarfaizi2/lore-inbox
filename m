Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130658AbQKBAEq>; Wed, 1 Nov 2000 19:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131891AbQKBAEg>; Wed, 1 Nov 2000 19:04:36 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:15371 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130658AbQKBAEa>;
	Wed, 1 Nov 2000 19:04:30 -0500
Message-ID: <3A00AF60.37DBB956@mandrakesoft.com>
Date: Wed, 01 Nov 2000 19:03:44 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kuznet@ms2.inr.ac.ru
Subject: Re: Linux-2.4.0-test10
In-Reply-To: <Pine.LNX.4.10.10010311237430.22165-100000@penguin.transmeta.com> <E13qiR9-0008FT-00@the-village.bc.nu> <20001101093839.A16274@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tue, Oct 31, 2000 at 08:55:13PM +0000, Alan Cox wrote:
> >       What about the fact anyone can crash a box using ioctls on net
> >       devices and waiting for an unload - was this fixed ?

> The ioctls of network devices are generally unsafe on SMP, because
> they run with kernel lock dropped now but are mostly not safe to do so.

Wrong.  The BLK is dropped in sock_ioctl, but struct netdevice::do_ioctl
is called with rtnl_lock held:

	net/core/dev.c:
		rtnl_lock();
		ret = dev_ifsioc(&ifr, cmd);
		rtnl_unlock();

Therefore for 2.4.x, our concern is whether a particular net driver
needs further SMP protection internally, or if rtnl_lock (a semaphore,
not a spinlock) is sufficient.

	Jeff


-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
