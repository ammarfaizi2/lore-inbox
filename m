Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVDJXtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVDJXtw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 19:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVDJXtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 19:49:52 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59104 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261491AbVDJXts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 19:49:48 -0400
Date: Mon, 11 Apr 2005 01:49:46 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Willy Tarreau <willy@w.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: Re: Re: [ANNOUNCE] git-pasky-0.1
Message-ID: <20050410234946.GE5902@pasky.ji.cz>
References: <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz> <20050410173349.GA17549@elte.hu> <20050410174221.GD7858@alpha.home.local> <20050410174512.GA18768@elte.hu> <20050410184522.GA5902@pasky.ji.cz> <Pine.LNX.4.58.0504101310430.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504101417150.1267@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504101417150.1267@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Apr 10, 2005 at 11:39:02PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> On Sun, 10 Apr 2005, Linus Torvalds wrote:
> > 
> > Can you pull my current repo, which has "diff-tree -R" that does what the 
> > name suggests, and which should be faster than the 0.48 sec you see..
> 
> Actually, I changed things around. Everybody hated the "<" ">" lines, so I 
> put a changed thing on a line of its own with a "*" instead.
> 
> So you'd now see lines like
> 
> 	*100644->100644 1874e031abf6631ea51cf6177b82a1e662f6183e->e8181df8499f165cacc6a0d8783be7143013d410 CREDITS
> 
> which means that the CREDITS file has changed, and it shows you the mode
> -> mode transition (that didn't change in this case) and the sha1 -> sha1
> transition.
> 
> So now it's always just one line per change. Firthermore, the filename is 
> always field 3, if you use spaces as delimeters, regardless of whether 
> it's a +/-/* field.

That's great, just when I finally managed to properly fix the xargs
boundary case in gitdiff-do (without throwing away the NUL-termination).
You know how to please people! ;-)

(Not that I'd have *anything* against the change. The logic is simpler
and you'll be actually able to work with diff-tree a little sanely.)

BTW, it is quite handy to have the entry type in the listing (guessing
that from mode in the script just doesn't feel right and doing explicit
cat-file kills the performance). I would also really prefer the fields
separated by tabs. It looks nicer on the screen (aligned, e.g. modes and
type are varsized), and is also easier to parse (cut defaults to tabs as
delimiters, for example).

> So let's say you want to merge two trees (dst1 and dst2) from a common
> parent (src), what you would do is:
> 
>  - get the list of files to merge:
> 
> 	diff-tree -R <dst1> <dst2> | tr '\0' '\n' > merge-files

...oh, I probably forgot to ask - why did you choose -R instead of -r?
It looks rather alien to me; if it starts by 'diff', my hand writes -r
without thinking.

>  - Which of those were changed by <src> -> <dstX>?
> 
> 	diff-tree -R <src> <dst1> | tr '\0' '\n' | join -j 3 - merge-files > dst1-change
> 	diff-tree -R <src> <dst2> | tr '\0' '\n' | join -j 3 - merge-files > dst2-change
> 
>  - Which of those are common to both? Let's see what the merge list is:
> 
> 	join dst1-change dst2-change > merge-list
> 
> and hopefully you'd usually be working on a very small list of files by 
> then (everything else you'd just pick from one of the destination trees 
> directly - you've got the name, the sha-file, everything: no need to even 
> look at the data).

Ok, this looks reasonable. (Provided that I DWYM regarding the joins.)

> Does this sound sane? Pasky? Wanna try a "git merge" thing? Starting off
> with the user having to tell what the common parent tree is - we can try
> to do the "automatically find best common parent" crud later. THAT may be 
> expensive.

I will definitively try "git merge", but maybe not this night anymore
(it's already 1:32 here now).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
