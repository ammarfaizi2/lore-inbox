Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262586AbVFVWcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbVFVWcu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 18:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbVFVWa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 18:30:26 -0400
Received: from mail.dvmed.net ([216.237.124.58]:48560 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262474AbVFVWZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 18:25:00 -0400
Message-ID: <42B9E536.60704@pobox.com>
Date: Wed, 22 Jun 2005 18:24:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Git Mailing List <git@vger.kernel.org>
Subject: Updated git HOWTO for kernel hackers
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Things in git-land are moving at lightning speed, and usability has 
improved a lot since my post a month ago:  http://lkml.org/lkml/2005/5/26/11



1) installing git

git requires bootstrapping, since you must have git installed in order 
to check out git.git (git repo), and linux-2.6.git (kernel repo).  I 
have put together a bootstrap tarball of today's git repository.

Download tarball from:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-20050622.tar.bz2

tarball build-deps:  zlib, libcurl, libcrypto (openssl)

install tarball:  unpack && make && sudo make prefix=/usr/local install

jgarzik helper scripts, not in official git distribution:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-new-branch
http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-changes-script

After reading the rest of this document, come back and update your copy 
of git to the latest:
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git


2) download a linux kernel tree for the very first time

$ mkdir -p linux-2.6/.git
$ cd linux-2.6
$ rsync -a --delete --verbose --stats --progress \
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ 
\          <- word-wrapped backslash; sigh
     .git/


3) update local kernel tree to latest 2.6.x upstream ("fast-forward merge")

$ cd linux-2.6
$ git-pull-script \
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git


4) check out files from the git repository into the working directory

$ git checkout -f


5) check in your own modifications (e.g. do some hacking, or apply a patch)

# go to repo
$ cd linux-2.6

# make some modifications
$ patch -sp1 < /tmp/my.patch
$ diffstat -p1 < /tmp/my.patch

# NOTE: add '--add' and/or '--remove' if files were added or removed
$ git-update-cache <list of all files changed>

# check in changes
$ git commit


6) List all changes in working dir, in diff format.

$ git-diff-cache -p HEAD


7) List all changesets (i.e. show each cset's description text) in local 
branch of local tree, that are not present in remote tree.

$ cd my-kernel-tree-2.6
$ git-changes-script -L ../linux-2.6 | less


8) List all changesets:

$ git-whatchanged


9) apply all patches in a Berkeley mbox-format file

First, download and add to your PATH Linus's git tools:
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git-tools.git

$ cd my-kernel-tree-2.6
$ dotest /path/to/mbox  # yes, Linus has no taste in naming scripts


10) don't forget to download tags from time to time.

git-pull-script only downloads sha1-indexed object data, and the 
requested remote head.  This misses updates to the .git/refs/tags/ and 
.git/refs/heads directories.  It is advisable to update your kernel .git 
directories periodically with a full rsync command, to make sure you got 
everything:

$ cd linux-2.6
$ rsync -a --delete --verbose --stats --progress \
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
\          <- word-wrapped backslash; sigh
     .git/


11) list all branches, such as those found in my netdev-2.6 or 
libata-dev trees.

Download
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git
	or
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git


$ cd netdev-2.6
$ ls .git/refs/heads/

{ these are the current netdev-2.6 branches }
> 8139cp       forcedeth    master     qeth           smc91x         we18
> 8139too-iomap  for-linus    natsemi      r8169      smc91x-eeprom  wifi
> airo           hdlc         ns83820      register-netdev  starfire
> atmel          ieee80211    orinoco      remove-drivers   tlan
> chelsio        iff-running  orinoco-hch  sis900           veth
> dm9000         janitor      ppp          skge             viro


12) make desired branch current in working directory

$ git checkout -f $branch


13) create a new branch, and make it current

$ cp .git/refs/heads/master .git/refs/heads/my-new-branch-name
$ git checkout -f my-new-branch-name


14) examine which branch is current

$ ls -l .git/HEAD


15) undo all local modifications (same as checkout):

$ git checkout -f


16) obtain a diff between current branch, and master branch

In most trees WITH BRANCHES, .git/refs/heads/master contains the current 
'vanilla' upstream tree, for easy diffing and merging.  (in trees 
without branches, 'master' simply contains your latest changes)

$ git-diff-tree -p master HEAD


