Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWGHLNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWGHLNi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 07:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWGHLNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 07:13:36 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:35600 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S964779AbWGHLNB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 07:13:01 -0400
Date: Sat, 8 Jul 2006 21:12:40 +1000
To: Arjan van de Ven <arjan@infradead.org>
Cc: davej@redhat.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: starting mc triggers lockdep
Message-ID: <20060708111240.GA7612@gondor.apana.org.au>
References: <E1Fz33I-0006vG-00@gondolin.me.apana.org.au> <1152352400.3120.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152352400.3120.19.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2006 at 11:53:20AM +0200, Arjan van de Ven wrote:
>
> > > now for the third part, which involves the nfs client:
> > > stat on an nfs file, which ends up taken the i_mutex of a directory in
> > > the path (obvious), and then does 
> > >       [<ffffffff8022800b>] tcp_sendmsg+0x1e/0xb1a
> > >       [<ffffffff80248f4b>] inet_sendmsg+0x45/0x53
> > >       [<ffffffff80259d25>] sock_sendmsg+0x110/0x130
> > >       [<ffffffff8041f462>] kernel_sendmsg+0x3c/0x52
> > >       [<ffffffff885399e9>] xs_tcp_send_request+0x117/0x320 [sunrpc]
> > >       [<ffffffff885388d5>] xprt_transmit+0x105/0x21e [sunrpc]
> > >       [<ffffffff8853771e>] call_transmit+0x1f4/0x239 [sunrpc]
> > >       [<ffffffff8853c06e>] __rpc_execute+0x9b/0x1e6 [sunrpc]
> > >       [<ffffffff8853c1de>] rpc_execute+0x1a/0x1d [sunrpc]
> > >       [<ffffffff885364ad>] rpc_call_sync+0x87/0xb9 [sunrpc]
> > >       [<ffffffff885a2587>] nfs3_rpc_wrapper+0x2e/0x74 [nfs]
> > >       [<ffffffff885a2a14>] nfs3_proc_lookup+0xe0/0x163 [nfs]
> > > where tcp_sendmsg calls lock_sock. So this is the BC dependency.
> > 
> > This is an nfs inode.
> > 
> > Did I miss something?
> 
> is it not possible to nfs export /sys, and then mount it over loopback?

Possibly, but not with the backtrace above.  You'd need an nfs server
backtrace to get the real sysfs inode.

In any case, the sock lock from the other backtrace that you had
(udp setsockopt) cannot be held by the kernel nfs client or server
since the kernel nfs sockets are not visible to user space.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
