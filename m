Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWCJMEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWCJMEa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 07:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWCJMEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 07:04:30 -0500
Received: from stinky.trash.net ([213.144.137.162]:16592 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1750702AbWCJMEa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 07:04:30 -0500
Message-ID: <44116ADF.7060604@trash.net>
Date: Fri, 10 Mar 2006 13:02:39 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Norbert Wegener <nw@sbs.de>
CC: linux-kernel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [netfilter-core] BUG: soft lockup detected on CPU#0!
References: <440AD8FE.3000900@sbs.de>
In-Reply-To: <440AD8FE.3000900@sbs.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------070702050604090301060600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070702050604090301060600
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Norbert Wegener wrote:
> Mar  5 12:48:15 nobbi kernel: ip_conntrack version 2.4 (3583 buckets,
> 28664 max) - 232 bytes per conntrack
> Mar  5 12:48:44 nobbi kernel: BUG: soft lockup detected on CPU#0!
> Mar  5 12:48:44 nobbi kernel:
> Mar  5 12:48:44 nobbi kernel: Pid: 12848, comm:                rmmod
> Mar  5 12:48:44 nobbi kernel: EIP: 0060:[<c011b230>] CPU: 0
> Mar  5 12:48:44 nobbi kernel: EIP is at local_bh_enable+0x1/0x5c
> Mar  5 12:48:44 nobbi kernel:  EFLAGS: 00000202    Not tainted 
> (2.6.15.1-default)
> Mar  5 12:48:44 nobbi kernel: EAX: 00000000 EBX: cdcabb10 ECX: c35dbf4c
> EDX: cdcabb10
> Mar  5 12:48:44 nobbi kernel: ESI: c35dbf4c EDI: 00000000 EBP: dd243db0
> DS: 007b ES: 007b
> Mar  5 12:48:44 nobbi kernel: CR0: 8005003b CR2: 0805e30c CR3: 059d5000
> CR4: 000006d0
> Mar  5 12:48:44 nobbi kernel:  [<dd243c54>] get_next_corpse+0xc7/0xce
> [ip_conntrack]
> Mar  5 12:48:44 nobbi kernel:  [<dd243db0>] kill_all+0x0/0x6 [ip_conntrack]
> Mar  5 12:48:44 nobbi kernel:  [<dd243cb5>]
> ip_ct_iterate_cleanup+0x5a/0x66 [ip_conntrack]
> Mar  5 12:48:44 nobbi kernel:  [<dd243dea>]
> ip_conntrack_cleanup+0x14/0x65 [ip_conntrack]
> Mar  5 12:48:45 nobbi kernel:  [<dd2427e9>] init_or_cleanup+0x24b/0x24f
> [ip_conntrack]
> Mar  5 12:48:45 nobbi kernel:  [<c0129642>] sys_delete_module+0x11f/0x14f
> Mar  5 12:48:45 nobbi kernel:  [<c0140905>] do_munmap+0xd2/0xe8
> Mar  5 12:48:45 nobbi kernel:  [<c01029db>] sysenter_past_esp+0x54/0x79

Can you reproduce the problem (by rmmod'ing ip_conntrack)? If so please
try if this patch helps.

--------------070702050604090301060600
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

diff --git a/net/ipv4/netfilter/ip_conntrack_core.c b/net/ipv4/netfilter/ip_conntrack_core.c
index 84c66db..fd16083 100644
--- a/net/ipv4/netfilter/ip_conntrack_core.c
+++ b/net/ipv4/netfilter/ip_conntrack_core.c
@@ -1251,9 +1251,6 @@ get_next_corpse(int (*iter)(struct ip_co
 		if (h)
 			break;
 	}
-	if (!h)
-		h = LIST_FIND_W(&unconfirmed, do_iter,
-				struct ip_conntrack_tuple_hash *, iter, data);
 	if (h)
 		atomic_inc(&tuplehash_to_ctrack(h)->ct_general.use);
 	write_unlock_bh(&ip_conntrack_lock);
@@ -1267,6 +1264,9 @@ ip_ct_iterate_cleanup(int (*iter)(struct
 	struct ip_conntrack_tuple_hash *h;
 	unsigned int bucket = 0;
 
+	/* make sure there are no unconfirmed conntracks */
+	synchronize_net();
+
 	while ((h = get_next_corpse(iter, data, &bucket)) != NULL) {
 		struct ip_conntrack *ct = tuplehash_to_ctrack(h);
 		/* Time to push up daises... */

--------------070702050604090301060600--
