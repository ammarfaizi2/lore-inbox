Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbUA3URU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 15:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbUA3URU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 15:17:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:19909 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263771AbUA3URS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 15:17:18 -0500
Date: Fri, 30 Jan 2004 12:18:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: ioana alexandrescu <ioanamitu@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Redundant uses of might_sleep_if()
Message-Id: <20040130121827.11ced639.akpm@osdl.org>
In-Reply-To: <20040130194057.358.qmail@web60506.mail.yahoo.com>
References: <20040130194057.358.qmail@web60506.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ioana alexandrescu <ioanamitu@yahoo.com> wrote:
>
> In kernel 2.6.1 it appears that the only necessary
> uses of might_sleep_if()are in __alloc_pages(), and
> perhaps, in cache_alloc_debugcheck_before() (see
> notes).
> 
> Other uses of might_sleep_if() appear to be redundant:
> 
> Pte_chain_alloc()-->might_sleep_if(), but also
> Pte_chain_alloc-->kmem_cache_alloc
>   -->__cache_alloc  -->__cache_alloc()
>   -->cache_alloc_debugcheck_before()
>   -->might_sleep_if()
> 
> skb_share_check()-->might_sleep_if(), but also
> skb_share_check()-->skb_clone()
>   -->kmem_cache_alloc()[as above]
> 
> skb_unshare()-->might_sleep_if(), but also
> skb_unshare()-->skb_copy()
>   -->kmem_cache_alloc()[as above]
> 
> Other paths through skb_unshare, same result.
> 
> 
> QUERY: Should these redundant uses be patched out?

Nope.

Take the case of pte_chain_alloc().  Most of the time, it won't call
kmem_cache_alloc() at all.  But sometimes it will.  But we want to run the
might_sleep() check *every* time someone calls pte_chain_alloc(), not just
some of the times.

