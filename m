Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129785AbQJ1XLa>; Sat, 28 Oct 2000 19:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129829AbQJ1XLV>; Sat, 28 Oct 2000 19:11:21 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:32260 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129785AbQJ1XLI>; Sat, 28 Oct 2000 19:11:08 -0400
Date: Sat, 28 Oct 2000 19:12:44 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "Dave S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: tcp_do_sendmsg() allocation still broken ?
Message-ID: <Pine.LNX.4.21.0010281859570.865-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David,

tcp_do_sendmsg() still allocates using GFP_KERNEL when it can't, it seems: 

int tcp_do_sendmsg(struct sock *sk, struct msghdr *msg)
{
...
                     TCP_SKB_CB(skb)->seq = tp->write_seq;
                        TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(skb)->seq +
copy;

                        /* This advances tp->write_seq for us. */
                        tcp_send_skb(sk, skb, queue_it);
			^^^^^^^^^^^^
 
                }
        }
        sk->err = 0;
...
}


Now what we can find at tcp_send_skb? :)


void tcp_send_skb(struct sock *sk, struct sk_buff *skb, int force_queue,
unsigned cur_mss) {

...

    if (!force_queue && tp->send_head == NULL && tcp_snd_test(tp, skb,
cur_mss, 1)) {
                /* Send it out now. */
                TCP_SKB_CB(skb)->when = tcp_time_stamp;
                if (tcp_transmit_skb(sk, skb_clone(skb, GFP_KERNEL)) == 0) {
							^^^^^^^^^^^^
                        tp->snd_nxt = TCP_SKB_CB(skb)->end_seq;

...




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
