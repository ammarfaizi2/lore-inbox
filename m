Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWCXXVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWCXXVM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 18:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWCXXVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 18:21:12 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:61793 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S932233AbWCXXVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 18:21:11 -0500
X-IronPort-AV: i="4.03,127,1141632000"; 
   d="scan'208"; a="317496696:sNHT44130704"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: akpm@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 0 of 18] ipath driver - for inclusion in 2.6.17
X-Message-Flag: Warning: May contain useful information
References: <patchbomb.1143175292@eng-12.pathscale.com>
	<ada4q1nr7pu.fsf@cisco.com>
	<1143227515.30626.43.camel@serpentine.pathscale.com>
	<adaveu3pml7.fsf@cisco.com>
	<1143239617.30626.83.camel@serpentine.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 24 Mar 2006 15:21:09 -0800
In-Reply-To: <1143239617.30626.83.camel@serpentine.pathscale.com> (Bryan O'Sullivan's message of "Fri, 24 Mar 2006 14:33:37 -0800")
Message-ID: <ada8xqzh1ju.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 24 Mar 2006 23:21:10.0218 (UTC) FILETIME=[A289FAA0:01C64F99]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Roland> I would just get rid of your atomic_clear_mask() and
    Roland> atomic_set_mask() calls.  They're bogus because you're not
    Roland> even operating on an atomic_t, and not many architectures
    Roland> implement them.

    Bryan> They're not obviously defined to operate on atomic_t
    Bryan> objects, but what you say makes sense.  I guess that's a
    Bryan> peril of using macros for that stuff.

Not on x86_64, but:

./asm-s390/atomic.h:static __inline__ void atomic_clear_mask(unsigned long mask, atomic_t * v)
./asm-sh/atomic.h:static __inline__ void atomic_clear_mask(unsigned int mask, atomic_t *v)
./asm-sh64/atomic.h:static __inline__ void atomic_clear_mask(unsigned int mask, atomic_t *v)

etc.  Some other architectures do use unsigned long instead.  It all
looks rather non-portable, and the only drivers that use these
functions are s390-specific.  Clearly the simplest solution for your
situation is just to kill it.

    Bryan> There is no duplicated SMA code.  There are two routines in
    Bryan> ipathfs that handle nodeinfo and portinfo structures, but
    Bryan> they're for passing them to userspace; they don't even
    Bryan> really resemble the code in ipath_mad.c.

We seem to be going around and around on this.  There definitely is
duplicated code; you just hide some of it in userspace.  You clearly
have two copies of the function to generate a reply to a GET of
NodeInfo, for example.

What if you moved the MAD query handling code into your core driver?
You could use your current method of sending and receiving replies
directly when ib_ipath isn't loaded, but just process the queries in
the kernel without proxying to userspace.  Then if/when QP0 is
created, switch to letting the MAD layer handle sending and receiving
queries and let it call the same query handling code via your
process_mad method.

But it would (I think) solve all the issues of needing ib_mad loaded
for things to work.  Users could even load ib_ipath without ib_mad and
have IB verbs work -- anything that actually needed MADs would pull in
ib_mad as a dependency, and everything else should work fine with the
SMA stuff handled by your driver.

Of course this would expose the duplication of the SMI directed route
handling logic between your driver and the IB midlayer.  Perhaps it
makes sense to move this directed route logic into its own module to
fix this.

I just really don't like the fact that you apparently have two
different MAD handling methods, with different features.  Diluting
your development by a factor of 2 isn't good for the code.  Also,
the way your are working around the IB midlayer just smells wrong --
either the midlayer or your driver should be fixed so that they work
well together.

    Bryan> That's true; sorry about that.  Do you want me to send you
    Bryan> a patch that drops it and pulls it out of headers and
    Bryan> kbuild stuff?

Let's just try to get closure on everything and then you can send a
real final patchset for merging.

I understand that you really, really want your driver in 2.6.17.  But
let's do things right.  Also, in my opinion, we can still merge ipath
even after 2.6.17-rc1, since it doesn't touch anything (except trivial
kbuild stuff) outside of drivers/infiniband/hw/ipath.

 - R.
