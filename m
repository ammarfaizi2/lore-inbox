Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWJGVZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWJGVZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 17:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWJGVZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 17:25:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60888 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750931AbWJGVZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 17:25:26 -0400
Date: Sat, 7 Oct 2006 14:25:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Simple script that locks up my box with recent kernels
In-Reply-To: <9a8748490610071402m4450365kedff5615d008fcd5@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0610071408220.3952@g5.osdl.org>
References: <9a8748490610061636r555f1be4x3c53813ceadc9fb2@mail.gmail.com> 
 <Pine.LNX.4.64.0610062000281.3952@g5.osdl.org>
 <9a8748490610071402m4450365kedff5615d008fcd5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 7 Oct 2006, Jesper Juhl wrote:
>
> > Can I bother you to just bisect it?
> 
> Sure, but it will take a little while since building + booting +
> starting the test + waiting for the lockup takes a fair bit of time
> for each kernel

Sure. That said, we've tried to narrow down things that took hours or days 
(under real loads, not some nice test-script) to reproduce, and while it 
doesn't always work, the real problem tends to be if the problem case 
isn't really reproducible. It sounds like yours is pretty clear-cut, and 
that will make things much easier.

> and also due to the fact that my git skills are pretty
> limited, but I'll figure it out (need to improve those git skills
> anyway) :-)

"git bisect" in particular isn't that hard to use, and it will really do 
a lot of heavy lifting for you.

Although since it will just select a random commit (well, it's not 
"random": it's strictly as half-way as it can possibly be, but it's 
automated without any regard for anything else), you can sometimes hit a 
situation where git will ask you to test a kernel that simply doesn't work 
at all, and you can't even test whether it reproduces your particular bug 
or not.

For example, "git bisect" might pick a kernel that just doesn't compile, 
because of some stupid bug that was fixed almost immediately afterwards. 
In those cases, the total automation of "git bisect" ends up being 
something that has to be helped along by hand, and then it definitely 
helps to know more about how git works.

Anyway, the quick tutorial about "git bisect" is that once you've given it 
the required first "good" and "bad" points, it will create a new branch in 
the repository (called "bisect", in case you care), and after that point 
it will do a search in the commit DAG (aka "history tree" - it's not a 
tree, it's a DAG, since merges will join branches together) for the next 
commit that will neatly "split" the DAG into two equal pieces. It will 
keep splitting the commit history until you get fed up, or until it has 
pinpointed the single commit that caused the problem.

The nicest tool to use during bisection is to just do a

	git bisect visualize

that simply starts up "gitk" (the default git history visualizer) to show 
what the current state of bisection is. Now, if there are thousands and 
thousands of commits, you'll have a really hard time getting a visual clue 
about what is going on, but especially once you get to a smaller set of 
commits, it's very useful indeed.

And it's _especially_ useful if you hit one of the problem spots where you 
can't test the resulting tree for some unrelated reason. When that 
happens, you should _not_ mark the problematic commit as being "bad", 
because you really don't know - the "badness" of that commit is probably 
not related to the "badness" that you're actually searching for.

Instead, you should say "ok, I refuse to test this commit at all, because 
it's got other problems, and I will select another commit instead". The 
bisection algorithm doesn't care which commit you pick, as long as it's 
within the set of "unknown" commits that you'll see with the visualization 
tool.

Of course, for efficiency reasons, the _closer_ you get to the half-way 
mark, the better. So it's useful to try to pick a commit that is close to 
the one that "git bisect" originally chose for you, but that's not a 
correctness issue, that's just an issue of "if we have a thousand 
potential commits, we're better off bisecting it 400/600 rather than 
1/999, even if the exact half-way point isn't testable".

So if you need to decide to pick another point than the one "git bisect" 
chose for you automatically, just select that commit in the visualizer 
(which will cut the SHA1 name of it), and then do

	git reset --hard <paste-sha1-here"

to reset the "bisect" branch to that point instead. And then compile and 
test that kernel instead (and then if that's good or bad, you can do the 
"git bisect good" or "git bisect bad" thing to mark it so, and git will 
continue to bisect the set of commits).

It can be a bit boring, but damn, it's effective. I've used "git bisect" 
several times when I've been too lazy to try to really think about what is 
going on - I'll happily brute-force bug-finding even if it might take a 
little longer, if it's guaranteed to find it (and if the bug is 
reproducible, git bisect definitely guarantees to find what made it 
appear, even if that may not necessarily be the deeper _cause_ of the bug)

		Linus
