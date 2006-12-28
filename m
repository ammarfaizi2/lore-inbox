Return-Path: <linux-kernel-owner+w=401wt.eu-S1754831AbWL1MPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831AbWL1MPm (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 07:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754830AbWL1MPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 07:15:42 -0500
Received: from mx10.go2.pl ([193.17.41.74]:40756 "EHLO poczta.o2.pl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753505AbWL1MPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 07:15:41 -0500
Date: Thu, 28 Dec 2006 13:17:02 +0100
From: Jarek Poplawski <jarkao2@o2.pl>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: Per Liden <per.liden@ericsson.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] tipc: checking returns and Re: Possible Circular Locking in TIPC
Message-ID: <20061228121702.GA5076@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166797726.18915.4.camel@alice>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-12-2006 15:28, Eric Sesterhenn wrote:
> hi,
> 
> while running my usual stuff on 2.6.20-rc1-git5, sfuzz (http://www.digitaldwarf.be/products/sfuzz.c)
> did the following, to produce the lockdep warning below:
...
> Here is the stacktrace:
> 
> [  313.239556] =======================================================
> [  313.239718] [ INFO: possible circular locking dependency detected ]
> [  313.239795] 2.6.20-rc1-git5 #26
> [  313.239858] -------------------------------------------------------
> [  313.239929] sfuzz/4133 is trying to acquire lock:
> [  313.239996]  (ref_table_lock){-+..}, at: [<c04cd0a9>] tipc_ref_discard+0x29/0xe0
> [  313.241101] 
> [  313.241105] but task is already holding lock:
> [  313.241225]  (&table[i].lock){-+..}, at: [<c04cb7c0>] tipc_deleteport+0x40/0x1a0
> [  313.241524] 
> [  313.241528] which lock already depends on the new lock.
> [  313.241535] 
> [  313.241709] 
> [  313.241713] the existing dependency chain (in reverse order) is:
> [  313.241837] 
> [  313.241841] -> #1 (&table[i].lock){-+..}:
> [  313.242096]        [<c01366c5>] __lock_acquire+0xd05/0xde0
> [  313.242562]        [<c0136809>] lock_acquire+0x69/0xa0
> [  313.243013]        [<c04d4040>] _spin_lock_bh+0x40/0x60
> [  313.243476]        [<c04cd1cb>] tipc_ref_acquire+0x6b/0xe0
> [  313.244115]        [<c04cac73>] tipc_createport_raw+0x33/0x260
> [  313.244562]        [<c04cbe21>] tipc_createport+0x41/0x120
> [  313.245007]        [<c04c57ec>] tipc_subscr_start+0xcc/0x120
> [  313.245458]        [<c04bdb56>] process_signal_queue+0x56/0xa0
> [  313.245906]        [<c011ea18>] tasklet_action+0x38/0x80
> [  313.246361]        [<c011ecbb>] __do_softirq+0x5b/0xc0
> [  313.246817]        [<c01060e8>] do_softirq+0x88/0xe0
> [  313.247450]        [<ffffffff>] 0xffffffff
> [  313.247894] 
> [  313.247898] -> #0 (ref_table_lock){-+..}:
> [  313.248155]        [<c0136415>] __lock_acquire+0xa55/0xde0
> [  313.248601]        [<c0136809>] lock_acquire+0x69/0xa0
> [  313.249037]        [<c04d4100>] _write_lock_bh+0x40/0x60
> [  313.249486]        [<c04cd0a9>] tipc_ref_discard+0x29/0xe0
> [  313.249922]        [<c04cb7da>] tipc_deleteport+0x5a/0x1a0
> [  313.250543]        [<c04cd4f8>] tipc_create+0x58/0x160
> [  313.250980]        [<c0431cb2>] __sock_create+0x112/0x280
> [  313.251422]        [<c0431e5a>] sock_create+0x1a/0x20
> [  313.251863]        [<c04320fb>] sys_socket+0x1b/0x40
> [  313.252301]        [<c0432a72>] sys_socketcall+0x92/0x260
> [  313.252738]        [<c0102fd0>] syscall_call+0x7/0xb
> [  313.253175]        [<ffffffff>] 0xffffffff
> [  313.253778] 
> [  313.253782] other info that might help us debug this:
> [  313.253790] 
> [  313.253956] 1 lock held by sfuzz/4133:
> [  313.254019]  #0:  (&table[i].lock){-+..}, at: [<c04cb7c0>] tipc_deleteport+0x40/0x1a0
> [  313.254346] 
> [  313.254351] stack backtrace:
> [  313.254470]  [<c01045da>] show_trace_log_lvl+0x1a/0x40
> [  313.254594]  [<c0104d72>] show_trace+0x12/0x20
> [  313.254711]  [<c0104e79>] dump_stack+0x19/0x20
> [  313.254829]  [<c013480f>] print_circular_bug_tail+0x6f/0x80
> [  313.254952]  [<c0136415>] __lock_acquire+0xa55/0xde0
> [  313.255070]  [<c0136809>] lock_acquire+0x69/0xa0
> [  313.255188]  [<c04d4100>] _write_lock_bh+0x40/0x60
> [  313.255315]  [<c04cd0a9>] tipc_ref_discard+0x29/0xe0
> [  313.255435]  [<c04cb7da>] tipc_deleteport+0x5a/0x1a0
> [  313.255565]  [<c04cd4f8>] tipc_create+0x58/0x160
> [  313.255687]  [<c0431cb2>] __sock_create+0x112/0x280
> [  313.255811]  [<c0431e5a>] sock_create+0x1a/0x20
> [  313.255942]  [<c04320fb>] sys_socket+0x1b/0x40
> [  313.256059]  [<c0432a72>] sys_socketcall+0x92/0x260
> [  313.256179]  [<c0102fd0>] syscall_call+0x7/0xb
> [  313.256300]  =======================
> 
> Greetings, Eric

Hello,

Maybe I misinterpret this but, IMHO lockdep
complains about locks acquired in different
order: tipc_ref_acquire() gets ref_table_lock 
and then tipc_ret_table.entries[index]->lock,
but tipc_deleteport() inversely (with:
tipc_port_lock() and tipc_ref_discard()).
I hope maintainers will decide the correct
order.

Btw. there is a problem with tipc_ref_discard():
it should be called with tipc_port_lock, but
how to discard a ref if this lock can't be
acquired? Is it OK to call it without the lock
like in subscr_named_msg_event()?

Btw. #2: during this checking I've found
two places where return values from
tipc_ref_lock() and tipc_port_lock() are not 
checked, so I attach a patch proposal for
this (compiled but not tested):

Regards,
Jarek P.
---

[PATCH] tipc: checking returns from locking functions

Checking of return values from tipc_ref_lock()
and tipc_port_lock() added in 2 places. 

Signed-off-by: Jarek Poplawski <jarkao2@o2.pl>
---

diff -Nurp linux-2.6.20-rc2-/net/tipc/port.c linux-2.6.20-rc2/net/tipc/port.c
--- linux-2.6.20-rc2-/net/tipc/port.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.20-rc2/net/tipc/port.c	2006-12-28 11:05:17.000000000 +0100
@@ -238,7 +238,12 @@ u32 tipc_createport_raw(void *usr_handle
 		return 0;
 	}
 
-	tipc_port_lock(ref);
+	if (!tipc_port_lock(ref)) {
+		tipc_ref_discard(ref);
+		warn("Port creation failed, reference table invalid\n");
+		kfree(p_ptr);
+		return 0;
+	}
 	p_ptr->publ.ref = ref;
 	msg = &p_ptr->publ.phdr;
 	msg_init(msg, DATA_LOW, TIPC_NAMED_MSG, TIPC_OK, LONG_H_SIZE, 0);
diff -Nurp linux-2.6.20-rc2-/net/tipc/subscr.c linux-2.6.20-rc2/net/tipc/subscr.c
--- linux-2.6.20-rc2-/net/tipc/subscr.c	2006-12-18 09:01:04.000000000 +0100
+++ linux-2.6.20-rc2/net/tipc/subscr.c	2006-12-28 11:31:27.000000000 +0100
@@ -499,7 +499,12 @@ static void subscr_named_msg_event(void 
 
 	/* Add subscriber to topology server's subscriber list */
 
-	tipc_ref_lock(subscriber->ref);
+	if (!tipc_ref_lock(subscriber->ref)) {
+		warn("Subscriber rejected, unable to find port\n");
+		tipc_ref_discard(subscriber->ref);
+		kfree(subscriber);
+		return;
+	}
 	spin_lock_bh(&topsrv.lock);
 	list_add(&subscriber->subscriber_list, &topsrv.subscriber_list);
 	spin_unlock_bh(&topsrv.lock);
