Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbVBKDvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVBKDvv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 22:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVBKDvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 22:51:51 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:40684
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262136AbVBKDvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 22:51:48 -0500
Date: Thu, 10 Feb 2005 19:50:26 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Werner Almesberger <wa@almesberger.net>
Cc: herbert@gondor.apana.org.au, anton@samba.org, okir@suse.de,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arp_queue: serializing unlink + kfree_skb
Message-Id: <20050210195026.09b507e7.davem@davemloft.net>
In-Reply-To: <20050210012304.E25338@almesberger.net>
References: <20050131102920.GC4170@suse.de>
	<E1CvZo6-0001Bz-00@gondolin.me.apana.org.au>
	<20050203142705.GA11318@krispykreme.ozlabs.ibm.com>
	<20050203150821.2321130b.davem@davemloft.net>
	<20050204113305.GA12764@gondor.apana.org.au>
	<20050204154855.79340cdb.davem@davemloft.net>
	<20050204222428.1a13a482.davem@davemloft.net>
	<20050210012304.E25338@almesberger.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2005 01:23:04 -0300
Werner Almesberger <wa@almesberger.net> wrote:

> David S. Miller wrote:
> > Unlike the above routines, it is required that explicit memory
> > barriers are performed before and after the operation.  It must
> > be done such that all memory operations before and after the
> > atomic operation calls are strongly ordered with respect to the
> > atomic operation itself.
> 
> Hmm, given that this description will not only be read by implementers
> of atomic functions, but also by users, the "explicit memory barriers"
> may be confusing.

Absolutely, I agree.  My fingers even itched as I typed those lines
in.  I didn't change the wording because I couldn't come up with
anything better.

> In fact, I would call them "implicit", because they're hidden in the
> atomic_foo functions :-)

That's confusing to the implementer :-)

> s/smb_/smp/ :-)

Good catch, fixed in my local copy.

> Do they also work for atomic_add and atomic_sub, or do we have to
> fall back to smb_mb or atomic_add_return (see below) there ?

Macros for the other routines don't exist simply because nobody
ever had a use for them.

In practice they will just work.

> What happens if the operation could return a value, but the user
> ignores it ? E.g. if I don't like smp_mb__*, could I just use
> 
> 	atomic_inc_and_test(foo);

You still get the memory barrier, whether you read the return
value or not.

> > These routines, like the atomic_t counter operations returning
> > values, require explicit memory barrier semantics around their
> > execution.
> 
> Very confusing: the barriers aren't around the routines (that
> is something the user would be doing), but around whatever does
> the atomic stuff inside them.

Yeah, it's the whole implicit/explicit wording issue discussed
above.
