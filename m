Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWDUTHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWDUTHH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 15:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWDUTHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 15:07:07 -0400
Received: from canuck.infradead.org ([205.233.218.70]:48046 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751210AbWDUTHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 15:07:06 -0400
Subject: Re: [PATCH] Shrink rbtree
From: David Woodhouse <dwmw2@infradead.org>
To: Zach Brown <zach.brown@oracle.com>
Cc: akpm@osdl.org, andrea@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <44492343.6040603@oracle.com>
References: <1145623663.11909.139.camel@pmac.infradead.org>
	 <44492343.6040603@oracle.com>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 20:06:52 +0100
Message-Id: <1145646412.11909.218.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 11:24 -0700, Zach Brown wrote:
> > the pointers are always going to be aligned. So let's just use the
> > lowest bit of the parent pointer instead. This shrinks the rb_node from
> > 4 machine-words to 3.
> 
> We've seen this patch before, haven't we? :)  I still like it.

Maybe. I thought I'd actually done it once before, but I couldn't
actually find it when I went looking. It should save about 40KiB of RAM
on my Nokia 770, because I should get 145 jffs2_node_frag objects in
each slab page instead of only 127 -- so yes, I like it too :)

> > Another pair of eyes on the 'remove dead code in rb_erase()' bit in
> > particular would be appreciated.
> 
> I'll trade you some eyes for a description beyond the four words
> obvious, remove, dead, and code.

Plenty more words in the git commit. They don't make much sense without
the patch right below them, and you can see them in juxtaposition at 
http://git.infradead.org/?p=users/dwmw2/rbtree-2.6.git;a=commitdiff;h=1975e59375756da4ff4e6e7d12f67485e813ace0

> >  #define	RB_RED		0
> >  #define	RB_BLACK	1
> 
> > +#define rb_colour(r)   ((r)->rb_parent_colour & 1)
> 
> This creates a pretty strong bond between the two.. maybe a
> RB_COLOUR_MASK and use that and the _RED/_BLACK defines instead of the
> raw constants?

I think it's be better just to drop the RB_RED and RB_BLACK definitions.

> > +static inline void rb_set_parent(struct rb_node *rb, struct rb_node *p)
> > +{
> 
> 	BUG_ON((unsigned long)p & 3);

Yeah, I suppose we could.
> > @@ -131,8 +147,7 @@ extern void rb_replace_node(struct rb_no
> >  static inline void rb_link_node(struct rb_node * node, struct rb_node * parent,
> >  				struct rb_node ** rb_link)
> >  {
> > -	node->rb_parent = parent;
> > -	node->rb_color = RB_RED;
> > +	node->rb_parent_colour = (unsigned long )parent;
> 
> use rb_set_parent(node, parent) and get the assertion.

Que?

-- 
dwmw2

