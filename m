Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUFSUF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUFSUF3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 16:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264627AbUFSUF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 16:05:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:19105 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263736AbUFSUFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 16:05:17 -0400
Date: Sat, 19 Jun 2004 13:04:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: frankvm@xs4all.nl, sdake@mvista.com, liste@jordet.nu,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: [2.4] page->buffers vanished in journal_try_to_free_buffers()
Message-Id: <20040619130409.6f3a5f8e.akpm@osdl.org>
In-Reply-To: <20040619194849.GA2843@logos.cnet>
References: <1075832813.5421.53.camel@chevrolet.hybel>
	<Pine.LNX.4.58L.0402052139420.16422@logos.cnet>
	<1078225389.931.3.camel@buick.jordet>
	<1087232825.28043.4.camel@persist.az.mvista.com>
	<20040615131650.GA13697@logos.cnet>
	<1087322198.8117.10.camel@persist.az.mvista.com>
	<20040617131600.GB3029@logos.cnet>
	<20040617200859.7fada9fe.akpm@osdl.org>
	<20040619194849.GA2843@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> Maybe adding this (untested) to v2.4 mainline helps? Comments?

It would be helpful.

>  --- transaction.c.orig	2004-06-19 15:21:32.861148560 -0300
>  +++ transaction.c	2004-06-19 15:23:18.214132472 -0300
>  @@ -1694,6 +1694,24 @@
>   	return 0;
>   }
>   
>  +void debug_page(struct page *p)
>  +{
>  +	struct buffer_head *bh;
>  +
>  +	bh = p->buffers;
>  +
>  +	printk(KERN_ERR "%s: page index:%u count:%d flags:%x\n", __FUNCTION__,
>  +		,p->index , atomic_read(&p->count), p->flags);

                ^

>  +
>  +	do {
>  +		printk(KERN_ERR "%s: bh b_next:%p blocknr:%u b_list:%u state:%x\n",
>  +			__FUNCTION__, bh->b_next, bh->b_blocknr, bh->b_list,
>  +				bh->b_state);
>  +		bh = bh->b_this_page;
>  +	} while (bh);
>  +}
>  +

you'll want to make this a while (!bh) {} loop, to handle the
page->buffers==NULL case.

