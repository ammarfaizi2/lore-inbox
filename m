Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVDKQBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVDKQBu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbVDKQA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:00:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:60804 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261828AbVDKQAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:00:07 -0400
Date: Mon, 11 Apr 2005 09:01:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Paul Jackson <pj@engr.sgi.com>, pasky@ucw.cz, rddunlap@osdl.org,
       ross@jose.lug.udel.edu, linux-kernel@vger.kernel.org,
       git@vger.kernel.org
Subject: Re: [rfc] git: combo-blobs
In-Reply-To: <20050411153905.GA7284@elte.hu>
Message-ID: <Pine.LNX.4.58.0504110852260.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
 <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050411113523.GA19256@elte.hu>
 <20050411074552.4e2e656b.pj@engr.sgi.com> <20050411151204.GA5562@elte.hu>
 <Pine.LNX.4.58.0504110826140.1267@ppc970.osdl.org> <20050411153905.GA7284@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Apr 2005, Ingo Molnar wrote:
> 
> if a repository is corrupted then it pretty much needs to be dropped 
> anyway.

I disagree. Yes, the thing is designed to be replicated, so most of the 
time the easiest thing to do is to just rsync with another copy. 

But dammit, I don't want to just depend on that. I wrote "fsck" for a 
reason. Right now it only finds errors, which is sufficient if you do the 
rsync thing, but I think it's _wrong_ to

 - be slower
 - be more complex
 - be less safe

to save some diskspace.

If you want to save disk-space, the current setup has a great way of doing
that: just drop old history. Exactly because a GIT repo doesn't do the
dependency chain thing, you can do that, and have a minimal GIT
repostiroty that is still perfectly valid (and is basically the size of a
single checked-out tree tree, except it's also compressed).

I don't think many people will do that, considering how cheap disk is, but 
the fact is, GIT allows it just fine. "fsck" will complain right now, but 
I'm actually going to make the "commit->commit" link be a "weaker" thing, 
and have fsck not complain about missing history unless you do the "-v" 
thing.

(Right now, for development, I _do_ want fsck to complain about missing
history, but that's a different thing. Right now it's there to make sure I
don't do stupid things, not for "users").

>	 Also, with a 'replicate the full object on every 8th commit' 
> rule the risk would be somewhat mitigated as well.

..but not the complexity.

The fact is, I want to trust this thing. Dammit, one reason I like GIT is
that I can mentally visualize the whole damn tree, and each step is so
_simple_. That's extra important when the object database itself is so
inscrutable - unlike CVS or SCCS or formats like that, it's damn hard to
visualize from looking at a directory listing.

So this really is a very important point for me: I want a demented 
chimpanzee to be able to understand the GIT linkages, and I do not want 
_any_ partial results anywhere. The recursive tree is already more 
complexity than I wanted, but at least that seemed inescapable.

		Linus
