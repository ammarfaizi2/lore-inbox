Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbWFUTt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbWFUTt6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbWFUTt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:49:57 -0400
Received: from cantor2.suse.de ([195.135.220.15]:18074 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030252AbWFUTtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:49:53 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 14/22] [PATCH] remove duplication from Documentation/power/devices.txt
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 21 Jun 2006 12:45:57 -0700
Message-Id: <11509192081167-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11509192043044-git-send-email-greg@kroah.com>
References: <20060621194511.GA23982@kroah.com> <11509191652021-git-send-email-greg@kroah.com> <11509191682051-git-send-email-greg@kroah.com> <11509191721672-git-send-email-greg@kroah.com> <1150919175882-git-send-email-greg@kroah.com> <11509191781796-git-send-email-greg@kroah.com> <11509191812079-git-send-email-greg@kroah.com> <115091918546-git-send-email-greg@kroah.com> <11509191893358-git-send-email-greg@kroah.com> <1150919192294-git-send-email-greg@kroah.com> <11509191951525-git-send-email-greg@kroah.com> <11509191982588-git-send-email-greg@kroah.com> <11509192022315-git-send-email-greg@kroah.com> <11509192043044-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

Remove a chunk of duplicated documentation text.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 Documentation/power/devices.txt |   90 ---------------------------------------
 1 files changed, 0 insertions(+), 90 deletions(-)

diff --git a/Documentation/power/devices.txt b/Documentation/power/devices.txt
index f987afe..fba1e05 100644
--- a/Documentation/power/devices.txt
+++ b/Documentation/power/devices.txt
@@ -135,96 +135,6 @@ # NOTIFICATION -- pretty much same as ON
 
 FREEZE -- stop DMA and interrupts, and be prepared to reinit HW from
 scratch. That probably means stop accepting upstream requests, the
-actual policy of what to do with them beeing specific to a given
-driver. It's acceptable for a network driver to just drop packets
-while a block driver is expected to block the queue so no request is
-lost. (Use IDE as an example on how to do that). FREEZE requires no
-power state change, and it's expected for drivers to be able to
-quickly transition back to operating state.
-
-SUSPEND -- like FREEZE, but also put hardware into low-power state. If
-there's need to distinguish several levels of sleep, additional flag
-is probably best way to do that.
-
-Transitions are only from a resumed state to a suspended state, never
-between 2 suspended states. (ON -> FREEZE or ON -> SUSPEND can happen,
-FREEZE -> SUSPEND or SUSPEND -> FREEZE can not).
-
-All events are:
-
-[NOTE NOTE NOTE: If you are driver author, you should not care; you
-should only look at event, and ignore flags.]
-
-#Prepare for suspend -- userland is still running but we are going to
-#enter suspend state. This gives drivers chance to load firmware from
-#disk and store it in memory, or do other activities taht require
-#operating userland, ability to kmalloc GFP_KERNEL, etc... All of these
-#are forbiden once the suspend dance is started.. event = ON, flags =
-#PREPARE_TO_SUSPEND
-
-Apm standby -- prepare for APM event. Quiesce devices to make life
-easier for APM BIOS. event = FREEZE, flags = APM_STANDBY
-
-Apm suspend -- same as APM_STANDBY, but it we should probably avoid
-spinning down disks. event = FREEZE, flags = APM_SUSPEND
-
-System halt, reboot -- quiesce devices to make life easier for BIOS. event
-= FREEZE, flags = SYSTEM_HALT or SYSTEM_REBOOT
-
-System shutdown -- at least disks need to be spun down, or data may be
-lost. Quiesce devices, just to make life easier for BIOS. event =
-FREEZE, flags = SYSTEM_SHUTDOWN
-
-Kexec    -- turn off DMAs and put hardware into some state where new
-kernel can take over. event = FREEZE, flags = KEXEC
-
-Powerdown at end of swsusp -- very similar to SYSTEM_SHUTDOWN, except wake
-may need to be enabled on some devices. This actually has at least 3
-subtypes, system can reboot, enter S4 and enter S5 at the end of
-swsusp. event = FREEZE, flags = SWSUSP and one of SYSTEM_REBOOT,
-SYSTEM_SHUTDOWN, SYSTEM_S4
-
-Suspend to ram  -- put devices into low power state. event = SUSPEND,
-flags = SUSPEND_TO_RAM
-
-Freeze for swsusp snapshot -- stop DMA and interrupts. No need to put
-devices into low power mode, but you must be able to reinitialize
-device from scratch in resume method. This has two flavors, its done
-once on suspending kernel, once on resuming kernel. event = FREEZE,
-flags = DURING_SUSPEND or DURING_RESUME
-
-Device detach requested from /sys -- deinitialize device; proably same as
-SYSTEM_SHUTDOWN, I do not understand this one too much. probably event
-= FREEZE, flags = DEV_DETACH.
-
-#These are not really events sent:
-#
-#System fully on -- device is working normally; this is probably never
-#passed to suspend() method... event = ON, flags = 0
-#
-#Ready after resume -- userland is now running, again. Time to free any
-#memory you ate during prepare to suspend... event = ON, flags =
-#READY_AFTER_RESUME
-#
-
-
-pm_message_t meaning
-
-pm_message_t has two fields. event ("major"), and flags.  If driver
-does not know event code, it aborts the request, returning error. Some
-drivers may need to deal with special cases based on the actual type
-of suspend operation being done at the system level. This is why
-there are flags.
-
-Event codes are:
-
-ON -- no need to do anything except special cases like broken
-HW.
-
-# NOTIFICATION -- pretty much same as ON?
-
-FREEZE -- stop DMA and interrupts, and be prepared to reinit HW from
-scratch. That probably means stop accepting upstream requests, the
 actual policy of what to do with them being specific to a given
 driver. It's acceptable for a network driver to just drop packets
 while a block driver is expected to block the queue so no request is
-- 
1.4.0

