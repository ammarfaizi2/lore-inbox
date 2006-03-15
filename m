Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752085AbWCOAUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbWCOAUx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 19:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbWCOAUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 19:20:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4819 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750816AbWCOAUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 19:20:52 -0500
Date: Tue, 14 Mar 2006 16:20:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, akpm@osdl.org,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       mingo@redhat.com, alan@redhat.com, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #4] 
In-Reply-To: <2301.1142380768@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0603141609520.3618@g5.osdl.org>
References: <17431.14867.211423.851470@cargo.ozlabs.ibm.com> 
 <m1veujy47r.fsf@ebiederm.dsl.xmission.com> <16835.1141936162@warthog.cambridge.redhat.com>
 <32068.1142371612@warthog.cambridge.redhat.com>  <2301.1142380768@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Mar 2006, David Howells wrote:
> 
> But that doesn't make any sense!
> 
> That would mean we that we'd've read b into d before having read the new value
> of p into q, and thus before having calculated the address from which to read d
> (ie: &b) - so how could we know we were supposed to read d from b and not from
> a without first having read p?
> 
> Unless, of course, the smp_wmb() isn't effective, and the write to b happens
> after the write to p; or the Alpha's cache isn't fully coherent.

The cache is fully coherent, but the coherency isn't _ordered_.

Remember: the smp_wmb() only orders on the _writer_ side. Not on the 
reader side. The writer may send out the stuff in a particular order, but 
the reader might see them in a different order because _it_ might queue 
the bus events internally for its caches (in particular, it could end up 
delaying updating a particular way in the cache because it's busy).

[ The issue of read_barrier_depends() can also come up if you do data 
  speculation. Currently I don't think anybody does speculation for 
  anything but control speculation, but it's at least possible that a read 
  that "depends" on a previous read actually could take place before the 
  read it depends on if the previous read had its result speculated.

  For example, you already have to handle the case of

	if (read a)
		read b;

  where we can read b _before_ we read a, because the CPU speculated the 
  branch as being not taken, and then re-ordered the reads, even though 
  they are "dependent" on each other. That's not that different from doing

	ptr = read a
	data = read [ptr]

  and speculating the result of the first read. Such a CPU would also need 
  a non-empty read-barrier-depends ]

So memory ordering is interesting. Some "clearly impossible" orderings 
actually suddenly become possible just because the CPU can do things 
speculatively and thus things aren't necessarily causally ordered any 
more.

			Linus
