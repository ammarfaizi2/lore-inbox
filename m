Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264943AbTBFCAz>; Wed, 5 Feb 2003 21:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264950AbTBFCAz>; Wed, 5 Feb 2003 21:00:55 -0500
Received: from [195.223.140.107] ([195.223.140.107]:52608 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S264943AbTBFCAu>;
	Wed, 5 Feb 2003 21:00:50 -0500
Date: Thu, 6 Feb 2003 03:10:29 +0100
From: Andrea Arcangeli <andrea@e-mind.com>
To: linux-kernel@vger.kernel.org
Subject: openbkweb-0.0
Message-ID: <20030206021029.GW19678@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In a few words: I prefer to spend time coding than in endless flamewars
on l-k, and I suggest everybody to do the same and to rather spend time
reading and contributing the code than in answerng this email unless
you've something technical to suggest of course ;)

If you're interested in checking out from the bitkeeper servers with an
open source program (GPLv2 actually) you can do/try it now (almost, see
below for the last trouble that I just discussed today on l-k).

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/openbkweb/openbkweb-0.0.tar.gz

I should thanks Aaron Swartz, since I included a GPLv2 html2text python
library for him (google found it) that makes it trivial to extract the
data.

For example to checkout bk head starting from a 2.5.59 tarball on
kernel.org the command is:

	mkdir 2.5-pickle
	python bkweb.py -u http://linux.bkbits.net:8080/linux-2.5 --rev=1.947.3.4 -t linux-2.5.59 -c 2.5-pickle

The number 1.947.3.4 cames from this webpage:

	http://linux.bkbits.net:8080/linux-2.5/ChangeSet@-4w?nav=index.html

you'll see that 1.947.3.4 matches the release number 2.5.59. The number
1.947.3.4 tells bkweb to apply all the changesets from 1.947.3.5 to the
last one. So it's really simple.

bkweb will fetch the data, will save it in the cache directory
(2.5-pickle) and it will apply it to the linux-2.5.59 directory.

Unfortunately it doesn't work reliably when Linus merges old changesets,
the logic will be confused. The current logic thinks all changesets can
be applied in order.

the problem is that to generate bk head it may have to apply also some
changeset in the past, not only between 2.5.59 to the last one in
cronological order. That still needs a solution. One solution could be
also that nobody should send bk pull to Linus anymore, if everybody
sends patches it won't risk to reject anymore ;) but I doubt it's an
acceptable one for everybody, I assume somebody is confortable with it, if
they're using it right now. I also suspect it will be necessary to use a
different numbering and not to use the bk changeset numbers as index.  The
object is to never have to rebuild the database. Currently I don't even
store persistent the ordering (not point to store it yet since it's not a 100%
reliable ordering ;).

The -c parameter tells the directory where to generate the cache. the
cache is truly the whole repository and it contains all the data and
metadata in an open form. To get it just run:

	changeset = self.unpickle(revision)

where revision can be '1.947.3.5'. dir(changeset) will show you what you
can find there, it's a live class after being restored from disk (I put
only data in there to save space on disk but in theory it could contain
software too, not that I think it is useful but..).

the output looks like this

athlon:~/devel/bkweb> python bkweb.py -u http://linux.bkbits.net:8080/linux-2.5 --rev=1.947.3.4 -t ~/devel/kernel/x -c ~/devel/kernel/2.5-pickle >/tmp/x
Downloading (linux.bkbits.net:8080,/linux-2.5/) ... done.
Found 14 Changeset fallback pages.
Searching rev 1.947.3.4 ... found at CHS 6
Pending 294 revisions
Downloading changeset 1.947.3.5 ... done.
------ Changeset:       1.947.3.5
------ Author:          scott.feldman@intel.com
------ Date:            2003-01-16 23:06:26-05:00
------ Commentary:      [netdrvr e100] udelay a better way

* Bug Fix: TCO workaround after hard reset of controller to wait for TCO
  traffic to settle.  Workaround requires issuing a CU load base command
  after hard reset, followed by a wait for scb and finally a wait for
  TCO traffic bit to clear.  Affects 82559s and above wired to SMBus.

------ Files:           ['drivers/net/e100/e100_main.c']
patching file drivers/net/e100/e100_main.c
make distclean ... done.
Pending 293 revisions
Downloading changeset 1.947.3.6 ... done.
------ Changeset:       1.947.3.6
------ Author:          scott.feldman@intel.com
------ Date:            2003-01-16 23:38:43-05:00
------ Commentary:      [netdrvr e100] fix TxDescriptor bit setting
------ Files:           ['drivers/net/e100/e100_main.c']
patching file drivers/net/e100/e100_main.c
make distclean ... done.
Pending 292 revisions
Downloading changeset 1.947.3.7 ... done.
------ Changeset:       1.947.3.7
------ Author:          scott.feldman@intel.com
------ Date:            2003-01-16 23:40:31-05:00
------ Commentary:      [netdrvr e100] standardize nic-specific stats
support

* Removed /proc/net/PRO_LAN_Adapters
* Added ethtool GSTATS support
------ Files:           ['drivers/net/e100/Makefile', 'drivers/net/e100/e100.h', 'drivers/net/e100/e100_main.c']
patching file drivers/net/e100/Makefile
patching file drivers/net/e100/e100.h
patching file drivers/net/e100/e100_main.c
[..]

at the first reject it stops and writes to stdout (/tmp/x in my example)
the patch that rejected so you can analyze it. I think it never completed
successfully yet but if it works correctly it should just exit with
nothing in stdout (with stdout I really mean fd 1, not stderr of
course).

So if you run the same command twice the second time it will find
everything in the cache obviously, and the cache is trivial to
manipulate using simple python scripts, so you can automate searches on
files in the changesets or whatever (including feeding the data into CVS
or whatever) So backing up the cache effectively you save the whole
bitkeeper repository (only the main branch). Converting the cache to
something python indipendent is trivial too, I wrote this thing fast
so this was the easiest way.

My main object is to give access to data and metadata of the changesets
generated during kernel development in a very manageable form to
everybody, reliably, without proprietary licence restrictions, and to store it
somewhere (possibly mirrored) in a open standard. This had to be the
case since the first place IMHO. the cset/ directory doesn't allow
anything like that in terms of regenerating the whole tree or managing
the metadata, and it's even less reliable than bkweb. The fact I've to
fetch from the web and not from the cset/ directories on the mirrors
should tell the whole story about the completeness of the cset/
directory. cset/ is better than nothing but it doesn't obviate the need
of bkweb or bk.

I wrote the first line of this program yesterday (it's not that I've
that much time for this thing but eventually I wanted to checkout
through the bitkeeper database too), clearly it's not well tested and I
don't have much time for it.

I guess the bitkeeper network protocol could be also implemented on the
longer run, it should be much faster to fetch all the database that way,
but clearly decoding the html is been much easier and it is supposed to
run in background for me, so I don't care about the checkout speed at
the moment.

If you run it like shown above it will stop like below on
fs/jfs/inode.c.rej in changeset 1.947.6.2, removing -F1 from the patch
parameters should workaround it but I didn't even tried it since I need
to solve this problem before it is really useful.

[..]
Pending 278 revisions
Downloading changeset 1.947.9.4 ... done.
------ Changeset:       1.947.9.4
------ Author:          ganesh@veritas.com
------ Date:            2003-01-17 11:58:19-08:00
------ Commentary:      [PATCH] USB ipaq driver ids

Added ids for the Dell Axim and Toshiba E740.

Thanks to Ian Molton and B.I.
------ Files:           ['drivers/usb/serial/ipaq.c', 'drivers/usb/serial/ipaq.h']
patching file drivers/usb/serial/ipaq.c
patching file drivers/usb/serial/ipaq.h
make distclean ... done.
Pending 277 revisions
Downloading changeset 1.947.6.2 ... done.
------ Changeset:       1.947.6.2
------ Author:          shaggy@ibm.com
------ Date:            2003-01-17 14:17:30-06:00
------ Commentary:      JFS: replace ugly JFS debug macros with simpler ones.

JFS has always used ugly debug macros, jFYI, jEVENT, & jERROR.  I have
replaced them with simpler jfs_info(), jfs_warn(), & jfs_err().

------ Files:           ['fs/jfs/inode.c', 'fs/jfs/jfs_btree.h', 'fs/jfs/jfs_debug.h', 'fs/jfs/jfs_dmap.c', 'fs/jfs/jfs_dtree.c', 'fs/jfs/jfs_imap.c', 'fs/jfs/jfs_inode.c', 'fs/jfs/jfs_logmgr.c', 'fs/jfs/jfs_metapage.c', 'fs/jfs/jfs_mount.c', 'fs/jfs/jfs_txnmgr.c', 'fs/jfs/jfs_umount.c', 'fs/jfs/jfs_unicode.c', 'fs/jfs/jfs_xtree.c', 'fs/jfs/namei.c', 'fs/jfs/super.c']
patching file fs/jfs/inode.c
Hunk #5 FAILED at 377.
1 out of 5 hunks FAILED -- saving rejects to file fs/jfs/inode.c.rej
patching file fs/jfs/jfs_btree.h
patching file fs/jfs/jfs_debug.h
patching file fs/jfs/jfs_dmap.c
patching file fs/jfs/jfs_dtree.c
patching file fs/jfs/jfs_imap.c
patching file fs/jfs/jfs_inode.c
patching file fs/jfs/jfs_logmgr.c
patching file fs/jfs/jfs_metapage.c
patching file fs/jfs/jfs_mount.c
patching file fs/jfs/jfs_txnmgr.c
patching file fs/jfs/jfs_umount.c
patching file fs/jfs/jfs_unicode.c
patching file fs/jfs/jfs_xtree.c
patching file fs/jfs/namei.c
patching file fs/jfs/super.c
Traceback (most recent call last):
  File "bkweb.py", line 283, in ?
    bkweb(sys.argv)
  File "bkweb.py", line 279, in bkweb
    checkout(url, rev, tree, cache, verbose)
  File "bkweb.py", line 235, in checkout
    raise 'FailedPatch', changeset.rev
FailedPatch: 1.947.6.2

Andrea
