Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWHXKln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWHXKln (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 06:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWHXKlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 06:41:42 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:5257 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751082AbWHXKlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 06:41:42 -0400
Date: Thu, 24 Aug 2006 12:34:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gautham R Shenoy <ego@in.ibm.com>
Cc: rusty@rustcorp.com.au, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@intel.linux.com, davej@redhat.com,
       vatsa@in.ibm.com, dipankar@in.ibm.com, ashok.raj@intel.com
Subject: Re: [RFC][PATCH 0/4] Redesign cpu_hotplug locking.
Message-ID: <20060824103412.GA14002@elte.hu>
References: <20060824102618.GA2395@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824102618.GA2395@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Gautham R Shenoy <ego@in.ibm.com> wrote:

> So here's an implementation on the lines of (c).
> 
> There are two types of tasks interested in cpu_hotplug
> - ones who want to *prevent* a hotplug event.
> - ones who want to *perform* a cpu hotplug.
> 
> For sake of simplicity let's call the former ones readers (though I 
> would have prefered inhibitors or somthing fancier!) and latter ones 
> writers. Let write operation = cpu_hotplug operation.
> 
> -The protocol is analogous to RWSEM, *only not so fair* .

really nice! I'm quite sure that this is the right way to approach this 
problem.

Please add the appropriate lock_acquire()/lock_release() calls into the 
new sleeping semaphore type. Just use the parameters that rwlocks use:

#define rwlock_acquire(l, s, t, i)            lock_acquire(l, s, t, 0, 2, i)
#define rwlock_acquire_read(l, s, t, i)       lock_acquire(l, s, t, 2, 2, i)

and lockdep will allow recursive read-locking. You'll also need a 
lockdep_init_map() call to register the lock with lockdep. Then your 
locking scheme will be fully checked by lockdep too. (with your current 
code the new lock type is not added to the lock dependency graph(s))

	Ingo
