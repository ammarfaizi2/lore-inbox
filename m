Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129518AbQKJAdn>; Thu, 9 Nov 2000 19:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129911AbQKJAdX>; Thu, 9 Nov 2000 19:33:23 -0500
Received: from quechua.inka.de ([212.227.14.2]:20532 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S129518AbQKJAdN>;
	Thu, 9 Nov 2000 19:33:13 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: catch 22 - porting net driver from 2.2 to 2.4
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B2708C@hasmsx52.iil.intel.com>
Organization: private Linux site, southern Germany
Date: Fri, 10 Nov 2000 01:09:07 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E13u1ki-0005sR-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We figured that since we are in user context (do_ioctl) and use
> spin_lock_bh() to protect us from other concurrent threads, it might
> interfere with rtnl_lock() so we remove our lock just before calling
> register_netdev() and lock again upon return but then the whole process just
> stopped and didn't return to the prompt. from within kdb, we could see that

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
