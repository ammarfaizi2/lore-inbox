Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268483AbUJGVud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268483AbUJGVud (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268301AbUJGVsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:48:51 -0400
Received: from smtp09.auna.com ([62.81.186.19]:43666 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S267555AbUJGVqq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:46:46 -0400
Date: Thu, 07 Oct 2004 21:46:37 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.9-rc3-mm3
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>
References: <20041007015139.6f5b833b.akpm@osdl.org>
	<200410071041.20723.sandersn@btinternet.com>
	<20041007025007.77ec1a44.akpm@osdl.org>
	<20041007114040.GV9106@holomorphy.com>
	<1097184341l.10532l.0l@werewolf.able.es>
In-Reply-To: <1097184341l.10532l.0l@werewolf.able.es> (from
	jamagallon@able.es on Thu Oct  7 23:25:41 2004)
X-Mailer: Balsa 2.2.5
Message-Id: <1097185597l.10532l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.10.07, J.A. Magallon wrote:
> 
> This conflicts with kernel/irq/proc.c:
> 
> 	unsigned long prof_cpu_mask = -1;
> 
> Shouldn't this be:
> 
> 	cpumask_t prof_cpu_mask = CPU_MASK_NONE;
> 
> This will show problems when NR_CPUS > sizeof(long)....
> 

Err....

There is a problem with this -mm:

line 422185:

--- /dev/null   2003-09-15 06:40:47.000000000 -0700
+++ 25/kernel/irq/proc.c    2004-10-07 00:39:41.626877840 -0700
@@ -0,0 +1,183 @@
+/*
+ * linux/kernel/irq/proc.c
+ *
+ * Copyright (C) 1992, 1998-2004 Linus Torvalds, Ingo Molnar
+ *
+ * This file contains the /proc/irq/ handling code.
+ */
+
+#include <linux/irq.h>
+#include <linux/proc_fs.h>
+#include <linux/interrupt.h>
+
+unsigned long prof_cpu_mask = -1;
+
 ^^^^ ^^^^^^^^^^ ^^^^^^^^^^^^^  ^

And then:

line 426061:
--- linux-2.6.9-rc3/kernel/profile.c    2004-09-30 12:56:52.000000000 -0700
+++ 25/kernel/profile.c 2004-10-07 00:41:51.898073608 -0700
...
 static int prof_on;
 static cpumask_t prof_cpu_mask = CPU_MASK_ALL;
+#ifdef CONFIG_SMP

If you do the change I proposed before:

  LD      kernel/built-in.o
kernel/irq/built-in.o(.bss+0x20): multiple definition of `prof_cpu_mask'
kernel/profile.o(.data+0x0): first defined here
make[1]: *** [kernel/built-in.o] Error 1
make: *** [kernel] Error 2

And, for example:
werewolf:/usr/src/linux# grep -r "int prof_cpu_mask_read_proc" *
arch/m32r/kernel/irq.c:static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
kernel/profile.c:static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
kernel/irq/proc.c:static int prof_cpu_mask_read_proc(char *page, char **start, off_t off,

Duplicate code ?
the profile.c is in -rc3, and -mm3 adds the one in irq/proc.c.

???

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc3-mm2 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #2


