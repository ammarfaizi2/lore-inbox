Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVDJUhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVDJUhc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 16:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVDJUhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 16:37:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:54946 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261600AbVDJUgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 16:36:20 -0400
Date: Sun, 10 Apr 2005 13:38:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Petr Baudis <pasky@ucw.cz>
cc: Ingo Molnar <mingo@elte.hu>, Willy Tarreau <willy@w.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: Re: [ANNOUNCE] git-pasky-0.1
In-Reply-To: <20050410184522.GA5902@pasky.ji.cz>
Message-ID: <Pine.LNX.4.58.0504101310430.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
 <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz>
 <20050410162723.GC26537@pasky.ji.cz> <20050410173349.GA17549@elte.hu>
 <20050410174221.GD7858@alpha.home.local> <20050410174512.GA18768@elte.hu>
 <20050410184522.GA5902@pasky.ji.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Apr 2005, Petr Baudis wrote:
> 
> It turns out to be the forks for doing all the cuts and such what is
> bogging it down so awfully (doing diff-tree takes 0.48s ;-). I do about
> 15 forks per change, I guess, and for some reason cut takes a long of
> time on its own.

Heh.

Can you pull my current repo, which has "diff-tree -R" that does what the 
name suggests, and which should be faster than the 0.48 sec you see..

It may not matter a lot, since actually generating the diff from the file 
contents is what is expensive, but remember my goal: I want the expense of 
a diff-tree to be relative to the size of the diff, so that implies that 
small diffs haev to be basically instantaenous. So I care.

So I just tried the 2.6.7->2.6.8 diff, and for me the new recursive
"diff-tree" can generate the _list_ of files changed in zero time:

	real    0m0.079s
	user    0m0.067s
	sys     0m0.024s

but then _doing_ the diff is pretty expensive (in this case 3800+ files
changed, so you have to unpack 7600+ objects - and even unpacking isn't
the expensive part, the expense is literally in the diff operation
itself).

Me, the stuff I automate is the small steps. Doing a single checkin. So
that's the case I care about going fast, when a "diff-tree" will likely
have maybe five files or something. That's why I want the small
incremental cases to go fast - it it takes me a minute to generate a diff
for a _release_, that's not a big deal. I make one release every other
month, but I work with lots of small patches all the time.

Anyway, with a fast diff-tree, you should be able to generate the list of 
objects for a fast "merge". That's next. 

(And by "merge", I of course mean "suck". I'm talking about the old CVS
three-way merge, and you have to specify the common parent explicitly and
it won't handle any renames or any other crud. But it would get us to 
something that might actually be useful for simple things. Which is why 
"diff-tree" is important - it gives the information about what to tell 
merge).

				Linus
