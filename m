Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317111AbSEXIEo>; Fri, 24 May 2002 04:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317112AbSEXIEn>; Fri, 24 May 2002 04:04:43 -0400
Received: from berta.E-Technik.Uni-Dortmund.DE ([129.217.182.12]:9476 "HELO
	kt.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S317111AbSEXIEm>; Fri, 24 May 2002 04:04:42 -0400
Date: Fri, 24 May 2002 10:04:34 +0200
From: Wolfgang Wegner <ww@kt.e-technik.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: sk_buff misunderstanding?
Message-ID: <20020524100434.B1778@bigmac.e-technik.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

i am trying to do some modification in the kernel to get some different
timestamp directly from a modified network driver, and am having some
difficulty (or maybe misunderstanding) with sk_buff's...

- struct sk_buff has a new member, struct ww_timestamp rcvtime, containing
  the actual timestamp and a flag is_valid
- the driver (currently orinoco.c from pcmcia_cs) is modified to fill
  the my_timestamp struct and sets is_valid.
- when passing the packet to a socket, this new timestamp is evaluated
  (in sock_recv_timestamp, where both sk_buff _and_ sock are known)

The problem is: in sock_recv_timestamp, is_valid is reset to 0 - and i
have no idea why.

Here are the last relevant lines in orinoco.c: (orinoco_ev_rx)
        /* WW_TIMESTAMP stuff */
        skb->rcvtime=rcvtime;
        printk("orinoco.c: skb=%p\n",skb);

        skb->rcvtime.is_valid=1;
        /* Pass the packet to the networking stack */
        netif_rx(skb);

Here is include/net/sock.h (tsbucket is an extension i made)
static __inline__ void
sock_recv_timestamp(struct msghdr *msg, struct sock *sk, struct sk_buff *skb)
{
        if (sk->rcvtstamp)
                put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP, sizeof(skb->stamp), &skb
->stamp);
        else
                sk->stamp = skb->stamp;
        if((sk->tsbucket))
          printk("skb=%p, timestamp.is_valid=%d!\n",skb,skb->rcvtime.is_valid);

My first idea was that maybe the skb is copied around before, so i put
some printk in skb_head_from_pool - but this seems not to be the case.
Here is what the kernel says: (no lines left out!)

May 24 08:55:43 licht kernel: skb_head_from_pool, skb=cfaa6d80
May 24 08:55:43 licht kernel: orinoco.c: skb=cfaa6d80
May 24 08:55:43 licht kernel: skb=cfaa6d80, timestamp.is_valid=0!
May 24 08:55:43 licht kernel: skb_head_from_pool, skb=cfaa6d80
May 24 08:55:43 licht kernel: skb_head_from_pool, skb=cf0fa200

I am out of ideas - anybody else?
(This must be some really stupid bug or misunderstanding of mine, i guess,
but i really have no idea what i overlooked.)

Any help is appreciated.

Thanks,
Wolfgang

