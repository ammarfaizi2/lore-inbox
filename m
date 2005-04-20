Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVDTKLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVDTKLJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 06:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVDTKLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 06:11:09 -0400
Received: from waste.org ([216.27.176.166]:11726 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261428AbVDTKK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 06:10:58 -0400
Date: Wed, 20 Apr 2005 03:10:54 -0700
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Mercurial v0.1 - a minimal scalable distributed SCM
Message-ID: <20050420101054.GE21897@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://selenic.com/mercurial/

April 19, 2005

I've spent the past couple weeks working on a completely new
proof-of-concept SCM. The goals:

 - to initially be as simple (and thereby hackable) as possible
 - to be as scalable as possible
 - to be memory, disk, and bandwidth efficient
 - to be able to do "clone/branch and pull/sync" style development

It's still very early on, but I think I'm doing surprisingly well. Now
that I've got something that actually does some interesting things if
you poke at it right, I figure it's time to throw it out there.
Here's what I've got so far:

 - O(1) file revision storage and retrieval with efficient delta compression
 - efficient append-only layout for rsync and http range protocols
 - bare bones commit, checkout, stat, history
 - working "clone/branch" and "pull/sync" functionality
 - functional enough to be self-hosting[1]
 - all in less than 600 lines of Python

When I say "pull/sync" works, that means I can do:

 hg merge other-repo

and it will pull all "changesets/deltas" that are in other-dir that I
don't have, merge them into the changeset history graph, and do the
same for all files changed for those deltas. It will call out to
a user-specified merge tool like tkdiff for a proper 3-way merge with
the nearest common ancestor in the case of conflicts.

Right now, "cloning/branching" is simply a matter of "cp -al" or
"rsync" (mercurial knows how to break hardlinks if needed).

Some benchmarks from my laptop:

 - prepare for commit of Linux 2.6.10: ~1s
 - commit Linux 2.6.10: 27s
 - checkout Linux 2.6.10: 45s
 - full tree stat for added/changed/deleted files: <1s
 - local hardlink clone: 1.5s
 - empty merge between full trees: <.1s
 - trivial 3-way merge with changes to Makefile: ~1s

Much thought has gone into what the best asymptotic performance can be
for the various things an SCM has to do and the core algorithms and
data structures here should scale relatively painlessly to arbitrary
numbers of changesets, files, and file revisions.

What remains to be done:

 - a halfway-usable command line tool
 - remote (network) repository support
 - diff generation
 - changelog entry editing
 - various manual interventions for merge
 - handle rename
 - handle rollback
 - all sorts of other error handling
 - all sorts of cleanup, packaging, documentation, testing...

Sample usage:

 export HGMERGE=tkmerge   # set a 3-way merge tool
 mkdir foo
 hg create                # create a repository in .hg/
 echo foo > Makefile
 hg add Makefile          # add a file to the current changeset
 hg commit                # commit files currently marked for add or delete
 hg history               # show all changesets
 hg index Makefile        # show change
 touch Makefile
 hg stat                  # find changed files
 cd ..; cp -al foo branch  # make a branch
 hg merge ../branch-foo    # sync changesets from a branch

[1] though the repository format is still in flux

-- 
Mathematics is the supreme nostalgia of our time.
