Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992770AbWJUQKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992770AbWJUQKP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 12:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992785AbWJUQKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 12:10:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50330 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992770AbWJUQKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 12:10:13 -0400
Date: Sat, 21 Oct 2006 09:10:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Git training wheels for the pimple faced maintainer
In-Reply-To: <4539EBF3.8050607@drzeus.cx>
Message-ID: <Pine.LNX.4.64.0610210844560.3962@g5.osdl.org>
References: <4537EB67.8030208@drzeus.cx> <Pine.LNX.4.64.0610191629250.3962@g5.osdl.org>
 <45386E0E.7030404@drzeus.cx> <Pine.LNX.4.64.0610200810390.3962@g5.osdl.org>
 <4539EBF3.8050607@drzeus.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 21 Oct 2006, Pierre Ossman wrote:
> >
> > HOWEVER! The above obviously only really works correctly if "master" is a 
> > strict subset of "for-linus".
> 
> Ah, that's a bit of a gotcha. Any nice tricks to keep track of where you
> where in sync with upstream last? Create a dummy branch/tag perhaps?

You don't need to. Git keeps track of the fork-point, and you can always 
get it with

	git merge-base a b

where "a" and "b" are the two branches.

HOWEVER. If you have _merged_ since (ie your branch contains merges _from_ 
the branch that you are tracking), this will give you the last 
merge-point (since that's the last common base), and as such a "diff" from 
that point will _ignore_ your changes from before the merge. See?

But holding a tag to the "original fork point" is equally useless in that 
case, since if you have merged from my tree since that tag, and you do a 
"git diff tag..for-linus", then the diff will contain all the new stuff 
that came from _me_ through your merge as well. See?

In other words: in both cases you really really shouldn't merge from me 
after you started developing. And the reason in both cases is really 
fundamnetlly the same: because merging from me obviously brings in commits 
_from_me_, so any single diff thus obviously turns pointless: it will 
_not_ talk about all your new work.

Anyway, notice the "single diff" caveat above. Git obviously does actually 
keep track of individual commits, so the individual commits that are 
unique to your repository are _still_ unique to your repository even after 
you've merged with me - since I haven't merged with you. So you _can_ get 
the information, but now you have to do something fundamentally 
different..

So if you've done merges with me since you started development, you cannot 
now just say "what's the difference between <this> point and <that> point 
in the development tree", because clearly there is no _single_ line of 
development that shows just _your_ changes. But that doesn't mean that 
your development isn't separatable, and you can do one of two things:

 (a) work on a "individual commit" level:

	git log -p linus..for-linus

     will show each commit that is in your "for-linus" branch but is _not_ 
     in your "linus" tracker branch. This does the right thing even in the 
     presense of merges: it will show the merge commit you did (since that 
     individual commit is _yours_), but it will not show the commits 
     merged (since those came from _my_ line of development)

     So now a

	git log -p linux..for-linus | diffstat

     will give something that _approximates_ the diffstat I will see when 
     merging. I say _approximates_, because it only really gives the right 
     answer if all the commits are entirely independent, and you never 
     have one commit that changes a line one way, and then a subsequent 
     commit that changes the same lines another way.

     If you have commits that are inter-dependent, the diffstat above will 
     show the "sum" of the diffs, which is not what I will see when I 
     actually merge. I will see just the end result, which is more like 
     the "union" of the diffs. And the two are the same only for 
     independent diffs, of course.

So the above is simple, and gives _almost_ the right answer. The other 
alternative is slightly smarter, and more involved, and gives the exact 
right answer:

 (b) create a temporary new merge, and see what the difference of the 
     merge is, as seen by me (eg as seen from "linus"). So this is 
     basically:

	git checkout -b test-branch for-linus
	git pull . linus
	git diff -M --stat --summary linus..

     will create a new branch ("checkout -b") based on your current 
     "for-linus" state, and within that branch, do a merge of the "linus" 
     branch (or you could have done it the other way around and made the 
     merge as if you were me: check out the state of "linus" and then 
     pull the "for-linus" branch instead).

     And then, the final step is to just diff the result of the merge 
     against the "linus" branch. This obviously gives the same diffstat 
     as the one _I_ should see when I merge, because you basically 
     "pre-tested" my merge for me.

See? git does give you the tools, but if you merge from me and don't have 
a branch that is a nice clear superset of what you started off with, but 
have mixed in changes from _my_ tree since you started developing, you end 
up having to do some extra work to separate out all the new changes.

So that's why I suggest not doing a lot of criss-crossing merges. It 
generates an uglier history that is much harder to follow visually in 
"gitk", but it also generates some extra work for you. Not a lot, but 
considering that there are seldom any real upsides, this hopefully 
explains why I suggest against it.

And again, as a final note: none of this is "set in stone". These are all 
_suggestions_. Notice the "seldom any real upsides". I say "seldom" on 
purpose, because quite frankly, sometimes it's just easier for you to 
merge (especially if you know there are likely to be clashes), so that you 
can fix up any issues that the merge brings.

Anyway, I hope this clarified the issue. I don't think we've actually had 
a lot of problems with these things in practice. None of this is really 
"hard", and a lot of it is just getting used to the model. Once you are 
comfortable with how git works (and using "gitk" to show history tends to 
be a very visual way to see what is going on in the presense of merges), 
and get used to working with me, you'll do all of this without even 
thinking about it.

It really just _sounds_ more complicated than it really is. 

		Linus
