Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281634AbRKPW5X>; Fri, 16 Nov 2001 17:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281633AbRKPW5N>; Fri, 16 Nov 2001 17:57:13 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:24580 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S281631AbRKPW45>; Fri, 16 Nov 2001 17:56:57 -0500
Date: Fri, 16 Nov 2001 23:56:44 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] devfs v196 available
In-Reply-To: <200111031747.fA3Hl0u19223@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.33.0111162035180.29140-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 3 Nov 2001, Richard Gooch wrote:

>   Hi, all. Version 196 of my devfs patch is now available from:

Some small comments:
- You should consider to integrate devfs into the dcache (check e.g.
  ramfs), currently you duplicate lots of infrastructure, which you get
  for free (and faster) from the dcache. It would save you also lots of
  locking.
- you should delay the path generation in try_modload to the read
  function, then you're not limited here in the pathname length and don't
  have to abuse the stack.
- you should use "%.*s" if you want to print a dentry name (no need to
  copy it).
- you should do something about the recursive calls, it's an invitation to
  abuse them.
- symlink/slave handling of tapes/disk/cdroms is maybe better done in
  userspace.
- uid/gid in devfsd_buf_entry is 16 bit
- devfs is not a database! E.g. devfs has no business to store the
  char/block device ops table. So devfs_get_ops is wrong here, the same
  for devfs_[gs]et_info. devfs has to stay optional and storing/retrieving
  certain device data should not be done in different ways, this is only
  asking for trouble because of subtle differences. The problem so far is
  that we have no [bc]dev_t, where this info should be stored, but this
  hopefully changes early 2.5. So the path to get e.g. to the ops table
  should be "kdev_t -> [bc]dev_t -> ops" and not "kdev_t -> search whole
  devfs tree -> no ops" (because you missed manual dev nodes).
- the simple event mechanism looks prone to DOS attacks (even if all races
  are gone). Events are too easily delayed or even dropped. This makes
  the events unreliable and unsuitable for any serious use.
- in _devfs_make_parent_for_leaf you shouldn't simply return if
  _devfs_append_entry fails, because someone else might have created the
  directory since _devfs_descend.

Especially the first point is very important, this was even suggested by
Linus already more than 3 years ago. devfs could be a very thin layer, but
right now it's far bigger than it had to be.

bye, Roman



