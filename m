Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262633AbUKELRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbUKELRy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 06:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbUKELRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 06:17:54 -0500
Received: from cantor.suse.de ([195.135.220.2]:2793 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262633AbUKELRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 06:17:52 -0500
Date: Fri, 5 Nov 2004 12:17:51 +0100
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lorenzo Allegrucci <l_allegrucci@yahoo.it>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: 2.6.10-rc1-mm3
Message-ID: <20041105111751.GC8349@wotan.suse.de>
References: <20041105001328.3ba97e08.akpm@osdl.org> <200411051041.17940.l_allegrucci@yahoo.it> <20041105102204.GA4730@elte.hu> <20041105110951.GA29702@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105110951.GA29702@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 12:09:51PM +0100, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > ------------[ cut here ]------------
> > > kernel BUG at mm/memory.c:156!
> > 
> > > Process shmt04 (pid: 4854, threadinfo=dca51000 task=de374510)
> > 
> > reproducible here too, just running LTP's shmt04 directly triggers it
> > immediately. Looks like there's interaction of 4-level pagetables with
> > ipc/shm.c or mm/shmem.c.
> 
> due to the PML4 feature, the clear_page_tables() function changed to
> clear_page_range(), changing its (first,size) argument to (first,last). 
> Normally it's called with (0,TASK_SIZE) which normally is PML4-aligned,
> but in the (relatively rare) do_munmap() use this is not the case. We
> correctly calculate the range that could be cleared, but it's not
> PML4_SIZE aligned.

I think just removing the BUG_ON is easier.  I sent a patch for that
to Andrew.

> The solution is to clip both 'first' and 'last' to PML4_SIZE boundary.
> Since when we calculate 'first' we add at least +PML4_SIZE to the value,
> it is safe to clip 'first'. It is obviously safe to clip 'last'.

It's a bit tricky because on 3level architectures it clips on
PGDs, not PML4s, otherwise it would never free any pagetables.  
But the if()s check that correctly.

-Andi
