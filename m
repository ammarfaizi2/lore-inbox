Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750764AbWFEUpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWFEUpK (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWFEUpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:45:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19669 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750764AbWFEUpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:45:07 -0400
Date: Mon, 5 Jun 2006 16:44:56 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: arjan@infradead.org, mingo@redhat.com
Subject: Re: 2.6.17-rc5-mm3
Message-ID: <20060605204456.GF6143@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	arjan@infradead.org, mingo@redhat.com
References: <20060603232004.68c4e1e3.akpm@osdl.org> <20060605194844.GA6143@redhat.com> <20060605130626.3f2917a2.akpm@osdl.org> <20060605200947.GC6143@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605200947.GC6143@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2006 at 04:09:47PM -0400, Dave Jones wrote:

 >  > Try reverting debug-shared-irqs.patch, or disable the sound driver?
 > Will turn off the sound driver, and see what happens.

Win! It now boots.   I blew it up really easy with a socket-fuzzer though.
(http://people.redhat.com/davej/sfuzz.c)

[  874.865028] ======================================
[  874.943738] [ BUG: bad unlock ordering detected! ]
[  875.002919] --------------------------------------
[  875.062134] sfuzz/23915 is trying to release lock (&sctp_port_alloc_lock) at:
[  875.149619]  [<d128ed4e>] sctp_get_port_local+0xd0/0x285 [sctp]
[  875.222636] but the next lock to release is:
[  875.276019]  (&sctp_port_hashtable[i].lock){-...}, at: [<d128ed0e>] sctp_get_port_local+0x90/0x285 [sctp]
[  875.393031]
[  875.393032] other info that might help us debug this:
[  875.476583] 1 locks held by sfuzz/23915:
[  875.526247]  #0:  (&sctp_port_alloc_lock){-...}, at: [<d128ecd9>] sctp_get_port_local+0x5b/0x285 [sctp]
[  875.641621]
[  875.641623] stack backtrace:
[  875.699891]  [<c0104966>] show_trace_log_lvl+0x54/0xfd
[  875.764425]  [<c0104f1a>] show_trace+0xd/0x10
[  875.819622]  [<c010502f>] dump_stack+0x19/0x1b
[  875.875924]  [<c013b4af>] lockdep_release+0x150/0x2d1
[  875.939610]  [<c032341e>] _spin_unlock+0x16/0x20
[  875.998171]  [<d128ed4e>] sctp_get_port_local+0xd0/0x285 [sctp]
[  876.072345]  [<d128efd4>] sctp_do_bind+0x9a/0x158 [sctp]
[  876.139315]  [<d128f0ce>] sctp_autobind+0x3c/0x44 [sctp]
[  876.206310]  [<d129253d>] sctp_inet_listen+0xe9/0x139 [sctp]
[  876.277539]  [<c02c20af>] sys_listen+0x4a/0x65
[  876.334730]  [<c02c308d>] sys_socketcall+0x98/0x186
[  876.397175]  [<c03239cb>] syscall_call+0x7/0xb


-- 
http://www.codemonkey.org.uk
