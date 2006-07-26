Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161037AbWGZUcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161037AbWGZUcV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 16:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161038AbWGZUcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 16:32:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27088 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161037AbWGZUcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 16:32:20 -0400
Date: Wed, 26 Jul 2006 13:22:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@linux.intel.com>
cc: Dave Jones <davej@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Reorganize the cpufreq cpu hotplug locking to not be
 totally bizare
In-Reply-To: <1153942954.3381.50.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0607261319160.4168@g5.osdl.org>
References: <200607242023_MC3-1-C5FE-CADB@compuserve.com> 
 <Pine.LNX.4.64.0607241752290.29649@g5.osdl.org>  <20060725185449.GA8074@elte.hu>
  <1153855844.8932.56.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.64.0607251355080.29649@g5.osdl.org>  <1153921207.3381.21.camel@laptopd505.fenrus.org>
  <20060726155114.GA28945@redhat.com>  <Pine.LNX.4.64.0607261007530.29649@g5.osdl.org>
 <1153942954.3381.50.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Jul 2006, Arjan van de Ven wrote:
> 
> As a quick hack I made non-lock_cpu_hotplug()'ing versions of the 3 key
> workqueue functions (patch below). It works, it's correct, it's just so
> ugly that I'm almost too ashamed to post it. I haven't found a better
> solution yet though... time to take a step back I suppose.

That really is _way_ too ugly for words.

For 2.6.18, we may just have to leave the recursive locking in place, and 
just remove the warning. With the recursive lock, if/when somebody needs 
to take that lock early, the code can just do so, and then the inner 
lock-taker ends up being a no-op.

Of course, that's why people want recursive locks in the first place, and 
it's also why we've (largely successfully) have avoided them - it allows 
for people being way too lazy about locking, and allows for really broken 
schenarios like this.

I wonder if we could just make the workqueue code just run with preemption 
disabled - that should also automatically protect against any CPU hotplug 
events on the local CPU (and I think "local CPU" is all that the wq code 
cares about, no?)

		Linus
