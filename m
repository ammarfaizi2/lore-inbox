Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266161AbUGTTyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266161AbUGTTyC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266147AbUGTTxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:53:44 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:35576 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266161AbUGTTuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 15:50:23 -0400
Date: Tue, 20 Jul 2004 21:50:12 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Steve Lord <lord@xfs.org>
Cc: linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com, nathans@sgi.com,
       Cahya Wirawan <cwirawan@email.archlab.tuwien.ac.at>,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] let 4KSTACKS depend on EXPERIMENTAL and XFS on 4KSTACKS=n
Message-ID: <20040720195012.GN14733@fs.tum.de>
References: <20040720114418.GH21918@email.archlab.tuwien.ac.at> <40FD0A61.1040503@xfs.org> <40FD2E99.20707@mnsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40FD2E99.20707@mnsu.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2004 at 09:39:21AM -0500, Jeffrey E. Hundstad wrote:
> Steve Lord wrote:
> 
> >Don't use 4K stacks and XFS. What you hit here is a path where the
> >filesystem is getting full and it needs to free some reserved space
> >by flushing cached data which is using reserved extents. Reserved
> >extents do not yet have an on disk address and they include a
> >reservation for the worst case metadata usage. Flushing them will
> >get you room back.
> >
> >As you can see, it is a pretty deep call stack, most of XFS is going
> >to work just fine with a 4K stack, but there are end cases like
> >this one which will just not fit.
> 
> 
> If this is a known truth with XFS maybe it would be a good idea to have 
> 4K stacks and XFS be an impossible combination using the config tool.


The patch below does:

1. let 4KSTACKS depend on EXPERIMENTAL
Rationale:
4Kb stacks on i386 are the future. But currently this option might still 
cause problems in some areas of the kernel. OTOH, 4Kb stacks isn't a big 
gain for most people.
2.6 is a stable kernel series, and 4KSTACKS=n is the safe choice.
Once all issues with 4KSTACKS=y are resolved this can be reverted.

2. let XFS depend on (4KSTACKS=n || BROKEN)
Rationale:
Mark Loy said:
  Don't use 4K stacks and XFS.
Mark this combination as BROKEN until XFS is fixed.
This might result in XFS support disappearing for some people, but if 
they use EXPERIMENTAL=y they should know what they are doing.

The 4KSTACKS option has to be moved for that it's asked before XFS in 
"make config".

diffstat output:
 arch/i386/Kconfig |   19 ++++++++++---------
 fs/Kconfig        |    1 +
 2 files changed, 11 insertions(+), 9 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc2-full/arch/i386/Kconfig.old	2004-07-20 21:00:32.000000000 +0200
+++ linux-2.6.8-rc2-full/arch/i386/Kconfig	2004-07-20 21:03:30.000000000 +0200
@@ -865,6 +865,16 @@
 	generate incorrect output with certain kernel constructs when
 	-mregparm=3 is used.
 
+config 4KSTACKS
+	bool "Use 4Kb for kernel stacks instead of 8Kb"
+	depends on EXPERIMENTAL
+	help
+	  If you say Y here the kernel will use a 4Kb stacksize for the
+	  kernel stack attached to each process/thread. This facilitates
+	  running more threads on a system and also reduces the pressure
+	  on the VM subsystem for higher order allocations. This option
+	  will also use IRQ stacks to compensate for the reduced stackspace.
+
 endmenu
 
 
@@ -1289,15 +1299,6 @@
 	  If you don't debug the kernel, you can say N, but we may not be able
 	  to solve problems without frame pointers.
 
-config 4KSTACKS
-	bool "Use 4Kb for kernel stacks instead of 8Kb"
-	help
-	  If you say Y here the kernel will use a 4Kb stacksize for the
-	  kernel stack attached to each process/thread. This facilitates
-	  running more threads on a system and also reduces the pressure
-	  on the VM subsystem for higher order allocations. This option
-	  will also use IRQ stacks to compensate for the reduced stackspace.
-
 config X86_FIND_SMP_CONFIG
 	bool
 	depends on X86_LOCAL_APIC || X86_VOYAGER
--- linux-2.6.8-rc2-full/fs/Kconfig.old	2004-07-20 21:04:02.000000000 +0200
+++ linux-2.6.8-rc2-full/fs/Kconfig	2004-07-20 21:04:25.000000000 +0200
@@ -294,6 +294,7 @@
 
 config XFS_FS
 	tristate "XFS filesystem support"
+	depends on (4KSTACKS=n || BROKEN)
 	help
 	  XFS is a high performance journaling filesystem which originated
 	  on the SGI IRIX platform.  It is completely multi-threaded, can
