Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267534AbUHPKom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267534AbUHPKom (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 06:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267523AbUHPKol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 06:44:41 -0400
Received: from mx1.elte.hu ([157.181.1.137]:12198 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267531AbUHPKoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 06:44:16 -0400
Date: Mon, 16 Aug 2004 12:45:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P1
Message-ID: <20040816104519.GA21628@elte.hu>
References: <1092624221.867.118.camel@krustophenia.net> <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu> <1092627691.867.150.camel@krustophenia.net> <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092630122.810.25.camel@krustophenia.net> <20040816043302.GA14979@elte.hu> <1092634931.793.3.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092634931.793.3.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> With this, and the extract_entropy hack, the biggest common latency I
> am now seeing (the copy_page_one is bigger but rarer) is the XFree86
> unmap_vmas issue.  This one actually occurs so often that I can't tell
> what #2 is.

found the unmap_vmas() latency: pages get queued up for TLB flush (and
subsequent freeing) and the lock-break in unmap_vmas() didnt account for
this. When there's a preemption request and we do the lock-break it's
already too late: we first have to free possibly thousands of pages,
resulting in the latency. The solution is to make the lock-break (and
hence, the queue-flush) periodically, regardless of preemption requests. 
Will release -P2 soon.

	Ingo
