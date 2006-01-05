Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWAEEwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWAEEwV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 23:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWAEEwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 23:52:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40074 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751037AbWAEEwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 23:52:20 -0500
Date: Wed, 4 Jan 2006 23:52:12 -0500
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: oops pauser.
Message-ID: <20060105045212.GA15789@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my quest to get better debug data from users in Fedora bug reports,
I came up with this patch.  A majority of users don't have serial
consoles, so when an oops scrolls off the top of the screen,
and locks up, they usually end up reporting a 2nd (or later) oops
that isn't particularly helpful (or worse, some inconsequential
info like 'sleeping whilst atomic' warnings)

With this patch, if we oops, there's a pause for a two minutes..
which hopefully gives people enough time to grab a digital camera
to take a screenshot of the oops.

It has an on-screen timer so the user knows what's going on,
(and that it's going to come back to life [maybe] after the oops).

The one case this doesn't catch is the problem of oopses whilst
in X. Previously a non-fatal oops would stall X momentarily,
and then things continue. Now those cases will lock up completely
for two minutes. Future patches could add some additional feedback
during this 'stall' such as the blinky keyboard leds, or periodic speaker beeps.

Signed-off-by: Dave Jones <davej@redhat.com>

--- vanilla/arch/i386/kernel/traps.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/arch/i386/kernel/traps.c	2006-01-04 23:42:46.000000000 -0500
@@ -256,6 +271,15 @@ void show_registers(struct pt_regs *regs
 		}
 	}
 	printk("\n");
+	{
+		int i;
+		for (i=120;i>0;i--) {
+			mdelay(1000);
+			touch_nmi_watchdog();
+			printk("Continuing in %d seconds. \r", i);
+		}
+		printk("\n");
+	}
 }	
 
 static void handle_BUG(struct pt_regs *regs)
