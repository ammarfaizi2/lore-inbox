Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262633AbRFGOEc>; Thu, 7 Jun 2001 10:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262615AbRFGOEW>; Thu, 7 Jun 2001 10:04:22 -0400
Received: from charybda.fi.muni.cz ([147.251.48.214]:22281 "HELO
	charybda.fi.muni.cz") by vger.kernel.org with SMTP
	id <S262563AbRFGOEJ>; Thu, 7 Jun 2001 10:04:09 -0400
From: Jan Kasprzak <kas@informatics.muni.cz>
Date: Thu, 7 Jun 2001 13:37:50 +0200
To: linux-kernel@vger.kernel.org
Cc: xgajda@fi.muni.cz, kron@fi.muni.cz
Subject: CacheFS
Message-ID: <20010607133750.I1193@informatics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	a friend of mine has developed the CacheFS for Linux. His work
is a prototype read-only implementation for Linux 2.2.11 or so. I am
thinking about adapting (or partly rewriting) his work for Linux 2.4.
But before I'll start working, I'd like to ask you for comments on the
proposed CacheFS architecture.

	The goal is to speed-up reading of potentially slow filesystems
(NFS, maybe even CD-based ones) by the local on-disk cache in the same way
IRIX or Solaris CacheFS works. I would expect this to be used on clusters
of computers or university computer labs with NFS-mounted /usr or some
other read-only filesystems. Another goal is to use the Linux filesystem
as a backing store (as opposed to the block device or single large file
used by CODA).

	The CacheFS architecture would consist in two components:
- kernel module, implementing the filesystem of the type "cachefs"
	and a character device /dev/cachefs
- user-space daemon, which would communicate with the kernel over /dev/cachefs
	and which would manage the backing store in a given directory.

	Every file on the front filesystem (NFS or so) volume will be cached
in two local files by cachefsd: The first one would contain the (parts of)
real file content, and the second one would contain file's metadata and the
bitmap of valid blocks (or pages) of the first file. All files in cachefsd's
backing store would be in a per-volume directory, and will be numbered by the
inode number from the front filesystem.

	Now here are some questions:

* Should the cachefsd be in user space (as it is in the prototype implementation)
or should it be moved to the kernel space? The former allows probably better
configuration (maybe a deeper directory structure in the backing store),
but the later is faster as it avoids copying data between the user and kernel
spaces.

* Would you suggest to have only one instance of cachefsd, or one per volume,
	or a multithreading implementation with configurable number
	of threads?

* Is the communication over the character device appropriate? Another
	alternative is probably a new syscall, /proc file, or maybe even
	an ioctl on the root directory of the filesystem (ugh!).

* Can the kernel part of CODA can be used for this?

	Thanks,

-Yenya

-- 
\ Jan "Yenya" Kasprzak <kas at fi.muni.cz>       http://www.fi.muni.cz/~kas/
\\ PGP: finger kas at aisa.fi.muni.cz   0D99A7FB206605D7 8B35FCDE05B18A5E //
\\\             Czech Linux Homepage:  http://www.linux.cz/              ///
It is a very bad idea to feed negative numbers to memcpy.         --Alan Cox
