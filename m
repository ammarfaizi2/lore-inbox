Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130667AbQLMSdC>; Wed, 13 Dec 2000 13:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130849AbQLMScx>; Wed, 13 Dec 2000 13:32:53 -0500
Received: from www.wen-online.de ([212.223.88.39]:57362 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130667AbQLMScn>;
	Wed, 13 Dec 2000 13:32:43 -0500
Date: Wed, 13 Dec 2000 19:02:03 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Signal 11 - the continuing saga
In-Reply-To: <Pine.LNX.4.10.10012130914470.19475-100000@penguin.transmeta.com>
Message-ID: <Pine.Linu.4.10.10012131856130.448-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2000, Linus Torvalds wrote:

> On Wed, 13 Dec 2000, Linus Torvalds wrote:
> > 
> > Lookin gat "swapoff()", it could easily be something like
> > 
> >  - swapoff walks theough the processes, marking the pages dirty
> >    (correctly)
> >  - swapoff goes on to the next swap entry, and because it needs memory for
> >    this, the VM layer will swap out old entries by marking them dirty in
> >    the "struct page".
> >  - final stages of swapoff() removes the swap cache entry, never minding
> >    the fact that it is marked dirty again in "struct page", and clean in
> >    various VM page tables.
> > 
> > Ho humm.. I don't think that is it exactly, but something along those
> > lines.
> 
> Actually, having thought about it for five more minutes, I actually think
> that that _is_ it.
> 
> If so, the fix looks like it could be really simple. The whole problem
> arises from the fact that we remove the page from the swap cache only
> _after_ we've walked the page-tables to look at it. It looks like the
> fairly trivial fix is simply to remove it from the swap cache before,
> getting rid of all such races in swapoff().
> 
> Mind trying out this patch?
> 
> NOTE! It's untested. It might not work. It might trigger some sanity-test
> somewhere else. But it looks like it should do the right thing (the page
> might be moved to _another_ swap device early, if there are multiple swap
> areas, but even that should be fine - the unuse_process() stuff doesn't
> care about what swapcache this actually is any more.
> 
> Does this patch make a difference (I moved the delete seven lines upwards,
> and removed the test - the test looks extraneous).

Not in my test tree.  Same fault, and same trace leading up to it.
I'll run virgin source hard tomorrow to be sure. (No message means
no change)

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
