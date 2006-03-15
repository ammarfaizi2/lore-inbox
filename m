Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbWCOBTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbWCOBTW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 20:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWCOBTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 20:19:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48563 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932181AbWCOBTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 20:19:21 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0603141609520.3618@g5.osdl.org> 
References: <Pine.LNX.4.64.0603141609520.3618@g5.osdl.org>  <17431.14867.211423.851470@cargo.ozlabs.ibm.com> <m1veujy47r.fsf@ebiederm.dsl.xmission.com> <16835.1141936162@warthog.cambridge.redhat.com> <32068.1142371612@warthog.cambridge.redhat.com> <2301.1142380768@warthog.cambridge.redhat.com> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, akpm@osdl.org,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       mingo@redhat.com, alan@redhat.com, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #4] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Wed, 15 Mar 2006 01:19:02 +0000
Message-ID: <3762.1142385542@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> That's not that different from doing
> 
> 	ptr = read a
> 	data = read [ptr]
> 
>   and speculating the result of the first read.

But that would lead to the situation I suggested (q == &b and d == a), not the
one Paul suggested (q == &b and d == old b) because we'd speculate on the old
value of the pointer, and so see it before it's updated, and thus still
pointing to a.

> The cache is fully coherent, but the coherency isn't _ordered_.
> 
> Remember: the smp_wmb() only orders on the _writer_ side. Not on the 
> reader side. The writer may send out the stuff in a particular order, but 
> the reader might see them in a different order because _it_ might queue 
> the bus events internally for its caches (in particular, it could end up 
> delaying updating a particular way in the cache because it's busy).

Ummm... So whilst smp_wmb() commits writes to the mercy of the cache coherency
system in a particular order, the updates can be passed over from one cache to
another and committed to the reader's cache in any order, and can even be
delayed:

	CPU 1		CPU 2		COMMENT
	===============	===============	=======================================
					a == 0, b == 1 and p == &a, q == &a
	b = 2;
	smp_wmb();			Make sure b is changed before p
	<post b=2>
			<queue b=2>
	p = &b;		q = p;
	<post p=&b>
			<queue p=&b>
			d = *q;
			<commit p=&b>
			<post q=p>
			<read *q>	Reads from b before b updated in cache
			<post d=*q>
			<commit b=2>

I presume the Alpha MB instruction forces cache queue completion in addition
to a partial ordering on memory accesses:

	CPU 1		CPU 2		COMMENT
	===============	===============	=======================================
					a == 0, b == 1 and p == &a, q == &a
	b = 2;
	smp_wmb();			Make sure b is changed before p
	<post b=2>
			<queue b=2>
	p = &b;		q = p;
	<post p=&b>
			<queue p=&b>
			smp_read_barrier_depends();
			<commit b=2>
			<commit p=&b>
			d = *q;
			<post q=p>
			<read *q>	Reads new value of b
			<post d=*q>


David
