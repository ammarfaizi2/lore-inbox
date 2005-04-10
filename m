Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVDJVha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVDJVha (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 17:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVDJVha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 17:37:30 -0400
Received: from fire.osdl.org ([65.172.181.4]:58801 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261612AbVDJVhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 17:37:19 -0400
Date: Sun, 10 Apr 2005 14:39:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Petr Baudis <pasky@ucw.cz>
cc: Ingo Molnar <mingo@elte.hu>, Willy Tarreau <willy@w.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: Re: [ANNOUNCE] git-pasky-0.1
In-Reply-To: <Pine.LNX.4.58.0504101310430.1267@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0504101417150.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
 <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz>
 <20050410162723.GC26537@pasky.ji.cz> <20050410173349.GA17549@elte.hu>
 <20050410174221.GD7858@alpha.home.local> <20050410174512.GA18768@elte.hu>
 <20050410184522.GA5902@pasky.ji.cz> <Pine.LNX.4.58.0504101310430.1267@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Apr 2005, Linus Torvalds wrote:
> 
> Can you pull my current repo, which has "diff-tree -R" that does what the 
> name suggests, and which should be faster than the 0.48 sec you see..

Actually, I changed things around. Everybody hated the "<" ">" lines, so I 
put a changed thing on a line of its own with a "*" instead.

So you'd now see lines like

	*100644->100644 1874e031abf6631ea51cf6177b82a1e662f6183e->e8181df8499f165cacc6a0d8783be7143013d410 CREDITS

which means that the CREDITS file has changed, and it shows you the mode
-> mode transition (that didn't change in this case) and the sha1 -> sha1
transition.

So now it's always just one line per change. Firthermore, the filename is 
always field 3, if you use spaces as delimeters, regardless of whether 
it's a +/-/* field.

So let's say you want to merge two trees (dst1 and dst2) from a common
parent (src), what you would do is:

 - get the list of files to merge:

	diff-tree -R <dst1> <dst2> | tr '\0' '\n' > merge-files

 - Which of those were changed by <src> -> <dstX>?

	diff-tree -R <src> <dst1> | tr '\0' '\n' | join -j 3 - merge-files > dst1-change
	diff-tree -R <src> <dst2> | tr '\0' '\n' | join -j 3 - merge-files > dst2-change

 - Which of those are common to both? Let's see what the merge list is:

	join dst1-change dst2-change > merge-list

and hopefully you'd usually be working on a very small list of files by 
then (everything else you'd just pick from one of the destination trees 
directly - you've got the name, the sha-file, everything: no need to even 
look at the data).

Does this sound sane? Pasky? Wanna try a "git merge" thing? Starting off
with the user having to tell what the common parent tree is - we can try
to do the "automatically find best common parent" crud later. THAT may be 
expensive.

(Btw, this is why I think "diff-tree" is more important than actually
generating the real diff itself - the above uses diff-tree three times
just to cut down to the point where _hopefully_ you don't actually need to
generate very much diffs at all. So I want "diff-tree" to be really fast, 
even if it then can take a minute to actually generate a big diff between 
releases etc).

			Linus
