Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946056AbWJSHRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946056AbWJSHRy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 03:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946057AbWJSHRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 03:17:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52871 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946056AbWJSHRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 03:17:53 -0400
Date: Thu, 19 Oct 2006 00:17:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: dmonakhov@openvz.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm:D-cache aliasing issue in cow_user_page
Message-Id: <20061019001747.7da58920.akpm@osdl.org>
In-Reply-To: <20061019.000027.41635681.davem@davemloft.net>
References: <8764ejqp52.fsf@sw.ru>
	<20061018233302.a067d1e7.akpm@osdl.org>
	<20061019.000027.41635681.davem@davemloft.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006 00:00:27 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> > >   1452                  if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE))
> > >   1453                          memset(kaddr, 0, PAGE_SIZE);
> > >   1454                  kunmap_atomic(kaddr, KM_USER0);
> > >   #### D-cache have to be flushed here.
> > >   #### It seems it is just forgotten.
> > > 
> > >   1455                  return;
> > >   1456                  
> > >   1457          }
> > >   1458          copy_user_highpage(dst, src, va);
> > >   #### Ok here. flush_dcache_page() called from this func if arch need it 
> > >   1459  }
> > > 
> > 
> > This page has just been allocated and is private to the caller - there can
> > be no userspace mappings of it.
> 
> Unfortunately, the kernel has just touched the page and thus there are
> active cache lines for the kernel side mapping.  When we map this into
> user space, userspace might see stale cachelines instead of the
> memset() stores.

hm.  Has it always been that way or did something change?

> Architectures typically take care of this in copy_user_page() and
> clear_user_page().  The absolutely depend upon those two routines
> being used for anonymous pages, and handle the D-cache issues there.

Only anonymous pages?  There are zillions of places where we modify
pagecache without a flush, especially against the blockdev mapping (fs
metadata).

> But this code is going outside of that scope, and therefore needs
> an explicit D-cache flush.

OK, I'll add the patch.
