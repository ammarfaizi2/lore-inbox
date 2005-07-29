Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262544AbVG2JTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbVG2JTW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 05:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbVG2JTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 05:19:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12246 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262544AbVG2JSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 05:18:35 -0400
Date: Fri, 29 Jul 2005 02:17:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab.c : prefetchw the start of new allocated
 objects
Message-Id: <20050729021722.2e6903e2.akpm@osdl.org>
In-Reply-To: <42E9F145.7040302@cosmosbay.com>
References: <42E6C8DB.4090608@earthlink.net>
	<s5hr7dklko4.wl%tiwai@suse.de>
	<42E7A8D8.1030809@earthlink.net>
	<20050729014150.6e97dfd2.akpm@osdl.org>
	<42E9F145.7040302@cosmosbay.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> wrote:
>
> Most of objects returned by __cache_alloc() will be written by the caller,
>  (but not all callers want to write all the object, but just at the begining)
>  prefetchw() tells the modern CPU to think about the future writes, ie start
>  some memory transactions in advance.

Sounds sensible enough..  slab does try to make sure it returns the
most-recently-freed object, so it's probably in cache already.  But in the
situation where we're allocating and using a lot of objects in succession
it might help.


>  Some CPU lacks a prefetchw() and currently do nothing, so I ask this question :
>  Should'nt make prefetchw() do at least a prefetch() ? A read hint is better than nothing.

Don't think so.  I was once told that if the cacheline is in local cache
for reading and the CPU decides to write to it, additional work is needed
for the write so the prefetch-for-read didn't buy you anything.
