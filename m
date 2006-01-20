Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422710AbWATBSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422710AbWATBSj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 20:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030454AbWATBSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 20:18:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40633 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030453AbWATBSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 20:18:38 -0500
Date: Thu, 19 Jan 2006 17:20:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shrink_list: Use of && instead || leads to unintended
 writing of pages
Message-Id: <20060119172032.04bad017.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0601191648440.13602@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0601191602260.13428@schroedinger.engr.sgi.com>
	<20060119164341.0fb9c7e3.akpm@osdl.org>
	<Pine.LNX.4.62.0601191648440.13602@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> On Thu, 19 Jan 2006, Andrew Morton wrote:
> 
> > The effects of this fix will be a) slightly improved memory allocator
> > latency, b) somehat improved disk writeout patterns and c) somewhat
> > increased risk of ooms.
> 
> If we do not operate in laptop mode and are not using zone_reclaim 
> (!may_writepage) which is the common case then there will be no effect at 
> all.

Ah, I misremembered how the code works.  Your patch will break laptop mode.

They way it works is:

laptop_mode=0: always write out dirty pages which come off the tail of the LRU.

laptop_mode=1: don't write out dirty pages if we're only performing light
scanning.  But do write them out once page reclaim starts getting into
difficulty.

The idea is that in laptop mode we'll avoid spinning up the disk for
occasional random dirty pages which are interspersed amongst a majority of
clean, reclaimable pages.  But once reclaim is getting into trouble, we
need to spin that disk up anyway to clean out some memory.

Your patch means that in laptop moe we'll just never write out these dirty
pages ever - we'll overscan and go oom.


I guess if zone reclaim wants to permanently disable writeback then it'll
be needing a new scan_control flag for that.  Which means that we need to
remember to initialise that flag in lots of different places, which is why
I dislike scan_control.  A (separate, preceding) patch which converts
scan_control initialisation to do memset+initialise-non-zero-members would
be appreciated.


