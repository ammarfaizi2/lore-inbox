Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284153AbRLARNC>; Sat, 1 Dec 2001 12:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284155AbRLARMx>; Sat, 1 Dec 2001 12:12:53 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:64149 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S284153AbRLARMr>; Sat, 1 Dec 2001 12:12:47 -0500
X-Gnus-Agent-Meta-Information: mail nil
From: Christoph Rohland <cr@sap.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch] tmpfs documentation
Organisation: SAP LinuxLab
Message-ID: <m37ks6dg6d.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
Date: 01 Dec 2001 18:07:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus and Marcelo,

The appended patch adds and reorganizes the documentation for
tmpfs.

It is against 2.4.16 but should apply to 2.5 also.

Please apply to both versions

		Christoph

diff -uNr 2.4.16/Documentation/Configure.help m2.4.16/Documentation/Configure.help
--- 2.4.16/Documentation/Configure.help	Mon Nov 26 16:21:44 2001
+++ m2.4.16/Documentation/Configure.help	Sat Dec  1 17:58:42 2001
@@ -13839,30 +13839,11 @@
 CONFIG_TMPFS
   Tmpfs is a file system which keeps all files in virtual memory.
 
-  In contrast to RAM disks, which get allocated a fixed amount of
-  physical RAM, tmpfs grows and shrinks to accommodate the files it
-  contains and is able to swap unneeded pages out to swap space.
+  Everything in tmpfs is temporary in the sense that no files will be
+  created on your hard drive. If you reboot, everything in tmpfs will
+  be lost.
 
-  Everything is "virtual" in the sense that no files will be created
-  on your hard drive; if you reboot, everything in tmpfs will be
-  lost.
-
-  You should mount the file system somewhere to be able to use
-  POSIX shared memory. Adding the following line to /etc/fstab should
-  take care of things:
-
-  tmpfs		/dev/shm	tmpfs		defaults	0 0
-
-  Remember to create the directory that you intend to mount tmpfs on
-  if necessary (/dev/shm is automagically created if you use devfs).
-
-  You can set limits for the number of blocks and inodes used by the
-  file system with the mount options "size", "nr_blocks" and
-  "nr_inodes". These parameters accept a suffix k, m or g for kilo,
-  mega and giga and can be changed on remount.
-
-  The initial permissions of the root directory can be set with the
-  mount option "mode".
+  See <file:Documentation/filesystems/tmpfs.txt> for details
 
 Simple RAM-based file system support
 CONFIG_RAMFS
diff -uNr 2.4.16/Documentation/filesystems/tmpfs.txt m2.4.16/Documentation/filesystems/tmpfs.txt
--- 2.4.16/Documentation/filesystems/tmpfs.txt	Thu Jan  1 01:00:00 1970
+++ m2.4.16/Documentation/filesystems/tmpfs.txt	Sat Dec  1 18:02:26 2001
@@ -0,0 +1,96 @@
+Tmpfs is a file system which keeps all files in virtual memory.
+
+
+Everything in tmpfs is temporary in the sense that no files will be
+created on your hard drive. If you reboot, everything in tmpfs will be
+lost.
+
+tmpfs puts everything into the kernel internal caches and grows and
+shrinks to accommodate the files it contains and is able to swap
+unneeded pages out to swap space. It has maximum size limits which can
+be adjusted on the fly via 'mount -o remount ...'
+
+If you compare it to ramfs (which was the template to create tmpfs)
+you gain swapping and limit checking. Another similar thing is the RAM
+disk (/dev/ram*), which simulates a fixed size hard disk in physical
+RAM, where you have to create an ordinary filesystem on top. Ramdisks
+cannot swap and you do not have the possibility to resize them. 
+
+Since tmpfs lives completely in the page cache and on swap, all tmpfs
+pages currently in memory will show up as cached. It will not show up
+as shared or something like that. Further on you can check the actual
+RAM+swap use of a tmpfs instance with df(1) and du(1).
+
+
+tmpfs has the following uses:
+
+1) There is always a kernel internal mount which you will not see at
+   all. This is used for shared anonymous mappings and SYSV shared
+   memory. 
+
+   This mount does not depend on CONFIG_TMPFS. If CONFIG_TMPFS is not
+   set, the user visible part of tmpfs is not build. But the internal
+   mechanisms are always present.
+
+2) glibc 2.2 and above expects tmpfs to be mounted at /dev/shm for
+   POSIX shared memory (shm_open, shm_unlink). Adding the following
+   line to /etc/fstab should take care of this:
+
+	tmpfs	/dev/shm	tmpfs	defaults	0 0
+
+   Remember to create the directory that you intend to mount tmpfs on
+   if necessary (/dev/shm is automagically created if you use devfs).
+
+   This mount is _not_ needed for SYSV shared memory. The internal
+   mount is used for that. (In the 2.3 kernel versions it was
+   necessary to mount the predecessor of tmpfs (shm fs) to use SYSV
+   shared memory)
+
+3) Some people (including me) find it very convenient to mount it
+   e.g. on /tmp and /var/tmp and have a big swap partition. But be
+   aware: loop mounts of tmpfs files do not work due to the internal
+   design. So mkinitrd shipped by most distributions will fail with a
+   tmpfs /tmp.
+
+4) And probably a lot more I do not know about :-)
+
+
+tmpfs has a couple of mount options:
+
+size:	   The limit of allocated bytes for this tmpfs instance. The 
+           default is half of your physical RAM without swap. If you
+	   oversize your tmpfs instances the machine will deadlock
+	   since the OOM handler will not be able to free that memory.
+nr_blocks: The same as size, but in blocks of PAGECACHE_SIZE.
+nr_inodes: The maximum number of inodes for this instance. The default
+           is half of the number of your physical RAM pages.
+
+These parameters accept a suffix k, m or g for kilo, mega and giga and
+can be changed on remount.
+
+The initial permissions of the root directory can be set with the
+mount option "mode". Later on you can change the permissions of the
+root directory with chmod.
+
+So 'mount -t tmpfs -o size=10G,nr_inodes=10k,mode=0700 tmpfs /mytmpfs'
+will give you tmpfs instance on /mytmpfs which can allocate 10GB
+RAM/SWAP in 10240 inodes and it is only accessible by root.
+
+
+TODOs:
+
+1) give the size option a percent semantic: If you give a mount option
+   size=50% the tmpfs instance should be able to grow to 50 percent of
+   RAM + swap. So the instance should adapt autatically if you add or
+   remove swap space.
+2) loop mounts: This is difficult since loop.c relies on the readpage
+   operation. This operation gets a page from the caller to be filled
+   with the content of the file at that position. But tmpfs always has
+   the page and thus cannot copy the content to the given page. So it
+   cannot provide this operation. The VM had to be changed seriously
+   to achieve this.
+3) Show the number of tmpfs RAM pages. (As shared?)
+
+
+Author:
+   Christoph Rohland <cr@sap.com>, 1.12.01

