Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUDHShV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 14:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbUDHShV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 14:37:21 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:44017 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262208AbUDHShM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 14:37:12 -0400
Subject: Re: NUMA API for Linux
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Andi Kleen <ak@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <20040408033125.376459b3.ak@suse.de>
References: <1081373058.9061.16.camel@arrakis>
	 <20040407232712.2595ac16.ak@suse.de> <1081374061.9061.26.camel@arrakis>
	 <20040407234525.4f775c16.ak@suse.de> <1081385903.9925.109.camel@arrakis>
	 <20040408033125.376459b3.ak@suse.de>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1081449406.12673.27.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 08 Apr 2004 11:36:47 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-07 at 18:31, Andi Kleen wrote:
> On Wed, 07 Apr 2004 17:58:23 -0700
> Matthew Dobson <colpatch@us.ibm.com> wrote:
> 
> 
> > Is there a reason you don't have a case for MPOL_PREFERRED?  You have a
> > comment about it in the function, but you don't check the nodemask isn't
> > empty...
> 
> Empty prefered is a special case. It means DEFAULT.  This is useful
> when you have a process policy != DEFAULT, but want to set a specific
> VMA to default. Normally default in a VMA would mean use process policy.

Ok.. That makes sense.


> > In this function, why do we care what bits the user set past
> > MAX_NUMNODES?  Why shouldn't we just silently ignore the bits like we do
> > in sys_sched_setaffinity?  If a user tries to hand us an 8k bitmask, my
> > opinion is we should just grab as much as we care about (MAX_NUMNODES
> > bits rounded up to the nearest UL).
> 
> This is to catch uninitialized bits. Otherwise it could work on a kernel
> with small MAX_NUMNODES, and then suddenly fail on a kernel with bigger
> MAX_NUMNODES when a node isn't online.

I am of the opinion that we should allow currently offline nodes in the
user's mask.  Those nodes may come online later on, and we should
respect the user's request to allocate from those nodes if possible. 
Just like in sched_setaffinity() we take in the user's mask, and when we
actually use the mask to make a decision, we check it against
cpu_online_map.  Just because a node isn't online at the time of the
mbind() call doesn't mean it won't be soon.  Besides, we should be
checking against node_online_map anyway, because nodes could go away. 
Well, maybe not right now, but in the near future.  Hotplugable memory
is a reality, even if we don't support it just yet.


> > This seems a bit strange to me.  Instead of just allocating a whole
> > struct zonelist, you're allocating part of one?  I guess it's safe,
> > since the array is meant to be NULL terminated, but we should put a note
> > in any code using these zonelists that they *aren't* regular zonelists,
> > they will be smaller, and dereferencing arbitrary array elements in the
> > struct could be dangerous.  I think we'd be better off creating a
> > kmem_cache_t for these and using *whole* zonelist structures. 
> > Allocating part of a well-defined structure makes me a bit nervous...
> 
> And that after all the whining about sharing policies? ;-) (a BIND policy will
> always carry a zonelist). As far as I can see all existing zonelist code
> just walks it until NULL.
> 
> I would not be opposed to always using a full one, but it would use considerably
> more memory in many cases.

I'm not whining about sharing policies because of the space usage,
although that is a small side issue.  I'm whining about sharing policies
because it just makes sense.  You've got a data structure that is always
dynamically allocated and referenced by pointers, that has no instance
specific data in it, and that *already has* an atomic reference counter
in it.  And you decided not to share this data structure?!  In my
opinion, it's harder and more code to *not* share it...  Instead of
copying the structure in mpol_copy(), just atomic_inc(policy->refcnt)
and we're pretty much done.  You already do an atomic_dec_and_test() in
mpol_free()...

-Matt

