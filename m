Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWHXLWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWHXLWA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 07:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWHXLWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 07:22:00 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:31928 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751128AbWHXLV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 07:21:59 -0400
Date: Thu, 24 Aug 2006 13:14:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gautham R Shenoy <ego@in.ibm.com>
Cc: rusty@rustcorp.com.au, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@intel.linux.com, davej@redhat.com,
       vatsa@in.ibm.com, dipankar@in.ibm.com, ashok.raj@intel.com
Subject: Re: [RFC][PATCH 3/4] (Refcount + Waitqueue) implementation for cpu_hotplug "locking"
Message-ID: <20060824111440.GA19248@elte.hu>
References: <20060824103233.GD2395@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824103233.GD2395@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4990]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Gautham R Shenoy <ego@in.ibm.com> wrote:

>  void lock_cpu_hotplug(void)
>  {

> +	DECLARE_WAITQUEUE(wait, current);
> +	spin_lock(&cpu_hotplug.lock);
> +	cpu_hotplug.reader_count++;

this should be per-CPU - lock_cpu_hotplug() should _not_ be a globally 
synchronized event.

CPU removal is such a rare event that we can easily do something like a 
global read-mostly 'CPU is locked for writes' flag (plus a completion 
queue) that the 'write' side takes atomically - combined with per-CPU 
refcount and a waitqueue that the read side increases/decreases and 
wakes. Read-locking of the CPU is much more common and should be 
fundamentally scalable: it should increase the per-CPU refcount, then 
check the global 'writer active' flag, and if the writer flag is set, it 
should wait on the global completion queue. When a reader drops the 
refcount it should wake up the per-CPU waitqueue. [in which a writer 
might be waiting for the refcount to go down to 0.]

	Ingo
