Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266187AbUIIQBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266187AbUIIQBn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 12:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbUIIQBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 12:01:43 -0400
Received: from mx1.elte.hu ([157.181.1.137]:21438 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266117AbUIIQAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 12:00:37 -0400
Date: Thu, 9 Sep 2004 18:02:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Lee Revell <rlrevell@joe-job.com>, Free Ekanayaka <free@agnula.org>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, luke@audioslack.com, free78@tin.it
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
Message-ID: <20040909160203.GA23415@elte.hu>
References: <OFD3DB738F.105F62D0-ON86256F08.005CDE25-86256F08.005CDE44@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFD3DB738F.105F62D0-ON86256F08.005CDE25-86256F08.005CDE44@raytheon.com>
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


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> Results from this morning's test with -R1 and some follow up on
> related messages.

lt002.v3k1/lt.10 is particularly interesting:

 00000001 0.000ms (+0.000ms): spin_lock (rtl8139_poll)
 00000001 0.000ms (+0.070ms): spin_lock (<00000000>)
 00000001 0.070ms (+0.070ms): rtl8139_rx (rtl8139_poll)
 00000001 0.140ms (+0.070ms): alloc_skb (rtl8139_rx)
 00000001 0.210ms (+0.070ms): kmem_cache_alloc (alloc_skb)
 00000001 0.280ms (+0.073ms): __kmalloc (alloc_skb)
 00000001 0.354ms (+0.139ms): eth_type_trans (rtl8139_rx)
 00000001 0.493ms (+0.076ms): netif_receive_skb (rtl8139_rx)
 00000002 0.570ms (+0.001ms): packet_rcv_spkt (netif_receive_skb)

this too shows the CPU in 'slow motion' in a codepath that normally
executes 10 times faster than this on a 100 MHz Pentium Classic ...

another interesting thing is that the unit of delay seems to be around
70 usecs. As if under certain circumstances every main memory access
created a 70 usecs hit. (a cachemiss perhaps?) The eth_type_trans entry
perhaps generated 2 main memory accesses (2 cachemisses?) or so.

	Ingo
