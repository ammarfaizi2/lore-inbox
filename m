Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266689AbUHCULz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266689AbUHCULz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 16:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266720AbUHCULz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 16:11:55 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:55550 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266689AbUHCULv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 16:11:51 -0400
Date: Tue, 3 Aug 2004 22:11:44 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       xfs-masters@oss.sgi.com, linux-xfs@oss.sgi.com
Subject: Re: [2.6 patch] let 4KSTACKS depend on EXPERIMENTAL (fwd)
Message-ID: <20040803201143.GE2746@fs.tum.de>
References: <20040802225951.GR2746@fs.tum.de> <20040802162846.3929e463.akpm@osdl.org> <20040803004509.GW2746@fs.tum.de> <1091490958.1647.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091490958.1647.25.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 12:56:01AM +0100, Alan Cox wrote:
> On Maw, 2004-08-03 at 01:45, Adrian Bunk wrote:
> > OTOH, at least XFS is known to have problems with 4kb stacks - and you 
> > don't want such problems to occur in production environments.
> 
> So put && !4KSTACKS in the XFS configuration ?


The patch below does exactly this.

The 4KSTACKS option has to be moved for that it's asked before XFS in
"make config".

diffstat output:
 arch/i386/Kconfig |   18 +++++++++---------
 fs/Kconfig        |    1 +
 2 files changed, 10 insertions(+), 9 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc2-full/arch/i386/Kconfig.old	2004-07-20 21:00:32.000000000 +0200
+++ linux-2.6.8-rc2-full/arch/i386/Kconfig	2004-07-20 21:03:30.000000000 +0200
@@ -865,6 +865,15 @@
 	generate incorrect output with certain kernel constructs when
 	-mregparm=3 is used.
 
+config 4KSTACKS
+	bool "Use 4Kb for kernel stacks instead of 8Kb"
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
