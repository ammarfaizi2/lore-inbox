Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271674AbRHQPiI>; Fri, 17 Aug 2001 11:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271676AbRHQPh6>; Fri, 17 Aug 2001 11:37:58 -0400
Received: from dfmail.f-secure.com ([194.252.6.39]:44561 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S271675AbRHQPht>; Fri, 17 Aug 2001 11:37:49 -0400
Date: Fri, 17 Aug 2001 18:51:40 +0300 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Justin A <justin@bouncybouncy.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATH] Trigger OOM handler through sysrq
In-Reply-To: <20010816233613.B23620@bouncybouncy.net>
Message-ID: <Pine.LNX.4.30.0108171757250.2660-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Justin,

On Thu, 16 Aug 2001, Justin A wrote:
> The below patch allows you to trigger the OOM handler rather then the
> generic SAK.

Hmm, does your patch work? You can't call oom_kill() from a non-task
context because it uses schedule(). I had a similar patch for
experiments long ago but can't find it. Anyway I think this solution
fixes the symptom, not the root of the problem, especially SysRq
is disabled in many places because of security reasons ....

.... but it's true it can be lifesaver in cases ;) The patch below works
for me. For people who are interested, see
/usr/src/linux/Documentation/sysrq.txt how to enable 'Magic SysRq keys'
and after you can use ALT-SysRQ-f whenever you want to free some
memory killing a process chosen by the kernel.

	Szaka


diff -ur linux.orig/drivers/char/sysrq.c linux/drivers/char/sysrq.c
--- linux.orig/drivers/char/sysrq.c	Fri Aug 17 00:58:32 2001
+++ linux/drivers/char/sysrq.c	Fri Aug 17 22:09:31 2001
@@ -28,6 +28,7 @@

 extern void reset_vc(unsigned int);
 extern struct list_head super_blocks;
+extern int sysrq_oom;

 /* Whether we react on sysrq keys or just ignore them */
 int sysrq_enabled = 1;
@@ -137,6 +138,11 @@
 		send_sig_all(SIGKILL, 1);
 		orig_log_level = 8;
 		break;
+	case 'f':					    /* F -- call out of memory killer */
+		printk("Trying to free some memory killing a \"bad\" process\n");
+	 	sysrq_oom = 1;
+		wakeup_kswapd();
+		break;
 	default:					    /* Unknown: help */
 		if (kbd)
 			printk("unRaw ");
@@ -147,7 +153,7 @@
 		printk("Boot ");
 		if (sysrq_power_off)
 			printk("Off ");
-		printk("Sync Unmount showPc showTasks showMem loglevel0-8 tErm kIll killalL\n");
+		printk("Sync Unmount showPc showTasks showMem loglevel0-8 tErm kIll killalL Freemem\n");
 		/* Don't use 'A' as it's handled specially on the Sparc */
 	}

diff -ur linux.orig/mm/vmscan.c linux/mm/vmscan.c
--- linux.orig/mm/vmscan.c	Fri Aug 17 03:01:33 2001
+++ linux/mm/vmscan.c	Fri Aug 17 22:03:51 2001
@@ -24,6 +24,8 @@

 #include <asm/pgalloc.h>

+int sysrq_oom = 0;
+
 /*
  * The "priority" of VM scanning is how much of the queues we
  * will scan in one go. A value of 6 for DEF_PRIORITY implies
@@ -925,6 +927,12 @@

 			/* Recalculate VM statistics. */
 			recalculate_vm_stats();
+		}
+
+		if (sysrq_oom) {
+			sysrq_oom = 0;
+			oom_kill();
+			continue;
 		}

 		if (!do_try_to_free_pages(GFP_KSWAPD, 1)) {



