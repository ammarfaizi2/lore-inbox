Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275552AbRK1QyX>; Wed, 28 Nov 2001 11:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274752AbRK1QyO>; Wed, 28 Nov 2001 11:54:14 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:8834 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S272818AbRK1QyI>; Wed, 28 Nov 2001 11:54:08 -0500
From: Christoph Rohland <cr@sap.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC] Documentation/filesystems/tmpfs
Organisation: SAP LinuxLab
Date: 28 Nov 2001 17:49:27 +0100
Message-ID: <m3y9kqon6w.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

Apparently there is a lack of information about tmpfs out there.

So I would like to reduce the Configure.help entry and instead
introduce a file Documentation/filesystems/tmpfs with more details.

My proposal is appended. Feedback about content and english language
is highly appreciated.

Greetings
		Christoph


--=-=-=
Content-Disposition: attachment

Tmpfs is a file system which keeps all files in virtual memory.


Everything is temporary in the sense that no files will be created on
your hard drive. If you reboot, everything in tmpfs will be lost.

In contrast to RAM disks, which get allocated a fixed amount of
physical RAM, tmpfs grows and shrinks to accommodate the files it
contains and is able to swap unneeded pages out to swap space. 

Since tmpfs lives completely in the page cache and on swap, all in
memory tmpfs pages will show up as cached. It will not show up as
shared or something like that.


tmpfs has the following uses:

1) There is always a kernel internal mount which you will not see at
   all. This is used for shared anonymous mappings and SYSV shared
   memory. 

   This mount does not depend on CONFIG_TMPFS. If CONFIG_TMPFS is not
   set the user visible part of tmpfs is not build, but the internal
   mechanisms are always present.

2) glibc 2.2 and above expects tmpfs to be mounted at /dev/shm for
   POSIX shared memory (shm_open, shm_unlink). Adding the following
   line to /etc/fstab should take care of this:

	tmpfs	/dev/shm	tmpfs	defaults	0 0

   Remember to create the directory that you intend to mount tmpfs on
   if necessary (/dev/shm is automagically created if you use devfs).

   This mount is _not_ needed for SYSV shared memory. The internal
   mount is used for that. (In the 2.3 kernel versions it was
   necessary to mount the predecessor of tmpfs (shm fs) to use SYSV
   shared memory)

3) Some people (including me) find it very convenient to mount it
   e.g. on /tmp and /var/tmp and have a big swap partition. But be
   aware: loop mounts of tmpfs files do not work due to the internal
   design. So mkinitrd shipped by most distributions will fail with a
   tmpfs /tmp.

4) And probably a lot more I do not know about :-)


tmpfs has a couple of mount options:

size:	   The limit of allocated bytes for this tmpfs instance. The 
           default is half of your physical RAM without swap. If you
	   oversize your tmpfs instances the machine will deadlock
	   since the OOM handler will not be able to free that memory.
nr_blocks: The same as size, but in blocks of PAGECACHE_SIZE.
nr_inodes: The maximum number of inodes for this instance. The default
           is half of the number of your physical RAM pages.

These parameters accept a suffix k, m or g for kilo, mega and giga and
can be changed on remount.

The initial permissions of the root directory can be set with the
mount option "mode". Later on you can change the permissions of the
root directory with chmod.

So 'mount -t tmpfs -o size=10G,nr_inodes=10k,mode=0700 tmpfs /mytmpfs'
will give you tmpfs instance on /mytmpfs which can allocate 10GB
RAM/SWAP in 10240 inodes and it is only accessible by root.


TODOs:

1) give the size option a percent semantic: If you give a mount option
   size=50% the tmpfs instance should be able to grow to 50 percent of
   RAM + swap. So the instance should adapt autatically if you add or
   remove swap space.
2) loop mounts: This is difficult since loop.c relies on the readpage
   operation. This operation gets a page from the caller to be filled
   with the content of the file at that position. But tmpfs always has
   the page and thus cannot copy the content to the given page. So it
   cannot provide this operation. The VM had to be changed seriously
   to achieve this.
3) Show the number of tmpfs pages. (As shared?)


Author:
   Christoph Rohland, 27.11.01
--=-=-=--

