Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbVH3Fwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVH3Fwi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 01:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVH3Fwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 01:52:38 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:46288 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750794AbVH3Fwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 01:52:37 -0400
Date: Tue, 30 Aug 2005 07:53:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rt1
Message-ID: <20050830055321.GB5743@elte.hu>
References: <20050829084829.GA23176@elte.hu> <1125372830.6096.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125372830.6096.7.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Ingo,
> 
> I just found another deadlock in the pi_lock logic.  The PI logic is 
> very dependent on the P1->L1->P2->L2->P3 order.  But our good old 
> friend is back, the BKL.
> 
> Since the BKL is let go and regrabbed even if a task is grabbing 
> another lock, it messes up the order.  For example, it can do the 
> following: L1->P1->L2->P2->L1 if L1 is the BKL.  Luckly, (and I guess 
> there's really no other way) the BKL is only held by those that are 
> currently running, or at least not blocked on anyone.  So I added code 
> in the pi_setprio code to test if the next lock in the loop is the BKL 
> and if so, if its owner is the current task.  If so, the loop is 
> broken.
> 
> Without this patch, I would constantly get lock ups on shutdown where 
> it sends SIGTERM to all the processes.  It usually would lock up on 
> the killing of udev.  But with the patch, I've shutdown a few times 
> already and no lockups so far.

thanks, applied.

	Ingo
