Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVCJEOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVCJEOt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 23:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVCJEMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 23:12:45 -0500
Received: from fire.osdl.org ([65.172.181.4]:40840 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261172AbVCJEKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 23:10:10 -0500
Date: Wed, 9 Mar 2005 20:09:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Direct io on block device has performance regression on 2.6.x
 kernel
Message-Id: <20050309200936.0b1bea9e.akpm@osdl.org>
In-Reply-To: <200503100347.j2A3lRg28975@unix-os.sc.intel.com>
References: <20050309182550.0291c6fd.akpm@osdl.org>
	<200503100347.j2A3lRg28975@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> Andrew Morton wrote Wednesday, March 09, 2005 6:26 PM
> > What does "1/3 of the total benchmark performance regression" mean?  One
> > third of 0.1% isn't very impressive.  You haven't told us anything at all
> > about the magnitude of this regression.
> 
> 2.6.9 kernel is 6% slower compare to distributor's 2.4 kernel (RHEL3).  Roughly
> 2% came from storage driver (I'm not allowed to say anything beyond that, there
> is a fix though).

The codepaths are indeed longer in 2.6.

> 2% came from DIO.

hm, that's not a lot.

Once you redo that patch to use aops and to work with O_DIRECT, the paths
will get a little deeper, but not much.  We really should do this so that
O_DIRECT works, and in case someone has gone and mmapped the blockdev.

Fine-grained alignment is probably too hard, and it should fall back to
__blockdev_direct_IO().

Does it do the right thing with a request which is non-page-aligned, but
512-byte aligned?

readv and writev?

2% is pretty thin :(

> The rest of 2% is still unaccounted for.  We don't know where.

General cache replacement, perhaps.  9MB is a big cache though.

> ...
> Around 2.6.5, we found global plug list is causing huge lock contention on
> 32-way numa box.  That got fixed in 2.6.7.  Then comes 2.6.8 which took a big
> dip at close to 20% regression.  Then we fixed 17% regression in the scheduler
> (fixed with cache_decay_tick).  2.6.9 is the last one we measured and it is 6%
> slower.  It's a constant moving target, a wild goose to chase.
> 

OK.  Seems that the 2.4 O(1) scheduler got it right for that machine.

> haven't got a chance to run transaction processing db workload on 2.6 kernel.
> Perhaps they have not compared, perhaps they are working on the same problem.
> I just don't know.

Maybe there are other factors which drown these little things out:
architecture improvements, choice of architecture, driver changes, etc.

