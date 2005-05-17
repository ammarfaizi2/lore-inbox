Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVEQQWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVEQQWf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 12:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVEQQWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 12:22:34 -0400
Received: from fire.osdl.org ([65.172.181.4]:12462 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261812AbVEQQR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 12:17:56 -0400
Date: Tue, 17 May 2005 09:19:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] 2.6.x libata fixes
In-Reply-To: <428A11C2.4030900@pobox.com>
Message-ID: <Pine.LNX.4.58.0505170855170.18337@ppc970.osdl.org>
References: <428A11C2.4030900@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 May 2005, Jeff Garzik wrote:
> 
> Please pull the master (HEAD) branch of
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-2.6.git

Pulled.

> Review contents (diffstat/changelog/patch) attached to this email.  I'm 
> still new to git, so pull carefully.  :)

My pull gets the same diffstat as you claimed, and everything looks good.

> Three git-related comments:
> 
> 1) James Bottomley's git-changes-script is darned useful, for this 
> ex-BitKeeper user.  I've attached it.

It should _really_ be updated to do a better job, modern git can do much 
better. 

See the answer to the next question, since that's really the same thing:

> 2) What is the preferred way to generate a 'for Linus' diff?  I used to 
> BitKeeper's "repogca" feature to find the GCA for the diff.

You can use

	"git-merge-base HEAD OTHER_HEAD"

to get the global common ancestor. However, that's pretty pointless, since 
what you're after is really "what are the differences", and that's what 
"git-rev-tree" gives you for any arbitrary points.

With modern git, what you do is something like this (totally untested, 
but you hopefully get the idea):

	local=.
	remote=.
	localhead=HEAD
	remotehead=HEAD

	#
	# default to silent mode (changelog only),
	# use "-p" to enable full patch information.
	#
	diff-tree-arg=-s

	#
	# Get the arguments
	#
	while true; do
	   case "$1" in
	      -R)     shift;
	              remote="$1"
	              shift;;
	      -L)     shift;
	              local="$1"
	              shift;;
	      -r)     shift;
	              remotehead="$1"
	              shift;;
	      -p)     diff-tree-args=-p
	              shift;;
	       *)     localhead="$1"
                      break;;
	   esac
	done
	
	#
	# Tell git about where it can find all the objects
	#
	export GIT_OBJECT_DIRECTORY=$local/.git/objects
	export GIT_ALTERNATE_OBJECT_DIRECTORIES=$remote/.git/objects

	# ..and get the heads
	head=$(cat $local/.git/$localhead)
	other_head=$(cat $remote/.git/$remotehead)

	# What exists in remote-head but not in the local head?
	git-rev-tree $other_head ^$head |
		cut -d' ' -f2 |
		git-diff-tree --stdin -v $diff-tree-args

and it should just DoTheRightThing(tm) modulo the inevitable
ObviousBugs(tm).

> 3) Note that my object database is not pruned.  When I used 
> git-pull-script to locally merge my libata-dev.git#misc-fixes branch 
> into libata-2.6.git, it pulled all the objects in libata-dev.  I was too 
> slack to bother with pruning libata-2.6.git, knowing that eventually the 
> other changesets will make their way upstream.

I do keep my trees pruned and I still run fsck religiously, so I just 
force a prune after a pull. I _prefer_ to see clean trees, though - not 
because it matters from a techncial perspective, but because it tells me 
that the other side didn't have any left-over strange objects that might 
have been intended to be included.

But your tree looked fine.

		Linus
