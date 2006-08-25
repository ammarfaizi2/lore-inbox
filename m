Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWHYRwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWHYRwV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 13:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWHYRwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 13:52:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60635 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751138AbWHYRwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 13:52:21 -0400
Date: Fri, 25 Aug 2006 10:50:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrey Savochkin <saw@sw.ru>
Cc: Kirill Korotaev <dev@sw.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, devel@openvz.org,
       Rik van Riel <riel@redhat.com>, Andi Kleen <ak@suse.de>,
       Greg KH <greg@kroah.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       Matt Helsley <matthltc@us.ibm.com>, Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: BC: resource beancounters (v2)
Message-Id: <20060825105047.5ab693a0.akpm@osdl.org>
In-Reply-To: <20060825203026.A16221@castle.nmd.msu.ru>
References: <44EC31FB.2050002@sw.ru>
	<20060823100532.459da50a.akpm@osdl.org>
	<44EEE3BB.10303@sw.ru>
	<20060825073003.e6b5ae16.akpm@osdl.org>
	<20060825203026.A16221@castle.nmd.msu.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2006 20:30:26 +0400
Andrey Savochkin <saw@sw.ru> wrote:

> On Fri, Aug 25, 2006 at 07:30:03AM -0700, Andrew Morton wrote:
> > 
> > D) Virtual scan of mm's in the over-limit container
> > 
> > E) Modify existing physical scanner to be able to skip pages which
> >    belong to not-over-limit containers.
> 
> I've actually tried (E), but it didn't work as I wished.
> 
> It didn't handle well shared pages.
> Then, in my experiments such modified scanner was unable to regulate
> quality-of-service.  When I ran 2 over-the-limit containers, they worked
> equally slow regardless of their limits and work set size.
> That is, I didn't observe a smooth transition "under limit, maximum
> performance" to "slightly over limit, a bit reduced performance" to
> "significantly over limit, poor performance".  Neither did I see any fairness
> in how containers got penalized for exceeding their limits.
> 
> My explanation of what I observed is that
>  - since filesystem caches play a huge role in performance, page scanner will
>    be very limited in controlling container's performance if caches
>    stay shared between containers,
>  - in the absence of decent disk I/O manager, stalls due to swapin/swapout
>    are more influenced by disk subsystem than by page scanner policy.
> So in fact modified page scanner provides control over memory usage only as
> "stay under limits or die", and doesn't show many advantages over (B) or (C).
> At the same time, skipping pages visibly penalizes "good citizens", not only
> in disk bandwidth but in CPU overhead as well.
> 
> So I settled for (A)-(C) for now.
> But it certainly would be interesting to hear if someone else makes such
> experiments.
> 

Makes sense.  If one is looking for good machine partitioning then a shared
disk is obviously a great contention point.  To address that we'd need to
be able to say "container A swaps to /dev/sda1 and container B swaps to
/dev/sdb1".  But the swap system at present can't do that.

