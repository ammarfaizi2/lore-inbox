Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262326AbVCPKT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbVCPKT4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 05:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbVCPKT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 05:19:56 -0500
Received: from mx2.elte.hu ([157.181.151.9]:58517 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262326AbVCPKTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 05:19:53 -0500
Date: Wed, 16 Mar 2005 11:19:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: rostedt@goodmis.org, rlrevell@joe-job.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/3] j_state_lock, j_list_lock, remove-bitlocks
Message-ID: <20050316101906.GA17328@elte.hu>
References: <Pine.LNX.4.58.0503141024530.697@localhost.localdomain> <Pine.LNX.4.58.0503150641030.6456@localhost.localdomain> <20050315120053.GA4686@elte.hu> <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain> <20050315133540.GB4686@elte.hu> <Pine.LNX.4.58.0503151150170.6456@localhost.localdomain> <20050316085029.GA11414@elte.hu> <20050316011510.2a3bdfdb.akpm@osdl.org> <20050316095155.GA15080@elte.hu> <20050316020408.434cc620.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316020408.434cc620.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> >  > There's a little lock ranking diagram in jbd.h which tells us that
> >  > these locks nest inside j_list_lock and j_state_lock.  So I guess
> >  > you'll need to turn those into semaphores.
> > 
> >  indeed. I did this (see the three followup patches, against BK-curr),
> >  and it builds/boots/works just fine on an ext3 box. Do we want to try
> >  this in -mm?
> 
> ooh, I'd rather not.  I spent an intense three days removing all the
> sleeping locks from ext3 (and three months debugging the result). 
> Ended up gaining 1000% on 16-way.
> 
> Putting them back in will really hurt the SMP performance.

seems like turning the bitlocks into spinlocks is the best option then. 
We'd need one lock in buffer_head (j_state_lock, renamed to something
more sensible like b_private_lock), and one lock in journal_head
(j_list_lock) i guess. How much would the +4/+8 bytes size increase in
buffer_head [on SMP] be frowned upon? 

	Ingo
