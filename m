Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267259AbUJBDCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267259AbUJBDCW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 23:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267251AbUJBDCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 23:02:22 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:58538 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267259AbUJBDCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 23:02:18 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm4-S7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20040928000516.GA3096@elte.hu>
References: <1094683020.1362.219.camel@krustophenia.net>
	 <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu>
	 <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu>
	 <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu>
	 <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu>
	 <20040924074416.GA17924@elte.hu>  <20040928000516.GA3096@elte.hu>
Content-Type: text/plain
Message-Id: <1096686137.1397.3.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 01 Oct 2004 23:02:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-27 at 20:05, Ingo Molnar wrote:
> i've released the -S7 VP patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm4-S7
> 

OK, I have been busy with other things, so haven't been able to test as
much.  There might be a few regressions with S7.  Here is a trace from
the ext3 journaling code that I never saw before.  It starts with some
printks from the rtc_interrupt, due to having the rtc-debug patch
installed, but these accout for less than 100 usecs of the ~600 usec
latency.

http://krustophenia.net/testresults.php?dataset=2.6.9-rc2-mm4-S7

This part repeats many times:

00000001 0.127ms (+0.000ms): journal_refile_buffer (journal_commit_transaction)
00000003 0.127ms (+0.000ms): __journal_refile_buffer (journal_refile_buffer)
00000003 0.128ms (+0.000ms): __journal_unfile_buffer (journal_refile_buffer)
00000002 0.128ms (+0.000ms): preempt_schedule (journal_refile_buffer)
00000002 0.128ms (+0.000ms): journal_remove_journal_head (journal_refile_buffer)
00000003 0.129ms (+0.000ms): __journal_remove_journal_head (journal_remove_journal_head)
00000003 0.129ms (+0.000ms): __brelse (__journal_remove_journal_head)
00000003 0.130ms (+0.000ms): journal_free_journal_head (journal_remove_journal_head)
00000003 0.130ms (+0.000ms): kmem_cache_free (journal_free_journal_head)
00000002 0.130ms (+0.000ms): preempt_schedule (journal_refile_buffer)
00000001 0.131ms (+0.000ms): preempt_schedule (journal_refile_buffer)
00000001 0.131ms (+0.000ms): __brelse (journal_commit_transaction)
00000002 0.132ms (+0.000ms): kfree (journal_commit_transaction)
00000001 0.132ms (+0.000ms): preempt_schedule (journal_commit_transaction)
00000001 0.133ms (+0.000ms): journal_refile_buffer (journal_commit_transaction)
00000003 0.133ms (+0.000ms): __journal_refile_buffer (journal_refile_buffer)
00000003 0.133ms (+0.000ms): __journal_unfile_buffer (journal_refile_buffer)
00000002 0.134ms (+0.000ms): preempt_schedule (journal_refile_buffer)
00000002 0.134ms (+0.000ms): journal_remove_journal_head (journal_refile_buffer)
00000003 0.135ms (+0.000ms): __journal_remove_journal_head (journal_remove_journal_head)
00000003 0.135ms (+0.000ms): __brelse (__journal_remove_journal_head)
00000003 0.135ms (+0.000ms): journal_free_journal_head (journal_remove_journal_head)
00000003 0.136ms (+0.000ms): kmem_cache_free (journal_free_journal_head)
00000002 0.136ms (+0.000ms): preempt_schedule (journal_refile_buffer)
00000001 0.136ms (+0.000ms): preempt_schedule (journal_refile_buffer)
00000001 0.137ms (+0.000ms): __brelse (journal_commit_transaction)
00000002 0.137ms (+0.000ms): kfree (journal_commit_transaction)
00000001 0.138ms (+0.000ms): preempt_schedule (journal_commit_transaction)
00000001 0.138ms (+0.000ms): journal_refile_buffer (journal_commit_transaction)
00000003 0.139ms (+0.000ms): __journal_refile_buffer (journal_refile_buffer)
00000003 0.139ms (+0.000ms): __journal_unfile_buffer (journal_refile_buffer)
00000002 0.140ms (+0.000ms): preempt_schedule (journal_refile_buffer)
00000002 0.140ms (+0.000ms): journal_remove_journal_head (journal_refile_buffer)
00000003 0.141ms (+0.000ms): __journal_remove_journal_head (journal_remove_journal_head)
00000003 0.141ms (+0.000ms): __brelse (__journal_remove_journal_head)
00000003 0.141ms (+0.000ms): journal_free_journal_head (journal_remove_journal_head)
00000003 0.142ms (+0.000ms): kmem_cache_free (journal_free_journal_head)
00000002 0.142ms (+0.000ms): preempt_schedule (journal_refile_buffer)
00000001 0.142ms (+0.000ms): preempt_schedule (journal_refile_buffer)
00000001 0.143ms (+0.001ms): __brelse (journal_commit_transaction)
00000002 0.144ms (+0.000ms): kfree (journal_commit_transaction)


Lee

