Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263589AbUC3JqZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 04:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbUC3JqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 04:46:25 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:17296 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S263589AbUC3JqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 04:46:23 -0500
Subject: Re: pdflush and dm-crypt
From: Christophe Saout <christophe@saout.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, nagyz@nefty.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20040329161248.41e87929.akpm@osdl.org>
References: <1067885681.20040329165002@nefty.hu>
	 <20040329150137.GH24370@suse.de>  <20040329161248.41e87929.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1080639971.7152.7.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Tue, 30 Mar 2004 11:46:11 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, den 29.03.2004, um 16:12 Uhr -0800, schrieb Andrew Morton:

> How come?  Isn't this problem just "gee, we have a lot of stuff to encrypt
> during writeback"?  If so, then it should be sufficient to poke a hole in
> the encryption loop?
> 
> --- 25/drivers/md/dm-crypt.c~a	Mon Mar 29 16:11:49 2004
> +++ 25-akpm/drivers/md/dm-crypt.c	Mon Mar 29 16:11:56 2004
> @@ -669,6 +669,7 @@ static int crypt_map(struct dm_target *t
>  		/* out of memory -> run queues */
>  		if (remaining)
>  			blk_congestion_wait(bio_data_dir(clone), HZ/100);
> +		cond_resched();
>  	}
>  
>  	/* drop reference, clones could have returned before we reach this */

cryptoapi always does this after every block. It also happens with
preemption enabled. I got feedback from a person who said that renicing
pdflush to 0 helped. So it looks like the CPU scheduler doesn't want to
schedule pdflush away. Hmm.


