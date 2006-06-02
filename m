Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbWFBTsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbWFBTsi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWFBTsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:48:17 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:43393 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932513AbWFBTql
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:46:41 -0400
Message-Id: <20060602194738.888394000@sous-sol.org>
References: <20060602194618.482948000@sous-sol.org>
Date: Fri, 02 Jun 2006 00:00:04 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgewood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org,
       johannes@sipsolutions.net, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 04/11] PowerMac: force only suspend-to-disk to be valid
Content-Disposition: inline; filename=powermac-force-only-suspend-to-disk-to-be-valid.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Johannes Berg <johannes@sipsolutions.net>

For a very long time, echoing 'standby' or 'mem' into /sys/power/state has
killed the machine on powerpc.  This patch fixes that.

This patch adds the .valid callback to pm_ops on PowerMac so that only the
suspend to disk state can be entered.  Note that just returning 0 would
suffice since the upper layers don't pass PM_SUSPEND_DISK down, but we
handle it there regardless just in case that changes.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 arch/powerpc/platforms/powermac/setup.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- linux-2.6.16.19.orig/arch/powerpc/platforms/powermac/setup.c
+++ linux-2.6.16.19/arch/powerpc/platforms/powermac/setup.c
@@ -456,11 +456,23 @@ static int pmac_pm_finish(suspend_state_
 	return 0;
 }
 
+static int pmac_pm_valid(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_DISK:
+		return 1;
+	/* can't do any other states via generic mechanism yet */
+	default:
+		return 0;
+	}
+}
+
 static struct pm_ops pmac_pm_ops = {
 	.pm_disk_mode	= PM_DISK_SHUTDOWN,
 	.prepare	= pmac_pm_prepare,
 	.enter		= pmac_pm_enter,
 	.finish		= pmac_pm_finish,
+	.valid		= pmac_pm_valid,
 };
 
 #endif /* CONFIG_SOFTWARE_SUSPEND */

--
