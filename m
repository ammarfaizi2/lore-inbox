Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269752AbUJMQx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269752AbUJMQx5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 12:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269753AbUJMQx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 12:53:56 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:23250 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269752AbUJMQxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 12:53:46 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm3-T3
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>, Mark_H_Johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20041012091740.GA18736@elte.hu>
References: <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu>
	 <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu>
	 <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu>
	 <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu>
	 <20041007105230.GA17411@elte.hu>
	 <1097555404.1553.18.camel@krustophenia.net>
	 <20041012091740.GA18736@elte.hu>
Content-Type: text/plain
Message-Id: <1097686342.6538.31.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 13 Oct 2004 12:52:23 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-12 at 05:17, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Just to recap, these are the three problem areas that still produce
> > latencies over 500 usec on my machine.
> > 
> > 	journal_clean_checkpoint_list
> 
> you might want to send this trace to Andrew too - the primary master of
> ext3 latency-breaking.
> 

OK, Andrew, here it is.  This is one of the last 2 or 3 code paths that
can still produce latencies > 200 usecs on a typical machine.

--

Also, I am still seeing some long latencies in the ext3 journaling code:

preemption latency trace v1.0.7 on 2.6.9-rc3-mm3-VP-T3
-------------------------------------------------------
 latency: 607 us, entries: 1087 (1087)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: kjournald/687, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: journal_commit_transaction+0x75/0x2830
 => ended at:   __journal_clean_checkpoint_list+0xb2/0xf0
=======>
00000001 0.000ms (+0.003ms): journal_commit_transaction (kjournald)

Here is the loop:

00000002 0.003ms (+0.001ms): kfree (journal_commit_transaction)
00000001 0.004ms (+0.001ms): journal_refile_buffer (journal_commit_transaction)
00000003 0.006ms (+0.000ms): __journal_refile_buffer (journal_refile_buffer)
00000003 0.006ms (+0.001ms): __journal_unfile_buffer (journal_refile_buffer)
00000002 0.008ms (+0.000ms): journal_remove_journal_head (journal_refile_buffer)
00000003 0.008ms (+0.000ms): __journal_remove_journal_head (journal_remove_journal_head)
00000003 0.009ms (+0.000ms): __brelse (__journal_remove_journal_head)
00000003 0.010ms (+0.000ms): journal_free_journal_head (journal_remove_journal_head)
00000003 0.010ms (+0.001ms): kmem_cache_free (journal_free_journal_head)
00000001 0.011ms (+0.000ms): __brelse (journal_commit_transaction)

[end loop]

00000002 0.012ms (+0.000ms): kfree (journal_commit_transaction)
00000001 0.013ms (+0.000ms): journal_refile_buffer (journal_commit_transaction)

Lee

