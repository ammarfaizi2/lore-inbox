Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLOD72>; Thu, 14 Dec 2000 22:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLOD7T>; Thu, 14 Dec 2000 22:59:19 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:39439 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129257AbQLOD7A>; Thu, 14 Dec 2000 22:59:00 -0500
Date: Thu, 14 Dec 2000 19:28:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Russell Cattelan <cattelan@thebarn.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Test12 ll_rw_block error.
In-Reply-To: <3A398D58.92BBC9A4@thebarn.com>
Message-ID: <Pine.LNX.4.10.10012141925080.1123-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Dec 2000, Russell Cattelan wrote:
> 
> So one more observation in
> filemap_sync_pte
> 
>  lock_page(page);
>  error = filemap_write_page(page, 1);
> ->  UnlockPage(page);
> This unlock page was removed? is that correct?

Yes. The "writepage" thing changed: "struct file" disappeared (as I'm sure
you also noticed), and the page writer is supposed to unlock the page
itself. Which it may do at any time, of course.

There are some reasons to do it only after the IO has actually completed:
this way the VM layer won't try to write it out _again_ before the first
IO hasn't even finished yet, and the writing logic can possibly be
simplified if you know that nobody else will be touching that page.

But that is up to you: you can do the UnlockPage before even returning
from your "->writepage()" function, if you choose to do so.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
