Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbUBYIYi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 03:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262521AbUBYIYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 03:24:38 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:12455 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262470AbUBYIYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 03:24:35 -0500
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 25 Feb 2004 19:24:00 +1100
Cc: davem@redhat.com, manfred@colorfullife.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.6.3 Slab corruption: errors are triggered when memory exceeds 2.5GB (correction)
Message-ID: <20040225082400.GJ18070@cse.unsw.EDU.AU>
References: <403AF155.1080305@colorfullife.com> <20040223225659.4c58c880.akpm@osdl.org> <403B8C78.2020606@colorfullife.com> <20040225005804.GE18070@cse.unsw.EDU.AU> <403C3F04.20601@colorfullife.com> <20040224230318.19a0e6b9.davem@redhat.com> <20040224232205.4fe87448.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040224232205.4fe87448.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK the patch is applied and the results are at:
http://quasar.cse.unsw.edu.au/~dsw/public-files/lemon-debug/
*-latest-skb

Darren

On Tue, 24 Feb 2004, Andrew Morton wrote:

> "David S. Miller" <davem@redhat.com> wrote:
> >
> > On Wed, 25 Feb 2004 07:21:56 +0100
> > Manfred Spraul <manfred@colorfullife.com> wrote:
> > 
> > > 0x620 (1568) is behind the end of the actual eth frame. Who could modify 
> > > that?
> > 
> > At the end of the SKB data area is where we keep struct skb_shared_info, something
> > is messing with the SKB state after a free it appears.
> > 
> > And since it's turning the debugging value 0x6b to 0x6a it must be the
> > "atomic_t dataref;" that is being mucked with.
> 
> Ah-hah.
> 
> This should find it:
> 
> 
>  25-akpm/include/linux/skbuff.h |    1 +
>  25-akpm/net/core/dev.c         |    1 +
>  25-akpm/net/core/skbuff.c      |    6 ++++++
>  3 files changed, 8 insertions(+)
> 
> diff -puN include/linux/skbuff.h~dataref-debug include/linux/skbuff.h
> --- 25/include/linux/skbuff.h~dataref-debug	Tue Feb 24 23:18:56 2004
> +++ 25-akpm/include/linux/skbuff.h	Tue Feb 24 23:19:20 2004
> @@ -140,6 +140,7 @@ struct skb_frag_struct {
>   */
>  struct skb_shared_info {
>  	atomic_t	dataref;
> +	int		debug;
>  	unsigned int	nr_frags;
>  	unsigned short	tso_size;
>  	unsigned short	tso_segs;
> diff -puN net/core/dev.c~dataref-debug net/core/dev.c
> --- 25/net/core/dev.c~dataref-debug	Tue Feb 24 23:18:56 2004
> +++ 25-akpm/net/core/dev.c	Tue Feb 24 23:19:34 2004
> @@ -1272,6 +1272,7 @@ int __skb_linearize(struct sk_buff *skb,
>  	/* Set up shinfo */
>  	ninfo = (struct skb_shared_info*)(data + size);
>  	atomic_set(&ninfo->dataref, 1);
> +	ninfo->debug = 0;
>  	ninfo->tso_size = skb_shinfo(skb)->tso_size;
>  	ninfo->tso_segs = skb_shinfo(skb)->tso_segs;
>  	ninfo->nr_frags = 0;
> diff -puN net/core/skbuff.c~dataref-debug net/core/skbuff.c
> --- 25/net/core/skbuff.c~dataref-debug	Tue Feb 24 23:18:56 2004
> +++ 25-akpm/net/core/skbuff.c	Tue Feb 24 23:21:36 2004
> @@ -148,6 +148,7 @@ struct sk_buff *alloc_skb(unsigned int s
>  	skb->end  = data + size;
>  
>  	atomic_set(&(skb_shinfo(skb)->dataref), 1);
> +	skb_shinfo(skb)->debug  = 0;
>  	skb_shinfo(skb)->nr_frags  = 0;
>  	skb_shinfo(skb)->tso_size = 0;
>  	skb_shinfo(skb)->tso_segs = 0;
> @@ -184,6 +185,9 @@ static void skb_clone_fraglist(struct sk
>  
>  void skb_release_data(struct sk_buff *skb)
>  {
> +	if (!skb->cloned)
> +		WARN_ON(skb_shinfo(skb)->debug != 0);
> +
>  	if (!skb->cloned ||
>  	    atomic_dec_and_test(&(skb_shinfo(skb)->dataref))) {
>  		if (skb_shinfo(skb)->nr_frags) {
> @@ -320,6 +324,7 @@ struct sk_buff *skb_clone(struct sk_buff
>  	C(tail);
>  	C(end);
>  
> +	WARN_ON(skb_shinfo(skb)->debug != 0);
>  	atomic_inc(&(skb_shinfo(skb)->dataref));
>  	skb->cloned = 1;
>  
> @@ -526,6 +531,7 @@ int pskb_expand_head(struct sk_buff *skb
>  	skb->h.raw   += off;
>  	skb->nh.raw  += off;
>  	skb->cloned   = 0;
> +	skb_shinfo(skb)->debug = 0;
>  	atomic_set(&skb_shinfo(skb)->dataref, 1);
>  	return 0;
>  
> 
> _
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
