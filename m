Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261433AbSKFJ2U>; Wed, 6 Nov 2002 04:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261450AbSKFJ2U>; Wed, 6 Nov 2002 04:28:20 -0500
Received: from packet.digeo.com ([12.110.80.53]:36018 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261433AbSKFJ2T>;
	Wed, 6 Nov 2002 04:28:19 -0500
Message-ID: <3DC8E23A.2578323F@digeo.com>
Date: Wed, 06 Nov 2002 01:34:50 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: Re: [PATCH] Convert NFS client to use ->readpages()
References: <shssmyfe8nt.fsf@charged.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2002 09:34:50.0594 (UTC) FILETIME=[C1083C20:01C28577]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> 
> +int
> +nfs_readpages(struct file *filp, struct address_space *mapping,
> +               struct list_head *pages, unsigned nr_pages)
> +{
> +       LIST_HEAD(head);
> +       struct nfs_readdesc desc = {
> +               .filp           = filp,
> +               .head           = &head,
> +       };
> +       struct nfs_server *server = NFS_SERVER(mapping->host);
> +       int is_sync = server->rsize < PAGE_CACHE_SIZE;
> +       int ret;
> +
> +       ret = read_cache_pages(mapping, pages,
> +                              is_sync ? readpage_sync_filler :
> +                                        readpage_async_filler,
> +                              &desc);
> +       if (!list_empty(pages)) {
> +               struct page *page = list_entry(pages->prev, struct page, list);
> +               list_del(&page->list);
> +               page_cache_release(page);
> +       }

What are the above few lines doing?  Looks odd.

Or should it be

	while (!list_empty(...))

?

> +       if (!list_empty(&head)) {
> +               int err = nfs_pagein_list(&head, server->rpages);
> +               if (!ret)
> +                       ret = err;
> +       }
> +       return ret;
> +}
> +
