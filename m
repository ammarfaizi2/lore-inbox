Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbVILV40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVILV40 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 17:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVILV40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 17:56:26 -0400
Received: from main.gmane.org ([80.91.229.2]:32442 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932143AbVILV4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 17:56:25 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nuutti Kotivuori <naked@iki.fi>
Subject: netfilter QUEUE target and packet socket interactions buggy or not
Date: Tue, 13 Sep 2005 01:12:26 +0300
Organization: Ye 'Ol Disorganized NNTPCache groupie
Message-ID: <87fysa9bqt.fsf@aka.i.naked.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: naked.iki.fi
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.17 (linux)
Cancel-Lock: sha1:J14O9A3LRgml30dl3o7X4Anu/A0=
Cache-Post-Path: aka.i.naked.iki.fi!unknown@aka.i.naked.iki.fi
X-Cache: nntpcache 3.0.1 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am in the process of debugging a kernel panic manifested on a Red
Hat Enterprise Linux 4 under rather difficult conditions. While
investigating this, I came upon a few bits of code that I'd like some
clarification on. However, I will start by describing the problem.

I am getting a consistent kernel panic under specific high load, which
involves heavy use of the netfilter QUEUE target and packet filter. I
will paraphrase the important parts of the backtrace here:

,----
| Unable to handle kernel NULL pointer dereference at virtual address 00000018
| ...
|         __kfree_skb+0xf4/0xf7
|  [<c02c3188>] packet_rcv+0x2ca/0x2d4
|  [<f888f792>] bcm5700_start_xmit+0x477/0x4a5 [bcm5700]
|  [<c01a3a02>] selinux_ipv4_postroute_last+0xf/0x13
| ...
|  [<c028cf66>] dst_output+0xf/0x1a
|  [<c027cfdb>] nf_reinject+0x14d/0x1a9
|  [<f894101e>] ipq_issue_verdict+0x1e/0x2b [ip_queue]
| ...
|  [<c028592c>] netlink_sendmsg+0x254/0x263
|  [<c011dcf5>] __wake_up+0x29/0x3c
|  [<c026b92d>] sock_sendmsg+0xdb/0xf7
| ...
|  [<c0133b04>] unqueue_me+0x73/0x79
|  [<c011dcf5>] __wake_up+0x29/0x3c
|  [<c026d465>] sys_socketcall+0x1c1/0x1dd
|  [<c0125351>] sys_gettimeofday+0x53/0xac
|  [<c02c7377>] syscall_call+0x7/0xb
`----

So what I gather is happening here is that we are in syscall context,
inside that the nf_reinject stuff puts the queued packet decision
received from userspace onwards and it ends up being captured by a
packet socket. And for some reason, the packet ends up being
kfree_skb'd twice.

Two things caught my attention. First of all, there was a relatively
recent fix to ip_queue which had to do with the calling context. I
will copy the rationale here:

,----[ Harald Welte <laforge at netfilter.org> ]
| [NETFILTER]: Fix deadlock with ip_queue and tcp local input path.
| 
| When we have ip_queue being used from LOCAL_IN, then we end up with a
| situation where the verdicts coming back from userspace traverse the TCP
| input path from syscall context.  While this seems to work most of the
| time, there's an ugly deadlock:
| 
| syscall context is interrupted by the timer interrupt.  When the timer
| interrupt leaves, the timer softirq get's scheduled and calls
| tcp_delack_timer() and alike.  They themselves do bh_lock_sock(sk),
| which is already held from somewhere else -> boom.
|
| I've now tested the suggested solution by Patrick McHardy and Herbert
| Xu to simply use local_bh_{en,dis}able().
`----

Second, I went looking at the packet socket code and found this
comment:

,----
| This function makes lazy skb cloning in hope that most of packets
| are discarded by BPF.
| 
| Note tricky part: we DO mangle shared skb! skb->data, skb->len
| and skb->cb are mangled. It works because (and until) packets
| falling here are owned by current CPU. Output packets are cloned
| by dev_queue_xmit_nit(), input packets are processed by net_bh
| sequencially, so that if we return skb to original state on exit,
| we will not harm anyone.
`----

But are those assumptions valid in the obscure case of us being in the
syscall context, receiving a queued packet from userspace? In any
case, by looking at the disassembly and at the stacktrace, it seems
that the incoming skb is not shared and gets dropped by one of the
goto clauses. The crashing call is the kfree_skb at the very end of
the af_packet.c:packet_rcv function.

I am putting this mail here as a heads up if someone manages to
instantly spot what's wrong with this setup. I will continue debugging
the real cause, and eliminating all the possible variables, seeing
whether this is an SMP problem, checking if it can be manifested with
a vanilla kernel and such.

A detailed dump of the crash can be found at:

  https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=118541

Warm fuzzies,
-- Naked

