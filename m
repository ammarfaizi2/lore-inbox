Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315748AbSG1Lt2>; Sun, 28 Jul 2002 07:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315758AbSG1Lt2>; Sun, 28 Jul 2002 07:49:28 -0400
Received: from t3o913p60.telia.com ([195.252.45.60]:6530 "EHLO
	best.localdomain") by vger.kernel.org with ESMTP id <S315748AbSG1Lt1>;
	Sun, 28 Jul 2002 07:49:27 -0400
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Subject: 2.5.29: bad: schedule() with irqs disabled!
From: Peter Osterlund <petero2@telia.com>
Date: 28 Jul 2002 13:52:41 +0200
Message-ID: <m2ofcsrrw6.fsf@best.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have seen the "schedule with irqs disabled" message twice now in
2.5.29 on an UP machine. It looks like do_softirq calls
wake_up_process with interrupts disabled:

c1807dd8 c023f540 00000000 c1807e00 c0110648 00000001 00000002 00000001 
       c02c1c18 fffffff8 c1807e10 c011066b c11eb040 00000000 00000246 c01189fe 
       00000007 00000100 c38cf1ac 00000000 c020dc39 c1807e80 00000000 00000000 
Call Trace: [<c0110648>] [<c011066b>] [<c01189fe>] [<c020dc39>] [<c01f26cb>] 
   [<c022a068>] [<c01ef2f2>] [<c019d595>] [<c01ef4ea>] [<c0138036>] [<c01f6217> 
   [<c013813a>] [<c0107127>] 

Trace; c0110648 <global_flush_tlb+1e8/200>
Trace; c011066b <wake_up_process+b/200>
Trace; c01189fe <do_softirq+9e/b0>
Trace; c020dc39 <ip_cmsg_recv+4a89/50a0>
Trace; c01f26cb <alloc_skb+27b/2e0>
Trace; c022a068 <unregister_inetaddr_notifier+1ce8/2080>
Trace; c01ef2f2 <sock_sendmsg+72/90>
Trace; c019d595 <tty_unregister_driver+28e5/2920>
Trace; c01ef4ea <sock_recvmsg+1da/7d0>
Trace; c0138036 <vfs_write+b6/860>
Trace; c01f6217 <netif_rx+277/300>
Trace; c013813a <vfs_write+1ba/860>
Trace; c0107127 <__up_wakeup+10fb/2634>



c1807cac c023f540 00000000 c1807cd4 c0110648 00000001 00000002 00000001 
       c02c1c18 fffffff8 c1807ce4 c011066b c11eb040 00000000 00000246 c01189fe 
       c1806000 00000001 00000100 c0208e60 c01fcf7c 00000000 c02e9b58 00000001 
Call Trace: [<c0110648>] [<c011066b>] [<c01189fe>] [<c0208e60>] [<c01fcf7c>] 
   [<c0205030>] [<c01fcecf>] [<c0207c8f>] [<c0208e60>] [<c0204c69>] [<c0205030> 
   [<c021cb87>] [<c0216ef9>] [<c0217522>] [<c0205170>] [<c011c105>] [<c010bc00> 
   [<c0217ff6>] [<c020daa6>] [<c01f6421>] [<c022a068>] [<c01ef2f2>] [<c019d595> 
   [<c01ef4ea>] [<c0138036>] [<c0118ca0>] [<c013813a>] [<c0107127>] 

Trace; c0110648 <global_flush_tlb+1e8/200>
Trace; c011066b <wake_up_process+b/200>
Trace; c01189fe <do_softirq+9e/b0>
Trace; c0208e60 <ip_finish_output+2b0/600>
Trace; c01fcf7c <nf_hook_slow+16c/190>
Trace; c0205030 <ip_rcv+3b0/1150>
Trace; c01fcecf <nf_hook_slow+bf/190>
Trace; c0207c8f <ip_options_undo+f8f/18d0>
Trace; c0208e60 <ip_finish_output+2b0/600>
Trace; c0204c69 <inet_del_protocol+479/490>
Trace; c0205030 <ip_rcv+3b0/1150>
Trace; c021cb87 <tcp_read_sock+e937/167e0>
Trace; c0216ef9 <tcp_read_sock+8ca9/167e0>
Trace; c0217522 <tcp_read_sock+92d2/167e0>
Trace; c0205170 <ip_rcv+4f0/1150>
Trace; c011c105 <del_timer+835/940>
Trace; c010bc00 <do_settimeofday+300/3d0>
Trace; c0217ff6 <tcp_read_sock+9da6/167e0>
Trace; c020daa6 <ip_cmsg_recv+48f6/50a0>
Trace; c01f6421 <netif_receive_skb+101/390>
Trace; c022a068 <unregister_inetaddr_notifier+1ce8/2080>
Trace; c01ef2f2 <sock_sendmsg+72/90>
Trace; c019d595 <tty_unregister_driver+28e5/2920>
Trace; c01ef4ea <sock_recvmsg+1da/7d0>
Trace; c0138036 <vfs_write+b6/860>
Trace; c0118ca0 <tasklet_kill+70/90>
Trace; c013813a <vfs_write+1ba/860>
Trace; c0107127 <__up_wakeup+10fb/2634>

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
