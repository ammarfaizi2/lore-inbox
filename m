Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932799AbWJINxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932799AbWJINxB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 09:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932823AbWJINxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 09:53:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:19858 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932799AbWJINxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 09:53:00 -0400
Date: Mon, 9 Oct 2006 15:52:54 +0200
From: Nick Piggin <npiggin@suse.de>
To: Thomas Hellstrom <thomas@tungstengraphics.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 3/3] mm: fault handler to replace nopage and populate
Message-ID: <20061009135254.GA19784@wotan.suse.de>
References: <20061009110007.GA3592@wotan.suse.de> <1160392214.10229.19.camel@localhost.localdomain> <20061009111906.GA26824@wotan.suse.de> <1160393579.10229.24.camel@localhost.localdomain> <20061009114527.GB26824@wotan.suse.de> <1160394571.10229.27.camel@localhost.localdomain> <20061009115836.GC26824@wotan.suse.de> <1160395671.10229.35.camel@localhost.localdomain> <20061009121417.GA3785@wotan.suse.de> <452A50C2.9050409@tungstengraphics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452A50C2.9050409@tungstengraphics.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 03:38:10PM +0200, Thomas Hellstrom wrote:
> Nick Piggin wrote:
> >On Mon, Oct 09, 2006 at 10:07:50PM +1000, Benjamin Herrenschmidt wrote:
> >
> >Ok I guess that would work. I was kind of thinking that one needs to
> >hold the mmap_sem for writing when changing the flags, but so long
> >as everyone *else* does, then I guess you can get exclusion from just
> >the read lock. And your per-object mutex would prevent concurrent
> >nopages from modifying it.
> 
> Wouldn't that confuse concurrent readers?

I think it should be safe so long as the entire mapping has been
unmapped. After that, there is no read path that should care about
that flag bit. So long as it is well commented (and maybe done via
a helper in mm/memory.c), I can't yet see a problem with it.

> Could it be an option to make it safe for the fault handler to 
> temporarily drop the mmap_sem read lock given that some conditions TBD 
> are met?
> In that case it can retake the mmap_sem write lock, do the VMA flags 
> modifications, downgrade and do the pte modifications using a helper, or 
> even use remap_pfn_range() during the time the write lock is held?

When you drop and retake the mmap_sem, you need to start again from
find_vma. At which point you technically probably want to start again
from the architecture specfic fault code. It sounds difficult but I
won't say it can't be done.
