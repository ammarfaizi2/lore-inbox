Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933013AbWFWK6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933013AbWFWK6Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933020AbWFWK6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:58:20 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:14316 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S933013AbWFWK5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:57:51 -0400
Date: Fri, 23 Jun 2006 12:52:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 50/61] lock validator: special locking: hrtimer.c
Message-ID: <20060623105255.GQ4889@elte.hu>
References: <20060529212109.GA2058@elte.hu> <20060529212709.GX3155@elte.hu> <20060529183556.602b1570.akpm@osdl.org> <20060623100439.GI4889@elte.hu> <20060623033825.b62eec20.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623033825.b62eec20.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > perhaps the naming should be clearer? I had it named 
> > spin_lock_init_standalone() originally, then cleaned it up to be 
> > spin_lock_init_static(). Maybe the original name is better?
> > 
> 
> hm.  This is where a "term of art" is needed.  What is lockdep's 
> internal term for locks-of-a-different-type?  It should have such a 
> term.

'lock type' is what i tried to use consistenty.

> "class" would be a good term, although terribly overused.  Using that 
> as an example, spin_lock_init_standalone_class()?  ug.
> 
> <gives up>
> 
> You want spin_lock_init_singleton().

hehe ;)

singleton wouldnt be enough here as we dont want just one instance of 
this lock type: we want separate types for each array entry. I.e. we 
dont want to unify the lock types (as the common spin_lock_init() call 
suggests), we want to split them along their static addresses.

singleton initialization is what spin_lock_init() itself accomplishes: 
the first call to a given spin_lock_init() will register a 'lock type' 
structure, and all subsequent calls to spin_lock_init() will find this 
type registered already. (keyed by the lockdep-type-key embedded in the 
spin_lock_init() macro)

so - spin_lock_init_split_type() might be better i think and expresses 
the purpose (to split away this type from the other lock types 
initialized here).

Or we could simply get rid of this static-variables special-case and 
embedd a lock_type_key in the runqueue and use 
spin_lock_init_key(&rq->rq_lock_key)? That would unify the 'splitting' 
of types for static and dynamic locks. (at a minimal cost of .data) Hm?

	Ingo
