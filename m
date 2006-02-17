Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932597AbWBQJOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbWBQJOw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 04:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbWBQJOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 04:14:52 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:2439 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932597AbWBQJOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 04:14:51 -0500
Date: Fri, 17 Feb 2006 10:13:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@sgi.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Robust futexes
Message-ID: <20060217091307.GB22718@elte.hu>
References: <1140152271.25078.42.camel@localhost.localdomain> <20060216224207.98526b40.pj@sgi.com> <1140160371.25078.81.camel@localhost.localdomain> <20060216232950.efa39e13.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060216232950.efa39e13.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@sgi.com> wrote:

> So the point is that we only have to cleanup the stale locks of dead 
> threads when some other task has the misfortune of trying to take the 
> orphaned lock and gets forced into a wait.
> 
> The wait call essentially becomes a "wait unless said other TID is 
> dead, in which case, a new owner is summarily declared."

the fundamental problem i see here: how do you 'declare' a TID as dead?  
32-bit TIDs can be reused, quite fundamentally. A 64-bit TID space with 
no wrapover was suggested before in this discussion, but that's not 
possible for many reasons (ABI impact, user impact, and due to futexes 
being designed as 32-bit variables).
 
also, CPU support is problematic: not all 32-bit CPUs we support can do 
64-bit atomic ops. The moment the TID cannot be handled atomically, we 
are back to square 1 and to ->list_op_pending type of techniques.

[ and even a 64-bit TID space might be too narrow: lets fast forward 5
  years and assume a CPU that can create/destroy a thread in 0.1 usecs
  (right now we can do that in ~1 usec), and assume a total number of
  2048 cores within the system [say 128x16], a 64-bit TID space, with 3
  high bits set aside, could wrap around in 3 years. That's just a
  single order of magnitude away from being 'months' and causing
  practical problems. And that assumes the most 'compressed' variant: a
  central TID counter - not including things like clustering or
  scalability enhancements by partitioning the TID space along CPUs. ]

also, this approach has a futex performance issue: at every FUTEX_WAIT 
we'd have to look up the TID, just to make sure that it isnt dead. This 
will likely be an expensive operation [it probably needs to take the 
tasklist_lock, to ensure that the task _really_ isnt dead] - and futexes 
are supposed to be lightweight, even in their in-kernel slowpath. While 
with the userspace-list based approach, the normal in-kernel futex path 
is not impacted _at all_ - and even in the failure case, the TID only 
has to be matched against current->pid.

but yes, in theory, if we had a unique ID (per bootup) for every task 
started in the system, things would be somewhat simpler in some areas.  
In practice though, even if all the other (big) hurdles are overcome, 
handling that unique ID likely needs similar techniques as handling the 
list, and wont perform as well as the userspace-list based approach.

	Ingo
