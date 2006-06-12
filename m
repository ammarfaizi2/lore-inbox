Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751868AbWFLLhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbWFLLhc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 07:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbWFLLhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 07:37:32 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:15013 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751868AbWFLLhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 07:37:31 -0400
Date: Mon, 12 Jun 2006 13:36:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Catalin Marinas <catalin.marinas@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Message-ID: <20060612113637.GA14136@elte.hu>
References: <20060611111815.8641.7879.stgit@localhost.localdomain> <20060611112156.8641.94787.stgit@localhost.localdomain> <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com> <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com> <Pine.LNX.4.58.0606121111440.7129@sbz-30.cs.Helsinki.FI> <20060612105345.GA8418@elte.hu> <Pine.LNX.4.58.0606121404080.7129@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0606121404080.7129@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:

> On Mon, 12 Jun 2006, Ingo Molnar wrote:
> > While it's always good to reduce the amount of false positives, i dont 
> > think it's unacceptable for inclusion right now. A few dozen annotations 
> > out of 7000+ allocation call sites isnt a big maintainance problem - and 
> > the benefits of automatic leak-checking are really huge.
> 
> Did you look at the call sites?  It seems clear that kmemleak doesn't 
> support existing kernel coding style yet (see below) which means we're 
> not covering all false positives.

but "supporting existing kernel coding style as-is" is not a must-have 
criterium for inclusion. While preserving semantics is strongly 
encouraged of course, a patch can change semantics (or can introduce 
restrictions) as long as it's common-sense or there is no other way out. 
The question is benefit vs. disadvantage, not a rigid "does it change 
semantics" rule.

Just look at Sparse annotations: they add maintainance overhead, but the 
overhead is well worth the trouble: they avoid bugs and they also serve 
as documentation/specification. And Sparse annotations are alot more 
numerous than kmemleak annotations will ever be!

> On Mon, 12 Jun 2006, Ingo Molnar wrote:
> > What i'd like to see though are clear explanations about why an 
> > allocation is not considered a leak, in terms of comments added to the 
> > code. That will also help us reduce the number of annotations later on.
> 
> I found at least two unacceptable false positive classes:
> 
>   - arch/i386/kernel/setup.c:
>     False positive because res pointer is stored in a global instance of
>     struct resource.

there's no good way around this one but to annotate it in one way or 
another.

We could express the non-leak nature of this allocation in a cleaner way 
by introducing the following API:

	memleak_boot_time_alloc(res);

Here kmemleak should build a global list of such allocations, with the 
following rules: these allocations must not be freed after that point, 
but these allocations will be searched for further pointers.

Via this method we will both document the special nature of these 
allocations and we'll enforce that it's not freed. (not that there is a 
high likelyhood of freeing a buffer whose pointer nobody knows - the 
purpose is rather to make sure that the annotation is correct)

>   - drivers/base/platform.c and fs/ext3/dir.c:
>     False positive because we allocate memory for struct + some extra
>     stuff.
> 
> At least the latter can be fixed as outlined by Catalin in another 
> mail.

yes.

my "document the exceptions" request was to make sure that such special 
rules are not forgotten. As long as they are documented clearly, if 
there's some common pattern between a number of them then they can be 
moved into the kmemleak infrastructure, to further reduce the annotation 
overhead.

	Ingo
