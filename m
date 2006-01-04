Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965176AbWADHQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbWADHQE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 02:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965191AbWADHQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 02:16:04 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:35188 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965176AbWADHQD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 02:16:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z8bFR7Ao7vNLAewsiPNqhPcPAo4LBmL1e1aDCndj5Zi3EbIrjpLpNo6ho5bh/hj9b2pQ51tBvDOR8etWxblwAHZEwL/vPZ/P2cThtM3EPxr/nlu2LBZky/2ocNtIOTCdrfQUstuN7kDaEBGH8yMBSgYVRJ3Q39++VdQnbof9fJQ=
Message-ID: <9c21eeae0601032316l3259fbecle6a0b290ed244e12@mail.gmail.com>
Date: Tue, 3 Jan 2006 23:16:02 -0800
From: David Brown <dmlb2000@gmail.com>
To: =?ISO-2022-JP?Q?YOSHIFUJI_Hideaki_/_=1B=24B5HF=231QL=40=1B=28B?= 
	<yoshfuji@linux-ipv6.org>
Subject: Re: 2.6.15-rt1
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20060103.202422.50699198.yoshfuji@linux-ipv6.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060103094720.GA16497@elte.hu>
	 <9c21eeae0601031512m44c4a269ua2214528eaf90914@mail.gmail.com>
	 <20060103.202422.50699198.yoshfuji@linux-ipv6.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch should fix compilation issues in net/ipv6 subsystem
> w/ rt patch.
>
> Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
>
> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> index f829a4a..15264f4 100644
> --- a/net/ipv6/mcast.c
> +++ b/net/ipv6/mcast.c
> @@ -224,7 +224,7 @@ int ipv6_sock_mc_join(struct sock *sk, i
>
>         mc_lst->ifindex = dev->ifindex;
>         mc_lst->sfmode = MCAST_EXCLUDE;
> -       mc_lst->sflock = RW_LOCK_UNLOCKED;
> +       mc_lst->sflock = RW_LOCK_UNLOCKED(mc_lst->sflock);
>         mc_lst->sflist = NULL;
>
>         /*
> diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
> index c2c52af..bfd7a2b 100644
> --- a/net/ipv6/netfilter/nf_conntrack_reasm.c
> +++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
> @@ -98,7 +98,7 @@ struct nf_ct_frag6_queue
>  #define FRAG6Q_HASHSZ  64
>
>  static struct nf_ct_frag6_queue *nf_ct_frag6_hash[FRAG6Q_HASHSZ];
> -static rwlock_t nf_ct_frag6_lock = RW_LOCK_UNLOCKED;
> +static rwlock_t nf_ct_frag6_lock = RW_LOCK_UNLOCKED(nf_ct_frag6_lock);
>  static u32 nf_ct_frag6_hash_rnd;
>  static LIST_HEAD(nf_ct_frag6_lru_list);
>  int nf_ct_frag6_nqueues = 0;
> @@ -371,7 +371,7 @@ nf_ct_frag6_create(unsigned int hash, u3
>         init_timer(&fq->timer);
>         fq->timer.function = nf_ct_frag6_expire;
>         fq->timer.data = (long) fq;
> -       fq->lock = SPIN_LOCK_UNLOCKED;
> +       fq->lock = SPIN_LOCK_UNLOCKED(fq->lock);
>         atomic_set(&fq->refcnt, 1);
>
>         return nf_ct_frag6_intern(hash, fq);
>
> --

Thanks and the patch worked fine, but I have a question about the
patch submitted to the url...
I created a new patch with the included ipv6 subsystem fix but I'm
getting a smaller patch than what is posted on the website.

$ wc -l patch-2.6.15-rt1
57869 patch-2.6.15-rt1
$ wc -l patch-2.6.15-rt1-1
57156 patch-2.6.15-rt1-1

patch-2.6.15-rt1-1 has the ipv6 patch yet is smaller than the initial
patch. I created the patch using:
$ diff -uprN linux-2.6.15 linux-2.6.15-rt1 > patch-2.6.15-rt1-1

Is this not the way you did it? I noticed different headers in my
patch vs. the patch posted. Really I'm concerned about missing
anything in the patch, considering it's 700+ lines smaller.

- David Brown
