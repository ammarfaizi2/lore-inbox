Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751710AbWGZVe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbWGZVe2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 17:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbWGZVe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 17:34:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40159 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751181AbWGZVe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 17:34:26 -0400
Date: Wed, 26 Jul 2006 14:29:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
cc: Arjan van de Ven <arjan@linux.intel.com>, Dave Jones <davej@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Chuck Ebbert <76306.1226@compuserve.com>,
       Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Reorganize the cpufreq cpu hotplug locking to not be
 totally bizare
In-Reply-To: <20060726205810.GB23488@in.ibm.com>
Message-ID: <Pine.LNX.4.64.0607261422110.4168@g5.osdl.org>
References: <200607242023_MC3-1-C5FE-CADB@compuserve.com>
 <Pine.LNX.4.64.0607241752290.29649@g5.osdl.org> <20060725185449.GA8074@elte.hu>
 <1153855844.8932.56.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0607251355080.29649@g5.osdl.org>
 <1153921207.3381.21.camel@laptopd505.fenrus.org> <20060726155114.GA28945@redhat.com>
 <Pine.LNX.4.64.0607261007530.29649@g5.osdl.org> <1153942954.3381.50.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0607261319160.4168@g5.osdl.org> <20060726205810.GB23488@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Jul 2006, Srivatsa Vaddagiri wrote:
> 
> __create_workqueue(), destroy_workqueue() and flush_workqueue() are all 
> taking CPU hotplug lock currently. AFAICS they all can block and so
> disabling preemption wont work. What am I missing?

Well, at least __create_workqueue() should hopefully be fixable in the 
sense that you can do the blocking ops first, and then do the final part 
of actually instantiating it with preemption disabled.

But I agree with Arjan - I think the fundamental problem is that cpu 
hotplug locking is just is fundamentally badly designed as-is. There's 
really very little point to making it a _lock_ per se, since most people 
really want more of a "I'm using this CPU, don't try to remove it right 
now" thing which is more of a ref-counting-like issue.

I think we're hopefully ok for now in the AB-BA deadlock department (and I 
should probably remove the recursion warning), and will need to revisit 
things again after 2.6.18 to try to see if we can fix it properly.

Do we have lockdep warnings remaining? I'd hope that Arjan's earlier patch 
(the one I already applied) got all of those, and that we at least thus 
would have some basis for the belief that we got the ABBA deadlocks fixed.

			Linus
