Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280686AbRKFW7I>; Tue, 6 Nov 2001 17:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280662AbRKFW4y>; Tue, 6 Nov 2001 17:56:54 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:59152 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S280667AbRKFW4d>; Tue, 6 Nov 2001 17:56:33 -0500
Date: Tue, 6 Nov 2001 23:56:20 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: <andrewm@uow.edu.au>, <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andreas Dilger <adilger@turbolabs.com>
Subject: Re: [PATCH] slip.c jiffies cleanup
In-Reply-To: <Pine.LNX.4.30.0111062152270.23828-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.30.0111062351330.24429-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2001, Tim Schmielau wrote:

> --- ../linux-2.4.14-pre6/drivers/net/slip.c	Sun Sep 30 21:26:07 2001
> +++ drivers/net/slip.c	Tue Nov  6 19:56:48 2001
[...]

> @@ -1412,7 +1412,7 @@
>  				spin_unlock(&slc->ctrl.lock);
>  			}
>  			local_bh_enable();
> -		} while (busy && jiffies - start < 1*HZ);
> +		} while (busy && time_before(jiffies, timeout);
>
>  		busy = 0;
>  		for (i = 0; i < slip_maxdev; i++) {
>


Sorry all, I screwed up.
While I did compile before sending the patch,
somehow I must have missed the error message.
Patch must be

> -		} while (busy && jiffies - start < 1*HZ);
> +		} while (busy && time_before(jiffies, timeout));

New patch appended.

Tim



--- ../linux-2.4.14-pre6/drivers/net/slip.c	Sun Sep 30 21:26:07 2001
+++ drivers/net/slip.c	Tue Nov  6 19:56:48 2001
@@ -483,7 +483,7 @@
 		 *      14 Oct 1994 Dmitry Gorodchanin.
 		 */
 #ifdef SL_CHECK_TRANSMIT
-		if (jiffies - dev->trans_start  < 20 * HZ)  {
+		if (time_before(jiffies, dev->trans_start + 20 * HZ))  {
 			/* 20 sec timeout not reached */
 			goto out;
 		}
@@ -1387,7 +1387,7 @@
 	int i;

 	if (slip_ctrls != NULL) {
-		unsigned long start = jiffies;
+		unsigned long timeout = jiffies + HZ;
 		int busy = 0;

 		/* First of all: check for active disciplines and hangup them.
@@ -1412,7 +1412,7 @@
 				spin_unlock(&slc->ctrl.lock);
 			}
 			local_bh_enable();
-		} while (busy && jiffies - start < 1*HZ);
+		} while (busy && time_before(jiffies, timeout));

 		busy = 0;
 		for (i = 0; i < slip_maxdev; i++) {

