Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVFRSYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVFRSYF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 14:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVFRSXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 14:23:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36505 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262162AbVFRSW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 14:22:27 -0400
Date: Sat, 18 Jun 2005 11:24:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, Netdev List <netdev@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] 2.6.x net driver updates
In-Reply-To: <Pine.LNX.4.58.0506181105110.2268@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0506181112590.2268@ppc970.osdl.org>
References: <42B456E2.8000500@pobox.com> <Pine.LNX.4.58.0506181047190.2268@ppc970.osdl.org>
 <Pine.LNX.4.58.0506181105110.2268@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Jun 2005, Linus Torvalds wrote:
> 
> Your parent information was crap, meaning that when I pulled, I had to
> re-merge. In fact, I'm going to undo this pull entirely, because of this -
> it's simply _wrong_. You claim to have done a merge and indeed your "data"
> is merged, but your history is totally buggered because you didn't do the 
> proper parents.

Btw, this is serious. If you don't do proper parenting, you may have the
right _data_ in the tree, but because you lost sight of where that data
came from, all the commits leading up to that data (from the branch that
wasn't properly marked as a parent) are worthless and no longer reachable. 

In other words, it means that all the history leading up to the merge was
just lost, and you end up with just a magic "all these changes suddenly
appeared" patch that claims to be a merge, but is really just a big patch.

It also means that "git prune" will just delete the unreachable commits, 
since they are clearly not connected to anything any more. Also, any 
intermediate file contents (that were only reachable through those 
commits) are also unreachable and thus pruned. You literally end up with a 
situation where the "merge" is 100% equivalent to just taking the final 
patch, and applying it on top of the other head.

This may be the reason why you've had problems with "git prune". Your 
tree histories may be buggered, and you've lost the merges with me.

Quite frankly, I'd never have noticed, except:

 - because the history was buggered, the automated merge didn't find the 
   proper nearest parent, and thus it ended up finding a parent much 
   further back in history, which in turn meant that a trivial merge
   wasn't trivial any more, and I got a merge conflict on the
   drivers/net/r8169.c file.

 - actually looking at the history (with gitk, or by looking at how many 
   parents the commits have with "git log --pretty=raw") made it obvious 
   that your "merge" had only one parent.

This, btw, is one reason why I suggest against multiple branches, and run
git-fsck-cache --unreachable religiously. A bad merge with lost parents
normally causes unreachable commits, and that's a sure sign of trouble.

However, in your usage schenario, those commits are reachable in the
branch they originated in, and you mix it all up, so you'll never see the
warning signs.

I'm hoping my earlier pulls on your trees haven't resulted in these kinds 
of history losses before, and that this was the first time you did a merge 
and didn't specify the parents properly. Pls confirm..

		Linus
