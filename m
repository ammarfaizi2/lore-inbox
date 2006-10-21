Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWJUTHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWJUTHy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 15:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWJUTHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 15:07:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3266 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964773AbWJUTHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 15:07:53 -0400
Date: Sat, 21 Oct 2006 12:07:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Git training wheels for the pimple faced maintainer
In-Reply-To: <453A6179.1060500@drzeus.cx>
Message-ID: <Pine.LNX.4.64.0610211150040.3962@g5.osdl.org>
References: <4537EB67.8030208@drzeus.cx> <Pine.LNX.4.64.0610191629250.3962@g5.osdl.org>
 <45386E0E.7030404@drzeus.cx> <Pine.LNX.4.64.0610200810390.3962@g5.osdl.org>
 <4539EBF3.8050607@drzeus.cx> <Pine.LNX.4.64.0610210844560.3962@g5.osdl.org>
 <453A6179.1060500@drzeus.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 21 Oct 2006, Pierre Ossman wrote:
> 
> If I read your response above and the man page for git-merge-base, it
> will do the right thing even if "linus" now is further in the future
> than the point I forked it.

Yes. You can continue to track my state in the "linus" branch as much as 
you want, and "git merge-base" will show where your branch and mine 
diverged, so you don't need to remember it explicitly.

Only if you start _mixing_ the branches (ie you merge "linus" into your 
branch) do you end up in the situation where there now is no longer a 
single-threaded line of development, so you can no longer expect to be 
able to just use a direct "git diff".

> >  (a) work on a "individual commit" level:
> >
> > 	git log -p linus..for-linus
> >
> >      will show each commit that is in your "for-linus" branch but is _not_ 
> >      in your "linus" tracker branch. This does the right thing even in the 
> >      presense of merges: it will show the merge commit you did (since that 
> >      individual commit is _yours_), but it will not show the commits 
> >      merged (since those came from _my_ line of development)
> 
> Ah, so "git log" will not show the commits that have popped up on
> "linus" after "for-linus" branched off? Neat. :)

That is what the git "a..b" syntax means for everything _but_ "diff". 
Doing a "git diff" really is actually the special case: to create a diff, 
you need two end-points. For all other git commands, "a..b" really means 
"all commits that are in 'b' but not in 'a'", ie it's _not_ really about 
two end-points, it's about a _set_ operation.

You should think of "a..b" as the "set difference" operation, or "b-a".

There's also a "symmetric difference", which is called "a...b" (three 
dots). That's the "union of the differences both ways", in other words, 
"a...b" is the set of commits that exist in a _or_ b, but not in both.

You can do some even more complex operations, and one that I find 
reasonably useful at times is for example

	gitk --all --not HEAD

which basically means: "show all commits in all branches, but subtract 
everything that is reachable from the current HEAD". In other words, it 
shows what commits exist in all the other branches that have not been 
merged into the current one.

(The "--not HEAD" thing is mostly written as "^HEAD", but I wrote it out 
in long-hand here because it is perhaps a bit more readable that way.)

> One concern I had was how to find stuff to cherry-pick when doing a
> stable review.

So looking at the above, what you can do is literally

	gitk --all ^linus

which shows all your branches _except_ stuff that is already merged into 
the "linus" branch that tracks what I have merged.

Git really is very clever.

HOWEVER! A word of warning: especially when you start doing 
cherry-picking, git will consider a commit that has been cherry-picked to 
be totally _separate_ from the original one. So when you do things like 
the above, and you have commits that have "identical patches" as the ones 
I have already applied, they will show up as "not being in linus' branch". 

That's because the identity of a commit is really not the patch it 
describes at all: the commit is defined by the exact spot in the history, 
and by the exact contents of that commit (which include date, time, 
committer info, parents, exact tree state etc). So when you do a 
"cherry-pick", you are very much creating a totally new commit - it just 
happens to generate the same (or similar) _diff_.

There are tools to help you filter out cherry-picked commits too, by 
literally looking at the diff and saying "oh, that same diff already 
exists upstream", but that's different. If you really care, you can look 
at what "git cherry" does (and it's not very efficient).

> git has a lot of these hidden features and ways of doing
> less-than-obvious things, so I'm just trying to broaden my repertoire by
> consulting those who have been using it on a more daily basis.

You really can do a _lot_ with git. Part of what seems to scare some 
people is that git really allows for a lot of power and flexibility, and 
you can do some very fancy stuff. 

At the same time, you can mostly also use it as if it were a lot dumber 
than it really is. There are ways to limit your usage so that you'll never 
even need to worry about things like multiple branches or cherry-picking 
or merging or anything else, and try to just see your work as a linear 
progression on top of a particular release version.

I'll happily explain all the grotty details, but keep in mind that you 
don't _need_ to use the features if you don't want to. 

> I am just thankful git has a reset command ;)

You can undo almost any mess you get yourself into (you _can_ really screw 
that up too, if you do a combination of "reset" and "git prune", but you 
have to work at it).

The bigger problem may be that if you get yourself into a real mess, you 
need to understand how you got there: you can always get back to a 
previous state, sometimes you just need to know what that state _was_, and 
if you get confused enough, even that can be a problem.

"gitk" really does tend to help clarify what happened.

			Linus
