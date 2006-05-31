Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbWEaNjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWEaNjW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 09:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbWEaNjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 09:39:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:12075 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964994AbWEaNjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 09:39:21 -0400
Date: Wed, 31 May 2006 15:41:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mason@suse.com, andrea@suse.de, hugh@veritas.com
Subject: Re: [rfc][patch] remove racy sync_page?
Message-ID: <20060531134125.GQ29535@suse.de>
References: <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org> <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org> <447BD31E.7000503@yahoo.com.au> <447BD63D.2080900@yahoo.com.au> <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org> <447CE43A.6030700@yahoo.com.au> <Pine.LNX.4.64.0605301739030.24646@g5.osdl.org> <447D9A41.8040601@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447D9A41.8040601@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31 2006, Nick Piggin wrote:
> Now having a mechanism for a task to batch up requests might be a
> good idea. Eg.
> 
> plug();
> submit reads
> unplug();
> wait for page

How's this different from what we have now? The plugging will happen
implicitly, if we need to. If the queue is already running, chances are
that there are requests there so you won't get to your first read first
anyways.

The unplug(); wait_for_page(); is already required unless you want to
wait for the plugging to time out (unlikely, since you are now waiting
for io completion on one of them).

> I'd think this would give us the benefits of corse grained (per-queue)
> plugging and more (e.g. it works when the request queue isn't empty).
> And it would be simpler because the unplug point is explicit and doesn't
> need to be kicked by lock_page or wait_on_page

I kind of like having the implicit unplug, for several reasons. One is
that people forget to unplug. We had all sorts of hangs there in 2.4 and
earlier because of that. Making the plugging implicit should help that
though. The other is that I don't see what the explicit unplug gains
you. Once you start waiting for one of the pages submitted, that is
exactly the point where you want to unplug in the first place.

-- 
Jens Axboe

