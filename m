Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbUC3GXA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 01:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263280AbUC3GXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 01:23:00 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:12497 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263273AbUC3GW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 01:22:58 -0500
Date: Tue, 30 Mar 2004 08:22:51 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: nagyz@nefty.hu, linux-kernel@vger.kernel.org
Subject: Re: pdflush and dm-crypt
Message-ID: <20040330062251.GM24370@suse.de>
References: <1067885681.20040329165002@nefty.hu> <20040329150137.GH24370@suse.de> <20040329161248.41e87929.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329161248.41e87929.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29 2004, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > On Mon, Mar 29 2004, Zoltan NAGY wrote:
> > > Hi!
> > > 
> > > I've just upgraded the system to 2.6.5-rc2-bk6, and I'm using
> > > dm-crypt. It's a heavily used server, on average 20-30mbit/sec
> > > traffic is on the wire 7/24, and just noticed, that the load is very
> > > high. In every 4-5 sec pdflush takes a lot of cpu... Is this
> > > intentional? I've found a similar question on kerneltrap
> > > (http://kerneltrap.org/node/view/2756), but havent found a solution
> > > yet. I'm just wondering if it is a problem, or it's the normal
> > > behavior? It's a 1.8 P4 with 1G ram and highmem enabled, with 256 bit
> > > aes thru dm-crypt.
> > 
> > Try the -mm kernels intead, should have lots better behaviour for
> > pdflush/dm interactions.
> > 
> 
> How come?  Isn't this problem just "gee, we have a lot of stuff to encrypt
> during writeback"?  If so, then it should be sufficient to poke a hole in
> the encryption loop?

If that is the problem, then yeah that'd work. I was assuming the 'load'
was just io load and pdflush got stuck on them.

> --- 25/drivers/md/dm-crypt.c~a	Mon Mar 29 16:11:49 2004
> +++ 25-akpm/drivers/md/dm-crypt.c	Mon Mar 29 16:11:56 2004
> @@ -669,6 +669,7 @@ static int crypt_map(struct dm_target *t
>  		/* out of memory -> run queues */
>  		if (remaining)
>  			blk_congestion_wait(bio_data_dir(clone), HZ/100);
> +		cond_resched();
>  	}

Reminds me, we have to kill that blk_congestion_wait() stuff too.

-- 
Jens Axboe

