Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266290AbUG0HAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266290AbUG0HAq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 03:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266289AbUG0HAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 03:00:45 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:57276 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S266262AbUG0HAa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 03:00:30 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 27 Jul 2004 08:48:25 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Frederik <frederik@padjen.de>, linux-kernel@vger.kernel.org
Subject: Re: Fw: Oops when modprobing cx8800
Message-ID: <20040727064824.GB16853@bytesex>
References: <20040725183038.108ffd7c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040725183038.108ffd7c.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 25, 2004 at 06:30:38PM -0700, Andrew Morton wrote:
> 
> hm, odd.

> Jul 21 15:30:21 athene kernel:  [<c020a377>] vsprintf+0x27/0x30
> Jul 21 15:30:21 athene kernel:  [<c020a39f>] sprintf+0x1f/0x30
> Jul 21 15:30:21 athene kernel:  [<d0cc1078>] cx8800_initdev+0x78/0x7a0 

The only bug I'm aware of which is still in 2.6.8-rc1+ and might be this
is that the card= insmod option lacks a range check (patch below), so
passing some insane high value might kill the driver.  It shouldn't
happen with a simple "insmod cx88" + card autodetect through.

If it is something else -- no idea.

> (This driver should be using kthread for the kernel thread management btw)

Yup, and some other v4l drivers as well ...
Just didn't know kthread exists before OLS ;)

  Gerd

diff -u -p -r1.27 -r1.28
--- cx88-video.c	22 Jul 2004 13:54:28 -0000	1.27
+++ cx88-video.c	23 Jul 2004 01:06:12 -0000	1.28
@@ -2382,7 +2382,9 @@ static int __devinit cx8800_initdev(stru
 	}
 
 	/* board config */
-	dev->board = card[cx8800_devcount];
+	dev->board = UNSET;
+	if (card[cx8800_devcount] < cx88_bcount)
+		dev->board = card[cx8800_devcount];
 	for (i = 0; UNSET == dev->board  &&  i < cx88_idcount; i++) 
 		if (pci_dev->subsystem_vendor == cx88_subids[i].subvendor &&
 		    pci_dev->subsystem_device == cx88_subids[i].subdevice)
