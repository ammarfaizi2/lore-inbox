Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932975AbWFWJqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932975AbWFWJqX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932976AbWFWJqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:46:23 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:468 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932975AbWFWJqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:46:23 -0400
Date: Fri, 23 Jun 2006 11:41:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
Message-ID: <20060623094126.GD4889@elte.hu>
References: <20060529212109.GA2058@elte.hu> <20060529183503.6bc60a83.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529183503.6bc60a83.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> > We are pleased to announce the first release of the "lock dependency 
> > correctness validator" kernel debugging feature
> 
> What are the runtime speed and space costs of enabling this?

The RAM space costs are estimated in the bootup info printout:

 ... MAX_LOCKDEP_SUBTYPES:    8
 ... MAX_LOCK_DEPTH:          30
 ... MAX_LOCKDEP_KEYS:        2048
 ... TYPEHASH_SIZE:           1024
 ... MAX_LOCKDEP_ENTRIES:     8192
 ... MAX_LOCKDEP_CHAINS:      8192
 ... CHAINHASH_SIZE:          4096
  memory used by lock dependency info: 696 kB
  per task-struct memory footprint: 1200 bytes

Plus every lock now embedds the lock_map structure which is 10 pointers. 
That is the biggest direct dynamic RAM cost.

There are also a few embedded keys in .data but they are small.

The .text overhead mostly comes from the subsystem itself - which is 
around 20K of .text. The callbacks are not inlined most of the time - 
there are about 200 of them right now, which should be another +1-2K of 
.text cost.

The runtime cycle cost is significant if CONFIG_DEBUG_LOCKDEP [lock 
validator self-consistency checks] is enabled - then we take a global 
lock from every lock operation which kills scalability.

If DEBUG_LOCKDEP is disabled then it's OK - smaller than DEBUG_SLAB. In 
this case we have the lock-stack maintainance overhead, the irq-trace 
callbacks and a lockless hash-lookup per lock operation. All of that 
overhead is O(1) and lockless so it shouldnt change fundamental 
characteristics anywhere.

	Ingo
