Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261941AbSJISVC>; Wed, 9 Oct 2002 14:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261942AbSJISVC>; Wed, 9 Oct 2002 14:21:02 -0400
Received: from relaydal.nai.com ([161.69.213.5]:20200 "EHLO RelayDAL.nai.com")
	by vger.kernel.org with ESMTP id <S261941AbSJISVB>;
	Wed, 9 Oct 2002 14:21:01 -0400
Message-ID: <1D4F16D4D695D21186A300A0C9DCF9838F611F@LOS-83-207.nai.com>
From: Andrew_Purtell@NAI.com
To: tytso@mit.edu
Cc: linux-kernel@vger.kernel.org
Subject: two problems using EXT3 htrees
Date: Wed, 9 Oct 2002 13:29:21 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently patched my 2.4.19 kernel with EXT3 dir_index support and tried
it out on my 80GB EXT3 data partition. This partition is used to cache CVS
and BK checkouts from 17 or so different software projects, some of them 
quite large (linux-kernel, GNOME2, and GNU src come to mind) and so it
contains thousands of directories and hundreds of thousands of files. I 
serve this via NFS to a couple of clients. Using htrees on this file
system would seem to be a good idea in theory.

(First let me state that this kernel has also been patched with the
"International Kernel Patch" for 2.4.18 but I don't believe this patch
touches any of EXT3 or JBD.)

Setting the dir_index feature flag and running e2fsck -fD (1.30-WIP) went
without a hitch. However, my problems started almost immediately.

First, there is some interaction with knfsd and the nfsfs on the clients
(also 2.4.19) where a large directory can put the client into an endless
loop when iterating directory entries. I have an exported directory
that contains 849 Ogg Vorbis files that would lock 'ls' etc. every time.

Also, I encountered a problem when building GNOME2 using a script that
first unpacks a tarball of the module, does a CVS update, repacks the
updated module, then does a configure/build/install cycle, then removes
the working sources. 

Intermittently this triggers a race where a file is deleted but the 
directory metadata is not entirely updated, leading to a condition where a
file partially exists, e.g.

  # rm -rf some-large-project
  rm: some-large-project/CVS/Entries: Input/Ouput error.
  rm: some-large-project/CVS: Directory not empty.
  rm: some-large-project: Directory not empty.
  # cd some-large-project/CVS
  # ls
  Entries: Input/Output error.

I wrote a very simple utility that calls unlink() directly:

  # unlink Entries

This succeeds in clearing the bogus entry but EXT3 complains:

  kernel: EXT3-fs warning (device ide0(3,65)): ext3-unlink:
    Deleting nonexistent file (9012125), 0

Of these two problems the latter is only a nuisance but the former
rendered my NFS exports useless, so I had to revert the filesystem.
Clearing the dir_index feature flag and then running e2fsck did the trick.

If there is any additional information I can provide, please let me know.


Andrew Purtell                                     andrew_purtell@nai.com
Network Associates Technologies, Inc.                     Los Angeles, CA
