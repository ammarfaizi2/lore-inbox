Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161340AbWJSHAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161340AbWJSHAq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 03:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161328AbWJSHAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 03:00:45 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:24201
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1945979AbWJSHAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 03:00:45 -0400
Date: Thu, 19 Oct 2006 00:00:27 -0700 (PDT)
Message-Id: <20061019.000027.41635681.davem@davemloft.net>
To: akpm@osdl.org
Cc: dmonakhov@openvz.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm:D-cache aliasing issue in cow_user_page
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061018233302.a067d1e7.akpm@osdl.org>
References: <8764ejqp52.fsf@sw.ru>
	<20061018233302.a067d1e7.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Wed, 18 Oct 2006 23:33:02 -0700

> On Tue, 17 Oct 2006 13:15:37 +0400
> Dmitriy Monakhov <dmonakhov@openvz.org> wrote:
> 
> >  from mm/memory.c:
> >   1434  static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va)
> >   1435  {
> >   1436          /*
> >   1437           * If the source page was a PFN mapping, we don't have
> >   1438           * a "struct page" for it. We do a best-effort copy by
> >   1439           * just copying from the original user address. If that
> >   1440           * fails, we just zero-fill it. Live with it.
> >   1441           */
> >   1442          if (unlikely(!src)) {
> >   1443                  void *kaddr = kmap_atomic(dst, KM_USER0);
> >   1444                  void __user *uaddr = (void __user *)(va & PAGE_MASK);
> >   1445  
> >   1446                  /*
> >   1447                   * This really shouldn't fail, because the page is there
> >   1448                   * in the page tables. But it might just be unreadable,
> >   1449                   * in which case we just give up and fill the result with
> >   1450                   * zeroes.
> >   1451                   */
> >   1452                  if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE))
> >   1453                          memset(kaddr, 0, PAGE_SIZE);
> >   1454                  kunmap_atomic(kaddr, KM_USER0);
> >   #### D-cache have to be flushed here.
> >   #### It seems it is just forgotten.
> > 
> >   1455                  return;
> >   1456                  
> >   1457          }
> >   1458          copy_user_highpage(dst, src, va);
> >   #### Ok here. flush_dcache_page() called from this func if arch need it 
> >   1459  }
> > 
> 
> This page has just been allocated and is private to the caller - there can
> be no userspace mappings of it.

Unfortunately, the kernel has just touched the page and thus there are
active cache lines for the kernel side mapping.  When we map this into
user space, userspace might see stale cachelines instead of the
memset() stores.

Architectures typically take care of this in copy_user_page() and
clear_user_page().  The absolutely depend upon those two routines
being used for anonymous pages, and handle the D-cache issues there.
But this code is going outside of that scope, and therefore needs
an explicit D-cache flush.

