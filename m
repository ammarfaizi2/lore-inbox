Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130479AbRCDLN4>; Sun, 4 Mar 2001 06:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130480AbRCDLNr>; Sun, 4 Mar 2001 06:13:47 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:3825 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130479AbRCDLNd>; Sun, 4 Mar 2001 06:13:33 -0500
Message-ID: <3AA22364.9253CF49@uow.edu.au>
Date: Sun, 04 Mar 2001 22:13:40 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] perform reboot notification in process context
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ctrl_alt_del() is called from hard interrupt context.
It traverses the reboot_notifier_list.  Many of the
callouts on that list are not designed to be called
in this context.

DAC960_Finalise()
        Calls remove_proc_entry() within interrupt context.
        remove_proc_entry uses spin_lock()s.
	Can deadlock.

drivers/char/sbc60xxwdt.c:sbc60xxwdt_unload()
        Calls misc_deregister which calls down().

drivers/i2o/i2o_core.c
        calls i2o_post_wait()
        calls i2o_reset_controller()

        Both of these schedule().  Crashes every time.

drivers/scsi/gdth.c
        gdth_halt()
        calls gdth_do_cmd
                does down().


This patch makes keventd do the callout.


--- linux-2.4.3-pre1/kernel/sys.c	Tue Oct 17 06:58:51 2000
+++ linux-akpm/kernel/sys.c	Sun Mar  4 22:04:57 2001
@@ -330,6 +330,12 @@
 	return 0;
 }
 
+static void deferred_cad(void *dummy)
+{
+	notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
+	machine_restart(NULL);
+}
+
 /*
  * This function gets called by ctrl-alt-del - ie the keyboard interrupt.
  * As it's called within an interrupt, it may NOT sync: the only choice
@@ -337,10 +343,13 @@
  */
 void ctrl_alt_del(void)
 {
-	if (C_A_D) {
-		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
-		machine_restart(NULL);
-	} else
+	static struct tq_struct cad_tq = {
+		routine: deferred_cad,
+	};
+
+	if (C_A_D)
+		schedule_task(&cad_tq);
+	else
 		kill_proc(1, SIGINT, 1);
 }
