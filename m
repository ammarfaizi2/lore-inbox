Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266043AbUAFEDz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 23:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266063AbUAFEDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 23:03:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:47548 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266043AbUAFEDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 23:03:53 -0500
Date: Mon, 5 Jan 2004 20:03:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christian Borntraeger <kernel@borntraeger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6: spinlock bug in sound/oss/dmabuf.c
Message-Id: <20040105200351.7683d112.akpm@osdl.org>
In-Reply-To: <200401051828.52363.kernel@borntraeger.net>
References: <200401051828.52363.kernel@borntraeger.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Borntraeger <kernel@borntraeger.net> wrote:
>
> I think I found a bug in sound/oss/dmabuf.c
> 
>  DMAbuf_getrdbuffer holds a spinlock and possibly calls dma_reset_input. The 
>  dma_reset_input tries to hold that spinlock again:

yup, thanks.

diff -puN sound/oss/dmabuf.c~oss-dmabuf-deadlock-fix sound/oss/dmabuf.c
--- 25/sound/oss/dmabuf.c~oss-dmabuf-deadlock-fix	2004-01-05 20:02:05.000000000 -0800
+++ 25-akpm/sound/oss/dmabuf.c	2004-01-05 20:02:19.000000000 -0800
@@ -587,7 +587,6 @@ int DMAbuf_getrdbuffer(int dev, char **b
 		spin_unlock_irqrestore(&dmap->lock,flags);
 		timeout = interruptible_sleep_on_timeout(&adev->in_sleeper,
 							 timeout);
-		spin_lock_irqsave(&dmap->lock,flags);
 		if (!timeout) {
 			/* FIXME: include device name */
 			err = -EIO;
@@ -595,6 +594,7 @@ int DMAbuf_getrdbuffer(int dev, char **b
 			dma_reset_input(dev);
 		} else
 			err = -EINTR;
+		spin_lock_irqsave(&dmap->lock,flags);
 	}
 	spin_unlock_irqrestore(&dmap->lock,flags);
 

_

