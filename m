Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUAYTxN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 14:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265243AbUAYTvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 14:51:02 -0500
Received: from mail.gmx.de ([213.165.64.20]:54205 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265244AbUAYTu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 14:50:27 -0500
X-Authenticated: #11949556
From: Michael Schierl <schierlm-usenet@gmx.de>
Subject: [PATCH] [APM] Is this the correct way to fix suspend bug introduced in 2.6.0-test4?
To: fr@canb.auug.org.au, linux-laptop@vger.kernel.org
CC: linux-kernel@vger.kernel.org, mochel@digitalimplant.org
User-Agent: 40tude_Dialog/2.0.10.1de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Reply-To: schierlm@gmx.de
Date: Sun, 25 Jan 2004 20:50:38 +0100
Message-ID: <13zy7qdcyz1q7$.50e5l3rpbsyx$.dlg@40tude.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the patch below (against 2.6.1-mm5) fixes my APM problems (my laptop, Acer
TravelMate 210TEV (Celeron 700, 128 MB RAM), hangs after resuming from APM
since 2.6.0-test4).

I found the "fix" by trying to "reversely" backport the changes from
patch-2.6.0-test4.bz2 into 2.6.1-mm5 (the old device_suspend code calls
sysdev_suspend, the new one does not; so what do I lose if I call
sysdev_suspend myself?). This trial-and-error-approach finally led into the
patch below (which works great for me).

Most likely this is not the cleanest way to do this; but since I don't even
know what this sysdev_suspend does (except that it does something that
seems to be vital for making my laptop resume...), i don't know how to make
it better...

If you have any suggestions, tell me (or change it yourself and submit it),
if you think that's okay like that, please submit that to the guy who is
responsible for 2.6 (is it Linus or Andrew? did not follow lkml recently).

TIA,

Michael

PS: if possible, please CC me in yout replies

====== apm-bug-introduced-in-test4.patch ======
--- linux-2.6.1-mm5/arch/i386/kernel/apm.c.old	Sun Jan 25 14:48:27 2004
+++ linux-2.6.1-mm5/arch/i386/kernel/apm.c	Sun Jan 25 16:10:43 2004
@@ -234,6 +234,9 @@ extern spinlock_t i8253_lock;
 extern unsigned long get_cmos_time(void);
 extern void machine_real_restart(unsigned char *, int);
 
+extern int sysdev_resume(void);
+extern int sysdev_suspend(u32 state);
+
 #if defined(CONFIG_APM_DISPLAY_BLANK) && defined(CONFIG_VT)
 extern int (*console_blank_hook)(int);
 #endif
@@ -1199,6 +1202,7 @@ static int suspend(int vetoable)
 	}
 
 	device_suspend(3);
+	sysdev_suspend(3);
 
 	/* serialize with the timer interrupt */
 	write_seqlock_irq(&xtime_lock);
@@ -1232,6 +1236,7 @@ static int suspend(int vetoable)
 	if (err != APM_SUCCESS)
 		apm_error("suspend", err);
 	err = (err == APM_SUCCESS) ? 0 : -EIO;
+	sysdev_resume();
 	device_resume();
 	pm_send_all(PM_RESUME, (void *)0);
 	queue_event(APM_NORMAL_RESUME, NULL);
@@ -1250,6 +1255,7 @@ static void standby(void)
 {
 	int	err;
 
+	sysdev_suspend(3);
 	/* serialize with the timer interrupt */
 	write_seqlock_irq(&xtime_lock);
 	/* If needed, notify drivers here */
@@ -1259,6 +1265,7 @@ static void standby(void)
 	err = set_system_power_state(APM_STATE_STANDBY);
 	if ((err != APM_SUCCESS) && (err != APM_NO_ERROR))
 		apm_error("standby", err);
+	sysdev_resume();
 }
 
 static apm_event_t get_event(void)
