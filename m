Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267602AbUIBHOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267602AbUIBHOE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 03:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267607AbUIBHOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 03:14:04 -0400
Received: from mx2.elte.hu ([157.181.151.9]:5012 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267602AbUIBHOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 03:14:00 -0400
Date: Thu, 2 Sep 2004 09:15:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Mark_H_Johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q8
Message-ID: <20040902071525.GA19925@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu> <1094108653.11364.26.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094108653.11364.26.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> Here are traces of a 145, 190, and 217 usec latencies in
> netif_receive_skb:
> 
> http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q6#/var/www/2.6.9-rc1-Q6/trace2.txt
> http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q6#/var/www/2.6.9-rc1-Q6/trace3.txt
> http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q6#/var/www/2.6.9-rc1-Q6/trace4.txt

these all seem to be single-packet processing latencies - it would be
quite hard to make those codepaths preemptible.

i'd suggest to turn off things like netfilter and ip_conntrack (and
other optional networking features that show up in the trace), they can
only increase latency:

 00000001 0.016ms (+0.000ms): ip_rcv (netif_receive_skb)
 00000001 0.019ms (+0.002ms): nf_hook_slow (ip_rcv)
 00000002 0.019ms (+0.000ms): nf_iterate (nf_hook_slow)
 00000002 0.021ms (+0.001ms): ip_conntrack_defrag (nf_iterate)
 00000002 0.022ms (+0.000ms): ip_conntrack_in (nf_iterate)
 00000002 0.022ms (+0.000ms): ip_ct_find_proto (ip_conntrack_in)
 00000103 0.023ms (+0.000ms): __ip_ct_find_proto (ip_ct_find_proto)
 00000102 0.024ms (+0.000ms): local_bh_enable (ip_ct_find_proto)
 00000002 0.025ms (+0.001ms): tcp_error (ip_conntrack_in)

	Ingo
