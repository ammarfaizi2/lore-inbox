Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbTJYJbN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 05:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbTJYJbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 05:31:13 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:6349 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262529AbTJYJbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 05:31:11 -0400
Date: Sat, 25 Oct 2003 11:12:56 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, grof@dragon.cz
Subject: Re: possible bug in tcp_input.c
Message-ID: <20031025091256.GB13378@louise.pinerecords.com>
References: <20031024162959.GB11154@louise.pinerecords.com> <20031024193034.30f1caed.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031024193034.30f1caed.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct-24 2003, Fri, 19:30 -0700
David S. Miller <davem@redhat.com> wrote:

> > /* tcp_input.c, line 1138 */
> > static inline int tcp_head_timedout(struct sock *sk, struct tcp_opt *tp)
> > {
> >   return tp->packets_out && tcp_skb_timedout(tp, skb_peek(&sk->write_queue));
> > }
> > 
> > The passed NULL (and yes, this is where we are getting one) is dereferenced
> > immediately in:
> > 
> > /* tcp_input.c, line 1133 */
> > static inline int tcp_skb_timedout(struct tcp_opt *tp, struct sk_buff *skb)
> > {
> >   return (tcp_time_stamp - TCP_SKB_CB(skb)->when > tp->rto);
> > }
> 
> If tp->packets_out is non-zero (which by definition it is
> in your case else the right hand side of the "&&" would not be
> evaluated) then we _MUST_ have some packets in sk->write_queue.
> 
> Something is being fiercely corrupted.  Probably some piece of
> netfilter is freeing up an SKB one too many times thus corrupting
> the TCP write queue list pointers.

Ok, thanks.  Here's the backtrace in case you are able to extract
some information out of it.

>>EIP; c01fa86f <tcp_time_to_recover+6f/1c0>   <=====
>>ebx; c606c19c <_end+5d94b7c/85faa40>
>>esi; c606c0e0 <_end+5d94ac0/85faa40>
>>ebp; c606c0e0 <_end+5d94ac0/85faa40>
>>esp; c026bc24 <init_task_union+1c24/2000>
Trace; c01ffbe5 <tcp_reset_xmit_timer+85/f0>
Trace; c01fb46b <tcp_fastretrans_alert+17b/5b0>
Trace; c01fbc67 <tcp_clean_rtx_queue+307/320>
Trace; c01fc06c <tcp_ack+14c/360>
Trace; c01fe6f2 <tcp_rcv_established+372/830>
Trace; c88e3c34 <[ip_tables]__kstrtab_ipt_register_table+0/0>
Trace; c01063a2 <sys_sigaction+72/110>
Trace; c0206835 <tcp_v4_rcv+485/520>
Trace; c01ed38e <ip_local_deliver_finish+14e/170>
Trace; c01e0a3b <nf_hook_slow+bb/190>
Trace; c01ed240 <ip_local_deliver_finish+0/170>
Trace; c01ed008 <ip_local_deliver+68/90>
Trace; c01ed240 <ip_local_deliver_finish+0/170>
Trace; c01ed589 <ip_rcv_finish+1d9/240>
Trace; c8912ddc <.data.end+3ba5/????>
Trace; c01e0ca4 <nf_reinject+194/1c0>
Trace; c01ed3b0 <ip_rcv_finish+0/240>
Trace; c88fa12a <[ip_nat_ftp].data.end+184b/8781>
Trace; c01e21cd <qdisc_restart+6d/100>
Trace; c88fa1cf <[ip_nat_ftp].data.end+18f0/8781>
Trace; c01e08c2 <nf_queue+122/1e0>
Trace; c88fa7c0 <[ip_nat_ftp].data.end+1ee1/8781>
Trace; c01ed3b0 <ip_rcv_finish+0/240>
Trace; c01ed3b0 <ip_rcv_finish+0/240>
Trace; c01e0a97 <nf_hook_slow+117/190>
Trace; c88fa7a0 <[ip_nat_ftp].data.end+1ec1/8781>
Trace; c01ed3b0 <ip_rcv_finish+0/240>
Trace; c88fa7c0 <[ip_nat_ftp].data.end+1ee1/8781>
Trace; c01ed1de <ip_rcv+1ae/210>
Trace; c01ed3b0 <ip_rcv_finish+0/240>
Trace; c01da3ef <netif_receive_skb+12f/1f0>
Trace; c01da533 <process_backlog+83/120>
Trace; c01da644 <net_rx_action+74/110>
Trace; c011b3b5 <do_softirq+95/a0>
Trace; c0108b4a <do_IRQ+9a/a0>
Trace; c0105390 <default_idle+0/40>
Trace; c010b0a8 <call_do_IRQ+5/d>
Trace; c0105390 <default_idle+0/40>
Trace; c01053b3 <default_idle+23/40>
Trace; c0105442 <cpu_idle+52/70>
Trace; c0105000 <_stext+0/0>

-- 
Tomas Szepe <szepe@pinerecords.com>
