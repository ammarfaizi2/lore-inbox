Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264711AbSLRQtI>; Wed, 18 Dec 2002 11:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264799AbSLRQtH>; Wed, 18 Dec 2002 11:49:07 -0500
Received: from bitmover.com ([192.132.92.2]:14754 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S264711AbSLRQtF>;
	Wed, 18 Dec 2002 11:49:05 -0500
Date: Wed, 18 Dec 2002 08:56:57 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@redhat.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: Freezing.. (was Re: Intel P6 vs P7 system call performance)
Message-ID: <20021218085657.B7976@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Dave Jones <davej@codemonkey.org.uk>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
	Andrew Morton <akpm@digeo.com>
References: <20021218164119.GC27695@suse.de> <Pine.LNX.4.44.0212180844550.29852-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0212180844550.29852-100000@home.transmeta.com>; from torvalds@transmeta.com on Wed, Dec 18, 2002 at 08:49:37AM -0800
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been wondering how to formalize patch acceptance at code freeze, but
> it might be a good idea to start talking about some way to maybe put
> brakes on patches earlier, ie some kind of "required approval process".

We went through this here for the bk-3.0 release.  We're a much smaller 
team so this may not work at all for you, but it was very successful 
for us, so much so that we are looking at formalizing it in BK.  But
you can apply the same process outside of BK just fine.

We created a well known spot for pending patches; all reviewers need access
to that spot.  Here's the README from that directory:

    There should be the following subdirectories here

	    ready/		-> waiting on review 
	    done/		-> in the tree
	    rejected/	-> no good


    In the ready/ subdirectory, for each repository which has changes that
    want to be in bk-3.0 but are not, I want:

	    ready/atrev -> /home/bk/wscott/bk-3.0-atrev
	    ready/atrev.RTI
	    ready/atrev.REVIEWED

    The first is a symlink to the location of the repository.

    The second is an RTI request which describes what is in the repo and why
    it should go in.

    The third contains the review comments in the form

	    lm (approved|not approved)
		    review comments
	    wscott (approved|not approved)
		    review comments
	    etc.

    Once the REVIEWED file contains enough approvals, in the judgement
    of the gatekeeper, then he pulls the repo into the bk-3.0 tree and moves
    the 3 files from ready/* to done/*

The things which worked very well were:

    a) extremely simple.  As we added developers they understood right away
       what the process was.
    b) centralized location.  Anyone could be bored and go do a review.
    c) tight control on the tree.



We're thinking about formalizing this in the context of BK as follows:

NAME
	bk queue - manage the queue of pending changes

DESCRIPTION
	bk queue is used to manage a queue of changes to a repository.
	It is typically used on integration repositories where tighter
	controls on change are desirable.  

	In all commands, if no URL is specified, the implied URL is the
	parent of the current repository, if any.  The URL "." means this
	repository.

	XXX - need a large paragraph on the importance of not circulating
	changesets which are in review state.  They'll come back.

	bk queue [-n<name>] [-R<rti>] [<URL>]
	    This is like a bk push but wants a "request to integrate"
	    (RTI) which is sent with the changes.  It also wants a name
	    for the set of changes.  All pending changesets are pushed.
	    If no name is given, the user is prompted for one.	If no
	    RTI is given, the user is prompted for one.

	bk queue -l [-n<name>] [<URL>]
	    Lists the set of pending changes in the queue like so:
	    <name> <date> <user> <state>

	    Values for the <state> field:
		unreviewed - nobody has looked at it yet
		reviewed by <reviewer> on <date> - obvious
		accepted - it is in accepted state but not integrated
		rejected - reviewed and rejected

	    Note that if there are multiple reviewers of a change, there
	    will be multiple lines in the listing for that change.

	    If the <name> arg is present then restrict the listing to 
	    that name.  If the <name> arg is present more than once,
	    restrict the listing to the set of named changes.

	    Could also have a -s<state> option which restricts the listing
	    to those changes in <state> state.

	bk queue -pR [-o<file>] <name> [<URL>]
	    Retrieves and displays the RTI for change <name>.  
	    If <file> is specified, put the form there.

	bk queue -pr [-o<file>] [-u<user>] <name> [<URL>]
	    Retrieves and displays the review form[s] for change <name>.
	    If a user is specified, retrieve that users' review only.
	    If <file> is specified, put the form there.

	bk queue -uR [<rti>] [<URL>]
	    Replaces any existing RTI with the specified RTI.  If no RTI
	    is specified, it prompts you for one like bk setup does.

	bk queue -ur [<review>] [<URL>]
	    Adds or replaces any existing review form with the specified
	    review.  If no review is specified, it prompts you for one
	    like bk setup does.  You may only replace your own reviews.  

	bk queue -O[<owner>] [<URL>]
	    Sets the owner of the repository to <owner>.  Only the owner
	    may update the repository.  Only the current owner can change
	    the ownership.  If no owner is specified and there is an owner
	    and the caller is the owner, then delete the owner.
	    (This is nothing more than a pre-{incoming,commit}-owner trigger)

	bk queue -d<name> [-f] [<URL>]
	    Delete the named change from the queue.  This deletes EVERYTHING,
	    the patch, rti, reviews, everything.  Only the submitter of the
	    change may delete the change unless the -f option is supplied.

	bk queue -U<name> [-R<rti>] [<URL>]
	    Replace the changes in the queue <name> with the set of
	    changesets in the current repository.  If the <rti> is
	    present, replace the current RTI form with the specified form.
	    All reviews, if any, are updated with a note that indicates
	    the existing review was against changes which have been replaced.

GUI
	This is a command line tool; Bryan gets to do bk queuetool
	using these interfaces.

TODO
	- how do we merge?  
	- define a format for the RTI
	- define a format for reviews
	- should the RTI & review files be KV files?
	- should the {name/RTI/REVIEWS} live as part of the repo and be
	  propogated?  I think yes for upstream propogation, no for 
	  downstream.  Hard to say.
	- need a way to add a queue item with no changes, i.e., an RFE which
	  needs to be in the tree but there are no changes yet.

FILES
	BitKeeper/queue/<name>/CSETS - changeset keys for change <name>
	BitKeeper/queue/<name>/RTI - RTI for change <name>
	BitKeeper/queue/<name>/PATCH - BK patch for change <name>
	BitKeeper/queue/<name>/RESYNC - exploded patch for change <name>
	BitKeeper/queue/<name>/review.user - review by user for change <name>
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
