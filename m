Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267466AbUI1KXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267466AbUI1KXc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 06:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267661AbUI1KXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 06:23:30 -0400
Received: from scanner1.mail.elte.hu ([157.181.1.137]:65470 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267186AbUI1KXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 06:23:14 -0400
Date: Tue, 28 Sep 2004 12:24:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, tytso@mit.edu
Subject: Re: Stack traces in 2.6.9-rc2-mm4
Message-ID: <20040928102454.GA20271@elte.hu>
References: <6.1.2.0.2.20040927184123.019b48b8@tornado.reub.net> <20040927085744.GA32407@elte.hu> <1096326753l.5222l.2l@werewolf.able.es> <20040928072123.GA15177@elte.hu> <4159177F.7030803@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4159177F.7030803@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >+	preempt_disable();
> > 	/* if over the trickle threshold, use only 1 in 4096 samples */
> > 	if ( random_state->entropy_count > trickle_thresh &&
> > 	     (__get_cpu_var(trickle_count)++ & 0xfff))
> >-		return;
> >+		goto out;
> > 
> 
> It looks like upstream code *is* buggy because that is a non-atomic
> RMW operation on the per-cpu var, no? Hence you must disable preempt.

no, the upstream code (i.e. BK-curr) is not buggy, because there this
code runs under the BKL, implicitly as part of vt_ioctl() - and the BKL 
disables preemption in the upstream kernel.

Yes, the code is fragile, but it's not buggy. With the remove-bkl patch
this fragility turned into an outright bug. (Fortunately the patch
detects all such incidents.)

	Ingo
