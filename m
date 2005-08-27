Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbVH0Rz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVH0Rz3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 13:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbVH0Rz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 13:55:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46055 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932352AbVH0Rz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 13:55:28 -0400
Date: Sat, 27 Aug 2005 10:53:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org
Subject: Re: [PATCH] make radix tree gang lookup faster by using a bitmap
 search
Message-Id: <20050827105355.360bd26a.akpm@osdl.org>
In-Reply-To: <1125159996.5159.8.camel@mulgrave>
References: <1125159996.5159.8.camel@mulgrave>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
> The current gang lookup is rather naive and slow.

I'd say the main naivety in gang lookup is the awkward top-level iteration
algorithm.  The way it bales out all the way to the top level of the tree
once __lookup() hits the end of the slots[] array, even though results[]
isn't full yet.  It's surely possible to go back up the tree just a
sufficient distance to resume the iteration, rather than all the way to the
top.  But it's hard, and it's all in CPU cache anyway there.

It would be much simpler if it was using recursion, of course.

>  This patch replaces
> the integer count with an unsigned long representing the bitmap of
> occupied elements.  We then use that bitmap to find the first occupied
> entry instead of looping over all the entries from the beginning of the
> radix node.

But only in __lookup().  I think most gang lookups use
radix_tree_gang_lookup_tag() -> __lookup_tag().

And __lookup_tag() could use find_next_bit() on the tags anyway, as the
comment says.  I spent a bit of time doing that, had some bug, shelved it,
never got on to fixing it up.

There's a userspace test/devel setup at
http://www.zip.com.au/~akpm/linux/patches/stuff/rtth.tar.gz, btw.

> The penalty of doing this is that on 32 bit machines, the size of the
> radix tree array is reduced from 64 to 32 (so an unsigned long can
> represent the bitmap).

If we did the bitmap lookup in __lookup_tag() we wouldn't have this
restriction.

Maybe we can

a) fix radix_tree_gang_lookup() to use find_next_bit()

b) remove radix_tree_node.count

c) Add a new tag field which simply means "present"

d) remove radix_tree_gang_lookup() and __lookup() altogether

e) Implement radix_tree_gang_lookup() via radix_tree_gang_lookup_tag()

That would involve setting and clearing bit in the "present" tag field when
adding and removing items.

> I also exported radix_tree_preload() so modules can make use of radix
> trees.

uh, OK.  Note that radix_tree_preload() uses prempt_disable() protection. 
So it has the limitation that the guarantee which it provides will become
unreliable, kernel-wide, if anyone anywhere tries to do a
radix_tree_insert() from interrupt context.

