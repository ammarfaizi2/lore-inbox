Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262086AbSJNSu6>; Mon, 14 Oct 2002 14:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262093AbSJNSu6>; Mon, 14 Oct 2002 14:50:58 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.34]:7831 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S262086AbSJNSu4> convert rfc822-to-8bit; Mon, 14 Oct 2002 14:50:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Bart De Schuymer <bart.de.schuymer@pandora.be>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: [RFC] bridge-nf -- map IPv4 hooks onto bridge hooks, vs 2.5.42
Date: Mon, 14 Oct 2002 20:58:53 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org, buytenh@gnu.org,
       Lennert Buytenhek <buytenh@gnu.org>, <rusty@rustcorp.com.au>
References: <20020911.153132.63843642.davem@redhat.com> <200210142005.06292.bart.de.schuymer@pandora.be> <20021014.110159.15420052.davem@redhat.com>
In-Reply-To: <20021014.110159.15420052.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210142058.53355.bart.de.schuymer@pandora.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 October 2002 20:01, David S. Miller wrote:
Hello,

These are probably stupid questions to you, but here it goes.

> These changes cannot go in:
>
> 1) There is no reason the 'okfn' you use cannot be the
>    function doing the MAC header copy.
>
>    This is how this is supposed to work.
>
>    I explained in that long thread a few weeks ago how
>    this copy may not be placed in the generic IP code.
>    This is final, you must find a way to make this copy
>    without touching ipv4/*.c

I've checked the skb->dst->hh field and it (or skb->dst itself) was NULL for 
purely bridged packets. So we'd have to fill this in ourselves. Can the 
bridge code go fill in a skb->dst and skb->dst->hh? Is this considered clean?

> 2) The netfilter changes need to be approved by the netfilter
>    team.
>
>    I suspect, like myself, they will barf at the phys{in,out}dev
>    additions to sk_buff.  We already have enough junk sitting
>    in sk_buff making it larger than it needs to be.

I added a third member as well... It's needed too, in my opinion.
There could ofcourse be added a pointer to a struct containing these three 
values (and a copied Ethernet header). Then we go from 3 to 1 extra member...
Anyway, it's not like Lennert and me like adding new members, but we need to 
save those things somewhere...

>    Perhaps you can hang this off the nf_conntrack pointer and
>    specify a destructor.
>
> 3) The bridging layer changes need to be approved by Lennert.
>    But I'd suggest working out #1 and #2 first.

So if I change
struct nf_conntrack {
	atomic_t use;
	void (*destroy)(struct nf_conntrack *);
};

into this:

struct nf_conntrack {
	atomic_t use;
	void (*destroy)(struct nf_conntrack *);
	struct brnf_data *brnf;
};

I can keep the copy of the Ethernet header in the struct brnf_data too (then I 
don't have to touch skbuff->dst).
The skbuff->nfct field can already be in use by an IP connection tracker (or 
something), so I can't use my own destroy function.
So I'd have to go do something in 
net/ipv4/netfilter/ip_conntrack_core.c::destroy_conntrack() and I don't know 
that stuff.
I sure don't like this solution more than the current situation.

Anyway, mapping the IPv4 hooks onto the bridge hooks is in my opinion by 
definition a hack. But a very useful hack. So if you want this in the kernel 
you'll have to be forgiving. Or present a nice solution, because I and 
probably Lennert really don't see a nice(r) solution.

So, the best solution I can think of is adding a skbuff->brnf pointer to a 
struct brnf_data. This will get rid of the copy in ip_output.c. Is that 
enough? This will uglify the ip_tables.c patch however.

-- 
cheers,
Bart

