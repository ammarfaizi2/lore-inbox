Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129457AbQKLLlE>; Sun, 12 Nov 2000 06:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129055AbQKLLky>; Sun, 12 Nov 2000 06:40:54 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:2575 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129040AbQKLLkk>; Sun, 12 Nov 2000 06:40:40 -0500
Message-ID: <07E6E3B8C072D211AC4100A0C9C5758302B2708D@hasmsx52.iil.intel.com>
From: "Hen, Shmulik" <shmulik.hen@intel.com>
To: "'Olaf Titz'" <olaf@bigred.inka.de>, linux-kernel@vger.kernel.org,
        "'LNML'" <linux-net@vger.kernel.org>
Subject: RE: catch 22 - porting net driver from 2.2 to 2.4
Date: Sun, 12 Nov 2000 03:40:14 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

and you don't get the "RTNL: assertion failed at
devinet.c(775):inetdev_event" in 2.4.x ?

the thing is I need to prevent Tx/Rx when a topology change is initiated
from the ioctl (registering a virtual adapter is just one example), so they
all share a single lock and I must use spin_lock_bh from the ioctl.

	Shmulik.

-----Original Message-----
From: Olaf Titz [mailto:olaf@bigred.inka.de]
Sent: Friday, November 10, 2000 2:09 AM
To: linux-kernel@vger.kernel.org
Subject: Re: catch 22 - porting net driver from 2.2 to 2.4


> We figured that since we are in user context (do_ioctl) and use
> spin_lock_bh() to protect us from other concurrent threads, it might
> interfere with rtnl_lock() so we remove our lock just before calling
> register_netdev() and lock again upon return but then the whole process
just
> stopped and didn't return to the prompt. from within kdb, we could see
that

Can't you just do this:

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,0) /* not sure about the 0 */
#define rtnl_LOCK()	rtnl_lock()
#define rtnl_UNLOCK()	rtnl_unlock()
#else
#define rtnl_LOCK()	/* nop */
#define rtnl_UNLOCK()	/* nop */
#endif

rtnl_LOCK();
register_netdevice(...);
rtnl_UNLOCK();

that works for me (yes, from do_ioctl, but without the bh lock - I
don't know if that's absolutely needed in your case).

Olaf
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
