Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWEBLaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWEBLaV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 07:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWEBLaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 07:30:21 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:64703 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964778AbWEBLaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 07:30:18 -0400
Date: Tue, 2 May 2006 13:34:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>, coreteam@netfilter.org
Subject: [lockup] 2.6.17-rc3: netfilter/sctp: lockup in sctp_new(), do_basic_checks()
Message-ID: <20060502113454.GA28601@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

running an "isic" stresstest on and against a testbox [which, amongst 
other things, generates random incoming and outgoing packets] on 
2.6.17-rc3 (and 2.6.17-rc3-mm1) over gigabit results in a reproducible 
lockup, after 5-10 minutes of runtime:

BUG: soft lockup detected on CPU#0!
 [<c0104e7f>] show_trace+0xd/0xf
 [<c0104e96>] dump_stack+0x15/0x17
 [<c015ad02>] softlockup_tick+0xc5/0xd9
 [<c0134c02>] run_local_timers+0x22/0x24
 [<c0134fb7>] update_process_times+0x40/0x65
 [<c011aa56>] smp_apic_timer_interrupt+0x58/0x60
 [<c010492b>] apic_timer_interrupt+0x27/0x2c
 [<c0f00df9>] sctp_new+0x8b/0x235
 [<c0ef9666>] ip_conntrack_in+0x175/0x4ca
 [<c0eb6dd7>] nf_iterate+0x31/0x94
 [<c0eb6e83>] nf_hook_slow+0x49/0xda
 [<c0ec2f55>] ip_rcv+0x24c/0x567
 [<c0e7dec4>] netif_receive_skb+0x34b/0x397
 [<c07870cb>] rtl8139_poll+0x3d8/0x5db
 [<c0e7c7ad>] net_rx_action+0x9b/0x1ba
 [<c0131955>] __do_softirq+0x6e/0xec
 [<c0106187>] do_softirq+0x59/0xcd
 =======================
 [<c0131427>] local_bh_enable+0x111/0x15d
 [<c0e7d8fb>] dev_queue_xmit+0x218/0x222
 [<c0ec7e2a>] ip_output+0x20b/0x249
 [<c0ec5711>] ip_push_pending_frames+0x331/0x3fe
 [<c0ede6e3>] raw_sendmsg+0x5cf/0x678
 [<c0ee62f8>] inet_sendmsg+0x39/0x46
 [<c0e7406f>] sock_sendmsg+0xf2/0x10d
 [<c0e741e5>] sys_sendmsg+0x15b/0x1c9
 [<c0e748b5>] sys_socketcall+0x16f/0x18a
 [<c1048c1b>] syscall_call+0x7/0xb

this is with FRAME_POINTERS enabled, so it's an exact stacktrace.

the lockup is at:

(gdb) list *0xc0f00df9
0xc0f00df9 is in sctp_new 
(net/ipv4/netfilter/ip_conntrack_proto_sctp.c:444).
439
440             sh = skb_header_pointer(skb, iph->ihl * 4, sizeof(_sctph), &_sctph);
441             if (sh == NULL)
442                     return 0;
443
444             if (do_basic_checks(conntrack, skb, map) != 0)
445                     return 0;
446
447             /* If an OOTB packet has any of these chunks discard (Sec 8.4) */
448             if ((test_bit (SCTP_CID_ABORT, (void *)map))

most likely somewhere within do_basic_checks(). [whose stack entry is 
obscured by the irq entry, so it's not in the stackdump.] I have SCTP 
turned on:

 CONFIG_NETFILTER_XT_MATCH_SCTP=y
 CONFIG_IP_NF_CT_PROTO_SCTP=y
 # SCTP Configuration (EXPERIMENTAL)
 CONFIG_IP_SCTP=y

but otherwise it's a stock Fedora install.

the full log and configs can be found at:

	http://redhat.com/~mingo/misc/crash3.log
	http://redhat.com/~mingo/misc/config3

this is a v2.6.17 showstopper i guess?

	Ingo
