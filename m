Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267199AbUIBFmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267199AbUIBFmQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 01:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267511AbUIBFmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 01:42:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64938 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267199AbUIBFmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 01:42:12 -0400
Date: Wed, 1 Sep 2004 22:41:08 -0700
From: "David S. Miller" <davem@redhat.com>
To: vatsa@in.ibm.com
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       paulmck@us.ibm.com
Subject: Re: [RFC] Use RCU for tcp_ehash lookup
Message-Id: <20040901224108.3b2d692d.davem@redhat.com>
In-Reply-To: <20040831125941.GA5534@in.ibm.com>
References: <20040831125941.GA5534@in.ibm.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2004 18:29:41 +0530
Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:

> Some notes on the patch:
> 
> - Although readprofile shows improvement in tick count for
>   __tcp_v4_lookup_established, I haven't come across any benchmarks that is
>   benefited noticeably by the lock-free lookup. I have tried httperf, netperf
>   and simple file transfer tests so far.
> 
>   This could possibly be because the hash table size on the machines I was
>   testing was high (tcp_ehash_size = 128K), leading to low contention rate on
>   the hash bucket locks. Also because of the fact that lookup could happen in
>   parallel to socket input packet processing.
> 
>   I would be interested to know if anyone has seen high-rate of lock contention
>   for hash bucket lock. Such workloads would benefit from the lock-free lookup.

The reason you don't see any improvement is that the ehash table is
pretty write heavy.

I'm not totally against your patch, I just don't think that the TCP established
hash table qualifies as "read heavy" as per what RCU is truly effective for.

> - I presume that one of the reasons for keeping the hash table so big is to
>   keep lock contention low (& to reduce the size of hash chains). If the lookup
>   is made lock-free, then could the size of the hash table be reduced (without
>   adversely impacting performance)?

It's large so that the hash itself is effective, not for locking reasons.

> - Biggest problem I had converting over to RCU was the refcount race between
>   sock_put and sock_hold. sock_put might see the refcount go to zero and decide
>   to free the object, while on some other CPU, sock_get's are pending against
>   the same object. The patch handles the race by deciding to free the object
>   only from the RCU callback.

That's exactly what I was concerned about when I saw that you had attempted
this change.  It is incredibly important for state changes and updates to
be seen as atomic by the packet input processing engine.  It would be illegal
for a cpu running TCP input to see a socket in two tables at the same time
(for example, in the main established area and in the second half for TIME_WAIT
buckets).

If the visibility of the socket is wrong, sockets could be erroneously
be reset during the transition from established to TIME_WAIT state.
Beware!

> - Socket table lookups that happens thr', say /proc/net/tcp or tcpdiag_dump, is
>   not lock-free yet. This is because of movement of socket performed in
>   __tcp_tw_hashdance, between established half to time-wait half.
>   There is a window during this movement, when the same socket is present
>   on both time-wait half as well as established half. I felt that it is not
>   good to have /proc/net/tcp report two instances of the same socket. Hence
>   I resorted to have /proc/net/tcp and tcpdiag_dump doing the lookup using
>   a spinlock.

/proc/net/tcp should simply not be used by people, we
have the netlink interface to get socket listings which
actually scales.

Leaving /proc/net/tcp readable on servers with real users is
a DoS waiting to happen.

>   Note that __tcp_v4_lookup_established should not be affected by the above
>   movement because I found it scans the established half first and _then_ the
>   time wait half. So even if the same socket is present in both established half
>   and time wait half, __tcp_v4_lookup_established will lookup only one of them
>   (& not both).

I hope this is true.
