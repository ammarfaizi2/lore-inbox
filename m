Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbTA2DFx>; Tue, 28 Jan 2003 22:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbTA2DFx>; Tue, 28 Jan 2003 22:05:53 -0500
Received: from sex.inr.ac.ru ([193.233.7.165]:35747 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S262418AbTA2DFx>;
	Tue, 28 Jan 2003 22:05:53 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200301290314.GAA31081@sex.inr.ac.ru>
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x,
To: davem@redhat.com (David S. Miller)
Date: Wed, 29 Jan 2003 06:14:55 +0300 (MSK)
Cc: benoit-lists@fb12.de, dada1@cosmosbay.com, cgf@redhat.com, andersg@0x63.nu,
       lkernel2003@tuxers.net, linux-kernel@vger.kernel.org, tobi@tobi.nu
In-Reply-To: <20030128.160806.13210372.davem@redhat.com> from "David S. Miller" at Jan 28, 3 04:08:06 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> BTW, Alexey, please please explain to me how that trick made
> by tcp_trim_head() works. :-)  I am talking about how it is
> setting ip_summed to CHECKSUM_HARDWARE blindly and not even
> bothering to set skb->csum correctly.

skb->csum is not used inside TCP when skb->ip_summed==CHECKSUM_HW:

void tcp_v4_send_check(struct sock *sk, struct tcphdr *th, int len,
                       struct sk_buff *skb)
{
        struct inet_opt *inet = inet_sk(sk);

        if (skb->ip_summed == CHECKSUM_HW) {
                th->check = ~tcp_v4_check(th, len, inet->saddr, inet->daddr, 0);
                skb->csum = offsetof(struct tcphdr, check);

And when pushing segment down to IP, it is initialized to offset of th->check.

So, it is safe to make skb->ip_summed := CHECKSUM_HW any moment when
we are lazy to recalculate checksum. Frankly speaking, it is not very good,
I was confused _a_ _lot_ when seeing wrong checksums on those bogus
zero-length packets in tcpdumps made by Christopher. But saves some
source lines.

Alexey
