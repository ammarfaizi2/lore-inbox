Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291771AbSBAOk7>; Fri, 1 Feb 2002 09:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291772AbSBAOkt>; Fri, 1 Feb 2002 09:40:49 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:42169 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S291771AbSBAOkp>;
	Fri, 1 Feb 2002 09:40:45 -0500
Date: Fri, 1 Feb 2002 15:40:34 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbd in 2.5.3 does not work, and can cause severe damage when read-write
Message-ID: <20020201144034.GA5982@vana.vc.cvut.cz>
In-Reply-To: <20020131132446.GA23990@vana.vc.cvut.cz> <20020131212157.GA516@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020131212157.GA516@elf.ucw.cz>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 10:21:57PM +0100, Pavel Machek wrote:
> >     to 20 is needed, as otherwise nbd server commits suicide. Maximum request size
> >     should be handshaked during nbd initialization, but currently just use
> >     hardwired 20 sectors, so it will behave like it did in the past.
> 
> But please do not apply this one. Nbd servers should be fixed, and I
> already have fix in cvs. (Besides, its trivial). Just make buffer in
> server 1MB big.
> 
> I do not like idea of handshake.

I do not like breaking backward compatibility when there is no
need for that, but as you will be the target of the complaints...

Linus, this reverts limit for request size from 10KB to unlimited.
Although no released nbd version supports it, it is certainly better to
add support to servers than cripple clients if incompatibility does
not matter.
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz

 
diff -urdN linux/drivers/block/nbd.c linux/drivers/block/nbd.c
--- linux/drivers/block/nbd.c	Thu Jan 31 19:00:00 2002
+++ linux/drivers/block/nbd.c	Thu Jan 10 18:15:38 2002
@@ -518,7 +518,6 @@
 	blksize_size[MAJOR_NR] = nbd_blksizes;
 	blk_size[MAJOR_NR] = nbd_sizes;
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_nbd_request, &nbd_lock);
-	blk_queue_max_sectors(BLK_DEFAULT_QUEUE(MAJOR_NR), 20);
 	for (i = 0; i < MAX_NBD; i++) {
 		nbd_dev[i].refcnt = 0;
 		nbd_dev[i].file = NULL;

