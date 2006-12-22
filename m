Return-Path: <linux-kernel-owner+w=401wt.eu-S1423082AbWLVO3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423082AbWLVO3T (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 09:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423074AbWLVO3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 09:29:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:56994 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423032AbWLVO3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 09:29:18 -0500
X-Authenticated: #704063
Subject: Possible Circular Locking in TIPC
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: per.liden@ericsson.com
Content-Type: text/plain
Date: Fri, 22 Dec 2006 15:28:46 +0100
Message-Id: <1166797726.18915.4.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

while running my usual stuff on 2.6.20-rc1-git5, sfuzz (http://www.digitaldwarf.be/products/sfuzz.c)
did the following, to produce the lockdep warning below:

socket(1, 3, 1)
        accept(3, "\x54\x1f\x6d\x30\x0b\x0b\x44\xb2\x6c\x57\x8f\xcd\x12\x8b\x67\xa0", 32)
        accept(3, "\x7d\xa0\x2c\x64\x45\x57\xdf\x36\xe5\x7f\xd0\x1c\x5e\x78\x6b\x0e", 16)
        setsockopt(3, 48, 206, "\x6e\xec\x11\x2a\xd1\xb0\x5d\xb9\xd9\xf4\x4e\x64\xe6\x78\xce\x46", 4)
        fstatfs(3, 0xbfff1cb8)
        listen(3, 5)
        fstatfs(3, 0xbfff1cb8)

socket(16, 3, 31)
        fstat(3, 0xbfff1cb8)
        getpeername(3, "\x7a\xcc\xda\xb9\x08\x52\x58\xfe\x30\x6e\xa7\x1e\x26\x6a\x3a\xbf", *-1652368178)
        accept(3, "\x9b\xf9\xf8\x16\x0f\x6c\x8a\x66\x0b\xf3\x5e\xeb\xcb\xa8\xac\x09", -106)
        getsockname(3, "\x68\x78\xb8\x46\x19\xe8\x61\xe1\xa7\x31\x5e\x6b\xd6\xe6\xbe\x7f", *256)
        listen(3, 9)
        shutdown(3, 0)
        shutdown(3, 0)
        fstatfs(3, 0xbfff1cb8)
        getsockopt(3, 28, 127, "\x41\x0e\x19\x52\x1e\x3f\xe9\x3c\xa3\xf0\x36\x9e\xd2\x02\x84\x03", *128)
        getsockopt(3, -170, 5, "\xfb\x48\x97\xdf\x7d\x4a\x79\x7a\x7e\x89\xe4\x3c\x36\x9f\x12\x30", *64)
        connect(3, "\xca\xbd\x43\xff\x7e\xa6\x47\x9a\x5a\x89\x1d\x3a\xfe\xcc\x6b\x21", -140)
        shutdown(3, 0)
        fstatfs(3, 0xbfff1cb8)
        bind(3, "\x25\x74\xed\xaf\x20\x5a\x1a\x75\xbc\x06\x37\x1d\x0a\x01\x41\x47", 32)
        fstat(3, 0xbfff1cb8)
        bind(3, "\xfd\xb5\x0c\x63\xd9\x32\xe6\x54\x0a\x93\xb7\xa6\x23\x68\x07\x00", 32)
        bind(3, "\x00\x7c\x05\xc6\xc7\xc2\x07\x68\xbd\x1d\x23\xe3\xea\x00\xec\xe7", 128)
        listen(3, 19)
        setsockopt(3, 197, -140, "\x84\x7b\xa2\xf8\x29\xf9\x2a\xd1\xd4\xe1\xa1\xcf\x5e\x7f\x6b\x4c", 32)


Here is the stacktrace:

[  313.239556] =======================================================
[  313.239718] [ INFO: possible circular locking dependency detected ]
[  313.239795] 2.6.20-rc1-git5 #26
[  313.239858] -------------------------------------------------------
[  313.239929] sfuzz/4133 is trying to acquire lock:
[  313.239996]  (ref_table_lock){-+..}, at: [<c04cd0a9>] tipc_ref_discard+0x29/0xe0
[  313.241101] 
[  313.241105] but task is already holding lock:
[  313.241225]  (&table[i].lock){-+..}, at: [<c04cb7c0>] tipc_deleteport+0x40/0x1a0
[  313.241524] 
[  313.241528] which lock already depends on the new lock.
[  313.241535] 
[  313.241709] 
[  313.241713] the existing dependency chain (in reverse order) is:
[  313.241837] 
[  313.241841] -> #1 (&table[i].lock){-+..}:
[  313.242096]        [<c01366c5>] __lock_acquire+0xd05/0xde0
[  313.242562]        [<c0136809>] lock_acquire+0x69/0xa0
[  313.243013]        [<c04d4040>] _spin_lock_bh+0x40/0x60
[  313.243476]        [<c04cd1cb>] tipc_ref_acquire+0x6b/0xe0
[  313.244115]        [<c04cac73>] tipc_createport_raw+0x33/0x260
[  313.244562]        [<c04cbe21>] tipc_createport+0x41/0x120
[  313.245007]        [<c04c57ec>] tipc_subscr_start+0xcc/0x120
[  313.245458]        [<c04bdb56>] process_signal_queue+0x56/0xa0
[  313.245906]        [<c011ea18>] tasklet_action+0x38/0x80
[  313.246361]        [<c011ecbb>] __do_softirq+0x5b/0xc0
[  313.246817]        [<c01060e8>] do_softirq+0x88/0xe0
[  313.247450]        [<ffffffff>] 0xffffffff
[  313.247894] 
[  313.247898] -> #0 (ref_table_lock){-+..}:
[  313.248155]        [<c0136415>] __lock_acquire+0xa55/0xde0
[  313.248601]        [<c0136809>] lock_acquire+0x69/0xa0
[  313.249037]        [<c04d4100>] _write_lock_bh+0x40/0x60
[  313.249486]        [<c04cd0a9>] tipc_ref_discard+0x29/0xe0
[  313.249922]        [<c04cb7da>] tipc_deleteport+0x5a/0x1a0
[  313.250543]        [<c04cd4f8>] tipc_create+0x58/0x160
[  313.250980]        [<c0431cb2>] __sock_create+0x112/0x280
[  313.251422]        [<c0431e5a>] sock_create+0x1a/0x20
[  313.251863]        [<c04320fb>] sys_socket+0x1b/0x40
[  313.252301]        [<c0432a72>] sys_socketcall+0x92/0x260
[  313.252738]        [<c0102fd0>] syscall_call+0x7/0xb
[  313.253175]        [<ffffffff>] 0xffffffff
[  313.253778] 
[  313.253782] other info that might help us debug this:
[  313.253790] 
[  313.253956] 1 lock held by sfuzz/4133:
[  313.254019]  #0:  (&table[i].lock){-+..}, at: [<c04cb7c0>] tipc_deleteport+0x40/0x1a0
[  313.254346] 
[  313.254351] stack backtrace:
[  313.254470]  [<c01045da>] show_trace_log_lvl+0x1a/0x40
[  313.254594]  [<c0104d72>] show_trace+0x12/0x20
[  313.254711]  [<c0104e79>] dump_stack+0x19/0x20
[  313.254829]  [<c013480f>] print_circular_bug_tail+0x6f/0x80
[  313.254952]  [<c0136415>] __lock_acquire+0xa55/0xde0
[  313.255070]  [<c0136809>] lock_acquire+0x69/0xa0
[  313.255188]  [<c04d4100>] _write_lock_bh+0x40/0x60
[  313.255315]  [<c04cd0a9>] tipc_ref_discard+0x29/0xe0
[  313.255435]  [<c04cb7da>] tipc_deleteport+0x5a/0x1a0
[  313.255565]  [<c04cd4f8>] tipc_create+0x58/0x160
[  313.255687]  [<c0431cb2>] __sock_create+0x112/0x280
[  313.255811]  [<c0431e5a>] sock_create+0x1a/0x20
[  313.255942]  [<c04320fb>] sys_socket+0x1b/0x40
[  313.256059]  [<c0432a72>] sys_socketcall+0x92/0x260
[  313.256179]  [<c0102fd0>] syscall_call+0x7/0xb
[  313.256300]  =======================

Greetings, Eric

