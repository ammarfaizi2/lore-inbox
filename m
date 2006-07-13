Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWGMJRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWGMJRq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 05:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWGMJRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 05:17:46 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:26121 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S964858AbWGMJRp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 05:17:45 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: davej@redhat.com (Dave Jones)
Subject: Re: another networking lockdep bug
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, arjan@infradead.org,
       mingo@elte.hu
Organization: Core
In-Reply-To: <20060713040715.GE4199@redhat.com>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1G0xKA-0007Ts-00@gondolin.me.apana.org.au>
Date: Thu, 13 Jul 2006 19:17:34 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
> Not sure if this one got reported/fixed yet, as I was running
> a kernel from sometime last week..

I think we've seen a couple of similar ones, this one is more
elaborate though :)
 
> -> #1 (rtnl_mutex){--..}:
>       [<ffffffff802ab792>] lock_acquire+0x4a/0x69
>       [<ffffffff802691c2>] __mutex_lock_slowpath+0xeb/0x29f
>       [<ffffffff8026939f>] mutex_lock+0x29/0x2e
>       [<ffffffff8042d973>] rtnl_lock+0xf/0x12
>       [<ffffffff8045c18a>] ip_mc_leave_group+0x1e/0xae
>       [<ffffffff80446087>] do_ip_setsockopt+0x6ad/0x9b2
>       [<ffffffff8044643a>] ip_setsockopt+0x2a/0x84
>       [<ffffffff80454328>] udp_setsockopt+0xd/0x1c
>       [<ffffffff8041f094>] sock_common_setsockopt+0xe/0x11
>       [<ffffffff8041e20f>] sys_setsockopt+0x8e/0xb4
>       [<ffffffff80262fd9>] tracesys+0xd0/0xdb
> 
> -> #0 (sk_lock-AF_INET){--..}:
>       [<ffffffff802ab792>] lock_acquire+0x4a/0x69
>       [<ffffffff8023726c>] lock_sock+0xd4/0xe7
>       [<ffffffff80228061>] tcp_sendmsg+0x1e/0xb1a
>       [<ffffffff80248ff8>] inet_sendmsg+0x45/0x53
>       [<ffffffff80259dd3>] sock_sendmsg+0x110/0x130
>       [<ffffffff8041ed0c>] kernel_sendmsg+0x3c/0x52
>       [<ffffffff8853c9e9>] xs_tcp_send_request+0x117/0x320 [sunrpc]
>       [<ffffffff8853b8d5>] xprt_transmit+0x105/0x21e [sunrpc]
>       [<ffffffff8853a71e>] call_transmit+0x1f4/0x239 [sunrpc]
>       [<ffffffff8853f06e>] __rpc_execute+0x9b/0x1e6 [sunrpc]
>       [<ffffffff8853f1de>] rpc_execute+0x1a/0x1d [sunrpc]
>       [<ffffffff885394ad>] rpc_call_sync+0x87/0xb9 [sunrpc]
>       [<ffffffff885a5587>] nfs3_rpc_wrapper+0x2e/0x74 [nfs]
>       [<ffffffff885a5870>] nfs3_proc_setattr+0x9b/0xd3 [nfs]
>       [<ffffffff8859bffb>] nfs_setattr+0xe9/0x11e [nfs]
>       [<ffffffff8022f7b4>] notify_change+0x154/0x2f7
>       [<ffffffff802e00c7>] do_truncate+0x52/0x72
>       [<ffffffff80212d17>] may_open+0x1d5/0x231
>       [<ffffffff8021c270>] open_namei+0x290/0x6b4
>       [<ffffffff80229974>] do_filp_open+0x27/0x46
>       [<ffffffff8021acb7>] do_sys_open+0x4e/0xcd
>       [<ffffffff80234b2a>] sys_open+0x1a/0x1d
>       [<ffffffff80262fd9>] tracesys+0xd0/0xdb

We know this is a false positive because the NFS sockets are not
exported to user-space and therefore #1 can't happen.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
