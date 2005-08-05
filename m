Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263031AbVHERtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263031AbVHERtm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 13:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbVHERtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 13:49:42 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:58399 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263031AbVHERtV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 13:49:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GHQXWpkEHyc0UKHXvr8kgDx7CHoLo7yuwiyLOHWzO7EtUjd42pdHvXVLl9lsxCB7UqsfphmexmzfORE/75W4gil7BuSNzwTbF7W4TX4zX3vfHmTYR7tJZOzBhIOCNHnSlQEsKdAMptFg3nwDLOTiJoh5woPsJQ10srgndV27d4U=
Message-ID: <feed8cdd050805104954a07573@mail.gmail.com>
Date: Fri, 5 Aug 2005 10:49:16 -0700
From: Stephen Pollei <stephen.pollei@gmail.com>
Reply-To: Stephen Pollei <stephen.pollei@gmail.com>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] kernel: use kcalloc instead kmalloc/memset
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Pekka J Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org,
       pmarques@grupopie.com, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0508051225270.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1123219747.20398.1.camel@localhost>
	 <20050804223842.2b3abeee.akpm@osdl.org>
	 <Pine.LNX.4.58.0508050925370.27151@sbz-30.cs.Helsinki.FI>
	 <20050804233634.1406e92a.akpm@osdl.org>
	 <Pine.LNX.4.61.0508051132540.3743@scrub.home>
	 <1123235219.3239.46.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0508051202520.3728@scrub.home>
	 <1123236831.3239.55.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0508051225270.3743@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/05, Roman Zippel <zippel@linux-m68k.org> wrote:
> On Fri, 5 Aug 2005, Arjan van de Ven wrote:
> > > This would imply a similiar kmalloc() would be useful as well.
> > > Second, how relevant is it for the kernel?

> > we've had a non-negliable amount of security holes because of this

> So why don't we have a similiar kmalloc()?

You mean something like:

static void __bad_kmalloc_safe_nonconstant_size(void);
static void __bad_kmalloc_safe_zero_size(void);
static void __bad_kmalloc_safe_too_large_size(void);
static void __bad_kmalloc_safe_too_large(void);
static inline void *kmalloc_safe(size_t nmemb, size_t size,int flags) {
        if (!__builtin_constant_p(size))
               __bad_kmalloc_safe_nonconstant_size();
        if ( !size )
                __bad_kmalloc_safe_zero_size();
        if ( size > 0x10000)
                __bad_kmalloc_safe_too_large_size();
        if (__builtin_constant_p(nmemb) && nmemb > 0x20000/size)
                __bad_kmalloc_safe_too_large();
        if (nmemb <= 0x20000/size)
                return kmalloc(nmemb*size,flags);
        else return 0; }


-- 
http://dmoz.org/profiles/pollei.html
http://sourceforge.net/users/stephen_pollei/
http://www.orkut.com/Profile.aspx?uid=2455954990164098214
http://stephen_pollei.home.comcast.net/
