Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbVAUDpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbVAUDpY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 22:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVAUDpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 22:45:24 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:2442 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262256AbVAUDpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 22:45:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=unpgQvQPo4daWJL83b9Kc203QbP/Dm7mfp6jRgNd9m7W6x460G+YJRKlwYZ29d7qQesk4mq9nL3RIv11xDr5xOaU7B3Xm/w+7WBPStG8d/gm+mvZ5JYDT4o+tXvMzXuZvuyjMCenawdF/0MTHz4rRwLGaVDEeVe1tgOBMsgOYes=
Message-ID: <73e6204505012019454372f6e3@mail.gmail.com>
Date: Fri, 21 Jan 2005 11:45:13 +0800
From: zhan rongkai <zhanrk@gmail.com>
Reply-To: zhan rongkai <zhanrk@gmail.com>
To: zhan rongkai <zhanrk@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: fix the bug of __free_pages() of mm/page_alloc.c
In-Reply-To: <73e6204505012019406cf47f04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <73e62045050120053463b7e763@mail.gmail.com>
	 <20050120143133.A13242@flint.arm.linux.org.uk>
	 <73e62045050120193214c1abf7@mail.gmail.com>
	 <73e6204505012019406cf47f04@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.6.10.orig/mm/page_alloc.c	2004-12-25 05:33:51.000000000 +0800
+++ linux-2.6.10/mm/page_alloc.c	2005-01-21 11:46:58.000000000 +0800
@@ -788,7 +788,22 @@
 
 fastcall void __free_pages(struct page *page, unsigned int order)
 {
-	if (!PageReserved(page) && put_page_testzero(page)) {
+	if (!PageReserved(page)) {
+#ifdef CONFIG_MMU
+		if (!put_page_testzero(page))
+			return;
+#else
+		int i, result = 1;
+
+		/*
+		 * We need to de-reference all the pages for this order -- see
set_page_refs()
+		 */
+		for (i = 0; i < (1 << order); i++)
+			result &= put_page_testzero(page+i);
+		if (!result)
+			BUG();
+#endif /* CONFIG_MMU */
+
 		if (order == 0)
 			free_hot_page(page);
 		else


On Fri, 21 Jan 2005 11:40:52 +0800, zhan rongkai <zhanrk@gmail.com> wrote:
> --- linux-2.6.10.orig/mm/page_alloc.c   2004-12-25 05:33:51.000000000 +0800
> +++ linux-2.6.10/mm/page_alloc.c        2005-01-21 11:43:44.000000000 +0800
> @@ -788,7 +788,22 @@
> 
>  fastcall void __free_pages(struct page *page, unsigned int order)
>  {
> -       if (!PageReserved(page) && put_page_testzero(page)) {
> +       if (!PageReserved(page)) {
> +#ifdef CONFIG_MMU
> +               if (!put_page_testzero(page))
> +                       return;
> +#else
> +               int i, result = 1;
> +
> +               /*
> +                * We need to de-reference all the pages for this order -- see
> set_page_refs()
> +                */
> +                for (i = 0; i < (1 << order); i++)
> +                        result &= put_page_testzero(page+i);
> +                if (!result)
> +                        BUG();
> +#endif /* CONFIG_MMU */
> +
>                 if (order == 0)
>                         free_hot_page(page);
>                 else
> 
> --
> Rongkai Zhan
> 


-- 
Rongkai Zhan
