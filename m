Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261399AbREQL1j>; Thu, 17 May 2001 07:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261401AbREQL13>; Thu, 17 May 2001 07:27:29 -0400
Received: from hera.cwi.nl ([192.16.191.8]:43735 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261400AbREQL1R>;
	Thu, 17 May 2001 07:27:17 -0400
Date: Thu, 17 May 2001 13:26:44 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105171126.NAA37619.aeb@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Bug in unlink error return
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone complained a moment ago about the error return in unlink.
And indeed, it used to be correct but since 2.1.132 we return a
buggy (or at least non-POSIX) error for unlink(directory).

Just changed the man page to say

unlink(2)
...
       EPERM  The system does not allow unlinking of directories,
              or unlinking  of  directories  requires  privileges
              that  the  current  process doesn't have.  (This is
              the POSIX prescribed error return.)

       EISDIR pathname refers to a directory.  (This is the  non-
              POSIX value returned by Linux since 2.1.132.)
...

Probably this should be fixed again, both in 2.2 and 2.4.
2.0 is still correct (I checked only ext2).

Andries


[The EISDIR is correct for rename(), and the cleanup that
made a nice uniform may_delete() in namei.c introduced this bug.
The very simple but slightly ugly fix is to write (in vfs_unlink)
	error = may_delete(dir, dentry, 0);
	if (error == -EISDIR)
		error = -EPERM;
]
