Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262874AbVDHQru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbVDHQru (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 12:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262877AbVDHQru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 12:47:50 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:24771 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S262874AbVDHQrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 12:47:05 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Martin Pool <mbp@sourcefrog.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       David Lang <dlang@digitalinsight.com>
Subject: Re: Kernel SCM saga..
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	<20050406193911.GA11659@stingr.stingr.net>
	<pan.2005.04.07.01.40.20.998237@sourcefrog.net>
	<20050407014727.GA17970@havoc.gtf.org>
	<pan.2005.04.07.02.25.56.501269@sourcefrog.net>
	<Pine.LNX.4.62.0504061931560.10158@qynat.qvtvafvgr.pbz>
	<1112852302.29544.75.camel@hope>
	<Pine.LNX.4.58.0504071626290.28951@ppc970.osdl.org>
	<1112939769.29544.161.camel@hope>
	<Pine.LNX.4.58.0504072334310.28951@ppc970.osdl.org>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Fri, 08 Apr 2005 17:46:38 +0100
In-Reply-To: <Pine.LNX.4.58.0504072334310.28951@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 7 Apr 2005 23:41:29 -0700 (PDT)")
Message-ID: <tnxekdlqkr5.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> Which is why I'd love to hear from people who have actually used various 
> SCM's with the kernel. There's bound to be people who have already
> tried.

I (successfully) tried GNU Arch with the Linux kernel. I mirrored all
the BKCVS changesets since Linux 2.6.9 (5300+ changesets) using this
script:
http://wiki.gnuarch.org/BKCVS_20to_20Arch_20Script_20for_20Linux_20Kernel

My repository size is 1.1GB but this is because the script I use
creates a snapshot (i.e. a full tarball) of every main and -rc
release. For each individual changeset, an arch repository has a
patch-xxx directory with a compressed tarball containing the patch, a
log file and a checksum file.

GNU Arch may have some annoying things (file naming, long commands,
harder to get started, imposed version naming) and I won't try to
advocate them but, for me, it looked like the best (free) option
available regarding both features and speed. Being changeset oriented
also has some advantages from my point of view. Being distributed
means that you can create a branch on your local repository from a
tree stored on a (read-only) remote repository (hosted on an ftp/http
server).

I can't compare it with BK since I haven't used it.

The way I use it:

- a main repository tracking all the changes to the bk-head,
  linux--main--2.6 (for those that never read/heard about arch, a tree
  name has the form "name--branch--version")
- my main branch from the mainline tree, linux-arm--main--2.6, that
  was integrating my patches and was periodically merging the latest
  changes in linux--main--2.6
- different linux-arm--platformX--2.6 or linux-arm--deviceX--2.6 trees
  that were eventually merged into the linux-arm--main--2.6 tree

The main merge algorithm is called star-merge and does a three-way
merge between the local tree, the remote one and the common ancestor
of these. Cherry picking is also supported for those that like it (I
found it very useful if, for example, I fix a general bug in a branch
that should be integrated in the main tree but the branch is not yet
ready for inclusion).

All the standard commands like commit, diff, status etc. are supported
by arch. A useful command is "missing" which shows what changes are
present in a tree and not in the current one. It is handy to see a
summary of the remote changes before doing a merge (and faster than a
full diff). It also supports file/directory renaming.

To speed things up, arch uses a revision library with a directory for
every revision, the files being hard-linked between revisions to save
space. You can also hard-link the working tree to the revision library
(which speeds the tree diff operation) but you need to make sure that
your editor renames the original file before saving a copy.

Having snapshots might take space but they are useful for both fast
getting a revision and creating a revision in the library.

A diff command takes usually around 1 min (on a P4 at 2.5GHz with IDE
drives) if the current revision is in the library. The tree diff is
the main time consuming operation when committing small changes. If
the revision is not in the library, it will try to create it by
hard-linking with a previous one and applying the corresponding
patches (later version I think can reverse-apply patches from newer
revisions).

The merge operation might take some time (minutes, even 10-20 minutes
for 1000+ changesets) depending on the number of changesets and
whether the revisions are already in the revision library. You can
specify a three-way merge that places conflict markers in the file
(like diff3 or cvs) or a two-way merge which is equivalent to applying
a patch (if you prefer a two-way merge, the "replay" command is
actually the fastest, it takes ~2 seconds to apply a small changeset
and doesn't need go to the revision library). Once a merge operation
completes, you would need to fix the conflicts and commit the
changes. All the logs are preserved but the newly merged individual
changes are seen as a single commit in the local tree.

In the way I use it (with a linux--main--2.6 tree similar to bk-head)
I think arch would get slow with time as changesets accumulate. The
way its developers advise to be used is to work, for example, on a
linux--main--2.6.12 tree for preparing this release and, once it is
ready, seal it (commit --seal). Further commits need to have a --fix
option and they should mainly be bug fixes. At this point you can
branch the linux--main--2.6.13 and start working on it. This new tree
can easily merge the bug fixes applied to the previous version. Arch
developers also recommend to use a new repository every year,
especially if there are many changesets.

A problem I found, even if the library revisions are hard-linked, they
still take a lot of space and should be cleaned periodically (a cron
script that checks the last access to them is available).

By default, arch also complains (with exit) about unknown files in the
working tree. Its developer(s) believe that the compilation should be
done in a different directory. I didn't find this a problem since I
use the same tree to compile for several platforms. Anyway, it can be
configured to ignore them, based on regexp.

I also tried monotone and darcs (since these two, unlike svn, can do
proper merging and preserve the merge history) but arch was by far the
fastest (CVS/RCS are hard to be bitten on speed).

Unfortunately, I can't make my repository public because of IT desk
issues but let me know if you'd like me to benchmark different
operations (or if you'd like a simple list of commands to create your
own).

Hope you find this useful.

-- 
Catalin

