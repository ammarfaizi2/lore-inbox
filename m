Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318202AbSHDSwn>; Sun, 4 Aug 2002 14:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318204AbSHDSwm>; Sun, 4 Aug 2002 14:52:42 -0400
Received: from [195.39.17.254] ([195.39.17.254]:16512 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S318203AbSHDSwg>;
	Sun, 4 Aug 2002 14:52:36 -0400
Date: Sun, 4 Aug 2002 20:54:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: S3 and swsusp: fixing device_resume order
Message-ID: <20020804185457.GA15103@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

pci driver's resume must not be called during RESUME_POWER_ON because
interrupts are still off and i8259A is not initialized [OHCI kills
machine in such case, cardbus probably too. PCI drivers just assume
initialized interrupts.]

Second hunk fixes device_resume calls to be okay according to
documentation. Please apply,
								Pavel


--- clean/drivers/pci/pci-driver.c	Thu Jul 25 22:21:15 2002
+++ linux-swsusp/drivers/pci/pci-driver.c	Sun Aug  4 18:23:27 2002
@@ -90,7 +90,11 @@
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 
 	if (pci_dev->driver) {
-		if (level == RESUME_POWER_ON && pci_dev->driver->resume)
+		/* We may not call PCI drivers resume at
+		   RESUME_POWER_ON because interrupts are not yet
+		   working at that point. Calling resume at
+		   RESUME_RESTORE_STATE seems like solution. */
+		if (level == RESUME_RESTORE_STATE && pci_dev->driver->resume)
 			pci_dev->driver->resume(pci_dev);
 	}
 	return 0;
--- clean/kernel/suspend.c	Sun Aug  4 20:19:49 2002
+++ linux-swsusp/kernel/suspend.c	Sun Aug  4 20:25:50 2002
@@ -619,8 +619,8 @@
 /* Make disk drivers accept operations, again */
 static void drivers_unsuspend(void)
 {
-	device_resume(RESUME_ENABLE);
 	device_resume(RESUME_RESTORE_STATE);
+	device_resume(RESUME_ENABLE);
 }
 
 /* Called from process context */
@@ -647,8 +647,8 @@
 static void drivers_resume(int flags)
 {
 	if (flags & RESUME_PHASE1) {
-		device_resume(RESUME_ENABLE);
 		device_resume(RESUME_RESTORE_STATE);
+		device_resume(RESUME_ENABLE);
 	}
   	if (flags & RESUME_PHASE2) {
 		if(pm_suspend_state) {

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
