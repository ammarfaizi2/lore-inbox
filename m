Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbTDXLRE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 07:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263111AbTDXLRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 07:17:04 -0400
Received: from [80.190.48.67] ([80.190.48.67]:30213 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262675AbTDXLQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 07:16:58 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.21-rc1 - unresolved
Date: Thu, 24 Apr 2003 13:27:39 +0200
User-Agent: KMail/1.5.1
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva> <200304220915.56757.m.c.p@wolk-project.de> <Pine.LNX.4.53L.0304231650300.7085@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.53L.0304231650300.7085@freak.distro.conectiva>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200304241320.52469.m.c.p@wolk-project.de>
X-PRIORITY: 2 (High)
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ro8p+0yxbTqgpAq"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_ro8p+0yxbTqgpAq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 23 April 2003 21:51, Marcelo Tosatti wrote:

Hi Marcelo,

> I'm sorry for not having looked into it, Marc. My inbox is not a very
> easily manageable thing.
> > Search the archives. I won't post it again and again and again and again
> > ^again^10.
> I will look into the archives. Thank you.
Don't waste your time with searching archives ;) Take the attached ones.

Explaination:

01. export 'proc_get_inode' symbol b/c it's unresolved in
    drivers/net/wan/comx.o

	Patch by: Andrea Arcangeli

02. export 'panic_notifier_list, panic_timeout' b/c it's unresolved in
    ipmi_msghandler.o and ipmi_watchdog.o

	Patch by: me

03. If a process cannot exit because it's stuck in eg. a driver, it
    doesn't make sense to have the OOM killer kill it repeatedly;
    that could lead to a hung system.

    Instead, kill another process if the first process we tried to
    kill hasn't made any move to exit within 5 seconds.  This way
    we have a much better chance of recovering the system.

	Patch by: Rik van Riel

    I can ack that this fixes the silly behaviour of the oom killer if the
    patch is _not_ applied. _With_ the patch, it works great.

--
ciao, Marc
--Boundary-00=_ro8p+0yxbTqgpAq
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="01_comx-driver-compile-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="01_comx-driver-compile-1.patch"

--- 2.4.19pre8aa2/fs/proc/root.c.~1~	Fri May  3 02:12:18 2002
+++ 2.4.19pre8aa2/fs/proc/root.c	Sat May  4 13:45:30 2002
@@ -145,3 +145,4 @@
 EXPORT_SYMBOL(proc_net);
 EXPORT_SYMBOL(proc_bus);
 EXPORT_SYMBOL(proc_root_driver);
+EXPORT_SYMBOL(proc_get_inode);

--Boundary-00=_ro8p+0yxbTqgpAq
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="03_oomkill-do-not-kill-same-process-repeatedly.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="03_oomkill-do-not-kill-same-process-repeatedly.patch"


If a process cannot exit because it's stuck in eg. a driver, it
doesn't make sense to have the OOM killer kill it repeatedly;
that could lead to a hung system.

Instead, kill another process if the first process we tried to
kill hasn't made any move to exit within 5 seconds.  This way
we have a much better chance of recovering the system.

Note: this patch applies without offset to both 2.4 and 2.5,
since oom_kill.c hasn't changed since about 2.4.14...

please apply,

Rik
-- 
Engineers don't grow up, they grow sideways.
http://www.surriel.com/		http://kernelnewbies.org/



===== mm/oom_kill.c 1.11 vs edited =====
--- 1.11/mm/oom_kill.c	Fri Aug 16 10:59:46 2002
+++ edited/mm/oom_kill.c	Sat Feb 22 17:31:49 2003
@@ -61,6 +61,9 @@

 	if (!p->mm)
 		return 0;
+
+	if (p->flags & PF_MEMDIE)
+		return 0;
 	/*
 	 * The memory size of the process is the basis for the badness.
 	 */

--Boundary-00=_ro8p+0yxbTqgpAq
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="02_ipmi-exported-symbols-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="02_ipmi-exported-symbols-fix.patch"

--- linux.orig/kernel/ksyms.c	Fri Dec  6 09:12:07 2002
+++ linux/kernel/ksyms.c	Fri Dec  6 09:13:01 2002
@@ -65,6 +65,8 @@
 extern int request_dma(unsigned int dmanr, char * deviceID);
 extern void free_dma(unsigned int dmanr);
 extern spinlock_t dma_spin_lock;
+extern int panic_timeout;
+
 
 #ifdef CONFIG_MODVERSIONS
 const struct module_symbol __export_Using_Versions
@@ -471,6 +471,8 @@
 
 /* misc */
 EXPORT_SYMBOL(panic);
+EXPORT_SYMBOL(panic_notifier_list);
+EXPORT_SYMBOL(panic_timeout);
 EXPORT_SYMBOL(__out_of_line_bug);
 EXPORT_SYMBOL(sprintf);
 EXPORT_SYMBOL(snprintf);

--Boundary-00=_ro8p+0yxbTqgpAq--

