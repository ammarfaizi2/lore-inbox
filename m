Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVDJPnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVDJPnL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 11:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVDJPnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 11:43:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:34768 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261514AbVDJPnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 11:43:03 -0400
Date: Sun, 10 Apr 2005 08:44:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Junio C Hamano <junkio@cox.net>
cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more git updates..
In-Reply-To: <7vhdifcbmo.fsf@assigned-by-dhcp.cox.net>
Message-ID: <Pine.LNX.4.58.0504100824470.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
 <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
 <7vhdifcbmo.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Apr 2005, Junio C Hamano wrote:
> 
> But I am wondering what your plans are to handle renames---or
> does git already represent them?

You can represent renames on top of git - git itself really doesn't care.  
In many ways you can just see git as a filesystem - it's content-
addressable, and it has a notion of versioning, but I really really
designed it coming at the problem from the viewpoint of a _filesystem_
person (hey, kernels is what I do), and I actually have absolutely _zero_
interest in creating a traditional SCM system.

So to take renaming a file as an example - why do you actually want to 
track renames? In traditional SCM's, you do it for two reasons:

 - space efficiency. Most SCM's are based on describing changes to a file, 
   and compress the data by doing revisions on the same file. In order to 
   continue that process past a rename, such an SCM _has_ to track 
   renames, or lose the delta-based approach.

   The most trivial example of this is "diff", ie a rename ends up 
   generating a _huge_ diff unless you track the rename explicitly.

   GIT doesn't care. There is _zero_ space efficiency in trying to track 
   renames. In fact, it would add overhead to the system, not lessen it. 
   That's because GIT fundamentally doesn't do the "delta-within-a-file"  
   model.

 - annotate/blame. This is a valid concern, but the fact is, I never use 
   it. It may be a deficiency of mine, but I simply don't do the per-line 
   thing when I debug or try to find who was responsible. I do "blame" on 
   a much bigger-picture level, and I personally believe (pretty strongly) 
   that per-line annotations are not actually a good thing - they come not 
   because people _want_ to do things at that low level, but because 
   historically, you didn't _have_ the bigger-picture thing.

   In other words, pretty much every SCM out there is based on SCCS 
   "mentally", even if not in any other model. That's why people think 
   per-line blame is important - you have that mental model. 

So consider me deficient, or consider me radical. It boils down to the 
same thing. Renames don't matter. 

That said, if somebody wants to create a _real_ SCM (rather than my notion
of a pure content tracker) on top of GIT, you probably could fairly easily
do so by imposing a few limitations on a higher level. For example, most
SCM's that track renames require that the user _tell_ them about the
renames: you do a "bk mv" or a "svn rename" or something.

If you want to do the same on top of GIT, then you should think of GIT as
what it is: GIT just tracks contents. It's a filesystem - although a
fairly strange one. How would you track renames on top of that? Easy: add
your own fields to the GIT revision messages: GIT enforces the header, but
you can add anything you want to the "free-form" part that follows it. 

Same goes for any other information where you care about what happens 
"within" a file. GIT simply doesn't track it. You can build things on top 
of GIT if you want to, though. They may not be as efficient as they would 
be if they were built _into_ GIT, but on the other hand GIT does a lot of 
other things a hell of a lot faster thanks to it's design.

So whether you agree with the things that _I_ consider important probably
depends on how you work. The real downside of GIT may be that _my_ way of 
doing things is quite possibly very rare.

But it clearly is the only right way. The fact that everybody else does it 
some other way only means that they are wrong.

		Linus
