Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbUC3KIM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 05:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbUC3KIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 05:08:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:39892 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263598AbUC3KIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 05:08:07 -0500
Date: Tue, 30 Mar 2004 02:07:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christophe Saout <christophe@saout.de>
Cc: axboe@suse.de, nagyz@nefty.hu, linux-kernel@vger.kernel.org
Subject: Re: pdflush and dm-crypt
Message-Id: <20040330020756.20705731.akpm@osdl.org>
In-Reply-To: <1080639971.7152.7.camel@leto.cs.pocnet.net>
References: <1067885681.20040329165002@nefty.hu>
	<20040329150137.GH24370@suse.de>
	<20040329161248.41e87929.akpm@osdl.org>
	<1080639971.7152.7.camel@leto.cs.pocnet.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout <christophe@saout.de> wrote:
>
> Am Mo, den 29.03.2004, um 16:12 Uhr -0800, schrieb Andrew Morton:
> 
>  > How come?  Isn't this problem just "gee, we have a lot of stuff to encrypt
>  > during writeback"?  If so, then it should be sufficient to poke a hole in
>  > the encryption loop?
>  > 
>  > --- 25/drivers/md/dm-crypt.c~a	Mon Mar 29 16:11:49 2004
>  > +++ 25-akpm/drivers/md/dm-crypt.c	Mon Mar 29 16:11:56 2004
>  > @@ -669,6 +669,7 @@ static int crypt_map(struct dm_target *t
>  >  		/* out of memory -> run queues */
>  >  		if (remaining)
>  >  			blk_congestion_wait(bio_data_dir(clone), HZ/100);
>  > +		cond_resched();
>  >  	}
>  >  
>  >  	/* drop reference, clones could have returned before we reach this */
> 
>  cryptoapi always does this after every block. It also happens with
>  preemption enabled. I got feedback from a person who said that renicing
>  pdflush to 0 helped. So it looks like the CPU scheduler doesn't want to
>  schedule pdflush away. Hmm.

Oh, OK, since pdflush was converted to use the kthread stuff it has been
running at keventd's `nice -10'.  You can probably renice it by hand.



diff -puN mm/pdflush.c~pdflush-nice-0 mm/pdflush.c
--- 25/mm/pdflush.c~pdflush-nice-0	2004-03-30 01:59:17.795116816 -0800
+++ 25-akpm/mm/pdflush.c	2004-03-30 02:02:29.865917616 -0800
@@ -177,6 +177,12 @@ static int __pdflush(struct pdflush_work
 static int pdflush(void *dummy)
 {
 	struct pdflush_work my_work;
+
+	/*
+	 * pdflush can spend a lot of time doing encryption via dm-crypt.  We
+	 * don't want to do that at keventd's priority.
+	 */
+	set_user_nice(current, 0);
 	return __pdflush(&my_work);
 }
 

_

