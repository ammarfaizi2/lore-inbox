Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbUBOKqP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 05:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264457AbUBOKqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 05:46:14 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:21511 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S264455AbUBOKqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 05:46:13 -0500
Date: Sun, 15 Feb 2004 11:40:16 +0100
From: Willy Tarreau <willy@w.ods.org>
To: len.brown@intel.com
Cc: marcelo.tosatti@cyclades.com.br, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH] fix ACPI poweroff in 2.4.25-rc2
Message-ID: <20040215104016.GA22576@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Len,

based on your suggestions, I've read several bug reports about poweroff
problems. I discovered that some people had to pass "nolapic" to make it
operational. I tried the same on my VAIO and it worked. I also found that
other people had to call the old acpi_suspend(ACPI_STATE_S5) code instead
of the new one in acpi_power_off().

So I compared acpi_suspend() with the new code, and noticed that acpi_suspend()
calls acpi_system_save_state() before doing acpi_enter_sleep_state_prep(). This
function is responsible for sending PM events to all system devices, it seems.
Thus, I inserted this call in acpi_poweroff() and it now works (on the VAIO
at least). Does it make sense ? I have yet to test it on other systems, but
if people with poweroff problems could try this patch on top of 2.4.25-rc2,
it would be interesting. Perhaps it could get its way into mainline before
2.4.25 ? Please note that with this one, it's no longer necessary to use
"nolapic" on the command line (for my notebook at least).

Regards,
Willy

--- linux-2.4.25-rc2/drivers/acpi/system.c	Wed Nov 19 15:31:22 2003
+++ linux-2.4.25-rc2-acpi/drivers/acpi/system.c	Sun Feb 15 11:38:17 2004
@@ -95,6 +95,7 @@
 {
 	if (unlikely(in_interrupt())) 
 		BUG();
+	acpi_system_save_state(ACPI_STATE_S5);
 	acpi_enter_sleep_state_prep(ACPI_STATE_S5);
 	ACPI_DISABLE_IRQS();
 	acpi_enter_sleep_state(ACPI_STATE_S5);

