Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbUCRS0a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 13:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbUCRS0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 13:26:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:52154 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262846AbUCRS0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 13:26:21 -0500
Date: Thu, 18 Mar 2004 10:26:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: mjy@geizhals.at, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-Id: <20040318102623.04e4fadb.akpm@osdl.org>
In-Reply-To: <20040318175855.GB2536@dualathlon.random>
References: <40591EC1.1060204@geizhals.at>
	<20040318060358.GC29530@dualathlon.random>
	<20040318015004.227fddfb.akpm@osdl.org>
	<20040318145129.GA2246@dualathlon.random>
	<20040318093902.3513903e.akpm@osdl.org>
	<20040318175855.GB2536@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> > They do?   kmap_atomic() disables preemption anyway.
> 
> dunno why but see:
> 
> 	spin_lock(&mm->page_table_lock);
> 	page_table = pte_offset_map(pmd, address);
> 
> 		pte_unmap(page_table);
> 		spin_unlock(&mm->page_table_lock);
> 

do_wp_page()?  The lock is there to pin the pte down isn't it?  Maybe it
can be optimised - certainly the spin_unlock() in there can be moved up a
few statements.

> Infact I wonder if we should try once more time and go atomic
> again. what you're doing right now is:
> 
> 	kmap_atomic()
> 	left = copy_user
> 	kunmap_atomic
> 	if (left) {
> 		kmap() <- persistent unscalable
> 		copy-user
> 		kunmap
> 	}
> 		
> I would suggest we should be even more aggressive like this:
> 
>         kmap_atomic()
>         left = copy_user
>         kunmap_atomic
>         if (left) {
> 		get_user()
>         	kmap_atomic()
> 	        left = copy_user
> 	        kunmap_atomic
> 		if (left) {
> 	                kmap() <- persistent unscalable
>         	        copy-user
>                 	kunmap
> 		}
>         }
> 
> 
> It's not going to trigger often anyways, but it's only a few bytecodes
> more and it sounds more scalable.

Could be.  When I did that code I had some printks in the slow path and
although it did trigger, it was rare.  We've already faulted the page in by
hand so we should only fall into the kmap() if the page was suddenly stolen
again.

But it was a long time ago - adding some instrumentation here to work out
how often we enter the slow path would tell us whether this is needed.
