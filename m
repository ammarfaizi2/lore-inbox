Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbVFWF4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbVFWF4a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 01:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbVFWF43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 01:56:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57287 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262124AbVFWF4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 01:56:16 -0400
Date: Wed, 22 Jun 2005 22:58:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
In-Reply-To: <42BA45B1.7060207@pobox.com>
Message-ID: <Pine.LNX.4.58.0506222225010.11175@ppc970.osdl.org>
References: <42B9E536.60704@pobox.com> <20050622230905.GA7873@kroah.com>
 <Pine.LNX.4.58.0506221623210.11175@ppc970.osdl.org> <42B9FCAE.1000607@pobox.com>
 <Pine.LNX.4.58.0506221724140.11175@ppc970.osdl.org> <42BA14B8.2020609@pobox.com>
 <Pine.LNX.4.58.0506221853280.11175@ppc970.osdl.org> <42BA1B68.9040505@pobox.com>
 <Pine.LNX.4.58.0506221929430.11175@ppc970.osdl.org> <42BA271F.6080505@pobox.com>
 <Pine.LNX.4.58.0506222014000.11175@ppc970.osdl.org> <42BA45B1.7060207@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Jun 2005, Jeff Garzik wrote:
>
> No complaint with that operation.  The complaint is that it's an 
> additional operation.  Re-read what Greg said:

Please re-read what I said.

Pulling a regular head _cannot_ and _must_not_ update tags. Tags are not 
associated with the tree, and they _cannot_ and _must_not_ be so, exactly 
because that would make them global instead of private, and it would 
fundamentally make them not be distributed, and would mean that they'd be 
pointless as anything but "Linus' official tags".

That's what we had in BK _AND IT DOES NOT WORK_!

Does it help when I scream?

> > Is there some reason why git doesn't pull the
> > tags in properly when doing a merge?  Chris and I just hit this when I
> > pulled his 2.6.12.1 tree and and was wondering where the tag went.

And I suggested that if you want that, then you pull on the TAG. You take 
my modification, you test it, and you see if

	git fetch tag ..repo.. tagname

works.

That solves exactly the case that Greg is complaining about, and it solves
it in a _sane_ manner: you tell git that you want a tag, and git fetches
it for you. It's that simple, and it does not introduce the _BROKEN_
notion that tags are associated directly with the commit itself and
somehow visible to all.

> Multiple users -- not just me -- would prefer that git-pull-script 
> pulled the tags, too.

And multiple users -- clearly including you -- aren't listening to me. 
Tags are separate from the source they tag, and they HAVE TO BE. There is 
no "you automatically get the tags when you get the tree", because the two 
don't have a 1:1 relationship.

And not making them separate breaks a lot of things. As mentioned, it
fundamentally breaks the distributed nature, but that also means that it
breaks whenever two people use the same name for a tag, for example. You
can't "merge" tags. BK had a very strange form of merging, which was (I
think) to pick the one last in the BK ChangeSet file, but that didn't make
it "right". You just never noticed, because Linux could never use tags at
all due to the lack of privacy, except for big releases..

> Suggested solution:  add '--tags' to git-pull-script 
> (git-fetch-script?), which calls
> 	rsync -r --ignore-existing repo/refs/tags/ .git/refs/tags/

How is this AT ALL different from just having a separate script that does
this? You've introduced nothing but syntactic fluff, and you've made it
less flexible at the same time. First off, you might want to get new tags
_without_ fetching anything else, and you might indeed want to get the 
tags _first_ in order to decide what you want to fetch. In fact, in many 
cases that's exactly what you want, namely you want to fetch the data 
based on the tag.

Secondly, if your worry is that you forget, then hell, write a small shell 
function, and be done with it.

BUT DO NOT MESS UP THINGS FOR OTHER PEOPLE.

When I fetch somebody elses head, I had better not fetch his tags. His
tags may not even make _sense_ in what I have - he may tag things in other
branches that I'm not fetching at all. In fact, his tag-namespace might be
_different_ from mine, ie he might have tagged something "broken" in his
tree, and I tagged something _else_ "broken" in mine, just because it
happens to be a very useful tag for when you want to mark "ok, that was a
broken tree".

It is wrong, wrong, _wrong_ to think that fetching somebody elses tree
means that you should fetch his tags. The _only_ reason you think it's
right is because you've only ever seen centralized tags: tags were the one
thing that BK kept centralized.

But once people realize that they can use tags in their own trees, and 
nobody else will ever notice, they'll slowly start using them. Maybe it 
takes a few months or even longer. But it will happen. And I refuse to 
make stupid decisions that makes it not work.

And thinking that "fetching a tree fetches all the tags from that tree"  
really _is_ a stupid decision. It's missing the big picture. It's missing
the fact that tags _should_ be normal every-day things that you just use
as "book-marks", and that the kind of big "synchronization point for many
people" tag should actually be the _rare_ case.

The fact that global tags make that private "bookmark" usage impossible
should be a big red blinking sign saying "don't do global tags".

> Let the kernel hacker say "yes, I really do want to download the tags 
> Linus publicly posted in linux-2.6.git/refs/tags" because this was a 
> common operation in the previous workflow, a common operation that we 
> -made use of-.

And I already suggested a trivial script. Send me the script patch,
instead of arguing for stupid things.

			Linus
