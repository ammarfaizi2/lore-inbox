Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262670AbSJaP6m>; Thu, 31 Oct 2002 10:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262689AbSJaP6m>; Thu, 31 Oct 2002 10:58:42 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:15108 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S262670AbSJaP6Y>; Thu, 31 Oct 2002 10:58:24 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15809.21551.294559.408447@laputa.namesys.com>
Date: Thu, 31 Oct 2002 19:02:55 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Linus Torvalds <Torvalds@Transmeta.COM>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: [PATCH]: reiser4 [7/8] reiser4 config files
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
Microsoft: Where the service packs are larger than the original releases.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

this patch adds fs/Kconfig entries and adds reiser4 to fs/Makefile.

Please apply.

Trick-or-treat?
Nikita.
diff -rup -X dontdiff linus-bk-2.5/fs/Kconfig linux-2.5-reiser4/fs/Kconfig
--- linus-bk-2.5/fs/Kconfig	Thu Oct 31 03:02:44 2002
+++ linux-2.5-reiser4/fs/Kconfig	Thu Oct 31 13:53:57 2002
@@ -84,6 +84,150 @@ config AUTOFS4_FS
 	  local network, you probably do not need an automounter, and can say
 	  N here.
 
+config REISER4_FS
+	tristate "Reiser4 (EXPERIMENTAL very fast general purpose filesystem)"
+	depends on EXPERIMENTAL
+	---help---
+	  Reiser4 is more than twice as fast for both reads and writes as
+	  ReiserFS.  That means it is four times as fast as NTFS by Microsoft.
+	  (Proper benchmarks will appear in a few months at
+	  www.namesys.com/benchmarks.html, please be patient for now).
+
+	  It is the storage layer of what will become a general purpose naming
+	  system --- like what Microsoft wants OFS to be except designed with a
+	  clean new semantic layer rather than being SQL based like OFS.
+
+	  It performs all filesystem operations as atomic transactions, which
+	  means that it either performs a write, or it does not, and in the
+	  event of a crash it does not partially perform it or corrupt it.
+
+	  It stores files in dancing trees, which are like balanced trees but
+	  faster.  It packs small files together so that they share blocks
+	  without wasting space.  This means you can use it to store really
+	  small files.  It also means that it saves you disk space.  It avoids
+	  hassling you with anachronisms like having a maximum number of
+	  inodes, and wasting space if you use less than that number.
+
+	  It can handle really large directories, because its search
+	  algorithms are logarithmic with size not linear.  With Reiser4 you
+	  should use subdirectories because they help YOU, not because they
+	  help your filesystem's performance, or because your filesystem won't
+	  be able to shrink a directory once you have let it grow.  For squid
+	  and similar applications, everything in one directory should perform
+	  better.
+
+	  It has a plugin-based infrastructure, which means that you can easily
+	  invent new kinds of files, and so can other people, so it will evolve
+	  rapidly.
+
+	  We will be adding a variety of security features to it that DARPA has
+	  funded us to write.
+
+	  "reiser4" is a distinct filesystem mount type from "reiserfs" (V3),
+	  which means that "reiserfs" filesystems will be unaffected by any
+	  reiser4 bugs.  They have no code in common.  Reiser4 is a complete
+	  rewrite from scratch fully incorporating what we learned by experience
+	  while doing "reiserfs" the first time.  That was a lot.;-)
+
+	  Reiser4 is about as stable as the usual tornado for now --- it is
+	  for use by developers and testers only.  We don't use it for our web
+	  server --- you should not either.  This will change before 2.6.0.
+	  ReiserFS V3 is the right choice for those who want a filesystem so
+	  stable that we can go for months now without any bug reports while we
+	  have millions of users.
+
+	  If you'd like to upgrade from reiserfs to reiser4, use tar to a
+	  temporary disk, maybe using NFS/ssh/SFS to get to that disk, or ask
+	  your favorite distro to sponsor writing a conversion program.
+
+	  Sponsored by the Defensed Advanced Research Projects Agency (DARPA)
+	  of the United States Government.  DARPA does not endorse this
+	  project, it merely sponsors it.  
+	  See http://www.darpa.mil/ato/programs/chats.htm
+
+	  To learn more about reiser4, go to http://www.namesys.com
+
+config REISER4_CHECK
+	bool "Enable reiser4 debug options"
+	depends on REISER4_FS
+	---help---
+	  Don't use this unless you are a developer debugging reiser4.  If
+	  using a kernel made by a distro that thinks they are our competitor
+	  (sigh) rather than made by Linus, always check each release to make
+	  sure they have not turned this on to make us look slow as was done
+	  once in the past.  This checks everything imaginable while reiser4
+	  runs.
+
+	  When adding features to reiser4 you should set this, and then
+	  extensively test the code, and then send to us and we will test it
+	  again.  Include a description of what you did to test it.  All
+	  reiser4 code must be tested, reviewed, and signed off on by two
+	  persons before it will be accepted into a stable kernel by Hans.
+
+config REISER4_DEBUG
+	bool "Assertions"
+	depends on REISER4_CHECK
+	help
+	  Turns on assertions checks. Eats a lot of CPU.
+
+config REISER4_CHECK_STACK
+	bool "Stack check"
+	depends on REISER4_CHECK
+	help
+	  Turns on checks for stack overflow.
+
+config REISER4_DEBUG_MODIFY
+	bool "Dirtying"
+	depends on REISER4_CHECK
+	help
+	  Check that node is marked dirty each time it's modified. This is done
+	  through maintaining checksum of node content. CPU hog.
+
+config REISER4_DEBUG_MEMCPY
+	bool "Memory copying"
+	depends on REISER4_CHECK
+	help
+	  Use special non-inlined versions on memcpy, memset, and memmove in
+	  reiser4 to estimate amount of CPU time spent in data copying.
+
+config REISER4_DEBUG_NODE
+	bool "Node consistency"
+	depends on REISER4_CHECK
+	help
+	  Run consistency checks on nodes in balanced tree. CPU hog.
+
+config REISER4_ZERO_NEW_NODE
+	bool "Node zeroing"
+	depends on REISER4_CHECK
+	help
+	  Zero new node before use.
+
+config REISER4_TRACE
+	bool "Tracing"
+	depends on REISER4_CHECK
+	help
+	  Turn on tracing facility. This enables trace_flags mount option.
+
+config REISER4_STATS
+	bool "Statistics"
+	depends on REISER4_CHECK
+	help
+	  Turn on statistics collection. This increases size of in-memory super
+	  block considerably.
+
+config REISER4_DEBUG_OUTPUT
+	bool "Printing"
+	depends on REISER4_CHECK
+	help
+	  Enable compilation of functions that print internal kernel data
+	  structures in human readable form. Useful for debugging.
+
+config REISER4_NOOPT
+	bool "Disable optimization"
+	depends on REISER4_CHECK
+	help
+	  Disable compiler optimizations for reiser4 code.
+
 config REISERFS_FS
 	tristate "Reiserfs support"
 	---help---
diff -rup -X dontdiff linus-bk-2.5/fs/Makefile linux-2.5-reiser4/fs/Makefile
--- linus-bk-2.5/fs/Makefile	Tue Oct 29 03:01:20 2002
+++ linux-2.5-reiser4/fs/Makefile	Tue Oct 29 12:40:59 2002
@@ -83,6 +83,7 @@ obj-$(CONFIG_AUTOFS_FS)		+= autofs/
 obj-$(CONFIG_AUTOFS4_FS)	+= autofs4/
 obj-$(CONFIG_ADFS_FS)		+= adfs/
 obj-$(CONFIG_REISERFS_FS)	+= reiserfs/
+obj-$(CONFIG_REISER4_FS)	+= reiser4/
 obj-$(CONFIG_SUN_OPENPROMFS)	+= openpromfs/
 obj-$(CONFIG_JFS_FS)		+= jfs/
 obj-$(CONFIG_XFS_FS)		+= xfs/
