Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316986AbSFFPSV>; Thu, 6 Jun 2002 11:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316989AbSFFPSU>; Thu, 6 Jun 2002 11:18:20 -0400
Received: from air-2.osdl.org ([65.201.151.6]:41867 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316986AbSFFPSU>;
	Thu, 6 Jun 2002 11:18:20 -0400
Date: Thu, 6 Jun 2002 08:14:09 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Amici Alessandro <alessandro_amici@telespazio.it>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: device model update 2/2
In-Reply-To: <A183DF60AC72D5119B990002A5749CB301E9C106@ROMADG-MAIL01>
Message-ID: <Pine.LNX.4.33.0206060808050.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Jun 2002, Amici Alessandro wrote:

> 
> hi,
> 
> +		lock_device(dev);
> +		dev->driver = NULL;
> +		unlock_device(dev);
> +
> +		/* detach from driver */
> +		if (dev->driver->remove)
> +			dev->driver->remove(dev);
> +		put_driver(dev->driver);
> 
> you might want to exchange these two blocks :)

D'oh. bk://ldm.bkbits.net/linux-2.5 is being updated now. Incremental 
patch below. 

	-pat

ChangeSet@1.456, 2002-06-06 08:10:56-07:00, mochel@osdl.org
  Don't reference driver after you set pointer to NULL in device_detach

 drivers/base/core.c |    8 ++++----
 1 files changed, 4 insertions, 4 deletions


diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Thu Jun  6 08:13:54 2002
+++ b/drivers/base/core.c	Thu Jun  6 08:13:54 2002
@@ -103,14 +103,14 @@
 		list_del_init(&dev->driver_list);
 		write_unlock(&dev->driver->lock);
 
-		lock_device(dev);
-		dev->driver = NULL;
-		unlock_device(dev);
-
 		/* detach from driver */
 		if (dev->driver->remove)
 			dev->driver->remove(dev);
 		put_driver(dev->driver);
+
+		lock_device(dev);
+		dev->driver = NULL;
+		unlock_device(dev);
 	}
 }
 

