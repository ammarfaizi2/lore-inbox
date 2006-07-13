Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030414AbWGMVrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414AbWGMVrE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 17:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbWGMVrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 17:47:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14802 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030414AbWGMVrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 17:47:02 -0400
Date: Thu, 13 Jul 2006 14:43:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: arjan@infradead.org, mingo@elte.hu, zach.brown@oracle.com,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert idr's internal locking to _irqsave variant
Message-Id: <20060713144341.97d4f771.akpm@osdl.org>
In-Reply-To: <adau05lrzdy.fsf@cisco.com>
References: <44B405C8.4040706@oracle.com>
	<adawtajzra5.fsf@cisco.com>
	<44B433CE.1030103@oracle.com>
	<adasll7zp0p.fsf@cisco.com>
	<20060712093820.GA9218@elte.hu>
	<adaveq2v9gn.fsf@cisco.com>
	<20060712183049.bcb6c404.akpm@osdl.org>
	<adau05ltsso.fsf@cisco.com>
	<20060713135446.5e2c6dd5.akpm@osdl.org>
	<adau05lrzdy.fsf@cisco.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006 14:03:21 -0700
Roland Dreier <rdreier@cisco.com> wrote:

>  > I suspect it'll get really ugly.  It's a container library which needs to
>  > allocate memory when items are added, like the radix-tree.  Either it needs
>  > to assume GFP_ATOMIC, which is bad and can easily fail or it does weird
>  > things like radix_tree_preload().
> 
> Actually I don't think it has to be too bad.  We could tweak the
> interface a little bit so that consumers do something like:
> 
> 	struct idr_layer *layer = NULL;	/* opaque */
> 
> retry:
>         spin_lock(&my_idr_lock);
> 	ret = idr_get_new(&my_idr, ptr, &id, layer);
>         spin_unlock(&my_idr_lock);
> 
>         if (ret == -EAGAIN) {
> 		layer = idr_alloc_layer(&my_idr, GFP_KERNEL);
> 		if (!IS_ERR(layer))
> 			goto retry;
> 	}
> 
> in other words make the consumer responsible for passing in new memory
> that can be used for a new entry (or freed if other entries have
> become free in the meantime).
> 

Good point, a try-again loop would work.  Do we really need the caller to
maintain a cache?  I suspect something like

drat:
	if (idr_pre_get(GFP_KERNEL) == ENOMEM)
		give_up();
	spin_lock();
	ret = idr_get_new();
	spin_unlock();
	if (ret == ENOMEM)
		goto drat;

would do it.
