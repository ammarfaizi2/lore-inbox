Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268051AbUJGWas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268051AbUJGWas (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 18:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269878AbUJGW2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:28:24 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:7592
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269873AbUJGW1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:27:48 -0400
Date: Thu, 7 Oct 2004 15:26:34 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: martijn@entmoot.nl, hzhong@cisco.com, jst1@email.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       davem@redhat.com
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-Id: <20041007152634.5374a774.davem@davemloft.net>
In-Reply-To: <4165C20D.8020808@nortelnetworks.com>
References: <00e501c4ac9a$556797d0$b83147ab@amer.cisco.com>
	<41658C03.6000503@nortelnetworks.com>
	<015f01c4acbe$cf70dae0$161b14ac@boromir>
	<4165B9DD.7010603@nortelnetworks.com>
	<20041007150035.6e9f0e09.davem@davemloft.net>
	<4165C20D.8020808@nortelnetworks.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Oct 2004 16:24:13 -0600
Chris Friesen <cfriesen@nortelnetworks.com> wrote:

> I believe you misread what I said.  Just before the above quote, I said "We are 
> discussing the case where the socket is nonblocking and the udp checksum is 
> corrupt, right? "

And in that case we return -EAGAIN and always have.

> What I had in mind was that the non-blocking file descriptor have select() 
> return without verifying the checksum, and if it was discovered to be bad at 
> recvmsg() time, we return EAGAIN.

That's what we do.  In net/ipv4/udp.c:udp_recvmsg()

	if (skb->ip_summed==CHECKSUM_UNNECESSARY) {
		err = skb_copy_datagram_iovec(skb, sizeof(struct udphdr), msg->msg_iov,
					      copied);
	} else if (msg->msg_flags&MSG_TRUNC) {
		if (__udp_checksum_complete(skb))
			goto csum_copy_err;
		err = skb_copy_datagram_iovec(skb, sizeof(struct udphdr), msg->msg_iov,
					      copied);
	} else {
		err = skb_copy_and_csum_datagram_iovec(skb, sizeof(struct udphdr), msg->msg_iov);

		if (err == -EINVAL)
			goto csum_copy_err;
	}
 ...
csum_copy_err:
	UDP_INC_STATS_BH(UDP_MIB_INERRORS);

	/* Clear queue. */
	if (flags&MSG_PEEK) {
		int clear = 0;
		spin_lock_irq(&sk->sk_receive_queue.lock);
		if (skb == skb_peek(&sk->sk_receive_queue)) {
			__skb_unlink(skb, &sk->sk_receive_queue);
			clear = 1;
		}
		spin_unlock_irq(&sk->sk_receive_queue.lock);
		if (clear)
			kfree_skb(skb);
	}

	skb_free_datagram(sk, skb);

	if (noblock)
		return -EAGAIN;	
	goto try_again;

If socket is non-blocking, return -EAGAIN, else go back to "try_again"
where we block on packet arrival or error.
