Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWDUSYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWDUSYK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 14:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWDUSYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 14:24:09 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:10689 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S932149AbWDUSYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 14:24:08 -0400
Message-ID: <44492343.6040603@oracle.com>
Date: Fri, 21 Apr 2006 11:24:03 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: akpm@osdl.org, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shrink rbtree
References: <1145623663.11909.139.camel@pmac.infradead.org>
In-Reply-To: <1145623663.11909.139.camel@pmac.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> the pointers are always going to be aligned. So let's just use the
> lowest bit of the parent pointer instead. This shrinks the rb_node from
> 4 machine-words to 3.

We've seen this patch before, haven't we? :)  I still like it.

> Another pair of eyes on the 'remove dead code in rb_erase()' bit in
> particular would be appreciated.

I'll trade you some eyes for a description beyond the four words
obvious, remove, dead, and code.

>  struct rb_node
>  {
> -	struct rb_node *rb_parent;
> -	int rb_color;
> +	unsigned long  rb_parent_colour;

How about some kerneldoc comments?

>  #define	RB_RED		0
>  #define	RB_BLACK	1

> +#define rb_colour(r)   ((r)->rb_parent_colour & 1)

This creates a pretty strong bond between the two.. maybe a
RB_COLOUR_MASK and use that and the _RED/_BLACK defines instead of the
raw constants?

> +#define rb_is_red(r)   (!rb_colour(r))
> +#define rb_is_black(r) rb_colour(r)
> +#define rb_set_red(r)  do { (r)->rb_parent_colour &= ~1; } while (0)
> +#define rb_set_black(r)  do { (r)->rb_parent_colour |= 1; } while (0)
> +
> +static inline void rb_set_parent(struct rb_node *rb, struct rb_node *p)
> +{

	BUG_ON((unsigned long)p & 3);

> +	rb->rb_parent_colour = (rb->rb_parent_colour & 3) | (unsigned long)p;
> +}
> +static inline void rb_set_colour(struct rb_node *rb, int colour)
> +{
> +	rb->rb_parent_colour = (rb->rb_parent_colour & ~1) | colour;
> +}
> +
>  #define RB_ROOT	(struct rb_root) { NULL, }
>  #define	rb_entry(ptr, type, member) container_of(ptr, type, member)
>  
> @@ -131,8 +147,7 @@ extern void rb_replace_node(struct rb_no
>  static inline void rb_link_node(struct rb_node * node, struct rb_node * parent,
>  				struct rb_node ** rb_link)
>  {
> -	node->rb_parent = parent;
> -	node->rb_color = RB_RED;
> +	node->rb_parent_colour = (unsigned long )parent;

use rb_set_parent(node, parent) and get the assertion.

- z
