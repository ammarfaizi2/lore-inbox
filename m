Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283054AbRK1ONb>; Wed, 28 Nov 2001 09:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283059AbRK1OMx>; Wed, 28 Nov 2001 09:12:53 -0500
Received: from zeus.kernel.org ([204.152.189.113]:25560 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S283063AbRK1OL2>;
	Wed, 28 Nov 2001 09:11:28 -0500
Date: Wed, 28 Nov 2001 15:05:04 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Rolf Fokkens <fokkensr@linux06.vertis.nl>
Cc: gandalf@marcelothewonderpenguin.com, linux-kernel@vger.kernel.org,
        netfilter-devel@lists.samba.org, torvalds@transmeta.com,
        marcelo@conectiva.com.br
Subject: Re: [BUG] vanilla 2.4.15 iptables/REDIRECT kernel oops
Message-Id: <20011128150504.4159214d.skraw@ithnet.com>
In-Reply-To: <01112723555300.01996@home01>
In-Reply-To: <Pine.LNX.4.21.0111271600420.23169-100000@tux.rsn.bth.se>
	<01112723555300.01996@home01>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001 23:55:53 -0800
Rolf Fokkens <fokkensr@linux06.vertis.nl> wrote:

> OK. So there hasn't been much response for this BUG report. So I did a little

> investigating myself.
> 
> By use of objdump I get the impression that the Oops shows up when 
> ip_dont_fragment is called (expanded). To be more specific: sk seems to be 
> NULL.
> 
> This is rather weird. ip_queue_xmit2 is also the caller of nf_hook_slow (via 
> ip_queue_xmit) at which time skb->sk must be OK. After nf_hook_slow things 
> suddenly are wrong.

Well, I have another impression. Look at this code from ip_queue_xmit2:

        if (skb_headroom(skb) < dev->hard_header_len && dev->hard_header) {
                struct sk_buff *skb2;

                skb2 = skb_realloc_headroom(skb, (dev->hard_header_len + 15) &
~15);
                kfree_skb(skb);  
                if (skb2 == NULL)
                        return -ENOMEM;
                if (sk)
                        skb_set_owner_w(skb2, sk);
                skb = skb2;
                iph = skb->nh.iph;
        }

What you see here is that the original author obviously thought it may be
possible that sk is NULL. Otherwise he would not have put the "if (sk)" in. We
believe him, that he knows what he's doing and read on.

        if (skb->len > rt->u.dst.pmtu)
                goto fragment;

        if (ip_dont_fragment(sk, &rt->u.dst))
                iph->frag_off |= __constant_htons(IP_DF);

Shit. You have it.

static inline
int ip_dont_fragment(struct sock *sk, struct dst_entry *dst)
{ 
        return (sk->protinfo.af_inet.pmtudisc == IP_PMTUDISC_DO ||
                (sk->protinfo.af_inet.pmtudisc == IP_PMTUDISC_WANT &&
                 !(dst->mxlock&(1<<RTAX_MTU))));
}

Obviously this breaks in case of sk == NULL. 
This leaves you with the following alternatives:

1) He should do 
	if (sk && ip_dont_fragment(sk, &rt->u.dst))

or

2) ip_dont_fragment is in itself broken, as it is obviously called with
sk==NULL and should handle that.

Anyway, this is a serious bug, because the code is definitely inconsistent.
ip_dont_fragment shows up 6 times in the source (according to my counting). The
safe patch would look like this:

--- ip.h-orig   Wed Nov 28 14:55:50 2001
+++ ip.h        Wed Nov 28 14:56:25 2001
@@ -181,9 +181,9 @@
 static inline
 int ip_dont_fragment(struct sock *sk, struct dst_entry *dst)
 {
-       return (sk->protinfo.af_inet.pmtudisc == IP_PMTUDISC_DO ||
+       return (sk && ( sk->protinfo.af_inet.pmtudisc == IP_PMTUDISC_DO ||
                (sk->protinfo.af_inet.pmtudisc == IP_PMTUDISC_WANT &&
-                !(dst->mxlock&(1<<RTAX_MTU))));
+                !(dst->mxlock&(1<<RTAX_MTU)))));
 }
 
 extern void __ip_select_ident(struct iphdr *iph, struct dst_entry *dst);



Can you check out?

Can any ip-stack guru comment?

Regards,
Stephan

PS: ip_select_ident looks clean in terms of sk==NULL, BTW.

