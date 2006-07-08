Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbWGHDAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbWGHDAz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 23:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWGHDAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 23:00:55 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:21259 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932494AbWGHDAy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 23:00:54 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: arjan@infradead.org (Arjan van de Ven)
Subject: Re: starting mc triggers lockdep
Cc: davej@redhat.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Organization: Core
In-Reply-To: <1152298113.3111.134.camel@laptopd505.fenrus.org>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1Fz33I-0006vG-00@gondolin.me.apana.org.au>
Date: Sat, 08 Jul 2006 13:00:16 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
> 
> i_mutex is taken within rtln_mutex like this:
>       [<ffffffff8030f4a0>] create_dir+0x2c/0x1e2
>       [<ffffffff8030fa5b>] sysfs_create_dir+0x59/0x78
>       [<ffffffff8034d2e2>] kobject_add+0x114/0x1d8
>       [<ffffffff803bb1e7>] class_device_add+0xb5/0x49d
>       [<ffffffff804300b1>] netdev_register_sysfs+0x98/0xa2
>       [<ffffffff80426f58>] register_netdevice+0x28c/0x376
>       [<ffffffff8042709c>] register_netdev+0x5a/0x69
> creating the AB dependency

This is a sysfs inode.

> now for the third part, which involves the nfs client:
> stat on an nfs file, which ends up taken the i_mutex of a directory in
> the path (obvious), and then does 
>       [<ffffffff8022800b>] tcp_sendmsg+0x1e/0xb1a
>       [<ffffffff80248f4b>] inet_sendmsg+0x45/0x53
>       [<ffffffff80259d25>] sock_sendmsg+0x110/0x130
>       [<ffffffff8041f462>] kernel_sendmsg+0x3c/0x52
>       [<ffffffff885399e9>] xs_tcp_send_request+0x117/0x320 [sunrpc]
>       [<ffffffff885388d5>] xprt_transmit+0x105/0x21e [sunrpc]
>       [<ffffffff8853771e>] call_transmit+0x1f4/0x239 [sunrpc]
>       [<ffffffff8853c06e>] __rpc_execute+0x9b/0x1e6 [sunrpc]
>       [<ffffffff8853c1de>] rpc_execute+0x1a/0x1d [sunrpc]
>       [<ffffffff885364ad>] rpc_call_sync+0x87/0xb9 [sunrpc]
>       [<ffffffff885a2587>] nfs3_rpc_wrapper+0x2e/0x74 [nfs]
>       [<ffffffff885a2a14>] nfs3_proc_lookup+0xe0/0x163 [nfs]
> where tcp_sendmsg calls lock_sock. So this is the BC dependency.

This is an nfs inode.

Did I miss something?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
