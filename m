Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUDSQv6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 12:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbUDSQv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 12:51:58 -0400
Received: from gprs214-2.eurotel.cz ([160.218.214.2]:57987 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261451AbUDSQvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 12:51:16 -0400
Date: Mon, 19 Apr 2004 18:51:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Cc: seife@suse.de
Subject: Big problems in acpi/event.c (needs seq_printf?)
Message-ID: <20040419165103.GA27589@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

acpi/event.c needs some heavy facelifting.

This one is needed so that return value (ERESTARTSYS) is propagated
from bus_receive_event(). If this is not done, suspend/resume causes
cat /proc/acpi/event to fail with -EIO. Please apply.

However, there are more problems with event.c:

* it uses spinlock_irq to protect event_is_open(). That's huge
overkill, atomic_t should be enough here, and it is never accessed
from interrupt anyway.

* its racy w.r.t. concurent readers (and yes, you *can* have concurent
readers, think threads). acpi_system_read_event() uses static
variables, without any locking. Probably seq_printf() converstion is
needed.
								Pavel

--- clean/drivers/acpi/event.c	2003-02-15 18:51:16.000000000 +0100
+++ linux/drivers/acpi/event.c	2004-04-19 18:43:58.000000000 +0200
@@ -63,9 +58,8 @@
 			return_VALUE(-EAGAIN);
 
 		result = acpi_bus_receive_event(&event);
-		if (result) {
-			return_VALUE(-EIO);
-		}
+		if (result)
+			return_VALUE(result);
 
 		chars_remaining = sprintf(str, "%s %s %08x %08x\n", 
 			event.device_class?event.device_class:"<unknown>",

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
