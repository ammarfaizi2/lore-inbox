Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265581AbTL3Hvu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 02:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265614AbTL3Hvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 02:51:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:33459 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265581AbTL3Hvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 02:51:48 -0500
Date: Mon, 29 Dec 2003 23:51:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] optimize ia32 memmove
Message-Id: <20031229235158.755e026c.akpm@osdl.org>
In-Reply-To: <3FF129F9.7080703@pobox.com>
References: <200312300713.hBU7DGC4024213@hera.kernel.org>
	<3FF129F9.7080703@pobox.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Linux Kernel Mailing List wrote:
> > ChangeSet 1.1496.22.32, 2003/12/29 21:45:30-08:00, akpm@osdl.org
> > 
> > 	[PATCH] optimize ia32 memmove
> > 	
> > 	From: Manfred Spraul <manfred@colorfullife.com>
> > 	
> > 	The memmove implementation of i386 is not optimized: it uses movsb, which is
> > 	far slower than movsd.  The optimization is trivial: if dest is less than
> > 	source, then call memcpy().  markw tried it on a 4xXeon with dbt2, it saved
> > 	around 300 million cpu ticks in cache_flusharray():
> [...]
> > diff -Nru a/include/asm-i386/string.h b/include/asm-i386/string.h
> > --- a/include/asm-i386/string.h	Mon Dec 29 23:13:20 2003
> > +++ b/include/asm-i386/string.h	Mon Dec 29 23:13:20 2003
> > @@ -299,14 +299,9 @@
> >  static inline void * memmove(void * dest,const void * src, size_t n)
> >  {
> >  int d0, d1, d2;
> > -if (dest<src)
> > -__asm__ __volatile__(
> > -	"rep\n\t"
> > -	"movsb"
> > -	: "=&c" (d0), "=&S" (d1), "=&D" (d2)
> > -	:"0" (n),"1" (src),"2" (dest)
> > -	: "memory");
> > -else
> > +if (dest<src) {
> > +	memcpy(dest,src,n);
> > +} else
> >  __asm__ __volatile__(
> >  	"std\n\t"
> >  	"rep\n\t"
> 
> Dumb question, though...   what about the overlap case, when dest<src ? 
>   It seems to me this change is ignoring that.
> 

"if dest is less that source, then call memcpy".  If the move is to a
higher address we do it the old way.

