Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265948AbTGKTxc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 15:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbTGKTxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 15:53:14 -0400
Received: from evil.netppl.fi ([195.242.209.201]:31964 "EHLO evil.netppl.fi")
	by vger.kernel.org with ESMTP id S265144AbTGKTts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 15:49:48 -0400
Date: Fri, 11 Jul 2003 23:04:30 +0300
From: Pekka Pietikainen <pp@netppl.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: REQ: BCM4400 network driver for 2.4.22
Message-ID: <20030711200430.GA13284@netppl.fi>
References: <200307092333.36917.bas@basmevissen.nl> <3F0C9194.5060206@pobox.com> <20030711163345.GA23076@netppl.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20030711163345.GA23076@netppl.fi>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 07:33:45PM +0300, Pekka Pietikainen wrote:
> Here's a patch against the driver version in 2.5.73 for testing/comments,
> which fixes all the issues I know of in the driver. I'm writing this mail
> through the driver running on 2.4.x, so obviously at least basic 
> functionality is working.
> 
> I'm not too sure about the pointer tricks I do with skb->data
> in b44_rx(), but they seem to do the trick just fine ;)
Two kinds of oopses uncovered in a bit heavier
testing, one doesn't mention b44 anywhere but it's very likely caused by 
something in the driver:

kernel BUG at slab.c:1228!
invalid operand: 0000
b44 ipt_TCPMSS ipt_tcpmss ipt_MASQUERADE iptable_nat ip_conntrack
parport_pc lp
parport iptable_filter ip_tables
autofs ppp_synctty ppp_async ppp_generic slhc
CPU:    0
EIP:    0060:[<c0137eb4>]    Not tainted
EFLAGS: 00010046
 
EIP is at kmem_extra_free_checks [kernel] 0x64 (2.4.20-20.1.2013.nptl)
eax: 00000000   ebx: 00000000   ecx: 00000800   edx: 00000000
esi: dbe3f14c   edi: dbe3e000   ebp: dbe3e000   esp: d9811dac
ds: 0068   es: 0068   ss: 0068
Process pppoe (pid: 6437, stackpage=d9811000)
Stack: dbe3e000 dbe3e000 dbe3e800 dbe3f14c c0138913 dffc56f0
dbe3f14c dbe3e000
       0053aba0 dbe3e000 00000286 dbeb47c0 c013803b dffc56f0
dbe3e000 dbeef7e8
       c01e9150 d9811ec8 c01ea263 dbe3e000 dbeef7e8 dbeef7e8
c01ea3ed dbeef7e8
Call Trace:   [<c0138913>] kmem_cache_free_one [kernel] 0xf3 (0xd9811dbc)
[<c013803b>] kfree [kernel] 0x5b (0xd9811ddc)
[<c01e9150>] sock_rfree [kernel] 0x0 (0xd9811dec)
[<c01ea263>] kfree_skbmem [kernel] 0x13 (0xd9811df4)
[<c01ea3ed>] __kfree_skb [kernel] 0x12d (0xd9811e04)
[<c0243507>] packet_recvmsg [kernel] 0x127 (0xd9811e1c)
[<c01e6a08>] sock_recvmsg [kernel] 0x58 (0xd9811e4c)
[<c01e678c>] sockfd_lookup [kernel] 0x1c (0xd9811e80)
[<c01e7af4>] sys_recvfrom [kernel] 0xb4 (0xd9811e94)
[<c0182046>] normal_poll [kernel] 0x106 (0xd9811ee8)
[<c015197a>] poll_freewait [kernel] 0x3a (0xd9811f10)
[<c0138913>] kmem_cache_free_one [kernel] 0xf3 (0xd9811f24)
[<c01e7b97>] sys_recv [kernel] 0x37 (0xd9811f64)
[<c01e831a>] sys_socketcall [kernel] 0x15a (0xd9811f80)
[<c01097ff>] system_call [kernel] 0x33 (0xd9811fc0)

and also something that looked like an assertion failure in skb handling
in b44_rx, but couldn't see fully due to having a 80x25 terminal and
scrolling not working either... 

That and 2.5.75 complains that irq are disabled in local_bh_enable(),
looks like the locking in b44_poll will need to be adjusted a bit.

Oh well, we're getting there ;)
-- 
Pekka Pietikainen




