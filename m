Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVDJUz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVDJUz5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 16:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVDJUz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 16:55:57 -0400
Received: from fire.osdl.org ([65.172.181.4]:13479 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261605AbVDJUzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 16:55:41 -0400
Date: Sun, 10 Apr 2005 13:57:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Jackson <pj@engr.sgi.com>
cc: junkio@cox.net, rddunlap@osdl.org, ross@jose.lug.udel.edu,
       linux-kernel@vger.kernel.org
Subject: Re: more git updates..
In-Reply-To: <20050410115055.2a6c26e8.pj@engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0504101338360.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
 <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
 <7vhdifcbmo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504100824470.1267@ppc970.osdl.org>
 <20050410115055.2a6c26e8.pj@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Apr 2005, Paul Jackson wrote:
> 
> Ah ha - that explains the read-tree and write-tree names.
> 
> The read-tree pulls stuff out of this file system into
> your working files, clobbering local edits.  This is like
> the read(2) system call, which clobbers stuff in your
> read buffer.

Yes. Except it's a two-stage thing, where the staging area is always the 
"current directory cache".

So a "read-tree" always reads the tree information into the directory 
cache, but does not actually _update_ any of the files it "caches". To do 
that, you need to do a "checkout-cache" phase.

Similarly, "write-tree" writes the current directory cache contents into a
set of tree files. But in order to have that match what is actually in
your directory right now, you need to have done a "update-cache"  phase
before you did the "write-tree".

So there is always a staging area between the "real contents" and the 
"written tree". 

> That way of thinking really doesn't work well here.
> 
> I will have to look more closely at pasky's GIT toolkit
> if I want to see an SCM style interface.

Yes. You really should think of GIT as a filesystem, and of me as a 
_systems_ person, not an SCM person. In fact, I tend to detest SCM's. I 
think the reason I worked so well with BitKeeper is that Larry used to do 
operating systems. He's also a systems person, not really an SCM person. 
Or at least he's in between the two.

My operations are like the "system calls". Useless on their own: they're
not real applications, they're just how you read and write files in this
really strange filesystem. You need to wrap them up to make them do
anything sane.

For example, take "commit-tree" - it really just says that "this is the 
new tree, and these other trees were its parents". It doesn't do any of 
the actual work to _get_ those trees written.

So to actually do the high-level operation of a real commit, you need to
first update the current directory cache to match what you want to commit
(the "update-cache" phase).

Then, when your directory cache matches what you want to commit (which is
NOT necessarily the same thing as your actual current working area - if
you don't want to commit some of the changes you have in your tree, you
should avoid updating the cache with those changes), you do stage 2, ie
"write-tree". That writes a tree node that describes what you want to
commit.

Only THEN, as phase three, do you do the "commit-tree". Now you give it 
the tree you want to commit (remember - that may not even match your 
current directory contents), and the history of how you got here (ie you 
tell commit what the previous commit(s) were), and the changelog. 

So a "commit" in SCM-speak is actually three totally separate phases in my
filesystem thing, and each of the phases (except for the last
"commit-tree" which is the thing that brings it all together) is actually
in turn many smaller parts (ie "update-cache"  may have been called
hundreds of times, and "write-tree" will write several tree objects that
point to each other).

Similarly, a "checkout" really is about first finding the tree ID you want
to check out, and then bringing it into the "directory cache" by doing a
"read-tree" on it. You can then actually update the directory cache 
further: you might "read-tree" _another_ project, or you could decide that 
you want to keep one of the files you already had.

So in that scneario, after doing the read-tree you'd do an "update-cache"
on the file you want to keep in your current directory structure, which
updates your directory cache to be a _mix_ of the original tree you now
want to check out _and_ of the file you want to use from your current
directory. Then doing a "checkout-cache -a" will actually do the actual
checkout, and only at that point does your working directory really get
changed.

Btw, you don't even have to have any working directory files at all. Let's
say that you have two independent trees, and you want to create a new
commit that is the join of those two trees (where one of the trees take
precedence). You'd do a "read-tree <a> <b>", which will create a directory
cache (but not check out) that is the union of the <a> and <b> trees (<b>
will overrride). And then you can do a "write-tree" and commit the
resulting tree - without ever having _any_ of those files checked out. 

		Linus
