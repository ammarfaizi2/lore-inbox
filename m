Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUKQOYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUKQOYR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 09:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUKQOYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 09:24:17 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:26340 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262331AbUKQOW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 09:22:58 -0500
Subject: PATCH (for comment): ide-cd possible race in PIO mode
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100697589.32677.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 17 Nov 2004 13:19:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Working on tracing down Fedora bug #115458
(https://bugzilla.redhat.com/bugzilla/process_bug.cgi) I found what
appears to be a race between the IDE CD driver and the hardware status.
It doesn't appear to explain the bug at all but it does look like a bug
of itself

When we issue an ide command the status bits don't become valid for
400nS. In the DMA case ide_execute_command handles this but in the PIO
case we don't do the needed locking, use OUTBSYNC to avoid posting or
delay. This means that in some situations we can execute the command
handler in PIO mode before the command status bits are valid and the
handler may read and act wrongly.

--- drivers/ide/ide-cd.c~	2004-11-17 14:08:42.950485320 +0000
+++ drivers/ide/ide-cd.c	2004-11-17 14:08:42.951485168 +0000
@@ -897,7 +897,10 @@
 		return ide_started;
 	} else {
 		/* packet command */
-		HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
+		spin_lock_irqsave(&ide_lock, flags);
+		HWIF(drive)->OUTBSYNC(WIN_PACKETCMD, IDE_COMMAND_REG);
+		ndelay(400);
+		spin_unlock_irqsave(&ide_lock, flags);
 		return (*handler) (drive);
 	}
 }

