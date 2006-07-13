Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030327AbWGMU6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030327AbWGMU6J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 16:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbWGMU6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 16:58:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62142 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030327AbWGMU6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 16:58:08 -0400
Date: Thu, 13 Jul 2006 13:54:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: arjan@infradead.org, mingo@elte.hu, zach.brown@oracle.com,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert idr's internal locking to _irqsave variant
Message-Id: <20060713135446.5e2c6dd5.akpm@osdl.org>
In-Reply-To: <adau05ltsso.fsf@cisco.com>
References: <44B405C8.4040706@oracle.com>
	<adawtajzra5.fsf@cisco.com>
	<44B433CE.1030103@oracle.com>
	<adasll7zp0p.fsf@cisco.com>
	<20060712093820.GA9218@elte.hu>
	<adaveq2v9gn.fsf@cisco.com>
	<20060712183049.bcb6c404.akpm@osdl.org>
	<adau05ltsso.fsf@cisco.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006 08:42:47 -0700
Roland Dreier <rdreier@cisco.com> wrote:

>  > Sigh.  It was always a mistake (of the kernel programming 101 type) to put
>  > any locking at all in the idr code.  At some stage we need to weed it all
>  > out and move it to callers.
>  > 
>  > Your fix is yet more fallout from that mistake.
> 
> Agreed.  Consider me on the hook to fix this up in a better way once
> my life is a little saner.  Maybe I'll try to cook something up on the
> plane ride to Ottawa.
> 

I suspect it'll get really ugly.  It's a container library which needs to
allocate memory when items are added, like the radix-tree.  Either it needs
to assume GFP_ATOMIC, which is bad and can easily fail or it does weird
things like radix_tree_preload().

The basic problem is:

	idr_pre_get(GFP_KERNEL);
	spin_lock(my_lock);
	idr_get_new(..);

which is racy, because some other CPU could have got in there and consumed
some of the pool which was precharged by idr_pre_get().

It's wildly improbable that it'll actually fail.  It requires all of:

a) that the race occur

b) that the racing thread consume an appreciable amount of the pool

c) that this thread also consume an appreciable amount (such that the
   total of both exceeds the pool size).

d) that a (needs to be added) GFP_ATOMIC attempt to replenish the pool
   inside idr_get_new() fails.


