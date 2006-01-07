Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbWAGDHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbWAGDHV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 22:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWAGDHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 22:07:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16274 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030323AbWAGDHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 22:07:19 -0500
Date: Fri, 6 Jan 2006 19:07:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: bcrl@kvack.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] use local_t for page statistics
Message-Id: <20060106190703.5c346c6e.akpm@osdl.org>
In-Reply-To: <43BF2D03.2030908@yahoo.com.au>
References: <20060106215332.GH8979@kvack.org>
	<20060106163313.38c08e37.akpm@osdl.org>
	<43BF2D03.2030908@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Andrew Morton wrote:
> > Benjamin LaHaise <bcrl@kvack.org> wrote:
> > 
> >>The patch below converts the mm page_states counters to use local_t.  
> >>mod_page_state shows up in a few profiles on x86 and x86-64 due to the 
> >>disable/enable interrupts operations touching the flags register.  On 
> >>both my laptop (Pentium M) and P4 test box this results in about 10 
> >>additional /bin/bash -c exit 0 executions per second (P4 went from ~759/s 
> >>to ~771/s).  Tested on x86 and x86-64.  Oh, also add a pgcow statistic 
> >>for the number of COW page faults.
> > 
> > 
> > Bah.  I think this is a better approach than the just-merged
> > mm-page_state-opt.patch, so I should revert that patch first?
> > 
> 
> No. On many load/store architectures there is no good way to do local_t,
> so something like ppc32 or ia64 just uses all atomic operations for
> local_t, and ppc64 uses 3 counters per-cpu thus tripling the cache
> footprint.
> 

Yes, local_t seems a bit half-assed at present.  And a bit broken with
interrupt nesting.

Surely 64-bit architectures would be better off using atomic64_t rather
than that v[3] monstrosity.
