Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316523AbSFPSve>; Sun, 16 Jun 2002 14:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316531AbSFPSvd>; Sun, 16 Jun 2002 14:51:33 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:56744 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316523AbSFPSvc>;
	Sun, 16 Jun 2002 14:51:32 -0400
Date: Sun, 16 Jun 2002 14:51:33 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
In-Reply-To: <UTC200206161313.g5GDDPX00513.aeb@smtp.cwi.nl>
Message-ID: <Pine.GSO.4.21.0206161412010.5807-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 16 Jun 2002 Andries.Brouwer@cwi.nl wrote:

>     That's simply not true.  Of the top of my head - /proc/self.
> 
> Ah, yes - that has the string on stack.
> That changes my inventory into: all callers except two use a page.
> One (jffs2) uses a kmalloced area. One (/proc/self) has its data
> on the stack.
> 
>     Look, it's getting ridiculous.
> 
> That is a counterproductive reply.
> You say "I tried to improve Linux three years ago and failed,
> so you can forget it - no improvement is possible".

No.  What I'm saying is "your handwaving is getting ridiculous".

> Let us try. The basic object is a struct link_work that has dentry,
> nameidata, link, page and flags and a pointer to the next such struct.
> This is a reverse linked list: the thing we work on is in front,
> the tail of the list is the thing we originally started to resolve.
> 
> The routine that does all this is
> 
> int do_link_work(struct link_work **lw) {
> 	int err = 0;
> 
> 	while((*lw)->link) {
> 		if (err == 0)
> 			err = do_link_item(lw);
> 		else
> 			do_bad_link_item(lw);
> 	}
> 	return err;
> }
>
> where do_link_item() has as duty to handle the next part
> of the pathname. That diminishes the work left, unless
> that next part was a symlink, in which case resolution
> of that is prepended to the list of work we have to do.
> If something is wrong, do_bad_link_item() only releases resources.
> 
> Looks like a nice and clean setup.

"The process is iterative, so there is a loop somewhere; let's put
whatever body it might have into a separate function - see, no ugliness
there". 

> Remains the question how to release the resources allocated
> by the filesystems in prepare_follow_link().

... and a couple of other questions, like, say it, how to deal with
handling of "alternative roots" (/usr/gnuemul/<foo>) or what will your
do_link_item() be.

> There are various possibilities. General ones: the filesystem
> provides a callback. Restricted ones: we ask the filesystem
> to have one page as the only resource. Kludgy ones: we allow
> some explicit short list, like page or kmalloc. Probably others.
>
> But maybe you are not interested in thinking about such things.
> You did it already.

Indeed I had.  Look, either you have a decent solution or not.  If you
want to try - by all means, go ahead, I'll be glad to see the current
situation improved.  Write a patch and post it for review - it's not
exactly the rocket science.  Obvious requirements:
	* if current code resolves a pathname, replacement should do the same.
	* if current code fails with something different from ELOOP - so
should the replacement (modulo things like ENOMEM, obviously)
	* replacement code should not penalize the lookups that do not
encounter nested symlinks at all.
	* resulting namei.c should not be uglier than it currently is
(and if some code migrates to new files - same for all these files combined).

Fair enough, I hope?  Keep in mind that pathname resolution is one of the
hotspots, so "should not penalize..." part is quite serious.  Write it
(starting at 2.5.<current> version) and post it for review.  Then there
will be something to talk about; right now you are making very vague
proposals of reorganization of code you hadn't read through and saying that
such reorganization can be done with decent results...

