Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932233AbWFDLRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWFDLRr (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 07:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWFDLRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 07:17:47 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:51348 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932233AbWFDLRr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 07:17:47 -0400
Message-ID: <349419864.11444@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Sun, 4 Jun 2006 19:17:54 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: [minor fix] radixtree: regulate tag get return value
Message-ID: <20060604111754.GA5984@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	nickpiggin@yahoo.com.au
References: <349410738.29011@ustc.edu.cn> <20060604021105.1ce7d727.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060604021105.1ce7d727.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2006 at 02:11:05AM -0700, Andrew Morton wrote:
> On Sun, 4 Jun 2006 16:45:48 +0800
> Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> 
> > Andrew, this small patch makes the radixtree tester program from
> >         http://www.zip.com.au/~akpm/linux/patches/stuff/rtth.tar.gz
> > run OK, with the latest radix tree code in linux-2.6.17-rc5-mm2.
> > 
> > It regulates the return value to 0/1 for functions
> > radix_tree_tag_get() and radix_tree_tagged().
> > 
> 
> Well yes.  But it slows down the kernel.  It would be better to fix rtth.

OK. I'll send an updated patch to directly fix the for-rtth radix_tree_tag_get().

> > ---
> > 
> > --- linux.orig/lib/radix-tree.c
> > +++ linux/lib/radix-tree.c
> > @@ -156,7 +156,7 @@ static inline void tag_clear(struct radi
> >  static inline int tag_get(struct radix_tree_node *node, unsigned int tag,
> >  		int offset)
> >  {
> > -	return test_bit(offset, node->tags[tag]);
> > +	return !! test_bit(offset, node->tags[tag]);
> >  }
> 
> test_bit() is (sadly) defined to return 0 or 1.  Did this really make a difference?

Interesting. I got the following gdb outputs. Note that tag_get()
returns -1 and root_tag_get() returns 1048576.

(gdb) n
399             while (height > 0) {
(gdb) n
402                     offset = (index >> shift) & RADIX_TREE_MAP_MASK;
(gdb)
403                     if (!tag_get(slot, tag, offset))
(gdb)
404                             tag_set(slot, tag, offset);
(gdb) p tag_get(slot, tag, offset)
$14 = 0
(gdb) n
405                     slot = slot->slots[offset];
(gdb) p tag_get(slot, tag, offset)
$15 = -1
(gdb) n
406                     BUG_ON(slot == NULL);
(gdb) n
407                     shift -= RADIX_TREE_MAP_SHIFT;
(gdb) n
408                     height--;
(gdb) n
399             while (height > 0) {
(gdb) n
412             if (slot && !root_tag_get(root, tag))
(gdb) p root_tag_get(root, tag)
$16 = 0
(gdb) n
413                     root_tag_set(root, tag);
(gdb) n
415             return slot;
(gdb) p root_tag_get(root, tag)
$17 = 1048576

> >  static inline void root_tag_set(struct radix_tree_root *root, unsigned int tag)
> > @@ -177,7 +177,7 @@ static inline void root_tag_clear_all(st
> >  
> >  static inline int root_tag_get(struct radix_tree_root *root, unsigned int tag)
> >  {
> > -	return root->gfp_mask & (1 << (tag + __GFP_BITS_SHIFT));
> > +	return !! (root->gfp_mask & (1 << (tag + __GFP_BITS_SHIFT)));
> >  }
> >  
> 
