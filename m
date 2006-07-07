Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWGGSsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWGGSsl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 14:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWGGSsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 14:48:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42196 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932205AbWGGSsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 14:48:40 -0400
Subject: Re: starting mc triggers lockdep
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: mingo@elte.hu, akpm@osdl.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
In-Reply-To: <20060707161314.GA3223@redhat.com>
References: <20060707161314.GA3223@redhat.com>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 20:48:33 +0200
Message-Id: <1152298113.3111.134.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-07 at 12:13 -0400, Dave Jones wrote:
> With 2.6.18rc1 + a selection of the lockdep tweaks found so far,
> midnight commander makes the kernel unhappy.
> 
> 		Dave
> 
> 
> =======================================================
> [ INFO: possible circular locking dependency detected ]
> -------------------------------------------------------
> mc/4913 is trying to acquire lock:
>  (sk_lock-AF_INET){--..}, at: [<ffffffff8022800c>] tcp_sendmsg+0x1f/0xb1a
> 
> but task is already holding lock:
>  (&inode->i_mutex){--..}, at: [<ffffffff802692e0>] mutex_lock+0x2a/0x2e
> 
> which lock already depends on the new lock.


ok this looks like a fun three-way variant of the traditional AB-BA
deadlock... an ABCA deadlock :)

Lock A: rtnl_mutex
Lock B: i_mutex
Lock C: sk_lock for AF_INET


i_mutex is taken within rtln_mutex like this:
       [<ffffffff8030f4a0>] create_dir+0x2c/0x1e2
       [<ffffffff8030fa5b>] sysfs_create_dir+0x59/0x78
       [<ffffffff8034d2e2>] kobject_add+0x114/0x1d8
       [<ffffffff803bb1e7>] class_device_add+0xb5/0x49d
       [<ffffffff804300b1>] netdev_register_sysfs+0x98/0xa2
       [<ffffffff80426f58>] register_netdevice+0x28c/0x376
       [<ffffffff8042709c>] register_netdev+0x5a/0x69
creating the AB dependency

now for the second part:
if you use the IP_DROP_MEMBERSHIP socket option, you end up going into
the function do_ip_setsockopt(), which first does a lock_sock(), and
then a call to ip_mc_leave_group(), which calls rtnl_lock()
So we have the CA dependency right here.

now for the third part, which involves the nfs client:
stat on an nfs file, which ends up taken the i_mutex of a directory in
the path (obvious), and then does 
       [<ffffffff8022800b>] tcp_sendmsg+0x1e/0xb1a
       [<ffffffff80248f4b>] inet_sendmsg+0x45/0x53
       [<ffffffff80259d25>] sock_sendmsg+0x110/0x130
       [<ffffffff8041f462>] kernel_sendmsg+0x3c/0x52
       [<ffffffff885399e9>] xs_tcp_send_request+0x117/0x320 [sunrpc]
       [<ffffffff885388d5>] xprt_transmit+0x105/0x21e [sunrpc]
       [<ffffffff8853771e>] call_transmit+0x1f4/0x239 [sunrpc]
       [<ffffffff8853c06e>] __rpc_execute+0x9b/0x1e6 [sunrpc]
       [<ffffffff8853c1de>] rpc_execute+0x1a/0x1d [sunrpc]
       [<ffffffff885364ad>] rpc_call_sync+0x87/0xb9 [sunrpc]
       [<ffffffff885a2587>] nfs3_rpc_wrapper+0x2e/0x74 [nfs]
       [<ffffffff885a2a14>] nfs3_proc_lookup+0xe0/0x163 [nfs]
where tcp_sendmsg calls lock_sock. So this is the BC dependency.


In summary, we have an AB dependency, a BC dependency and a CA
dependency. This is reason for lockdep to conclude that there is a
circular dependency happening, which, looking at my analysis, seems to
be at least reasonably right...




