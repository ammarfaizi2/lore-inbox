Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbUCRSlq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 13:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbUCRSko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 13:40:44 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:2182
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262864AbUCRShz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 13:37:55 -0500
Date: Thu, 18 Mar 2004 19:38:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: mjy@geizhals.at, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-ID: <20040318183844.GD32573@dualathlon.random>
References: <40591EC1.1060204@geizhals.at> <20040318060358.GC29530@dualathlon.random> <20040318015004.227fddfb.akpm@osdl.org> <20040318145129.GA2246@dualathlon.random> <20040318093902.3513903e.akpm@osdl.org> <20040318175855.GB2536@dualathlon.random> <20040318102623.04e4fadb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318102623.04e4fadb.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 10:26:23AM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > > They do?   kmap_atomic() disables preemption anyway.
> > 
> > dunno why but see:
> > 
> > 	spin_lock(&mm->page_table_lock);
> > 	page_table = pte_offset_map(pmd, address);
> > 
> > 		pte_unmap(page_table);
> > 		spin_unlock(&mm->page_table_lock);
> > 
> 
> do_wp_page()?  The lock is there to pin the pte down isn't it?  Maybe it
> can be optimised - certainly the spin_unlock() in there can be moved up a
> few statements.

It's not needed, we need the lock only when we _read_ the pte, not
during the kmap_atomic. The kmap_atomic is just a window on some highmem
rmap, it has no clue what's there and it can't affect the locking in any
way. The only thing it matters is that we don't schedule.

so taking locks regularly earlier than needed sounds a bit confusing,
since somebody could think they're really needed there.

> Could be.  When I did that code I had some printks in the slow path and
> although it did trigger, it was rare.  We've already faulted the page in by

I agree it must be _very_ rare ;). Writing zeros isn't very useful
anyways. And while swapping the scalability don't matter much anywyas.

> hand so we should only fall into the kmap() if the page was suddenly stolen
> again.

Oh so you mean the page fault insn't only interrupting the copy-user
atomically, but the page fault is also going to sleep and pagein the
page? I though you didn't want to allow other tasks to steal the kmap
before you effectively run the kunmap_atomic. I see it can be safe if
kunmap_atomic is a noop though, but you're effectively allowing
scheduling inside a kmap this way.
