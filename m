Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbVBBPyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbVBBPyv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 10:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbVBBPyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 10:54:51 -0500
Received: from sd291.sivit.org ([194.146.225.122]:57052 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262596AbVBBPwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 10:52:41 -0500
Date: Wed, 2 Feb 2005 16:54:04 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050202155403.GE3117@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've played lately a bit with Subversion and used it for managing
the kernel sources, using Larry McVoy's bk2cvs bridge and Ben Collins'
bkcvs2svn conversion script.

Since there is little information on the web on how to properly
set up a SVN repository and use it for tracking the latest kernel
tree, I wrote a small howto (modeled after the bk kernel howto)
in case it can be useful for other people too.

Feel free to comment on it (but let's not start a new BK flamewar
or SVN bashing session please). If there is enough interest I'll
submit a patch to include this in the kernel Documentation/ 
directory.

I've put it also on my web page along with the necessary scripts:
	http://popies.net/svn-kernel/

And now a question to Larry and whoever else is involved in the
bkcvs mirror on kernel.org: what is the periodicity of the CVS
repository update ? 

Stelian.

---------------------8<-----------------------8<----------------------
This document is intended mainly for kernel developers, occasional or full-time,
but sysadmins and power users may find parts of it useful as well.

This in *not* intended to replace the Subversion documentation.  Always run
'svn <command> --help' or browse the manual at http://svnbook.red-bean.com for
reference documentation.

But I thought the kernel used BitKeeper not Subversion ?
--------------------------------------------------------

Indeed, some kernel developers, including Linus, use BitKeeper to manage the
kernel sources. The Linus BitKeeper repository (hosted on
http://linux.bkbits.net) is the reference repository for the latest kernel code.

However, BitKeeper is not free software. It is provided either free of charge
under a restrictive license or under a classical commercial license. For more
details, read the BitKeeper license.

This document is intended for those who can't or don't want to use BitKeeper to
follow the kernel development, but still want to use a SCM tool to:
* keep up to date to Linus tree
* easily consult change logs
* do kernel related development and merge them with the latest Linus changes
* etc...

In this document, the SCM tool used is Subversion.

How does it work ?
------------------

Thanks to Larry McVoy of BitMover, the kernel metadata (change logs, authors
etc) are not only available in the BitKeeper tree, but are also made available
through a special BK to CVS bridge.

In the past, this bridge was accessible using a CVS pserver running on
cvs.kernel.org, but due to several reasons this was changed and the only way
to access the CVS repository today is by using rsync from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/bkcvs/

Ben Collins wrote a small tool which converts the kernel CVS repository into a
SVN repository. The same script can be used in an incremental fashion afterwards
to keep the two repositories synchronized.

How can I setup a SVN repository ?
----------------------------------

Get the CVS repository:

	rsync -avz --delete \
		rsync://rsync.kernel.org/pub/scm/linux/kernel/bkcvs/linux-2.5/ \
		/repos/kernel/linux-2.6-bkcvs

Create the SVN repository:

	svnadmin create /repos/kernel/linux-2.6-svn

Convert the CVS repository to SVN:

	bkcvs2svn -s \
		/repos/kernel/linux-2.6-svn \
		/repos/kernel/linux-2.6-bkcvs

The previous step will take a LONG time. On my AMD64 2000+ it took about 8 hours
to complete. But you'll have to pay this price only once, subsequent re-syncs
will be much quicker.

You also need about 500 MB of disk space for the CVS repository and 900 MB for
the SVN one (example for a kernel 2.6.11). In addition, each working copy of
this repository will take 650 MB.

How do I access this repository ?
---------------------------------

You can use the SVN repository just to track the Linus latest commits.

The SVN repository is not easily readable, you will want to get a 'working copy'
of it, by doing a 'svn checkout':

	svn checkout file://repos/kernel/linux-2.6-svn/trunk \
		/home/user/kernel/linux-2.6-linus

You will then have a full kernel source tree in 
'/home/user/kernel/linux-2.6-linus'.

In this document the repository and the working copy are on the same machine,
but this is not required. You can easily have the repository on a remote machine
and access it using directly SVN (svnserve) or SSH (svn+ssh). Please refer to
the SVN documentation for more details.

How can I update the repository to the latest version ?
-------------------------------------------------------

The repository can be updated on real-time to show Linus latest commits in his
BitKeeper tree.

The CVS tree exported by BitMover is updated each XXX hours and you can rerun
'bkcvs2svn' in an incremental fashion, to get only the new changes insert them
into the SVN repository.

You will then just redo the 'rsync' and 'bkcvs2svn' steps and you will obtain
a full updated SVN repository. (the script 'bk2svn' does just that, and you
can run it from 'cron' to periodically update your repository).

Back into your working copy, you can get the updated code by issuing a
'svn update'.

Where do I make my development ?
--------------------------------

The Linus repository gets converted to SVN using the main SVN branch (called
'trunk'). You cannot do your own modification directly on the 'trunk' because
Linus changes will overwrite your owns ('bkcvs2svn' does overwrite not merge
the modifications it imports into the repository).

So, if you are doing kernel related work, you will have to use a separate 
SVN branch. All your development will occur on this branch, you will regularly
merge the trunk into the branch (to adapt to the latest Linus tree).

Branch creation:

	svn mkdir file://repos/kernel/linux-2.6-svn/branches/
	svn copy file://repos/kernel/linux-2.6-svn/trunk \
		file://repos/kernel/linux-2.6-svn/branches/user
	... note the revision you copy, referenced later by <first> ...

Branch checkout:

	svn checkout file://repos/kernel/linux-2.6-svn/branches/user \
		/home/user/kernel/linux-2.6-user
	... hack in /home/user/kernel/linux-2.6-user ...

Merge the updated changes:

	cd /home/user/kernel/linux-2.6-linus
	svn update
	... note the revision here, referenced later by <last> ...
	cd /home/user/kernel/linux-2.6-user
	svn merge -r <first>:<last> file://repos/kernel/linux-2.6-svn/trunk
	... if there are conflicts, resolve them ...
	svn commit
	... give <first> the value of <last> ...

Note on merges: you will need to remember the revision numbers you used for a
merge because on subsequent merges you'll need to start from the last revision
merged (<first> in the example). A common way to do this is to record the
revision range in the SVN commit log.

Patch submission day. How do I do it ?
--------------------------------------

When submitting patches to Linus (or to some other kernel maintainer), you will
have to generate patches against the 'trunk'.

You can find all the differences between the trunk and your branch using:

	svn diff file://repos/kernel/linux-2.6-svn/trunk \
		file://repos/kernel/linux-2.6-svn/branches/user
		
A cleaner way to submit the differences (which enables you to properly split the
changes into small patches, document them etc), is to create a temporary branch
just for the submission:

	svn copy file://repos/kernel/linux-2.6-svn/trunk \
		file://repos/kernel/linux-2.6-svn/branches/to-linus

Then, find the differences between your branch and the temporary one:

	svn diff file://repos/kernel/linux-2.6-svn/branches/to-linus \
		file://repos/kernel/linux-2.6-svn/branches/user

And for each logical change, copy it by hand from the 'user' branch to the
'to-linus' branch, and commit the change.

Once you've finished, all you have to do is send each revision (beginning with
the creation of the branch) in the 'to-linus' branch as a separate patch (the
script 'svnsend' can help you presenting the patch is a clean format for
submission to lkml. You can also use 'svnsendall' which calls 'svnsend' for
each revision in a revision range).

The temporary branch can be removed when it is no longer needed via a simple:

	svn remove file://repos/kernel/linux-2.6-svn/branches/to-linus

How to I ignore temporary build files ?
---------------------------------------

It is useful to ignore temporary build kernel files so they are not shown in
'svn diff' etc. The lines below show how to do this on a SVN kernel tree:

	cd /tmp
	wget http://www.moses.uklinux.net/patches/dontdiff
	cd /home/user/kernel/linux-2.6-user
	svn propset svn:ignore -R -F /tmp/dontdiff .
	svn commit -m "Added svn:ignore properties." 

How do I generate 'proper' diffs ?
----------------------------------

Subversion by default does generate patches to be applied with 'patch -p0', 
which is not recommended for the kernel. The patch format also doesn't use '-p'
(tell the name of the function being modified) which is also recommended.

If you want to generate proper kernel patches, you will have to edit your
'$HOME/.subversion/config' file and put the following lines into it:

	[helpers]
	diff-cmd = /usr/local/bin/svn-diff

This will instruct SVN to call the 'svn-diff' wrapper (find it into this 
directory) whenever you call 'svn diff'.

What are the possible problems with using SVN for kernel development ?
----------------------------------------------------------------------

There are several possible problems you should be aware of when using
Subversion for kernel related development.

1. Unfortunately, the BK->CVS conversion is not perfect and the granularity
of changes is bigger than the original. The explanation is that BK branches and
consequent merges into the mainline are not reproduced on the CVS side, so all
changes done in a parallel trees will be shown as a single commit on the CVS
side. This is why you'll sometimes find a single SVN revision for many
BitKeeper changesets.

2. Subversion is based on a centralized, server based model, and this imposes
limitations on the operations you can do while being disconnected from the
server (no commits, no history accesses etc).

3. Subversion can be rather slow on some operations. This is due to the fact
that the kernel tree is rather large, and also to the fact that the operations
are done on the server rather than doing them on the client.

4. The SVN repository could need complete regeneration, and this would require
hand recreation of the development branches. The CVS repository is generated by
a tool written by Larry McVoy of BitMover, and it happened in the past (and
could happen again in the future) that bugs are discovered in this tool which
requires regenerating the whole CVS repository, and the revision numbers could
become incompatible with the old repository. This will require regenerating the
SVN repository as well, and all the branches contents will be lost. There is
unfortunately no simple way to moving the data you had in the old branches
to the new repository, you'll have to do it manually (using 'svnsendall' for
example).

5. Backuping the data is not simple. You cannot backup only the development
branches, you will have to backup the whole SVN repository (using 'svnadmin
dump' for example).


-- 
Stelian Pop <stelian@popies.net>
