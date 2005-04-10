Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVDJW1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVDJW1n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 18:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVDJW1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 18:27:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:9439 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261618AbVDJW1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 18:27:38 -0400
Date: Mon, 11 Apr 2005 00:27:37 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Willy Tarreau <willy@w.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: Re: Re: [ANNOUNCE] git-pasky-0.1
Message-ID: <20050410222737.GC5902@pasky.ji.cz>
References: <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz> <20050410173349.GA17549@elte.hu> <20050410174221.GD7858@alpha.home.local> <20050410174512.GA18768@elte.hu> <20050410184522.GA5902@pasky.ji.cz> <Pine.LNX.4.58.0504101310430.1267@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504101310430.1267@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Apr 10, 2005 at 10:38:11PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> On Sun, 10 Apr 2005, Petr Baudis wrote:
> > 
> > It turns out to be the forks for doing all the cuts and such what is
> > bogging it down so awfully (doing diff-tree takes 0.48s ;-). I do about
> > 15 forks per change, I guess, and for some reason cut takes a long of
> > time on its own.
> 
> Heh.
> 
> Can you pull my current repo, which has "diff-tree -R" that does what the 
> name suggests, and which should be faster than the 0.48 sec you see..

Funnily enough, now after some more cache teasing it's ~0.185. Your one
still ~0.17, though. :/ (That might be because of the format changes,
though, since you do less printing now.) (BTW, all those measurements
are done on my AMD K6 walking on 1600MHz, 512M RAM, about 200M available
for caches.)

Just out of interest, did you have a look at my diff-tree -r
implementation and decided that you don't like it, or you weren't aware
of it?

I will probably take most of your diff-tree change, but I'd prefer to do
the sha1->tree mapping directly in diff_tree().

> It may not matter a lot, since actually generating the diff from the file 
> contents is what is expensive, but remember my goal: I want the expense of 
> a diff-tree to be relative to the size of the diff, so that implies that 
> small diffs haev to be basically instantaenous. So I care.

Me too, of course.

> So I just tried the 2.6.7->2.6.8 diff, and for me the new recursive
> "diff-tree" can generate the _list_ of files changed in zero time:
> 
> 	real    0m0.079s
> 	user    0m0.067s
> 	sys     0m0.024s
> 
> but then _doing_ the diff is pretty expensive (in this case 3800+ files
> changed, so you have to unpack 7600+ objects - and even unpacking isn't
> the expensive part, the expense is literally in the diff operation
> itself).
> 
> Me, the stuff I automate is the small steps. Doing a single checkin. So
> that's the case I care about going fast, when a "diff-tree" will likely
> have maybe five files or something. That's why I want the small
> incremental cases to go fast - it it takes me a minute to generate a diff
> for a _release_, that's not a big deal. I make one release every other
> month, but I work with lots of small patches all the time.

I see.

> Anyway, with a fast diff-tree, you should be able to generate the list of 
> objects for a fast "merge". That's next. 
> 
> (And by "merge", I of course mean "suck". I'm talking about the old CVS
> three-way merge, and you have to specify the common parent explicitly and
> it won't handle any renames or any other crud. But it would get us to 
> something that might actually be useful for simple things. Which is why 
> "diff-tree" is important - it gives the information about what to tell 
> merge).

I currently already do a merge when you track someone's source - it will
throw away your previous HEAD record though, so if you committed some
local changes after the previous pull, you will get orphaned commits and
the changes will turn to uncommitted ones. I have some ideas regarding
how to do it properly (and do any arbitrary merging, for that matter), I
hope to get to it as soon as I catch up with you. :-)

BTW, the three-way merge comes from RCS. That reminds me, is there any
tool which will take .rej files and throw them into the file to create
rcsmerge-like conflicts? Perhaps it's fault of my bad tools, but I
prefer to work with the inline rejects much more to .rej files (except
to actually notice the rejects).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
