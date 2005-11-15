Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbVKOFoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbVKOFoz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 00:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbVKOFoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 00:44:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40115 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751332AbVKOFoy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 00:44:54 -0500
Date: Mon, 14 Nov 2005 21:44:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: torvalds@osdl.org, marcelo.tosatti@cyclades.com, kravetz@us.ibm.com,
       raybry@mpdtxmail.amd.com, lee.schermerhorn@hp.com,
       linux-kernel@vger.kernel.org, clameter@sgi.com, magnus.damm@gmail.com,
       pj@sgi.com, haveblue@us.ibm.com, kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 1/5] Swap Migration V5: LRU operations
Message-Id: <20051114214415.1e107c7b.akpm@osdl.org>
In-Reply-To: <20051101031244.12488.38211.sendpatchset@schroedinger.engr.sgi.com>
References: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com>
	<20051101031244.12488.38211.sendpatchset@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
>  +static void lru_add_drain_per_cpu(void *dummy)
>  +{
>  +	lru_add_drain();
>  +}
>  +
>  +/*
>  + * Isolate one page from the LRU lists and put it on the
>  + * indicated list. Do necessary cache draining if the
>  + * page is not on the LRU lists yet.
>  + *
>  + * Result:
>  + *  0 = page not on LRU list
>  + *  1 = page removed from LRU list and added to the specified list.
>  + * -1 = page is being freed elsewhere.
>  + */
>  +int isolate_lru_page(struct page *page)
>  +{
>  +	int rc = 0;
>  +	struct zone *zone = page_zone(page);
>  +
>  +redo:
>  +	spin_lock_irq(&zone->lru_lock);
>  +	rc = __isolate_lru_page(zone, page);
>  +	spin_unlock_irq(&zone->lru_lock);
>  +	if (rc == 0) {
>  +		/*
>  +		 * Maybe this page is still waiting for a cpu to drain it
>  +		 * from one of the lru lists?
>  +		 */
>  +		smp_call_function(&lru_add_drain_per_cpu, NULL, 0 , 1);

lru_add_drain() ends up doing spin_unlock_irq(), so we'll enable interrupts
within the smp_call_function() handler.  Is that legal on all
architectures?

