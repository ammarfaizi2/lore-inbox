Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbVDKAiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVDKAiX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 20:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVDKAiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 20:38:22 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:9424 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261650AbVDKAiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 20:38:11 -0400
Date: Sun, 10 Apr 2005 17:28:50 -0400
From: Christopher Li <lkml@chrisli.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Jackson <pj@engr.sgi.com>, junkio@cox.net, rddunlap@osdl.org,
       ross@jose.lug.udel.edu, linux-kernel@vger.kernel.org
Subject: Re: more git updates..
Message-ID: <20050410212850.GA23960@64m.dyndns.org>
References: <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <7vhdifcbmo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504100824470.1267@ppc970.osdl.org> <20050410115055.2a6c26e8.pj@engr.sgi.com> <Pine.LNX.4.58.0504101338360.1267@ppc970.osdl.org> <20050410190331.GG13853@64m.dyndns.org> <Pine.LNX.4.58.0504101533020.1267@ppc970.osdl.org> <20050410195354.GH13853@64m.dyndns.org> <Pine.LNX.4.58.0504101611370.1267@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504101611370.1267@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see. It just need some basic set operation (+, -, and)
and some way to select a set:


      sha5--->
     / 
    / 
sha1-->sha2-->sha3--
   \        /
    \      /
     >sha4


list sha1		# all the file list in changeset sha1
			# {sha1}
list sha1,sha1		# same as above
list sha1,sha2		# all the file list in between changeset sha1
			# and changeset sha2
			# {sha1, sha2} in example
list sha1,sha3		# {sha1, sha2, sha3, sha4}
			
list sha1,any		# all the change set reachable from sha1.
			{sha1, ... sha5, ...}

new	 sha1,sha2	# all the new file add between in sha1, sha2 (+)
changed  sha1,sha2	# add the changed file between sha1, sha2   (>) (<)
deleted  sha1,sha2	# add the deleted file between sha1, sha2    (-)

before   time		# all the file before time
after 	 time		# all the file after time


So in my example, the file I want to delete is :

{list hack1, base}+ {list hack2, base} ... {list hack6, base} \
- [list official_merge, base ]



On Sun, Apr 10, 2005 at 04:21:08PM -0700, Linus Torvalds wrote:
> 
> 
> > the official tree. It is more for my local version control.
> 
> I have a plan. Namely to have a "list-needed" command, which you give one
> commit, and a flag implying how much "history" you want (*), and then it
> spits out all the sha1 files it needs for that history.
> 
> Then you delete all the other ones from your SHA1 archive (easy enough to
> do efficiently by just sorting the two lists: the list of "needed" files
> and the list of "available" files).
> 
> Script that, and call the command "prune-tree" or something like that, and 
> you're all done.
> 
> (*) The amount of history you want might be "none", which is to say that 
> you don't want to go back in time, so you want _just_ the list of tree and 
> blob objects associated with that commit.

That will be {list head}

> 
> Or you might want a "linear"  history, which would be the longest path
> through the parent changesets to the root.

That will be {list head,root}

> 
> Or you might want "all", which would follow all parents and all trees.

That will be {list any, root}

> 
> Or you might want to prune the history tree by date - "give me all
> history, but cut it off when you hit a parent that was done more than 6
> months ago".

That is {after -6month }

> 
> This "list-needed" thing is not just for pruning history either. If you
> have a local tree "x", and you want to figure out how much of it you need
> to send to somebody else who has an older tree "y", then what you'd do is
> basically "list-needed x" and remove the set of "list-needed y". That
> gives you the answer to the question "what's the minimum set of sha1 files
> I need to send to the other guy so that he can re-create my top-of-tree".
>

That is {list x, any} - {list y, any}


> My second plan is to make somebody else so fired up about the problem that 
> I can just sit back and take patches. That's really what I'm best at. 
> Sitting here, in the (rain) on the patio, drinking a foofy tropical drink, 
> and pressing the "apply" button. Then I take all the credit for my 
> incredible work. 

Sounds like a good plan.

Chris

