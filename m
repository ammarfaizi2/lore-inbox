Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbUFSAlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUFSAlZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 20:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUFRUjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:39:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:14258 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263851AbUFRUiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:38:05 -0400
Date: Fri, 18 Jun 2004 13:40:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, linux-mm@kvack.org
Subject: Re: [PATCH]: Option to run cache reap in thread mode
Message-Id: <20040618134045.2b7ce5c5.akpm@osdl.org>
In-Reply-To: <20040618143332.GA11056@sgi.com>
References: <40D08225.6060900@colorfullife.com>
	<20040616180208.GD6069@sgi.com>
	<40D09872.4090107@colorfullife.com>
	<20040617131031.GB8473@sgi.com>
	<20040617214035.01e38285.akpm@osdl.org>
	<20040618143332.GA11056@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitri Sivanich <sivanich@sgi.com> wrote:
>
> At the time of the holdoff (the point where we've spent a total of 30 usec in
> the timer_interrupt), we've looped through more than 100 of the 131 caches,
> usually closer to 120.

ahh, ooh, ow, of course.

Manfred, we need a separate list of "slabs which might need reaping".

That'll help the average case.  To help the worst case we should change
cache_reap() to only reap (say) ten caches from the head of the new list
and to then return.  Maybe increase the timer frequency too.

something like:

/*
 * FIFO list of caches (via kmem_cache_t.reap_list) which need consideration in
 * cache_reap().  Protected by cache_chain_sem.
 */
static LIST_HEAD(global_reap_list);

cache_reap()
{
	for (i = 0; i < 10; i++) {
		if (list_empty(&global_reap_list))
			break;
		cachep = list_entry(&global_reap_list, kmem_cache_t, reap_list);
		list_del_init(&cachep->reap_list);
		<prune it>
	}
}

mark_cache_for_reaping(kmem_cach_t *cachep)
{
	if (list_empty(&cachep->reap_list)) {
		if (!down_trylock(&cache_chain_sem)) {
			list_add(&cachep->reap_list, &global_reap_list);
			up(&cache_chain_sem);
	}
}

Maybe cache_chain_sem should become a spinlock.
