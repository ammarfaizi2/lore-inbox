Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUJHXO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUJHXO2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 19:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUJHXO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 19:14:27 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:53735 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265971AbUJHXOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 19:14:10 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm3-T3
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>, Mark_H_Johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
In-Reply-To: <20041007105230.GA17411@elte.hu>
References: <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu>
	 <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu>
	 <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu>
	 <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu>
	 <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu>
	 <20041007105230.GA17411@elte.hu>
Content-Type: text/plain
Message-Id: <1097277103.1442.87.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Oct 2004 19:11:44 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-07 at 06:52, Ingo Molnar wrote:
> i've released the -T3 VP patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm3-T3
> 

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

I think I already reported this one with S7.

Lee

