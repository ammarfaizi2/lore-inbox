Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265144AbUIIOy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUIIOy1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 10:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUIIOy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 10:54:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:52879 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265144AbUIIOyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 10:54:25 -0400
Date: Thu, 9 Sep 2004 07:54:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Matt Mackall <mpm@selenic.com>, Anton Blanchard <anton@samba.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH][5/8] Arch agnostic completely out of line locks / ppc64
In-Reply-To: <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0409090751230.5912@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com>
 <16703.60725.153052.169532@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Sep 2004, Zwane Mwaikambo wrote:
> 
> I think cpu_relax() (or some other primitive) should actually take a 
> parameter, this will allow for us to use monitor/mwait on i386 too so 
> that in cases where we're spinning waiting on memory modify we could do 
> something akin to the following;
> 
> while (spin_is_locked(lock))
> 	cpu_relax(lock);

You can't do it that way. It needs to be arch-specific. When using 
something like monitor/mwait (or a "futex", which something like UML might 
use), you need to load the value you want to wait on _before_. So the 
interface literally would have to be the monitor/mwait interface:

	for (;;) {
		lockval = monitor(lock);
		if (!is_locked(lockval))
			break;
		mwait(lock, lockval);
	}

and the fact is, this is all much better just done in the arch-specific 
spinlock code. 

		Linus
