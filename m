Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161335AbWJSGfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161335AbWJSGfX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 02:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161337AbWJSGfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 02:35:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16107 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161335AbWJSGfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 02:35:22 -0400
Date: Wed, 18 Oct 2006 23:33:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitriy Monakhov <dmonakhov@openvz.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH] mm:D-cache aliasing issue in cow_user_page
Message-Id: <20061018233302.a067d1e7.akpm@osdl.org>
In-Reply-To: <8764ejqp52.fsf@sw.ru>
References: <8764ejqp52.fsf@sw.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2006 13:15:37 +0400
Dmitriy Monakhov <dmonakhov@openvz.org> wrote:

>  from mm/memory.c:
>   1434  static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va)
>   1435  {
>   1436          /*
>   1437           * If the source page was a PFN mapping, we don't have
>   1438           * a "struct page" for it. We do a best-effort copy by
>   1439           * just copying from the original user address. If that
>   1440           * fails, we just zero-fill it. Live with it.
>   1441           */
>   1442          if (unlikely(!src)) {
>   1443                  void *kaddr = kmap_atomic(dst, KM_USER0);
>   1444                  void __user *uaddr = (void __user *)(va & PAGE_MASK);
>   1445  
>   1446                  /*
>   1447                   * This really shouldn't fail, because the page is there
>   1448                   * in the page tables. But it might just be unreadable,
>   1449                   * in which case we just give up and fill the result with
>   1450                   * zeroes.
>   1451                   */
>   1452                  if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE))
>   1453                          memset(kaddr, 0, PAGE_SIZE);
>   1454                  kunmap_atomic(kaddr, KM_USER0);
>   #### D-cache have to be flushed here.
>   #### It seems it is just forgotten.
> 
>   1455                  return;
>   1456                  
>   1457          }
>   1458          copy_user_highpage(dst, src, va);
>   #### Ok here. flush_dcache_page() called from this func if arch need it 
>   1459  }
> 

This page has just been allocated and is private to the caller - there can
be no userspace mappings of it.
