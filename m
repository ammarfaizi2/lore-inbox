Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbTHZTMH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 15:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbTHZTMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 15:12:06 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:732 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S262913AbTHZTMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 15:12:02 -0400
Date: Tue, 26 Aug 2003 16:07:34 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Nick Pollitt <npollitt@sgi.comom>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4 avenrun values
Message-ID: <Pine.LNX.4.55L.0308261557190.18109@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In sysinfo there is a cli/sti around the reading of the avenrun
values.  On a UP system, this will prevent a timer tick/timer bh
from coming in and updating the values while they're being read.

However, on an SMP system, using the cli on some cpu other than
cpu0 will not stop the timer bh on cpu0 from updating the avenrun
values while they're being read by sysinfo.  Also, loadavg_read_proc
does no locking whatsoever.

Below is a patch that uses the xtime_lock around the writer and
both readers of the avenrun values.  Please apply.

--- 1.21/fs/proc/proc_misc.c    Mon Jul 14 13:10:30 2003
+++ edited/fs/proc/proc_misc.c  Fri Aug 22 16:28:37 2003
@@ -65,6 +65,7 @@
 #ifdef CONFIG_SGI_DS1286
 extern int get_ds1286_status(char *);
 #endif
+extern rwlock_t xtime_lock;

--- 1.2/kernel/info.c   Mon Feb  4 23:39:30 2002
+++ edited/kernel/info.c        Fri Aug 22 16:19:12 2003
@@ -13,13 +13,15 @@

 #include <asm/uaccess.h>

+extern rwlock_t xtime_lock;
+
 asmlinkage long sys_sysinfo(struct sysinfo *info)
 {
        struct sysinfo val;

        memset((char *)&val, 0, sizeof(struct sysinfo));

-       cli();
+       read_lock(&xtime_lock);

Shouldnt this be read_lock_irq() to avoid interrupts?

        val.uptime = jiffies / HZ;

        val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
@@ -27,7 +29,7 @@
        val.loads[2] = avenrun[2] << (SI_LOAD_SHIFT - FSHIFT);

        val.procs = nr_threads-1;
-       sti();
+       read_unlock(&xtime_lock);

        si_meminfo(&val);
        si_swapinfo(&val);

