Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbTDHJM5 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 05:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbTDHJM5 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 05:12:57 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:33156 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S262727AbTDHJM4 (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 05:12:56 -0400
Message-ID: <037e01c2fdb0$a4a5b5b0$5600a8c0@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: "Andrew Morton" <akpm@digeo.com>
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0304071051190.1385-100000@penguin.transmeta.com><035401c2fdac$6e6aa400$5600a8c0@edumazet> <20030408020439.16c8322b.akpm@digeo.com>
Subject: Re: Kernel BUG linux-2.5.67
Date: Tue, 8 Apr 2003 11:24:22 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes... the futex was placed un a hugetlb page...

Thanks Andrew, I will test your patch very soon.

From: "Andrew Morton" <akpm@digeo.com>
> "dada1" <dada1@cosmosbay.com> wrote:
> >
> > Hello
> > 
> > I tried linux-2.5.67 this morning...
> > 
> > instant oops with a small multi-threaded program using futex()
> 
> Was the futex placed inside a hugetlb page?  Please say yes.
> 
> There is a stunning bug.
> 
> --- 25/include/linux/mm.h~a 2003-04-08 02:03:19.000000000 -0700
> +++ 25-akpm/include/linux/mm.h 2003-04-08 02:03:24.000000000 -0700
> @@ -231,8 +231,8 @@ static inline void get_page(struct page 
>  static inline void put_page(struct page *page)
>  {
>   if (PageCompound(page)) {
> + page = (struct page *)page->lru.next;
>   if (put_page_testzero(page)) {
> - page = (struct page *)page->lru.next;
>   if (page->lru.prev) { /* destructor? */
>   (*(void (*)(struct page *))page->lru.prev)(page);
>   } else {
> 
> _
> 
