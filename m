Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWA2Hv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWA2Hv1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 02:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWA2Hv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 02:51:27 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:38122 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750741AbWA2Hv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 02:51:26 -0500
Date: Sun, 29 Jan 2006 08:51:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Eric Dumazet <dada1@cosmosbay.com>, dipankar@in.ibm.com,
       paulmck@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: RCU latency regression in 2.6.16-rc1
Message-ID: <20060129075144.GA15056@elte.hu>
References: <20060124213802.GC7139@in.ibm.com> <1138224506.3087.22.camel@mindpipe> <20060126191809.GC6182@us.ibm.com> <1138388123.3131.26.camel@mindpipe> <20060128170302.GB5633@in.ibm.com> <1138471203.2799.13.camel@mindpipe> <1138474283.2799.24.camel@mindpipe> <20060128193412.GH5633@in.ibm.com> <43DBCB62.7030308@cosmosbay.com> <1138520283.2799.103.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138520283.2799.103.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Sat, 2006-01-28 at 20:52 +0100, Eric Dumazet wrote:
> > > Your new trace shows that we are held up in in rt_run_flush(). 
> > > I guess we need to investigate why we spend so much time in rt_run_flush(),
> > > because of a big route table or the lock acquisitions.
> > 
> > Some machines have millions of entries in their route cache.
> > 
> > I suspect we cannot queue all them (or only hash heads as your
> > previous patch) by RCU. Latencies and/or OOM can occur.
> > 
> > What can be done is :
> > 
> > in rt_run_flush(), allocate a new empty hash table, and exchange the
> > hash tables.
> > 
> > Then wait a quiescent/grace RCU period (may be the exact term is not
> > this one, sorry, I'm not RCU expert)
> > 
> > Then free all the entries from the old hash table (direclty of course,
> > no need for RCU grace period), and free the hash table.
> > 
> > As the hash table can be huge, we might need allocate it at boot time,
> > just in case a flush is needed (it usually is :) ). If we choose
> > dynamic allocation and this allocation fails, then fallback to what is
> > done today.
> > 
> 
> No problem, I'm not a networking expert...
> 
> Ingo's response to these traces was that softirq preemption, which 
> simply offloads all softirq processing to softirqd and has been tested 
> in the -rt patchset for over a year, is the easiest solution.  Any 
> thoughts on that?  Personally, I'd rather fix the very few problematic 
> softirqs, than take such a drastic step - this softirq appears to be 
> one of the last obstacles to being able to meet a 1ms soft RT 
> constraint with the mainline kernel.

well, softirq preemption is not really a drastic step - its biggest 
problem is that it cannot be included in v2.6.16 ;-) But i agree that if 
a solution can be found to break up a latency path, that is preferred.

	Ingo
