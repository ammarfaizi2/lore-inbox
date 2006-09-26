Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWIZFwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWIZFwt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWIZFwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:52:15 -0400
Received: from mail.suse.de ([195.135.220.2]:51425 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751301AbWIZFiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:38:46 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 14/47] PM: PCI and IDE handle PM_EVENT_PRETHAW
Date: Mon, 25 Sep 2006 22:37:34 -0700
Message-Id: <11592491274168-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <1159249124371-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

Convert some framework code to handle the new PRETHAW message.

  - IDE just treats it like a FREEZE.

  - The pci_choose_state() thingie still doesn't use PCI_D0 when it gets a
    FREEZE (and now PRETHAW) event, which seems rather buglike but wasn't
    something to change with this patch.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/ide/ide.c |    6 ++++--
 drivers/pci/pci.c |    4 +++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index defd4b4..9c8468d 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1207,7 +1207,7 @@ int system_bus_clock (void)
 
 EXPORT_SYMBOL(system_bus_clock);
 
-static int generic_ide_suspend(struct device *dev, pm_message_t state)
+static int generic_ide_suspend(struct device *dev, pm_message_t mesg)
 {
 	ide_drive_t *drive = dev->driver_data;
 	struct request rq;
@@ -1221,7 +1221,9 @@ static int generic_ide_suspend(struct de
 	rq.special = &args;
 	rq.end_io_data = &rqpm;
 	rqpm.pm_step = ide_pm_state_start_suspend;
-	rqpm.pm_state = state.event;
+	if (mesg.event == PM_EVENT_PRETHAW)
+		mesg.event = PM_EVENT_FREEZE;
+	rqpm.pm_state = mesg.event;
 
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9f79dd6..8ab0278 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -432,10 +432,12 @@ pci_power_t pci_choose_state(struct pci_
 	case PM_EVENT_ON:
 		return PCI_D0;
 	case PM_EVENT_FREEZE:
+	case PM_EVENT_PRETHAW:
+		/* REVISIT both freeze and pre-thaw "should" use D0 */
 	case PM_EVENT_SUSPEND:
 		return PCI_D3hot;
 	default:
-		printk("They asked me for state %d\n", state.event);
+		printk("Unrecognized suspend event %d\n", state.event);
 		BUG();
 	}
 	return PCI_D0;
-- 
1.4.2.1

