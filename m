Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316235AbSEZRfb>; Sun, 26 May 2002 13:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316236AbSEZRfa>; Sun, 26 May 2002 13:35:30 -0400
Received: from berta.E-Technik.Uni-Dortmund.DE ([129.217.182.12]:61706 "HELO
	kt.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S316235AbSEZRf3>; Sun, 26 May 2002 13:35:29 -0400
Date: Sun, 26 May 2002 19:35:29 +0200
From: Wolfgang Wegner <ww@kt.e-technik.uni-dortmund.de>
To: Wolfgang Wegner <ww@kt.e-technik.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sk_buff modification problem -> (almost) solved
Message-ID: <20020526193529.A11200@bigmac.e-technik.uni-dortmund.de>
In-Reply-To: <20020524100434.B1778@bigmac.e-technik.uni-dortmund.de> <20020526010025.A18021@bigmac.e-technik.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I finally found the source of the problem, and was such able to solve
it for me. Unfortunately, I do not really understand, why all this
behaves that way.

In short:
I inserted a new member into struct sk_buff, which was filled in in the
driver (orinoco.c) and should be evaluated "upstairs". However, the contents
of this field was already lost in netif_rx...

(Like this:
[orinoco.c, orinoco_ev_rx]
        skb->rcvtime.is_valid=1; 
        printk("orinoco.c: skb=%p, is_valid=%d\n",skb,skb->rcvtime.is_valid);
        netif_rx(skb);

[linux/net/core/dev.c]
int netif_rx(struct sk_buff *skb)
{
        int this_cpu = smp_processor_id();
        struct softnet_data *queue;
        unsigned long flags;

        if (skb->stamp.tv_sec == 0)
                do_gettimeofday(&skb->stamp);

        printk("netif_rx: skb=%p, is_valid=%d\n",skb,skb->rcvtime.is_valid);

dmesg:
May 26 14:41:05 licht kernel: orinoco.c: skb=c3d40d80, is_valid=1
May 26 14:41:05 licht kernel: netif_rx: skb=c3d40d80, is_valid=0
May 26 14:41:05 licht kernel: orinoco.c: skb=c3d400c0, is_valid=1
May 26 14:41:05 licht kernel: netif_rx: skb=c3d400c0, is_valid=0
...and so on)

It turned out to be a problem with the pcmcia-cs-3.1.33 package i was using,
now i modified the in-kernel orinoco driver to generate the timestamps i want,
and everything works as expected.

What i do not understand is how such a behaviour can evolve, without any
compiler warning?
Just post it again because i really would be interested which trap i ran
into here... ;-)

Wolfgang

