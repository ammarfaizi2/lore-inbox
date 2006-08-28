Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWH1QDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWH1QDe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 12:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWH1QDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 12:03:34 -0400
Received: from helium.samage.net ([83.149.67.129]:57511 "EHLO
	helium.samage.net") by vger.kernel.org with ESMTP id S1751143AbWH1QDd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 12:03:33 -0400
Message-ID: <3720.81.207.0.53.1156780999.squirrel@81.207.0.53>
In-Reply-To: <1156760564.23000.31.camel@twins>
References: <20060825153946.24271.42758.sendpatchset@twins> 
    <20060825153957.24271.6856.sendpatchset@twins> 
    <1396.81.207.0.53.1156559843.squirrel@81.207.0.53>
    <1156760564.23000.31.camel@twins>
Date: Mon, 28 Aug 2006 18:03:19 +0200 (CEST)
Subject: Re: [PATCH 1/4] net: VM deadlock avoidance framework
From: "Indan Zupancic" <indan@nul.nu>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>,
       "Daniel Phillips" <phillips@google.com>,
       "Rik van Riel" <riel@redhat.com>, "David Miller" <davem@davemloft.net>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, August 28, 2006 12:22, Peter Zijlstra said:
> On Sat, 2006-08-26 at 04:37 +0200, Indan Zupancic wrote:
>> Why not 'emergency'? Looks like 'emerge' with a typo now. ;-)
>
> hehe, me lazy, you gentoo ;-)
> sed -i -e 's/emerg/emregency/g' -e 's/EMERG/EMERGENCY/g' *.patch

I used it for a while, long ago, until I figured out that there were better
alternatives. I didn't like the overly complex init and portage system though.

But if you say "emerg" it will sound as "emerge", and all other fields in that
struct aren't abbreviated either and often longer, so it just makes more sense
to use the full name.


>> > @@ -391,6 +391,7 @@ enum sock_flags {
>> >  	SOCK_RCVTSTAMP, /* %SO_TIMESTAMP setting */
>> >  	SOCK_LOCALROUTE, /* route locally only, %SO_DONTROUTE setting */
>> >  	SOCK_QUEUE_SHRUNK, /* write queue has been shrunk recently */
>> > +	SOCK_VMIO, /* promise to never block on receive */
>>
>> It might be used for IO related to the VM, but that doesn't tell _what_ it does.
>> It also does much more than just not blocking on receive, so overal, aren't
>> both the vmio name and the comment slightly misleading?
>
> I'm so having trouble with this name; I had SOCK_NONBLOCKING for a
> while, but that is a very bad name because nonblocking has this well
> defined meaning when talking about sockets, and this is not that.
>
> Hence I came up with the VMIO, because that is the only selecting
> criteria for being special. - I'll fix up the comment.

It's nice and short, but it might be weird if someone after a while finds another way
of using this stuff. And it's relation to 'emergency' looks unclear. So maybe calling
both the same makes most sense, no matter how you name it.


>> > @@ -82,6 +82,7 @@ EXPORT_SYMBOL(zone_table);
>> >
>> >  static char *zone_names[MAX_NR_ZONES] = { "DMA", "DMA32", "Normal", "HighMem" };
>> >  int min_free_kbytes = 1024;
>> > +int var_free_kbytes;
>>
>> Using var_free_pages makes the code slightly simpler, as all that needless
>> convertion isn't needed anymore. Perhaps the same is true for min_free_kbytes...
>
> 't seems I'm a bit puzzled as to what you mean here.

I mean to store the variable reserve in pages instead of kilobytes. Currently you're
converting from the one to the other both when setting and when using the value. That
doesn't make much sense and can be avoided by storing the value in pages from the start.


>> > +noskb:
>> > +	/* Attempt emergency allocation when RX skb. */
>> > +	if (!(flags & SKB_ALLOC_RX))
>> > +		goto out;
>>
>> So only incoming skb allocation is guaranteed? What about outgoing skbs?
>> What am I missing? Or can we sleep then, and increasing var_free_kbytes is
>> sufficient to guarantee it?
>
> ->sk_allocation |= __GFP_EMERGENCY - will take care of the outgoing
> packets. Also, since one only sends a limited number of packets out and
> then will wait for answers, we do not need to worry about fragmentation
> issues that much in this case.

Ah, missed that one. Didn't knew that the alloc flags were stored in the sock.


>> > +static void emerg_free_skb(struct kmem_cache *cache, void *objp)
>> > +{
>> > +	free_page((unsigned long)objp);
>> > +	emerg_rx_pages_dec();
>> > +}
>> > +
>> >  /*
>> >   *	Free an skbuff by memory without cleaning the state.
>> >   */
>> > @@ -326,17 +373,21 @@ void kfree_skbmem(struct sk_buff *skb)
>> >  {
>> >  	struct sk_buff *other;
>> >  	atomic_t *fclone_ref;
>> > +	void (*free_skb)(struct kmem_cache *, void *);
>> >
>> >  	skb_release_data(skb);
>> > +
>> > +	free_skb = skb->emerg ? emerg_free_skb : kmem_cache_free;
>> > +
>> >  	switch (skb->fclone) {
>> >  	case SKB_FCLONE_UNAVAILABLE:
>> > -		kmem_cache_free(skbuff_head_cache, skb);
>> > +		free_skb(skbuff_head_cache, skb);
>> >  		break;
>> >
>> >  	case SKB_FCLONE_ORIG:
>> >  		fclone_ref = (atomic_t *) (skb + 2);
>> >  		if (atomic_dec_and_test(fclone_ref))
>> > -			kmem_cache_free(skbuff_fclone_cache, skb);
>> > +			free_skb(skbuff_fclone_cache, skb);
>> >  		break;
>> >
>> >  	case SKB_FCLONE_CLONE:
>> > @@ -349,7 +400,7 @@ void kfree_skbmem(struct sk_buff *skb)
>> >  		skb->fclone = SKB_FCLONE_UNAVAILABLE;
>> >
>> >  		if (atomic_dec_and_test(fclone_ref))
>> > -			kmem_cache_free(skbuff_fclone_cache, other);
>> > +			free_skb(skbuff_fclone_cache, other);
>> >  		break;
>> >  	};
>> >  }
>>
>> I don't have the original code in front of me, but isn't it possible to
>> add a "goto free" which has all the freeing in one place? That would get
>> rid of the function pointer stuff and emerg_free_skb.
>
> perhaps, yes, however I prefer this one, it allows access to the size.

What size are you talking about? What I had in mind is probably less readable,
but it avoids a bunch of function calls and that indirect function call, so
with luck it has less overhead and smaller object size:

void kfree_skbmem(struct sk_buff *skb)
{
	struct sk_buff *other;
	atomic_t *fclone_ref;
	struct kmem_cache *cache = skbuff_head_cache;
	struct sk_buff *free = skb;

	skb_release_data(skb);
	switch (skb->fclone) {
	case SKB_FCLONE_UNAVAILABLE:
		goto free;

	case SKB_FCLONE_ORIG:
		fclone_ref = (atomic_t *) (skb + 2);
		if (atomic_dec_and_test(fclone_ref)){
			cache = skbuff_fclone_cache;
			goto free;
		}
		break;

	case SKB_FCLONE_CLONE:
		fclone_ref = (atomic_t *) (skb + 1);
		other = skb - 1;

		/* The clone portion is available for
		 * fast-cloning again.
		 */
		skb->fclone = SKB_FCLONE_UNAVAILABLE;

		if (atomic_dec_and_test(fclone_ref)){
			cache = skbuff_fclone_cache;
			free = other;
			goto free;
		}
		break;
	};
	return;
free:
	if (!skb->emergency)
		kmem_cache_free(cache, free);
	else
		emergency_rx_free(free, kmem_cache_size(cache));
}


>> Are these functions only called for incoming skbs? If not, calling
>> emerg_rx_pages_try_inc() is the wrong thing to do. A quick search says
>> they aren't. Add a RX check? Or is that fixed by SKB_FCLONE_UNAVAILABLE?
>> If so, why are skb_clone() and pskb_expand_head() modified at all?
>> (Probably ignorance on my end.)
>
> Well, no, however only incoming skbs can have skb->emergency set to
> begin with.

Yes, that solves it.


>> You can get rid of the memalloc_reserve and vmio_request_queues variables
>> if you want, they aren't really needed for anything. If using them reduces
>> the total code size I'd keep them though.
>
> I find my version easier to read, but that might just be the way my
> brain works.

Maybe true, but I believe my version is more natural in the sense that it makes
more clear what the code is doing. Less bookkeeping, more real work, so to speak.

But after another look things seem a bit shaky, in the locking corner anyway.

sk_adjust_memalloc() calls adjust_memalloc_reserve(), which changes var_free_kbytes
and then calls setup_per_zone_pages_min(), which does the real work. But it reads
min_free_kbytes without holding any locks. In mainline that's fine as the function
is only called by the proc handler and in obscure memory hotplug stuff. But with
your code it can also be called at any moment when a VMIO socket is made, which now
races with the proc callback. More a theoretical than a real problem, but still
slightly messy.

adjust_memalloc_reserve() has no locking at all, while it might be called concurrently
from different sources. Luckily sk_adjust_memalloc() is the only user, and which uses
its own spinlock for synchronization, so things go well by accident now. It seems
cleaner to move that spinlock so that it protects var|min_free_kbytes instead.


+int adjust_memalloc_reserve(int pages)
+{
+	int kbytes;
+	int err = 0;
+
+	kbytes = var_free_kbytes + (pages << (PAGE_SHIFT - 10));
+	if (kbytes < 0) {
+		err = -EINVAL;
+		goto out;
+	}

Shouldn't that be a BUG_ON instead?

Greetings,

Indan


