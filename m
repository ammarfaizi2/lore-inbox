Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbUCIA5j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 19:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbUCIA5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 19:57:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:47589 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261435AbUCIA5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 19:57:37 -0500
Date: Mon, 8 Mar 2004 16:59:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in
 <=16G machines)
Message-Id: <20040308165937.562e3d29.akpm@osdl.org>
In-Reply-To: <20040309003550.GL12612@dualathlon.random>
References: <20040308202433.GA12612@dualathlon.random>
	<Pine.LNX.4.58.0403081238060.9575@ppc970.osdl.org>
	<20040308132305.3c35e90a.akpm@osdl.org>
	<20040308230247.GC12612@dualathlon.random>
	<20040308152126.54f4f681.akpm@osdl.org>
	<20040308234014.GG12612@dualathlon.random>
	<20040308161046.04270108.akpm@osdl.org>
	<20040309003550.GL12612@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> btw, this reminds me another trouble, that is what to do in the case
> where in 2.4 we convert file-mapped-pages into anonymous pages while
> they're still mapped (I don't remeber exactly what could do that but it
> could happen, do you remember the details? I think this is the case that
> Hugh calls the Morton pages, he also had troubles in his anobjrmap
> attempt but I think it was more a fixme comment). In 2.4 the swap_out
> had to deal with that somehow, but with my anobjrmap the vm will now
> lose track of those pages, so they will become unswappable. Not sure if
> they were unswappable in 2.4 too and/or if 2.6-rmap could leave them
> visible to the vm or not.
> 
> Also these pages should be swapped to the swap device, if something,
> they lost reference of the inode.
> 
> Input on the Morton pages is appreciated ;)

You mean Dickens pages ;)

They were caused by a race between truncate and filemap_nopage(), iirc. 
nopage was sleeping on the read I/O and truncate would come in and tear
down the pagetables.  Then the read I/O completes and nopage reinstantiates
the page outside i_size after truncate ripped it off the mapping.  truncate
was unable to free the page because ext3 happened to have a ref via the
page's buffer_heads.  Something like that.

But these pages should no longer exist, due to the truncate_count logic in
do_no_page().


However I'm not sure that this (truly revolting) problem which Rajesh
identified:

http://www.ussg.iu.edu/hypermail/linux/kernel/0402.2/1155.html

Cannot cause them to come back.

I really do want to fix that problem via locking: say taking i_shared_sem
inside mremap().  i_shared_sem is a very innermost lock and the ranking
with mmap_sem is all wrong.

For now, it would be sufficient to put a debug printk in there somewhere to
see if we are still getting Dickens pages.
