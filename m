Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbVCPKld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbVCPKld (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 05:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbVCPKld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 05:41:33 -0500
Received: from fire.osdl.org ([65.172.181.4]:56997 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262347AbVCPKky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 05:40:54 -0500
Date: Wed, 16 Mar 2005 02:40:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: rostedt@goodmis.org, rlrevell@joe-job.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/3] j_state_lock, j_list_lock, remove-bitlocks
Message-Id: <20050316024022.6d5c4706.akpm@osdl.org>
In-Reply-To: <20050316101906.GA17328@elte.hu>
References: <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
	<Pine.LNX.4.58.0503150641030.6456@localhost.localdomain>
	<20050315120053.GA4686@elte.hu>
	<Pine.LNX.4.58.0503150746110.6456@localhost.localdomain>
	<20050315133540.GB4686@elte.hu>
	<Pine.LNX.4.58.0503151150170.6456@localhost.localdomain>
	<20050316085029.GA11414@elte.hu>
	<20050316011510.2a3bdfdb.akpm@osdl.org>
	<20050316095155.GA15080@elte.hu>
	<20050316020408.434cc620.akpm@osdl.org>
	<20050316101906.GA17328@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > >  > There's a little lock ranking diagram in jbd.h which tells us that
> > >  > these locks nest inside j_list_lock and j_state_lock.  So I guess
> > >  > you'll need to turn those into semaphores.
> > > 
> > >  indeed. I did this (see the three followup patches, against BK-curr),
> > >  and it builds/boots/works just fine on an ext3 box. Do we want to try
> > >  this in -mm?
> > 
> > ooh, I'd rather not.  I spent an intense three days removing all the
> > sleeping locks from ext3 (and three months debugging the result). 
> > Ended up gaining 1000% on 16-way.
> > 
> > Putting them back in will really hurt the SMP performance.
> 
> seems like turning the bitlocks into spinlocks is the best option then. 
> We'd need one lock in buffer_head (j_state_lock, renamed to something
> more sensible like b_private_lock), and one lock in journal_head
> (j_list_lock) i guess.

Those two are in the journal, actually.  You refer to jbd_lock_bh_state()
and jbd_lock_bh_journal_head().  I think they both need to be in the
buffer_head.  jbd_lock_bh_journal_head() can probably go away (just use
caller's jbd_lock_bh_state()).

Or make them global, or put them in the journal.

> How much would the +4/+8 bytes size increase in
> buffer_head [on SMP] be frowned upon? 

It wouldn't be the end of the world.  I'm not clear on what bits of the
rt-super-low-latency stuff is intended for mainline though?
