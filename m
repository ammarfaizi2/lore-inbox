Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261678AbSKMO4m>; Wed, 13 Nov 2002 09:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261872AbSKMO4m>; Wed, 13 Nov 2002 09:56:42 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:61960 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261678AbSKMO4l>; Wed, 13 Nov 2002 09:56:41 -0500
Message-Id: <200211131457.gADEvKp15095@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "David S. Miller" <davem@redhat.com>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: dmesg of 2.5.45 boot on NFS client
Date: Wed, 13 Nov 2002 17:48:40 -0200
X-Mailer: KMail [version 1.3.2]
References: <200211061605.gA6G5xp14090@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200211061605.gA6G5xp14090@Port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org,
       Alexander Vlasenko <intrnl_edu@ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mii-tool -F 100baseTx-FD eth0

does not work in 2.5 while working fine in 2.4.
What should I do? Fix eth driver?
Use never mii-tool or equivalent?

# mii-tool --version
mii-tool.c 1.9 2000/04/28 00:56:08 (David Hinds)

# lspci
01:08.0 Ethernet controller: Intel Corp. 82820 (ICH2) Chipset Ethernet Controller (rev 03)

On 6 November 2002 18:57, Denis Vlasenko wrote:
> TCP: Hash tables configured (established 4096 bind 5461)
> Sending DHCP requests .fix old protocol handler
> ic_bootp_recv+0x0/0x3a0! .fix old protocol handler
> ic_bootp_recv+0x0/0x3a0!
> ,fix old protocol handler ic_bootp_recv+0x0/0x3a0!
>  OK

Dave, Arnaldo, I can attempt to fix this if you think
it's feasible to receive my possibly buggy newcomer code
instead of fixing it yourself. In this case, feel free
to apply a cluebat as to what should be done / where should
I look for example of 'new protocol handler' ;)

I know that plans are underway to push all this stuff to early
userspace but I need it *now* if I want to test 2.5 at this time.

I suspect you already seen these lines of code,
but here they are (2.5.47):

net/core/dev.c:
static int deliver_to_old_ones(struct packet_type *pt,
                               struct sk_buff *skb, int last)
{
        int ret = NET_RX_DROP;

        if (!last) {
                skb = skb_clone(skb, GFP_ATOMIC);
                if (!skb)
                        goto out;
        }
        if (skb_is_nonlinear(skb) && skb_linearize(skb, GFP_ATOMIC))
                goto out_kfree;

#if CONFIG_SMP
        /* Old protocols did not depened on BHs different of NET_BH and
           TIMER_BH - they need to be fixed for the new assumptions.
         */
        print_symbol("fix old protocol handler %s!\n", (unsigned long)pt->func);
#endif


net/ipv4/ipconfig.c:
...
static int ic_bootp_recv(struct sk_buff *skb, struct net_device *dev, struct packet_type *pt);

static struct packet_type bootp_packet_type __initdata = {
        .type = __constant_htons(ETH_P_IP),
        .func = ic_bootp_recv,
};
...
static int __init ic_bootp_recv(struct sk_buff *skb, struct net_device *dev, struct packet_type *pt)
{
        struct bootp_pkt *b = (struct bootp_pkt *) skb->nh.iph;
        struct iphdr *h = &b->iph;
        struct ic_device *d;
        int len;

        /* One reply at a time, please. */
        spin_lock(&ic_recv_lock);

        /* If we already have a reply, just drop the packet */
        if (ic_got_reply)
                goto drop;
--
vda
