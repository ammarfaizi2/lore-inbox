Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286968AbSBKEPt>; Sun, 10 Feb 2002 23:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287002AbSBKEPj>; Sun, 10 Feb 2002 23:15:39 -0500
Received: from 24.159.201.38.roc.nc.chartermi.net ([24.159.201.38]:16054 "EHLO
	201roc038.chartermi.net") by vger.kernel.org with ESMTP
	id <S286968AbSBKEP1>; Sun, 10 Feb 2002 23:15:27 -0500
Date: Sun, 10 Feb 2002 22:15:26 -0600 (CST)
From: Dave Larson <davlarso@acm.org>
X-X-Sender: <davlarso@ratbert.davelarson.net>
To: <linux-kernel@vger.kernel.org>
cc: <davlarso@acm.org>
Subject: Problems maintaining a TCP connection  
Message-ID: <Pine.LNX.4.33.0202102207500.719-100000@ratbert.davelarson.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a problem with a WinCE based device maintaining a tcp connection with
a linux box. The TCP dump below shows the end of a tcp session where the WinCE
device gives up on the linux box and closes the connection. The WinCE device
missed the TCP segment with seq 1118253692 and is waiting for it to be
retransmitted, but it never gets sent and WinCE gives up on the connection.

192.168.1.4 = linux
192.168.1.15 = WinCE

21:18:58.587491 192.168.1.4.139 > 192.168.1.15.1435: . 1118236172:1118237632(1460) ack 844981730 win 5840
21:18:58.588007 192.168.1.4.139 > 192.168.1.15.1435: . 1118237632:1118239092(1460) ack 844981730 win 5840
21:18:58.588523 192.168.1.4.139 > 192.168.1.15.1435: P 1118239092:1118240552(1460) ack 844981730 win 5840
21:18:58.588530 192.168.1.15.1435 > 192.168.1.4.139: . ack 1118237632 win 5840 (DF)
21:18:58.589241 192.168.1.4.139 > 192.168.1.15.1435: . 1118240552:1118242012(1460) ack 844981730 win 5840
21:18:58.589754 192.168.1.4.139 > 192.168.1.15.1435: P 1118242012:1118243472(1460) ack 844981730 win 5840
21:18:58.589875 192.168.1.15.1435 > 192.168.1.4.139: . ack 1118240552 win 2920 (DF)
21:18:58.597275 192.168.1.15.1435 > 192.168.1.4.139: . ack 1118243472 win 0 (DF)
21:18:58.598352 192.168.1.15.1435 > 192.168.1.4.139: . ack 1118243472 win 8760 (DF)
21:18:58.598998 192.168.1.4.139 > 192.168.1.15.1435: . 1118243472:1118244932(1460) ack 844981730 win 5840
21:18:58.599506 192.168.1.4.139 > 192.168.1.15.1435: . 1118244932:1118246392(1460) ack 844981730 win 5840
21:18:58.600012 192.168.1.4.139 > 192.168.1.15.1435: . 1118246392:1118247852(1460) ack 844981730 win 5840
21:18:58.600518 192.168.1.4.139 > 192.168.1.15.1435: P 1118247852:1118249312(1460) ack 844981730 win 5840
21:18:58.600566 192.168.1.15.1435 > 192.168.1.4.139: . ack 1118246392 win 8760 (DF)
21:18:58.607082 192.168.1.4.139 > 192.168.1.15.1435: . 1118249312:1118250772(1460) ack 844981730 win 5840
21:18:58.607585 192.168.1.4.139 > 192.168.1.15.1435: P 1118250772:1118252232(1460) ack 844981730 win 5840
21:18:58.607886 192.168.1.15.1435 > 192.168.1.4.139: . ack 1118249312 win 8760 (DF)
21:18:58.608590 192.168.1.4.139 > 192.168.1.15.1435: . 1118252232:1118253692(1460) ack 844981730 win 5840
21:18:58.609098 192.168.1.4.139 > 192.168.1.15.1435: . 1118253692:1118255152(1460) ack 844981730 win 5840
21:18:58.609499 192.168.1.15.1435 > 192.168.1.4.139: . ack 1118252232 win 5840 (DF)
21:18:58.609906 192.168.1.4.139 > 192.168.1.15.1435: P 1118255152:1118255852(700) ack 844981730 win 5840
21:18:58.616858 192.168.1.15.1435 > 192.168.1.4.139: . ack 1118253692 win 4380 (DF)
21:18:58.617823 192.168.1.15.1435 > 192.168.1.4.139: . ack 1118253692 win 8760 (DF)
21:19:06.927122 192.168.1.15.1435 > 192.168.1.4.139: F 844981730:844981730(0) ack 1118253692 win 8760 (DF)

I've put some printk's in the retransmit code and discovered that linux is
trying to retransmit this segment. But this check in tcp_retransmit_skb
is preventing the retransmit from occuring:

/* Do not sent more than we queued. 1/4 is reserved for possible
 * copying overhead: frgagmentation, tunneling, mangling etc.
 */
 if (atomic_read(&sk->wmem_alloc) > min(sk->wmem_queued+(sk->wmem_queued>>2),sk->sndbuf))
      return -EAGAIN;

The lines that start with E are in tcp_restransmit_skb when this check
fails. The tcp_retransmit_timer: rc=-11 lines show that EAGAIN was
returned but tcp_restransmit_skb.

Feb 10 21:18:58 quetico kernel: c5288198 tcp_retransmit_timer: snd_wnd=8760 packets_out=2
Feb 10 21:18:58 quetico kernel: c5288198 tcp_enter_loss: ca_state->TCP_CA_Loss ssthresh=2
Feb 10 21:18:58 quetico kernel: c5288198 tcp_retransmit_skb: seq=1118253692
Feb 10 21:18:58 quetico kernel: c5288198 E wmem_alloc=5772 wmem_queued=3848 wmem_queued>>2=962 sndbuf=26768
Feb 10 21:18:58 quetico kernel: c5288198 tcp_retransmit_timer: rc=-11
Feb 10 21:18:59 quetico kernel: c5288198 tcp_retransmit_timer: snd_wnd=8760 packets_out=2
Feb 10 21:18:59 quetico kernel: c5288198 tcp_enter_loss: ca_state->TCP_CA_Loss ssthresh=2
Feb 10 21:18:59 quetico kernel: c5288198 tcp_retransmit_skb: seq=1118253692
Feb 10 21:18:59 quetico kernel: c5288198 E wmem_alloc=5772 wmem_queued=3848 wmem_queued>>2=962 sndbuf=26768
Feb 10 21:18:59 quetico kernel: c5288198 tcp_retransmit_timer: rc=-11
Feb 10 21:19:00 quetico kernel: c5288198 tcp_retransmit_timer: snd_wnd=8760 packets_out=2
Feb 10 21:19:00 quetico kernel: c5288198 tcp_enter_loss: ca_state->TCP_CA_Loss ssthresh=2
Feb 10 21:19:00 quetico kernel: c5288198 tcp_retransmit_skb: seq=1118253692
Feb 10 21:19:00 quetico kernel: c5288198 E wmem_alloc=5772 wmem_queued=3848 wmem_queued>>2=962 sndbuf=26768
Feb 10 21:19:00 quetico kernel: c5288198 tcp_retransmit_timer: rc=-11
Feb 10 21:19:01 quetico kernel: c5288198 tcp_retransmit_timer: snd_wnd=8760 packets_out=2
Feb 10 21:19:01 quetico kernel: c5288198 tcp_enter_loss: ca_state->TCP_CA_Loss ssthresh=2 Feb 10 21:19:01 quetico kernel: c5288198 tcp_retransmit_skb: seq=1118253692
Feb 10 21:19:01 quetico kernel: c5288198 E wmem_alloc=5772 wmem_queued=3848 wmem_queued>>2=962 sndbuf=26768
Feb 10 21:19:01 quetico kernel: c5288198 tcp_retransmit_timer: rc=-11
Feb 10 21:19:05 quetico kernel: c5288198 tcp_retransmit_timer: snd_wnd=8760 packets_out=2
Feb 10 21:19:05 quetico kernel: c5288198 tcp_enter_loss: ca_state->TCP_CA_Loss ssthresh=2
Feb 10 21:19:05 quetico kernel: c5288198 tcp_retransmit_skb: seq=1118253692
Feb 10 21:19:05 quetico kernel: c5288198 E wmem_alloc=5772 wmem_queued=3848 wmem_queued>>2=962 sndbuf=26768
Feb 10 21:19:05 quetico kernel: c5288198 tcp_retransmit_timer: rc=-11


So I'm trying to understand why this check fails and prevents the lost
segment from being retransmitted.

If I understand the code correctly, when tcp_transmit_skb calls
skb_set_owner_w, wmem_alloc is incremented. Later on tcp_charge_skb
is called when the skb is sent down to the IP later and increments
wmem_queued. Then when an ACK is received for that skb, tcp_free_skb
is called which decrements wmem_queued, and I think should also
call __kfree_skb, which should call the sock_wfree destructor and
decrement wmem_alloc. So wmem_alloc should reflect the amount of skb
memory that is currently allocated by the tcp write queue, and wmem_queued
should reflect the amount of that data that is actually used.

But that is not the behavior I'm seeing. If I trace the values of
wmem_alloc I certainly see if go up when sending a segment, but I
don't see it go down when calling tcp_free_skb when that segment
is ACKed, even though the queued value does so down. Here's what
I've seen happen to these values on this same connetion:

Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_transmit_skb - skb_set_owner_w: wmem_alloc=3848 (+1924) seq=1118240552
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_transmit_skb - skb_set_owner_w: wmem_alloc=5772 (+1924) seq=1118242012
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_clean_rtx_queue - tcp_free_skb: BEFORE wmem_alloc=5772 (-1924)  wmem_queued=19240 (-1924) seq=1118237632
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_clean_rtx_queue - tcp_free_skb: AFTER wmem_alloc=5772 wmem_queued=17316
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_clean_rtx_queue - tcp_free_skb: BEFORE wmem_alloc=5772 (-1924)  wmem_queued=17316 (-1924) seq=1118239092
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_clean_rtx_queue - tcp_free_skb: AFTER wmem_alloc=5772 wmem_queued=15392
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_clean_rtx_queue - tcp_free_skb: BEFORE wmem_alloc=5772 (-1924)  wmem_queued=21164 (-1924) seq=1118240552
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_clean_rtx_queue - tcp_free_skb: AFTER wmem_alloc=5772 wmem_queued=19240
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_clean_rtx_queue - tcp_free_skb: BEFORE wmem_alloc=5772 (-1924)  wmem_queued=19240 (-1924) seq=1118242012
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_clean_rtx_queue - tcp_free_skb: AFTER wmem_alloc=5772 wmem_queued=17316
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_transmit_skb - skb_set_owner_w: wmem_alloc=7696 (+1924) seq=1118243472
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_transmit_skb - skb_set_owner_w: wmem_alloc=9620 (+1924) seq=1118244932
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_transmit_skb - skb_set_owner_w: wmem_alloc=11544 (+1924) seq=1118246392
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_transmit_skb - skb_set_owner_w: wmem_alloc=13468 (+1924) seq=1118247852
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_clean_rtx_queue - tcp_free_skb: BEFORE wmem_alloc=13468 (-1924)  wmem_queued=17316 (-1924) seq=1118243472
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_clean_rtx_queue - tcp_free_skb: AFTER wmem_alloc=13468 wmem_queued=15392
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_clean_rtx_queue - tcp_free_skb: BEFORE wmem_alloc=13468 (-1924)  wmem_queued=15392 (-1924) seq=1118244932
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_clean_rtx_queue - tcp_free_skb: AFTER wmem_alloc=13468 wmem_queued=13468
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_transmit_skb - skb_set_owner_w: wmem_alloc=15392 (+1924) seq=1118249312
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_transmit_skb - skb_set_owner_w: wmem_alloc=17316 (+1924) seq=1118250772
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_clean_rtx_queue - tcp_free_skb: BEFORE wmem_alloc=0 (-1924)  wmem_queued=13468 (-1924) seq=1118246392
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_clean_rtx_queue - tcp_free_skb: AFTER wmem_alloc=0 wmem_queued=11544
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_clean_rtx_queue - tcp_free_skb: BEFORE wmem_alloc=0 (-1924)  wmem_queued=11544 (-1924) seq=1118247852
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_clean_rtx_queue - tcp_free_skb: AFTER wmem_alloc=0 wmem_queued=9620
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_transmit_skb - skb_set_owner_w: wmem_alloc=1924 (+1924) seq=1118252232
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_transmit_skb - skb_set_owner_w: wmem_alloc=3848 (+1924) seq=1118253692
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_clean_rtx_queue - tcp_free_skb: BEFORE wmem_alloc=3848 (-1924)  wmem_queued=9620 (-1924) seq=1118249312
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_clean_rtx_queue - tcp_free_skb: AFTER wmem_alloc=3848 wmem_queued=7696
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_clean_rtx_queue - tcp_free_skb: BEFORE wmem_alloc=3848 (-1924)  wmem_queued=7696 (-1924) seq=1118250772
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_clean_rtx_queue - tcp_free_skb: AFTER wmem_alloc=3848 wmem_queued=5772
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_transmit_skb - skb_set_owner_w: wmem_alloc=5772 (+1924) seq=1118255152
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_clean_rtx_queue - tcp_free_skb: BEFORE wmem_alloc=5772 (-1924)  wmem_queued=5772 (-1924) seq=1118252232
Feb 10 21:18:58 quetico kernel: c5288198 c5288060 tcp_clean_rtx_queue - tcp_free_skb: AFTER wmem_alloc=5772 wmem_queued=3848

It would seem that there is a problem here in that when tcp_free_skb
is called when we get an ACK for a segment, wmem_queued gets reduced
but wmem_alloc does not. But I can't figure out why wmem_alloc is
not being reduced. It looks like skb_set_owner_w sets the skb
destructor to sock_wfree, and tcp_free_skb calls __kfree_skb, which
should call that desctructor which should then reduce wmem_alloc.
But that just doesn't appear to be happening.

Can someone who is more familiar with the networking code let me
know if my interpretation of this problem is correct or if I'm totally
off base here?

BTW, please cc: me on responses as I'm not currently subscribed to LKML.


