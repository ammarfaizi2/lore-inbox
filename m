Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161203AbWBTXf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161203AbWBTXf6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 18:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161201AbWBTXf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 18:35:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21124 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161200AbWBTXf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 18:35:56 -0500
Date: Mon, 20 Feb 2006 15:34:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: kiran@scalex86.org, linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [patch] Cache align futex hash buckets
Message-Id: <20060220153419.5ea8dd89.akpm@osdl.org>
In-Reply-To: <20060220153320.793b6a7d.akpm@osdl.org>
References: <20060220233242.GC3594@localhost.localdomain>
	<20060220153320.793b6a7d.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> >
> > Following change places each element of the futex_queues hashtable on a 
> > different cacheline.  Spinlocks of adjacent hash buckets lie on the same 
> > cacheline otherwise.
> > 
> > Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
> > Signed-off-by: Shai Fultheim <shai@scalex86.org>
> > 
> > Index: linux-2.6.16-rc2/kernel/futex.c
> > ===================================================================
> > --- linux-2.6.16-rc2.orig/kernel/futex.c	2006-02-07 23:14:04.000000000 -0800
> > +++ linux-2.6.16-rc2/kernel/futex.c	2006-02-09 14:04:22.000000000 -0800
> > @@ -100,9 +100,10 @@ struct futex_q {
> >  struct futex_hash_bucket {
> >         spinlock_t              lock;
> >         struct list_head       chain;
> > -};
> > +} ____cacheline_internodealigned_in_smp;
> >  
> > -static struct futex_hash_bucket futex_queues[1<<FUTEX_HASHBITS];
> > +static struct futex_hash_bucket futex_queues[1<<FUTEX_HASHBITS] 
> > +				__cacheline_aligned_in_smp;
> >  
> 
> How much memory does that thing end up consuming?

I think a megabyte?
