Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965073AbVIIAQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbVIIAQR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 20:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbVIIAQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 20:16:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58857 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965073AbVIIAQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 20:16:16 -0400
Date: Thu, 8 Sep 2005 17:16:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: helge.hafting@aitel.hist.no,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       airlied@gmail.com
Subject: Re: rc6 keeps hanging and blanking displays where rc4-mm1 works
 fine.
In-Reply-To: <20050908164719.00066dc2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0509081700220.3051@g5.osdl.org>
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org>
 <20050805104025.GA14688@aitel.hist.no> <21d7e99705080503515e3045d5@mail.gmail.com>
 <42F89F79.1060103@aitel.hist.no> <42FC7372.7040607@aitel.hist.no>
 <Pine.LNX.4.58.0508120937140.3295@g5.osdl.org> <43008C9C.60806@aitel.hist.no>
 <Pine.LNX.4.58.0508150843380.3553@g5.osdl.org> <20050908164719.00066dc2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Sep 2005, Andrew Morton wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > If you remember/save the good/bad commit ID's, you can restart the whole
> >  process and just feed the correct state for the ID's:
> > 
> >  	git bisect start
> >  	git bisect bad v2.6.13-rc5
> >  	git bisect good v2.6.13-rc4
> >  	.. here bisect will start narrowing things down ..
> >  	git bisect bad <sha1 of known bad>
> >  	git bisect good <sha1 of known good>
> >  	..
> 
> What do you suggest should be done if you hit a compile error partway
> through the bisection search?  Is there some way to go forward or backward
> a few csets while keeping the search markers sane?

Hmm.. There's no really nice interface for doing it, but since bisection 
uses a perfectly normal git branch (it's a special "bisect" branch) you 
can use other git commands to move around the head of that branch and try 
at any other point than the one it selected for you automatically.

In other words, you can "git reset" the head point of the branch to any
point you want to, and the only problem is to pick what point to try next
(since you don't want to mark the current point good or bad). One thing to
do is perhaps to just do:

	git bisect visualize

which just starts "gitk" with the proper arguments that you can see what 
we're currently looking at bisecting. Then you can pick a new point to 
select as the bisection point by hand, and then do

	git reset --hard <sha-of-that-point>

by just selecting that commit in gitk and pasting the result into that 
"git reset --hard xyz.." command line.

("git reset --hard ..." will reset the current branch to the selected
point and force a checkout of the new state while its at it. It's pretty
much equivalent to "git reset ..." followed by a "git checkout -f").

Of course, you can pick the bisection point with any other means too. So
if you just do "git log" and you know what commit broke the compile, just
pick the father by hand.

The only important point is that you should obviously pick something that
is within the current known good/bad range, and that's where the
aforementioned "git bisect visualize" can help.

Oh, and the "git bisect visualize" thing is fairly new: if you have an 
older version of git that doesn't have that nice helper function, you can 
always do it by hand with the following magic command line.

	gitk bisect/bad --not $(cd .git/refs && echo bisect/good-*)

(you can see how "git bisect visualize" is a bit simpler to type and
remember ;)

		Linus
