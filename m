Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130018AbQLCFUO>; Sun, 3 Dec 2000 00:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129823AbQLCFUE>; Sun, 3 Dec 2000 00:20:04 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:43784 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S129667AbQLCFTs>; Sun, 3 Dec 2000 00:19:48 -0500
To: trond.myklebust@fys.uio.no
cc: linux-kernel@vger.kernel.org
Subject: negative NFS cookies: bad C library or bad kernel?
From: buhr@stat.wisc.edu (Kevin Buhr)
Date: 02 Dec 2000 22:49:16 -0600
Message-ID: <vbaaeae2joz.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond:

Fiddling with the Crytographic File System the other day, I managed to
tickle a mysterious bug.  When some directories grew large enough,
suddenly a chunk of files would half "disappear".  "find" would list
them fine, but "ls" and "echo *" wouldn't.

After a bit of troubleshooting, I discovered that the CFS daemon
(which presents itself to the system as an NFS daemon) was using
small, big-endian cookies in its directory entries.  These became
large positive and negative little-endian "d_off" values in the dirent
structs.

The C library (in glibc-2.1.3/sysdeps/unix/sysv/linux/getdents.c) does
some fancy, double-buffering footwork in getdents(2) to try to guess
how many bytes of kernel_dirents it needs to read into a temporary
buffer to fill the user-supplied buffer with user dirents (which have
an extra "d_type" field).  When its heuristic screws up, it does an
lseek on the directory so the next getdents(2) will start with the
right directory entry:

      if ((char *) dp + new_reclen > buf + nbytes)
        {
          /* Our heuristic failed.  We read too many entries.  Reset
             the stream.  `last_offset' contains the last known
             position.  If it is zero this is the first record we are
             reading.  In this case do a relative search.  */
          if (last_offset == 0)
            __lseek (fd, -retval, SEEK_CUR);
          else
            __lseek (fd, last_offset, SEEK_SET);
          break;
        }

In my case, for "ls" and "bash", the "last_offset" happened to be a
negative little-endian cookie.  The kernel's "default_lseek" returned
EINVAL, the error was ignored, and "ls" and "bash" were blissfully
unaware that a bunch of directory entries had been read into the
temporary buffer and forever lost.  Since "find" used a different
buffer size, it happened to have a positive little-endian cookie for
"last_offset" and didn't exhibit the problem.

A fix was easy---after modifying CFS to convert its cookies to small,
little-endian numbers, everything worked fine.

However, who's to blame here?  It can't be CFS---any four-byte cookie
should be valid, right?

Is the kernel NFS client code to blame?  If it's going to be using
cookies as offsets, shouldn't we have an nfs_lseek that special-cases
directory lseeks (at least those using SEEK_SET) to take negative
offsets, so utilities and libraries don't need to be bigfile-aware
just to read directories?  And what in the world can we do about bogus
code like the:

            __lseek (fd, -retval, SEEK_CUR);

that appears above?  Shouldn't any non-SEEK_SET lseek on an NFS
directory fail with an error?

Any thoughts?

Thanks.

Kevin <buhr@stat.wisc.edu>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
