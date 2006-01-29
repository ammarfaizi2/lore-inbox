Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWA2Hme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWA2Hme (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 02:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWA2Hmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 02:42:33 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:57059 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751206AbWA2HiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 02:38:11 -0500
Subject: Re: RCU latency regression in 2.6.16-rc1
From: Lee Revell <rlrevell@joe-job.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: dipankar@in.ibm.com, paulmck@us.ibm.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <43DBCB62.7030308@cosmosbay.com>
References: <20060124092330.GA7060@elte.hu>
	 <1138095856.2771.103.camel@mindpipe> <20060124162846.GA7139@in.ibm.com>
	 <20060124213802.GC7139@in.ibm.com> <1138224506.3087.22.camel@mindpipe>
	 <20060126191809.GC6182@us.ibm.com> <1138388123.3131.26.camel@mindpipe>
	 <20060128170302.GB5633@in.ibm.com> <1138471203.2799.13.camel@mindpipe>
	 <1138474283.2799.24.camel@mindpipe> <20060128193412.GH5633@in.ibm.com>
	 <43DBCB62.7030308@cosmosbay.com>
Content-Type: text/plain
Date: Sun, 29 Jan 2006 02:38:02 -0500
Message-Id: <1138520283.2799.103.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-28 at 20:52 +0100, Eric Dumazet wrote:
> > Your new trace shows that we are held up in in rt_run_flush(). 
> > I guess we need to investigate why we spend so much time in rt_run_flush(),
> > because of a big route table or the lock acquisitions.
> 
> Some machines have millions of entries in their route cache.
> 
> I suspect we cannot queue all them (or only hash heads as your
> previous patch) by RCU. Latencies and/or OOM can occur.
> 
> What can be done is :
> 
> in rt_run_flush(), allocate a new empty hash table, and exchange the
> hash tables.
> 
> Then wait a quiescent/grace RCU period (may be the exact term is not
> this one, sorry, I'm not RCU expert)
> 
> Then free all the entries from the old hash table (direclty of course,
> no need for RCU grace period), and free the hash table.
> 
> As the hash table can be huge, we might need allocate it at boot time,
> just in case a flush is needed (it usually is :) ). If we choose
> dynamic allocation and this allocation fails, then fallback to what is
> done today.
> 

No problem, I'm not a networking expert...

Ingo's response to these traces was that softirq preemption, which
simply offloads all softirq processing to softirqd and has been tested
in the -rt patchset for over a year, is the easiest solution.  Any
thoughts on that?  Personally, I'd rather fix the very few problematic
softirqs, than take such a drastic step - this softirq appears to be one
of the last obstacles to being able to meet a 1ms soft RT constraint
with the mainline kernel.

Thanks for looking at this; I'd be glad to test any patches...

Lee


