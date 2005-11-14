Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbVKNLxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbVKNLxo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 06:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbVKNLxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 06:53:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:22229 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751089AbVKNLxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 06:53:44 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Arjan van de Ven <arjan@infradead.org>
To: Jens Axboe <axboe@suse.de>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051114113442.GU3699@suse.de>
References: <20051114021127.GC5735@stusta.de> <4378650A.1070209@drzeus.cx>
	 <1131964282.2821.11.camel@laptopd505.fenrus.org>
	 <20051114111108.GR3699@suse.de>
	 <1131967167.2821.14.camel@laptopd505.fenrus.org>
	 <20051114112402.GT3699@suse.de>
	 <1131967678.2821.21.camel@laptopd505.fenrus.org>
	 <20051114113442.GU3699@suse.de>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 12:53:31 +0100
Message-Id: <1131969212.2821.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 
> > Also in the implementation I don't see any way 4Kb stacks could show up
> > in any benchmarks as negative; there are only 4 or 5 extra instructions
> > in any path, and afaics no cache downsides (in fact the same irq stack
> > memory is now reused for irqs instead of threadstack-du-jour, so less
> > footprint/hotter caches)
> 
> The only downside is the potential crashes due to overflowing the stack,
> I'm not worried about 4kb stacks performing worse.
> 

First of all the 8Kb->4Kb change sounds like a big change, but 4Kb
really is 4Kb+4Kb (eg interrupt stacks). So the net reduction in
available stack for user context is a lot less (IRQ context need at
least 2Kb given that this is reentrant code wrt softirq processing),
probably in the order of 2Kb (compared to 8Kb 2.6 kernels) to 500 bytes
compared to 2.4 kernels (in 2.4 you lost 1.5 to the task struct on the
stack).

The experience with Fedora so far is exceptionally good; in early 2.6
there were some reports with XFS stacked on top of DM, but since then
XFS has gone on a stack diet... also the -mm patches to do non-recursive
IO submission will bury this (mostly theoretical) monster for good.



