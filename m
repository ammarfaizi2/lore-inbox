Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268877AbUHaTlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268877AbUHaTlP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269031AbUHaTgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:36:44 -0400
Received: from mx2.elte.hu ([157.181.151.9]:63195 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268955AbUHaTgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:36:00 -0400
Date: Tue, 31 Aug 2004 21:37:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Daniel Schmitt <pnambic@unu.nu>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Message-ID: <20040831193734.GA29852@elte.hu>
References: <1093727453.8611.71.camel@krustophenia.net> <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net> <1093737080.1385.2.camel@krustophenia.net> <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu> <20040830090608.GA25443@elte.hu> <1093934448.5403.4.camel@krustophenia.net> <20040831070658.GA31117@elte.hu> <1093980065.1603.5.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093980065.1603.5.camel@krustophenia.net>
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

> 00000001 0.009ms (+0.000ms): generic_set_mtrr (set_mtrr)
> 00000001 0.009ms (+0.000ms): prepare_set (generic_set_mtrr)

this is the call to prepare_set() [implicit mcount()].

> 00000002 0.010ms (+0.000ms): prepare_set (generic_set_mtrr)

explicit mcount() #1,

> 00000002 0.010ms (+0.000ms): prepare_set (generic_set_mtrr)

#2,

> 00000002 0.375ms (+0.364ms): prepare_set (generic_set_mtrr)

#3. So the latency is this codepath:

+       mcount();
        wbinvd();
+       mcount();

bingo ...

to continue:

> 00000002 0.375ms (+0.000ms): prepare_set (generic_set_mtrr)

mcount #4

> 00000002 0.526ms (+0.150ms): prepare_set (generic_set_mtrr)

#5. This means the following code had the latency:

        write_cr0(cr0);
+       mcount();
        wbinvd();
+       mcount();

the other wbinvd(). Since we didnt execute all that much it didnt take
as much time as the first wbinvd() [the cache was just write-flushed, so
less flushing had to be done second time around].

plus:

 00000002 0.548ms (+0.006ms): generic_set_mtrr (set_mtrr)
 00000002 0.552ms (+0.004ms): post_set (generic_set_mtrr)
 00000001 0.708ms (+0.155ms): set_mtrr (mtrr_add_page)
 00000001 0.713ms (+0.005ms): sub_preempt_count (sys_ioctl)

proves that it's post_set() that took 155 usecs here, which too does a 
wbinvd().

so it's the invalidation of the cache that takes so long.

i believe that the invalidations are excessive. It is quite likely that
no invalidation has to be done at all. Does your box still start up X
fine if you uncomment all those wbinvd() calls?

	Ingo
