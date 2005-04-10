Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVDJXQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVDJXQS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 19:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVDJXQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 19:16:17 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:11722 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261637AbVDJXPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 19:15:21 -0400
Date: Sun, 10 Apr 2005 16:14:57 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: junkio@cox.net, rddunlap@osdl.org, ross@jose.lug.udel.edu,
       linux-kernel@vger.kernel.org
Subject: Re: more git updates..
Message-Id: <20050410161457.2a30099a.pj@engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0504101338360.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
	<20050409200709.GC3451@pasky.ji.cz>
	<Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
	<7vhdifcbmo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504100824470.1267@ppc970.osdl.org>
	<20050410115055.2a6c26e8.pj@engr.sgi.com>
	<Pine.LNX.4.58.0504101338360.1267@ppc970.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Useful explanation - thanks, Linus.

Is this picture and description accurate:

==============================================================


             < working directory files (foo.c) >
                           ^
  ^                        |
  |  upward ops            |            downward ops  |
  |  ----------            |            ------------  |
  | checkout-cache         |            update-cache  |
  | show-diff              |                          v
                           v
        < current directory cache (".dircache/index") >
                           ^
  ^                        |
  |  upward ops            |            downward ops  |
  |  ----------            |            ------------  |
  |   read-tree            |             write-tree   |
  |                        |            commit-tree   |
                           |                          v
                           v
< git filesystem (blobs, trees, commits: .dircache/{HEAD,objects}) >


==============================================================


The checkout-cache and show-diff ops read their meta-data from
the cache, and the actual file contents from the git filesystem.
Similary, the update-cache op writes meta-data into the cache,
and may create new files in the git filesystem.

The cache (but not the git filesystem) stores transient
information (ctime, mtime, dev, ino, uid, gid, and size)
about each working file update-cache has copied into the git
filesystem so that checkout-cache and show-diff can detect
changes in the contents of working files just from a stat,
without actually rereading the file.

In some sense, the cache holds the git filesystem inodes,
and the git filesystem holds the data blocks.  Except that:
  (1) the cache just holds the current "view" into the git
      filesystem,
  (2) objects in the filesystem have an "inode" number (their
      <sha1> value) that is persistent whether in view or not,
  (3) objects in the filesystem are not removed just because
      nothing in the cache references them,
  (4) objects in the filesystem can reference other objects,
      that are typically also in the filesystem, but that can
      still be reliably self-identified even if found in the
      wild of say one's email inbox, and
  (5) the view in the directory cache can itself be made into
      a filesystem object - using commit-tree.


==============================================================

Minor question:

  I must have an old version - I got 'git-0.03', but
  it doesn't have 'checkout-cache', and its 'read-tree'
  directly writes my working files.
 
  How do I get a current version?  Well, one way I see,
  and that's to pick up Pasky's:
    
    http://pasky.or.cz/~pasky/dev/git/git-pasky-base.tar.bz2
 
  Perhaps that's the best way?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
