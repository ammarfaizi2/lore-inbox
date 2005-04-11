Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVDKOn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVDKOn6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 10:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbVDKOn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 10:43:58 -0400
Received: from rev.193.226.232.28.euroweb.hu ([193.226.232.28]:60889 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261753AbVDKOno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 10:43:44 -0400
To: linux-fsdevel@vger.kernel.org
CC: linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <20050411114728.GA13128@infradead.org> (message from Christoph
	Hellwig on Mon, 11 Apr 2005 12:47:28 +0100)
Subject: [RFC] FUSE permission modell (Was: fuse review bits)
References: <20050320151212.4f9c8f32.akpm@osdl.org> <20050321073519.GA13879@outpost.ds9a.nl> <20050323083347.GA1807@infradead.org> <E1DE2D1-0005Ie-00@dorka.pomaz.szeredi.hu> <20050325095838.GA9471@infradead.org> <E1DEmYC-0008Qg-00@dorka.pomaz.szeredi.hu> <20050331112427.GA15034@infradead.org> <E1DH13O-000400-00@dorka.pomaz.szeredi.hu> <20050331200502.GA24589@infradead.org> <E1DJsH6-0004nv-00@dorka.pomaz.szeredi.hu> <20050411114728.GA13128@infradead.org>
Message-Id: <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Apr 2005 16:43:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're having a bit of a disagreement with Christoph Hellwig about the
way FUSE does (or should do) permission checking.  Comments (either
way) are appreciated.

Here's my side of the story:

FUSE (filesystem in userspace) is designed to allow mounting an FS by
non-privileged users (it can also be used in the traditional way, but
that is uncontroversial and I'm not going to detail it here).  The
philosophy behind this is that sometimes it's very convenient if a
program can have a filesystem as it's _output_.

Examples are:

  - tar, zip, rar, etc[1] filesystem

  - ftp[2], ssh[3], etc filesystem

  - cvs[4], svn, etc filesystem

The common theme is that what you usually perform with some
specialized command can equally well (or sometimes better) be
performed with all the generic tools there are for file searching,
viewing, etc.

For example, the ftp and sftp commands actually give you a simulated
filesystem with a very limited shell (some variants have improved the
"simulation" by adding filename completion, etc).

With FUSE you can have the real thing and use your favourite tools on
remote or archived files.  I think this fits in very well with the
"everything is a file" UNIX philosophy.

To allow this to work in the most convenient and secure way the
following must be satisfied:

  1) User must not be able to modify files or directories in a way
     which he otherwise could not do (e.g. mount a filesystem over
     /bin)

  2) Suid and device semantics should be disabled within the mount

  3) No other user should have access to files under the mount, not
     even root[5]

  4) Access should not be further restricted for the owner of the
     mount, even if permission bits, uid or gid would suggest
     otherwise

  5) As much of the available information should be exported via the
     filesystem as possible

These are solved by:

  1) Only allow mount over a directory for which the user has write
     access (and is not sticky)

  2) Use nosuid,nodev mount options

  3) In permission method of FUSE kernel module compare fsuid against
     mounting user's ID, and return EACCES if they are not equal.

  4) The filesystem daemon does not run with elevated permissions.
     The kernel doesn't check file more in the permission method.

  5) The filesystem daemon is free to fill in all file attributes to
     any (sane) value, and the kernel won't modify these.

The debated part is 3) and 4), namely that normal permission checking
based on file mode is bypassed, and the mounting user has full
permission to all files, while other users have none.

This feature has been in FUSE from the start and thus has been very
well tested in real world scenarios.  Also I have thought a lot about
how this could pose any kind of security threat, and as yet found no
such possiblity.

Despite this Christoph feels this behavior is unacceptable for a
filesystem, and wants me to remove this feature before merging FUSE
into mainline.  I try to be open to ideas, but also feel strongly that
this is the Right Way, so I won't give up easily.

OK, open the flamethrowers!

Miklos

[1] http://www.inf.bme.hu/~mszeredi/avfs/ (CVS version required for
FUSE support)

[2] http://sourceforge.net/project/showfiles.php?group_id=121684&package_id=132803

[3] http://fuse.sourceforge.net/sshfs.html

[4] http://cvsfs.sourceforge.net/

[5] Obviously root cannot be restricted, but accidental access to
private data is still a good idea.  E.g. root squashing by NFS servers
has a similar affect.
