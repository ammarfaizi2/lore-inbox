Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262742AbVAFF64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbVAFF64 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 00:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVAFF64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 00:58:56 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:14921
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262742AbVAFF6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 00:58:53 -0500
Date: Thu, 6 Jan 2005 06:59:05 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, riel@redhat.com, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
Message-ID: <20050106055905.GT4597@dualathlon.random>
References: <41DCB577.9000205@yahoo.com.au> <20050105202611.65eb82cf.akpm@osdl.org> <41DCC014.80007@yahoo.com.au> <20050105204706.0781d672.akpm@osdl.org> <20050106045932.GN4597@dualathlon.random> <20050105210539.19807337.akpm@osdl.org> <20050106051707.GP4597@dualathlon.random> <41DCCA68.3020100@yahoo.com.au> <20050106052507.GR4597@dualathlon.random> <20050105213704.0282316f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050105213704.0282316f.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 09:37:04PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > 2) we won't need unreliable anti-deadlock timeouts anymore
> 
> The timeouts are for:
> 
> a) A fallback for backing stores which don't wake up waiters in
>    blk_congestion_wait() (eg: NFS).

that anti-deadlock will be unnecessary too with the new logic.

> b) handling the race case where the request queue suddenly goes empty
>    before the sleeper gets onto the waitqueue.

as I mentioned with proper locking setting task in uninterruptible and
then registering into the new per classzone waitqueue, the timeout will
be unnecessary even for this.

> It can probably be removed with some work, and additional locking.

The additional locking will then remove the current locking in
blk_congestion_wait so it's new locking but it will replace the current
locking. But I agree registering in the waitqueue inside the
blk_congestion_wait was simpler. It's just I've an hard time to like the
timeout.  Timeout is always wrong when it triggers: if it triggers it
always triggers either too late (wasted resources) or too early (early
oom kills). So unless it messes everything up, it'd be nice to the
locking strict. anyway point 1 and 2 can be implemented separately, at
first we can leave the timeout if the race is too hard to handle. 

Ideally if we keep the total number of oustanding writebacks
per-classzone (not sure if we account for it already somewhere, I guess
if something we've the global number and not the per-classzone one), we
could remove the timeout without having to expose the locking outside
blk_congestion_wait. With the number of oustanding writebacks
per-classzone we could truly fix the race and obsolete the timeout in a
self contained manner. Though it will require a proper amount of memory
barriers around the account increment/decrement/read.
