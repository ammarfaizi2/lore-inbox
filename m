Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWAKVIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWAKVIM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWAKVIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:08:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32467 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964853AbWAKVIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:08:09 -0500
Date: Wed, 11 Jan 2006 13:07:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, sct@redhat.com, mingo@elte.hu
Subject: Re: 2.6.15-git7 oopses in ext3 during LTP runs
Message-Id: <20060111130728.579ab429.akpm@osdl.org>
In-Reply-To: <1137012917.2929.78.camel@laptopd505.fenrus.org>
References: <200601112126.59796.ak@suse.de>
	<20060111124617.5e7e1eaa.akpm@osdl.org>
	<1137012917.2929.78.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> On Wed, 2006-01-11 at 12:46 -0800, Andrew Morton wrote:
> > Andi Kleen <ak@suse.de> wrote:
> > >
> > > 
> > > Running LTP with the default runfile on a 4 virtual CPU x86-64 
> > > system gives
> > > 
> > > To reproduce: run ltp 20040908 (newer one will probably work
> > > too) with runltp -p -q -l `uname -r` on a ext3 file system
> > > 
> > > config is x86-64 defconfig.
> > > 
> > 
> > mutex_trylock() is returning the wrong value.  fs/super.c:write_super()
> > clearly took the lock.
> 
> 
> the conversion is buggy.
> 
> mutex_trylock has the same convention as spin_try_lock (which is the
> opposite of down_trylock). THe conversion forgot to add a !
> 
> --- linux-2.6.15/fs/ext3/super.c~	2006-01-11 21:54:13.000000000 +0100
> +++ linux-2.6.15/fs/ext3/super.c	2006-01-11 21:54:13.000000000 +0100
> @@ -2150,7 +2150,7 @@
>  
>  static void ext3_write_super (struct super_block * sb)
>  {
> -	if (mutex_trylock(&sb->s_lock) != 0)
> +	if (!mutex_trylock(&sb->s_lock) != 0)
>  		BUG();
>  	sb->s_dirt = 0;
>  }

We expect the lock to be held on entry.  Hence we expect mutex_trylock()
to return zero.
