Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265259AbTLaLZv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 06:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265261AbTLaLZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 06:25:50 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:7562 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S265259AbTLaLZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 06:25:47 -0500
Date: Wed, 31 Dec 2003 12:25:45 +0100
From: bert hubert <ahu@ds9a.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Molina <tmolina@cablespeed.com>, torvalds@osdl.org,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 performance problems
Message-ID: <20031231112545.GA3406@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Andrew Morton <akpm@osdl.org>,
	Thomas Molina <tmolina@cablespeed.com>, torvalds@osdl.org,
	wli@holomorphy.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain> <Pine.LNX.4.58.0312291420370.1586@home.osdl.org> <Pine.LNX.4.58.0312291755080.5835@localhost.localdomain> <Pine.LNX.4.58.0312291502210.1586@home.osdl.org> <Pine.LNX.4.58.0312300903170.2825@localhost.localdomain> <20031230143929.GN27687@holomorphy.com> <Pine.LNX.4.58.0312301524220.3152@localhost.localdomain> <Pine.LNX.4.58.0312301318540.2065@home.osdl.org> <Pine.LNX.4.58.0312301938060.3193@localhost.localdomain> <20031230173411.01d46876.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031230173411.01d46876.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> CONFIG_DEBUG_PAGEALLOC really does hurt on small machines.  Mainly because
> it rounds the size of all slab object which are >= 128 bytes up to a full
> 4k.  So things like inodes and dentries take vastly more memory.
> 
> The other debug options are less costly.

The patch below rationalizes the Kconfig documentation for the debugging
options a bit.

 * removed one occurence of 'don't enable on production systems' as this
   would imply that the other options are safe to enable on such systems.

 * added a general warning that performance may suffer (but that you should
   enable nonetheless in case of debugging), and two specific warnings, one
   for slab poisoning, a big one for page alloc debugging.

 * some spelling, added notice about /proc/sysrq-trigger to magic SysRQ

 * Removed warning about SysRQ 'only if you know what it does' - I often ask
   people to press alt-sysrq to get debugging information, only to find that
   they have it turned off, even when I would be able to understand the
   output.

Against 2.6.0 (path is wrong), please consider applying:

--- linux-2.6.0-test11/arch/i386/Kconfig.orig	Wed Dec 31 12:03:20 2003
+++ linux-2.6.0-test11/arch/i386/Kconfig	Wed Dec 31 12:16:01 2003
@@ -1131,7 +1131,8 @@
 	bool "Kernel debugging"
 	help
 	  Say Y here if you are developing drivers or trying to debug and
-	  identify kernel problems.
+	  identify kernel problems. Enabling these features often incurs
+	  a performance hit, but will help debug problems much faster.
 
 config DEBUG_STACKOVERFLOW
 	bool "Check for stack overflows"
@@ -1143,7 +1144,7 @@
 	help
 	  Say Y here to have the kernel do limited verification on memory
 	  allocation as well as poisoning memory on free to catch use of freed
-	  memory.
+	  memory. Hurts performance.
 
 config DEBUG_IOVIRT
 	bool "Memory mapped I/O debugging"
@@ -1166,9 +1167,9 @@
 	  immediately or dump some status information). This is accomplished
 	  by pressing various keys while holding SysRq (Alt+PrintScreen). It
 	  also works on a serial console (on PC hardware at least), if you
-	  send a BREAK and then within 5 seconds a command keypress. The
-	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
-	  unless you really know what this hack does.
+	  send a BREAK and then within 5 seconds a command keypress.
+	  Additionally, /proc/sysrq-trigger can be used. More documentation
+	  is in <file:Documentation/sysrq.txt>. 
 
 config DEBUG_SPINLOCK
 	bool "Spinlock debugging"
@@ -1180,19 +1181,18 @@
 	  deadlocks are also debuggable.
 
 config DEBUG_PAGEALLOC
-	bool "Page alloc debugging"
+	bool "Page alloc debugging (slow/resource intensive)"
 	depends on DEBUG_KERNEL
 	help
 	  Unmap pages from the kernel linear mapping after free_pages().
-	  This results in a large slowdown, but helps to find certain types
-	  of memory corruptions.
+	  This results in a large slowdown and requires a lot of memory,
+	  but helps to find certain types of memory corruptions.
 
 config DEBUG_HIGHMEM
 	bool "Highmem debugging"
 	depends on DEBUG_KERNEL && HIGHMEM
 	help
-	  This options enables addition error checking for high memory systems.
-	  Disable for production systems.
+	  This options enables additional error checking for high memory systems.
 
 config DEBUG_INFO
 	bool "Compile the kernel with debug info"


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
