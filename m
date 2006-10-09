Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWJIIL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWJIIL5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 04:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWJIIL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 04:11:57 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:1930 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S932365AbWJIIL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 04:11:56 -0400
Subject: Re: [PATCH] lockdep: annotate nfs/nfsd in-kernel sockets
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       steved@redhat.com, Ingo Molnar <mingo@elte.hu>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
In-Reply-To: <17705.40741.552103.194329@cse.unsw.edu.au>
References: <1160146860.2792.111.camel@taijtu>
	 <17705.40741.552103.194329@cse.unsw.edu.au>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 10:12:01 +0200
Message-Id: <1160381521.2792.129.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-09 at 11:00 +1000, Neil Brown wrote:
> On Friday October 6, a.p.zijlstra@chello.nl wrote:
> > 
> > Stick NFS sockets in their own class to avoid some lockdep warnings.
> > NFS sockets are never exposed to user-space, and will hence not trigger
> > certain code paths that would otherwise pose deadlock scenarios.
> 
> I'm a bit bothered that the changelog entry does mention what sort of
> lockdep warning are begin avoided, 

These:
  http://lkml.org/lkml/2006/7/13/84

> and that 'svc_reclassify_socket'
> doesn't contain the work 'lock', yet is it really the locks that are
> being reclassified.

Hmm, good point, shall I do s/reclassify_socket/reclassify_sock_lock/ ?

>   However
> 
> Acked-by: NeilBrown <neilb@suse.de>
> 
> NeilBrown
> 
> > +
> > +static inline void svc_reclassify_socket(struct socket *sock)
> > +{
> > +	struct sock *sk = sock->sk;
> > +	BUG_ON(sk->sk_lock.owner != NULL);
> > +	switch (sk->sk_family) {
> > +		case AF_INET:
> > +			sock_lock_init_class_and_name(sk,
> > +				"slock-AF_INET-NFSD", &svc_slock_key[0],
> > +				"sk_lock-AF_INET-NFSD", &svc_key[0]);
> > +			break;
> > +
> > +		case AF_INET6:
> > +			sock_lock_init_class_and_name(sk,
> > +				"slock-AF_INET6-NFSD", &svc_slock_key[1],
> > +				"sk_lock-AF_INET6-NFSD", &svc_key[1]);
> > +			break;
> > +
> > +		default:
> > +			BUG();
> > +	}
> > +}

