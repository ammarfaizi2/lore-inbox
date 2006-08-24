Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWHXMcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWHXMcn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 08:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWHXMcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 08:32:43 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:65254 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751198AbWHXMcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 08:32:42 -0400
Date: Thu, 24 Aug 2006 14:25:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gautham R Shenoy <ego@in.ibm.com>
Cc: rusty@rustcorp.com.au, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@linux.intel.com, davej@redhat.com,
       vatsa@in.ibm.com, dipankar@in.ibm.com, ashok.raj@intel.com
Subject: Re: [RFC][PATCH 3/4] (Refcount + Waitqueue) implementation for cpu_hotplug "locking"
Message-ID: <20060824122527.GA28275@elte.hu>
References: <20060824103233.GD2395@in.ibm.com> <20060824111440.GA19248@elte.hu> <20060824122808.GH2395@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824122808.GH2395@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4606]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Gautham R Shenoy <ego@in.ibm.com> wrote:

> This was the approach I tried to make it cache friendly.
> These are the problems I faced.
> 
> - Reader checks the write_active flag. If set, he waits in the global read
> queue. else, he gets the lock and increments percpu refcount.
> 
> - the writer would have to check each cpu's read refcount, and ensure that
> read refcount =0 on all of them before he sets write_active and 
> begins a write operation.
> This will create a big race window - a writer is checking
> for a refcount on cpu(j), a reader comes on cpu(i) where i<j;
> Let's assume the writer checks refcounts in increasing order of cpus.
> Should the reader on cpu(i) wait or go ahead? If we use a global
> lock to serialize this operation, we the whole purpose of maintaining
> per cpu data is lost.

no. The writer first sets the global write_active flag, and _then_ goes 
on to wait for all readers (if any) to get out of their critical 
sections. (That's the purpose of the per-cpu waitqueue that readers use 
to wake up a writer waiting for the refcount to go to 0.)

can you still see problems with this scheme?

(the 'write_active' flag is probably best implemented as a mutex, where 
readers check mutex_is_locked(), and writers try to take it.)

	Ingo
