Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVBXIfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVBXIfX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 03:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVBXIfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 03:35:23 -0500
Received: from mx1.elte.hu ([157.181.1.137]:24975 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261986AbVBXIfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 03:35:05 -0500
Date: Thu, 24 Feb 2005 09:34:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/13] timestamp fixes
Message-ID: <20050224083441.GA8733@elte.hu>
References: <1109229293.5177.64.camel@npiggin-nld.site> <1109229362.5177.67.camel@npiggin-nld.site> <20050224074624.GA7847@elte.hu> <1109231761.5177.115.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109231761.5177.115.camel@npiggin-nld.site>
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

> On Thu, 2005-02-24 at 08:46 +0100, Ingo Molnar wrote:
> > * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > 
> > > 1/13
> > > 
> > 
> > ugh, has this been tested? It needs the patch below.
> > 
> 
> Yes. Which might also explain why I didn't see -ve intervals :( Thanks
> Ingo.
> 
> In the context of the whole patchset, testing has mainly been based
> around multiprocessor behaviour so this doesn't invalidate that.

nono, by 'this' i only meant that patch. The other ones look mainly OK,
but obviously they need a _ton_ of testing.

these:

 [PATCH 1/13] timestamp fixes
   (+fix)
 [PATCH 2/13] improve pinned task handling
 [PATCH 3/13] rework schedstats

can go into BK right after 2.6.11 is released as they are fixes or
norisk-improvements. [lets call them 'group A'] These three:

 [PATCH 4/13] find_busiest_group fixlets
 [PATCH 5/13] find_busiest_group cleanup

 [PATCH 7/13] better active balancing heuristic

look pretty fine too and i'd suggest early BK integration too - but in
theory they could impact things negatively so that's where immediate BK
integration has to stop in the first phase, to get some feedback. [lets 
call them 'group B']

these:

 [PATCH 6/13] no aggressive idle balancing

 [PATCH 8/13] generalised CPU load averaging
 [PATCH 9/13] less affine wakups
 [PATCH 10/13] remove aggressive idle balancing
 [PATCH 11/13] sched-domains aware balance-on-fork
  [PATCH 12/13] schedstats additions for sched-balance-fork
 [PATCH 13/13] basic tuning

change things radically, and i'm uneasy about them even in the 2.6.12
timeframe. [lets call them 'group C'] I'd suggest we give them a go in
-mm and see how things go, so all of them get:

  Acked-by: Ingo Molnar <mingo@elte.hu>

If things dont stabilize quickly then we need to do it piecemail wise.
The only possible natural split seems to be to go for the running-task
balancing changes first:

 [PATCH 6/13] no aggressive idle balancing

 [PATCH 8/13] generalised CPU load averaging
 [PATCH 9/13] less affine wakups
 [PATCH 10/13] remove aggressive idle balancing

 [PATCH 13/13] basic tuning

perhaps #8 and relevant portions of #13 could be moved from group C into
group B and thus hit BK early, but that would need remerging.

and then for the fork/clone-balancing changes:

 [PATCH 11/13] sched-domains aware balance-on-fork
 [PATCH 12/13] schedstats additions for sched-balance-fork

a more finegrained splitup doesnt make much sense, as these groups are
pretty compact conceptually.

But i expect fork/clone balancing to be almost certainly a problem. (We
didnt get it right for all workloads in 2.6.7, and i think it cannot be
gotten right currently either, without userspace API help - but i'd be
happy to be proven wrong.)

(if you agree with my generic analysis then when you regenerate your
patches next time please reorder them according to the flow above, and
please try to insert future fixlets not end-of-stream but according to
the conceptual grouping.)

	Ingo
