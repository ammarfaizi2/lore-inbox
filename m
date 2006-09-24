Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752140AbWIXSs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbWIXSs3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 14:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbWIXSs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 14:48:29 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:29355 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1752140AbWIXSs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 14:48:28 -0400
From: Junio C Hamano <junkio@cox.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: 2.6.18-mm1
References: <20060924040215.8e6e7f1a.akpm@osdl.org>
	<20060924124647.GB25666@flint.arm.linux.org.uk>
	<20060924132213.GE11916@pasky.or.cz>
	<20060924142005.GF25666@flint.arm.linux.org.uk>
	<20060924142958.GU13132@pasky.or.cz>
	<20060924144710.GG25666@flint.arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org, Petr Baudis <pasky@suse.cz>
Date: Sun, 24 Sep 2006 11:48:26 -0700
In-Reply-To: <20060924144710.GG25666@flint.arm.linux.org.uk> (Russell King's
	message of "Sun, 24 Sep 2006 15:47:10 +0100")
Message-ID: <7veju185j9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> writes:

> I'm just experimenting with git-apply for the forward case, and I'm
> hitting a small problem.  I can do:
>
> 	cat patch | git-apply --stat
>
> then I come to commit it:
>
> 	git commit -F -
>
> but if I just use that, _all_ changes which happen to be in the tree
> get committed, not just those which are in the index file.

That does not sound right.

 * "git apply --stat patch" (you do not need "cat |" there) is
   only to inspect the changes; it does not apply the change to
   your working tree.  Think of it as "diffstat for git".

   If you want to apply it _and_ view diffstat, you can say "git
   apply --stat --apply patch".

 * Not having any pathname in the "git commit" like quoted above
   in the final step should commit what is in index.  What will
   be committed may not match what is in your working tree (iow
   "git diff" can still show some local changes you are not
   committing).  We often call this "partial commit".

 * When doing partial commits, having "git apply" to prepare
   what you want to commit in the index is less error prone
   (otherwise you would somehow need to parse the patch and find
   out what is added and what is deleted).  I do not exactly
   know what you are doing in your Perl wrapper, but I suspect
   bulk of that is to figure out what is changed and run
   git-update-index on them -- you can lose all that code by
   using "git apply --index patch".  Then added, removed and
   modified paths are all updated in the index.

> I guess we'll just have to live with the screwed history until some
> of the issues I've brought up with git are resolved (the biggest one
> being git commit being able to take a list of files deleted.)

If you _are_ updating index yourself before calling git-commit,
you do not need to (and indeed you should not) pass _any_
pathnames to it.  I think that's where this confusion comes from.

As an old-timer, you may remember that git-commit did not take
any path arguments initially.  You were supposed to do update-index
the paths you care about to build the image of what you want to
record in your next commit and then tell git-commit to commit
the index, and that was the only way to make a commit.  We still
support that model of operation.

Then "git-commit -a" was added.  This made git-commit to notice
modified and deleted files (but not added ones) and run
update-index automatically on them before doing its work.  

In addition, git-commit started to take path parameters.
Originally, this was meant to tell git-commit "Oh, I forgot to
run update-index on these paths so far, so the changes I made to
the index is fine, but also include the change to these paths in
the commit as well".  This made git-commit run update-index on
the given paths ON TOP OF the current index before making a
commit.  We still support this model of operation, but it now
requires an explicit -i option to invoke it.

What "git-commit paths..." without an explicit -i option
currently does is a compromise made to mollify CVS minded
people's argument to help newbies.  You are telling git-commit:

	Ignore any change I made to the index so far.  The
	commit I want to make now is the last commit plus
	changes I have in my working tree on these paths.

This is only meant to support the workflow for people who do not
want to deal with index at all.  After checking out the last
commit, you muck with what is in your working tree, and say
"git-commit paths..." to commit only changes made to the paths
explicitly listed on the command line.  Hence, as a safety
measure, we require a few things when this option is used:

 * The index entries for paths you named on the command line
   should match what is in the last commit.  Otherwise, it means
   you have done something like this:

	checkout
	edit foo
        update-index foo ;# happy with _THIS_ state of foo
        edit foo ;# further work
        edit bar
        commit foo bar

   The new "commit paths..." without -i is not "index has what I
   want but in addition I want changes to these", so without
   this check you will end up committing foo after "further
   work", and you would lose the state you marked with the
   manual update-index.  Now it may be what the user wanted, or
   it may not be (remember, this "explicit paths" is now for
   people who do not usually deal with index, so index entry for
   named paths being different from the last commit indicates
   there is something else going on -- maybe the user really
   cared).  So we flag the problem when we notice it.

 * The named paths must exist in the index (they do not have to
   exist in your working tree -- so "rm foo; git commit foo"
   commits the removal of foo).  This is to catch typo on the
   command line.

So in short, 

        patch -p1 < patch
        git add $added
        git rm $removed
	git update-index $modified
        echo commit-message | git commit -F - -- $added $modified

is mixing two incompatible mode of operations from separate
workflows.  You are index-aware by using update-index (or git
add/rm) but you are driving git-commit as if you are not.

Two possibilities (I would recommend 1b).

(1) Use index-aware workflow consistently (1a):

	patch -p1 <patch
        parse patch and figure out $added $removed and $modified
        git update-index --add --remove $added $removed $modified
	git commit -F $logfile

    Or slightly simpler (1b):

	git apply --index patch
        git commit -F $logfile

(2) Use index-unaware workflow consistently:

	patch -p1 <patch
        parse patch and figure out $added $removed and $modified
	git add $added
        git rm $removed
        git update-index $modified
	git commit -F $logfile


