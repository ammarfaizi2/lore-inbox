Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263269AbUC3AKq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 19:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbUC3AKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 19:10:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:29859 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263269AbUC3AKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 19:10:40 -0500
Date: Mon, 29 Mar 2004 16:12:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: nagyz@nefty.hu, linux-kernel@vger.kernel.org
Subject: Re: pdflush and dm-crypt
Message-Id: <20040329161248.41e87929.akpm@osdl.org>
In-Reply-To: <20040329150137.GH24370@suse.de>
References: <1067885681.20040329165002@nefty.hu>
	<20040329150137.GH24370@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> On Mon, Mar 29 2004, Zoltan NAGY wrote:
> > Hi!
> > 
> > I've just upgraded the system to 2.6.5-rc2-bk6, and I'm using
> > dm-crypt. It's a heavily used server, on average 20-30mbit/sec
> > traffic is on the wire 7/24, and just noticed, that the load is very
> > high. In every 4-5 sec pdflush takes a lot of cpu... Is this
> > intentional? I've found a similar question on kerneltrap
> > (http://kerneltrap.org/node/view/2756), but havent found a solution
> > yet. I'm just wondering if it is a problem, or it's the normal
> > behavior? It's a 1.8 P4 with 1G ram and highmem enabled, with 256 bit
> > aes thru dm-crypt.
> 
> Try the -mm kernels intead, should have lots better behaviour for
> pdflush/dm interactions.
> 

How come?  Isn't this problem just "gee, we have a lot of stuff to encrypt
during writeback"?  If so, then it should be sufficient to poke a hole in
the encryption loop?

--- 25/drivers/md/dm-crypt.c~a	Mon Mar 29 16:11:49 2004
+++ 25-akpm/drivers/md/dm-crypt.c	Mon Mar 29 16:11:56 2004
@@ -669,6 +669,7 @@ static int crypt_map(struct dm_target *t
 		/* out of memory -> run queues */
 		if (remaining)
 			blk_congestion_wait(bio_data_dir(clone), HZ/100);
+		cond_resched();
 	}
 
 	/* drop reference, clones could have returned before we reach this */

_

