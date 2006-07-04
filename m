Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWGDSc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWGDSc4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 14:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWGDSc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 14:32:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54679 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932295AbWGDScz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 14:32:55 -0400
Subject: Re: [2.6.17-git22] lock debugging output
From: Arjan van de Ven <arjan@infradead.org>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: akpm@osdl.org, mingo@elte.hu, Linux Kernel <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
In-Reply-To: <5a4c581d0607041113o2993cbf5m7011b2a06e96d974@mail.gmail.com>
References: <5a4c581d0607041113o2993cbf5m7011b2a06e96d974@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 04 Jul 2006 20:32:46 +0200
Message-Id: <1152037966.3109.91.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>

On Tue, 2006-07-04 at 20:13 +0200, Alessandro Suardi wrote:
> Hoping gmail doesn't mess it too badly...
> 
> eth0: tg3 (BCM5751 Gbit Ethernet)
> eth1: ipw2200 (Intel PRO/Wireless 2200BG)
> 
> Sequence:
>  1. boot with eth0 disconnected (eth1 doesn't come up on boot)
>  2. ifup eth1, bring wpa-supplicant up
>  3. run 'dig' ---> <lock debug info gets printed on console>


this appears to be a real deadlock:

the SO_BINDTODEVICE ioctl calls sk_dst_reset(), which looks like this:
static inline void
sk_dst_reset(struct sock *sk)
{
        write_lock(&sk->sk_dst_lock);
        __sk_dst_reset(sk);
        write_unlock(&sk->sk_dst_lock);
}

now... ipv6 does this in softirq context:
  [<c028cf72>] sk_dst_check+0x1b/0xe6
  [<f8ce1305>] ip6_dst_lookup+0x31/0x16d [ipv6]
  [<f8cf3338>] icmpv6_send+0x332/0x549 [ipv6]
  [<f8cf09a1>] udpv6_rcv+0x4ab/0x4d6 [ipv6]
  [<f8ce2900>] ip6_input+0x19c/0x228 [ipv6]
  [<f8ce2d61>] ipv6_rcv+0x188/0x1b7 [ipv6]
  [<c02925b7>] netif_receive_skb+0x18d/0x1d8
  [<c0293d6a>] process_backlog+0x80/0xf9
  [<c0293f43>] net_rx_action+0x80/0x174
  [<c01162fd>] __do_softirq+0x46/0x9c
  [<c01040e6>] do_softirq+0x4d/0xac

where sk_dst_check() takes the same lock for read.

that looks like a real deadlock to me... 
the most obvious low impact solution is to make sk_dst_reset use an
irqsave variant; patch for that is attached below. I'll leave it to the
networking people to say if that's the real right approach

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

---
 include/net/sock.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6.17-mm6/include/net/sock.h
===================================================================
--- linux-2.6.17-mm6.orig/include/net/sock.h
+++ linux-2.6.17-mm6/include/net/sock.h
@@ -1025,9 +1025,10 @@ __sk_dst_reset(struct sock *sk)
 static inline void
 sk_dst_reset(struct sock *sk)
 {
-	write_lock(&sk->sk_dst_lock);
+	unsigned long flags;
+	write_lock_irqsave(&sk->sk_dst_lock, flags);
 	__sk_dst_reset(sk);
-	write_unlock(&sk->sk_dst_lock);
+	write_unlock_irqrestore(&sk->sk_dst_lock, flags);
 }
 
 extern struct dst_entry *__sk_dst_check(struct sock *sk, u32 cookie);


