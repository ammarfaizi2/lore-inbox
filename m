Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUDHBbt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 21:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbUDHBbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 21:31:49 -0400
Received: from ns.suse.de ([195.135.220.2]:35039 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261430AbUDHBb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 21:31:27 -0400
Date: Thu, 8 Apr 2004 03:31:25 +0200
From: Andi Kleen <ak@suse.de>
To: colpatch@us.ibm.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mbligh@aracnet.com
Subject: Re: NUMA API for Linux
Message-Id: <20040408033125.376459b3.ak@suse.de>
In-Reply-To: <1081385903.9925.109.camel@arrakis>
References: <1081373058.9061.16.camel@arrakis>
	<20040407232712.2595ac16.ak@suse.de>
	<1081374061.9061.26.camel@arrakis>
	<20040407234525.4f775c16.ak@suse.de>
	<1081385903.9925.109.camel@arrakis>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Apr 2004 17:58:23 -0700
Matthew Dobson <colpatch@us.ibm.com> wrote:


> Is there a reason you don't have a case for MPOL_PREFERRED?  You have a
> comment about it in the function, but you don't check the nodemask isn't
> empty...

Empty prefered is a special case. It means DEFAULT.  This is useful
when you have a process policy != DEFAULT, but want to set a specific
VMA to default. Normally default in a VMA would mean use process policy.


> In this function, why do we care what bits the user set past
> MAX_NUMNODES?  Why shouldn't we just silently ignore the bits like we do
> in sys_sched_setaffinity?  If a user tries to hand us an 8k bitmask, my
> opinion is we should just grab as much as we care about (MAX_NUMNODES
> bits rounded up to the nearest UL).

This is to catch uninitialized bits. Otherwise it could work on a kernel
with small MAX_NUMNODES, and then suddenly fail on a kernel with bigger
MAX_NUMNODES when a node isn't online.
 

> This seems a bit strange to me.  Instead of just allocating a whole
> struct zonelist, you're allocating part of one?  I guess it's safe,
> since the array is meant to be NULL terminated, but we should put a note
> in any code using these zonelists that they *aren't* regular zonelists,
> they will be smaller, and dereferencing arbitrary array elements in the
> struct could be dangerous.  I think we'd be better off creating a
> kmem_cache_t for these and using *whole* zonelist structures. 
> Allocating part of a well-defined structure makes me a bit nervous...

And that after all the whining about sharing policies? ;-) (a BIND policy will
always carry a zonelist). As far as I can see all existing zonelist code
just walks it until NULL.

I would not be opposed to always using a full one, but it would use considerably
more memory in many cases.


> I'm guessing this is why you aren't checking MPOL_PREFERRED in
> check_policy()?  So the user can call mbind() with MPOL_PREFERRED and an
> empty nodes bitmap and get the default behavior you mentioned in the
> comments?

Yep.

-Andi
