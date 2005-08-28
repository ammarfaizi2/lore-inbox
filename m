Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVH1Uk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVH1Uk5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 16:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbVH1Uk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 16:40:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50067 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750715AbVH1Uk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 16:40:56 -0400
Date: Sun, 28 Aug 2005 13:39:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make radix tree gang lookup faster by using a bitmap
 search
Message-Id: <20050828133922.6208fe62.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508281253320.3317@g5.osdl.org>
References: <1125159996.5159.8.camel@mulgrave>
	<20050827105355.360bd26a.akpm@osdl.org>
	<1125258200.5048.18.camel@mulgrave>
	<Pine.LNX.4.58.0508281253320.3317@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Sun, 28 Aug 2005, James Bottomley wrote:
> > 
> > radix_tree_insert() is reliable from IRQ provided you don't try to use
> > radix_tree_preload() and you defined your radix tree gfp flag to be
> > GFP_ATOMIC.
> 
> It would be better if it wasn't, though.

There's nothing in radix-tree which forces this: it requires
caller-provided locking.

> I really don't see why we made it irq-safe, and take the hit of disabling
> interrupts in addition to the locking.  That's a quite noticeable loss,
> and I don't think it's really a valid thing to insert (or look up) page
> cache entries from interrupts.
> 
> What _is_ it that makes us do that, btw? Is it just because we clear the 
> writeback tag bits or something? Sad. It makes page lookup noticeably more 
> expensive.

Yes, address_space.tree_lock was made IRQ-safe so we could alter the tree's
tags from disk completions.  Presumably Nick's lockless pagecache stuff
removes that.
