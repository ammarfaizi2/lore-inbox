Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWAKV2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWAKV2L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWAKV2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:28:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:64672 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750772AbWAKV2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:28:09 -0500
Subject: Re: 2.6.15-git7 oopses in ext3 during LTP runs
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, sct@redhat.com, mingo@elte.hu
In-Reply-To: <20060111130728.579ab429.akpm@osdl.org>
References: <200601112126.59796.ak@suse.de>
	 <20060111124617.5e7e1eaa.akpm@osdl.org>
	 <1137012917.2929.78.camel@laptopd505.fenrus.org>
	 <20060111130728.579ab429.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 22:27:55 +0100
Message-Id: <1137014875.2929.81.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 15/fs/ext3/super.c~	2006-01-11 21:54:13.000000000 +0100
> > +++ linux-2.6.15/fs/ext3/super.c	2006-01-11 21:54:13.000000000 +0100
> > @@ -2150,7 +2150,7 @@
> >  
> >  static void ext3_write_super (struct super_block * sb)
> >  {
> > -	if (mutex_trylock(&sb->s_lock) != 0)
> > +	if (!mutex_trylock(&sb->s_lock) != 0)
> >  		BUG();
> >  	sb->s_dirt = 0;
> >  }
> 
> We expect the lock to be held on entry.  Hence we expect mutex_trylock()
> to return zero.

you are correct, and the x86-64 mutex.h is buggy

--- linux-2.6.15/include/asm-x86_64/mutex.h.org	2006-01-11 22:25:37.000000000 +0100
+++ linux-2.6.15/include/asm-x86_64/mutex.h	2006-01-11 22:25:43.000000000 +0100
@@ -104,7 +104,7 @@
 static inline int
 __mutex_fastpath_trylock(atomic_t *count, int (*fail_fn)(atomic_t *))
 {
-	if (likely(atomic_cmpxchg(count, 1, 0)) == 1)
+	if (likely(atomic_cmpxchg(count, 1, 0) == 1))
 		return 1;
 	else
 		return 0;

changes the asm to be the correct one for me.
This is odd/evil though..



