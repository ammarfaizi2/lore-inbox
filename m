Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWJIIEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWJIIEL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 04:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWJIIEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 04:04:11 -0400
Received: from mail.suse.de ([195.135.220.2]:31361 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932243AbWJIIEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 04:04:09 -0400
From: Neil Brown <neilb@suse.de>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Mon, 9 Oct 2006 11:00:21 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17705.40741.552103.194329@cse.unsw.edu.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       steved@redhat.com, Ingo Molnar <mingo@elte.hu>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [PATCH] lockdep: annotate nfs/nfsd in-kernel sockets
In-Reply-To: message from Peter Zijlstra on Friday October 6
References: <1160146860.2792.111.camel@taijtu>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday October 6, a.p.zijlstra@chello.nl wrote:
> 
> Stick NFS sockets in their own class to avoid some lockdep warnings.
> NFS sockets are never exposed to user-space, and will hence not trigger
> certain code paths that would otherwise pose deadlock scenarios.

I'm a bit bothered that the changelog entry does mention what sort of
lockdep warning are begin avoided, and that 'svc_reclassify_socket'
doesn't contain the work 'lock', yet is it really the locks that are
being reclassified.  However

Acked-by: NeilBrown <neilb@suse.de>

NeilBrown

> +
> +static inline void svc_reclassify_socket(struct socket *sock)
> +{
> +	struct sock *sk = sock->sk;
> +	BUG_ON(sk->sk_lock.owner != NULL);
> +	switch (sk->sk_family) {
> +		case AF_INET:
> +			sock_lock_init_class_and_name(sk,
> +				"slock-AF_INET-NFSD", &svc_slock_key[0],
> +				"sk_lock-AF_INET-NFSD", &svc_key[0]);
> +			break;
> +
> +		case AF_INET6:
> +			sock_lock_init_class_and_name(sk,
> +				"slock-AF_INET6-NFSD", &svc_slock_key[1],
> +				"sk_lock-AF_INET6-NFSD", &svc_key[1]);
> +			break;
> +
> +		default:
> +			BUG();
> +	}
> +}
