Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWF2T4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWF2T4u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWF2T4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:56:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41350 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932262AbWF2T4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:56:48 -0400
Date: Thu, 29 Jun 2006 12:56:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: miles.lane@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.17-mm3 -- BUG: illegal lock usage -- illegal {softirq-on-W}
 -> {in-softirq-R} usage.
Message-Id: <20060629125640.d828a0b3.akpm@osdl.org>
In-Reply-To: <1151610155.3122.65.camel@laptopd505.fenrus.org>
References: <a44ae5cd0606291201v659b4235sfa9941aa3b18e766@mail.gmail.com>
	<20060629122608.440d474c.akpm@osdl.org>
	<1151610155.3122.65.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 21:42:34 +0200
Arjan van de Ven <arjan@infradead.org> wrote:

> On Thu, 2006-06-29 at 12:26 -0700, Andrew Morton wrote:
> > On Thu, 29 Jun 2006 12:01:06 -0700
> > "Miles Lane" <miles.lane@gmail.com> wrote:
> > 
> > > [ BUG: illegal lock usage! ]
> > > ----------------------------
> > 
> > This is claiming that we're taking sk->sk_dst_lock in a deadlockable manner.
> > 
> > > illegal {softirq-on-W} -> {in-softirq-R} usage.
> > 
> > It found someone doing write_lock(sk_dst_lock) with softirqs enabled, but
> > someone else takes read_lock(dst_lock) inside softirqs.
> > 
> > > java_vm/4418 [HC0[0]:SC1[1]:HE1:SE0] takes:
> > >  (&sk->sk_dst_lock){---?}, at: [<c119d0a9>] sk_dst_check+0x1b/0xe6
> > > {softirq-on-W} state was registered at:
> > >   [<c102d1c8>] lock_acquire+0x60/0x80
> > >   [<c12012d7>] _write_lock+0x23/0x32
> > >   [<c11ddbe7>] inet_bind+0x16c/0x1cc
> > >   [<c119ae58>] sys_bind+0x61/0x80
> > >   [<c119b465>] sys_socketcall+0x7d/0x186
> > >   [<c1002d6d>] sysenter_past_esp+0x56/0x8d
> > 
> > 	inet_bind()
> > 	->sk_dst_get
> > 	  ->read_lock(&sk->sk_dst_lock)
> 
> actually write_lock() not read_lock()
> 

static inline struct dst_entry *
sk_dst_get(struct sock *sk)
{
	struct dst_entry *dst;

	read_lock(&sk->sk_dst_lock);

> > 
> > > irq event stamp: 11052
> > > hardirqs last  enabled at (11052): [<c105d454>] kmem_cache_alloc+0x89/0xa6
> > > hardirqs last disabled at (11051): [<c105d405>] kmem_cache_alloc+0x3a/0xa6
> > > softirqs last  enabled at (11040): [<c11a506d>] dev_queue_xmit+0x224/0x24b
> > > softirqs last disabled at (11041): [<c1004a64>] do_softirq+0x58/0xbd
> > > 
> > > other info that might help us debug this:
> > > 1 lock held by java_vm/4418:
> > >  #0:  (af_family_keys + (sk)->sk_family#4){-+..}, at: [<f93c9281>]
> > > tcp_v6_rcv+0x308/0x7b7 [ipv6]
> > 
> > 	softirq
> > 	->ip6_dst_lookup
> > 	  ->sk_dst_check
> > 	    ->sk_dst_reset
> > 	      ->write_lock(&sk->sk_dst_lock);
> 
> write_lock.. or read_lock() ? 

static inline void
sk_dst_reset(struct sock *sk)
{
	write_lock(&sk->sk_dst_lock);

> > 
> > > stack backtrace:
> > >  [<c1003502>] show_trace_log_lvl+0x54/0xfd
> > >  [<c1003b6a>] show_trace+0xd/0x10
> > >  [<c1003c0e>] dump_stack+0x19/0x1b
> > >  [<c102b833>] print_usage_bug+0x1cc/0x1d9
> > >  [<c102bd34>] mark_lock+0x193/0x360
> > >  [<c102c94a>] __lock_acquire+0x3b7/0x970
> > >  [<c102d1c8>] lock_acquire+0x60/0x80
> > >  [<c12013eb>] _read_lock+0x23/0x32
> 
> backtrace says read lock to me ...
> > >  [<c119d0a9>] sk_dst_check+0x1b/0xe6
> > >  [<f93ae479>] ip6_dst_lookup+0x31/0x172 [ipv6]
> > >  [<f93c7065>] tcp_v6_send_synack+0x10f/0x238 [ipv6]
> > >  [<f93c7dc5>] tcp_v6_conn_request+0x281/0x2c7 [ipv6]
> > >  [<c11cca33>] tcp_rcv_state_process+0x5d/0xbde
> 
> 
> > So the allegation is that if a softirq runs sk_dst_reset() while
> > process-context code is running sk_dst_set(), we'll do write_lock() while
> > holding read_lock().  
> 
> hmm or...
> 
> we're doing a write_lock(), then an interrupt can happen that triggers
> the softirq that triggers the read_lock(), which will deadlock because
> we interrupted the writer...
> 

either way ain't good ;)

