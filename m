Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310436AbSCPQwe>; Sat, 16 Mar 2002 11:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310435AbSCPQwY>; Sat, 16 Mar 2002 11:52:24 -0500
Received: from bitmover.com ([192.132.92.2]:6020 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S310433AbSCPQwO>;
	Sat, 16 Mar 2002 11:52:14 -0500
Date: Sat, 16 Mar 2002 08:52:13 -0800
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Larry McVoy <lm@bitmover.com>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Problems using new Linux-2.4 bitkeeper repository.
Message-ID: <20020316085213.B10086@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Larry McVoy <lm@bitmover.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200203161608.g2GG8WC05423@localhost.localdomain> <3C9372BE.4000808@mandrakesoft.com> <20020316083059.A10086@work.bitmover.com> <3C9375B7.3070808@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C9375B7.3070808@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Mar 16, 2002 at 11:41:27AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 11:41:27AM -0500, Jeff Garzik wrote:
> I started with Linus's linux-2.4 repo and so did Marcelo.  We 
> independently checked in 2.4.recent patches (including proper renametool 
> use), which included the ia64 and mips merges, which added a ton of 
> files.  

OK, so there is the root cause.  It's time to talk about duplicate changes.
You know how Linus hates bad csets in the history and doesn't want them
there?  Well, I hate duplicate csets and don't want them there.  There are
lots of reasons.  One reason is that it means revtool is a lot less useful
for debugging.  If you are trying to track down the change which caused a
bug but it is obscured by a duplicate patch, you just got hosed.  Another
reason is file creates.  Suppose you and Marcelo both created a file called
"foo".  You pull, there is a file conflict, you remove one of the two files.
It isn't actually removed, it's just moved to BitKeeper/deleted.  Time passes
and you or someone else is fixing bugs in a pre-merged copy of the tree and
you are updating "foo".  You later pull that bugfix into the merged tree
and the bugfix happily is applied to the *deleted* copy of the file, since
the changes follow the "inode", not the pathname.  Bummer, you are now
scratching your head wondering where your bugfix went.

There are things we can do in BK to deal with this, but they are not easy
and are going to take several months, is my guess.  I'd like to see if you
can work around this by avoiding duplicate patches.  If you can, do so, 
you will save yourself lots of grief.

If you get into a duplicate patch situation, you are far better off to 
pick one tree or the other tree as the official tree, and cherrypick
the changes that the unofficial tree has and place them in the official
tree.  Then toss the unofficial tree.  I can make you a "bk portpatch"
command which does this, we have that already, it needs a bit of updating
to catch the comments.

You really want to listen to this, I'm trying to head you off from screwing
up the history.  If you get 300 renames like this, it's almost always a 
duplicate patch scenario.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
