Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272356AbTHEBIg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 21:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272342AbTHEBIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 21:08:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:19175 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272328AbTHEBIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 21:08:12 -0400
Date: Mon, 4 Aug 2003 18:13:04 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: torvalds@transmeta.com
cc: pavel@ucw.cz, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [BK PATCH] Power Management Updates
Message-ID: <Pine.LNX.4.44.0308041806060.23977-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, 

Here is a set of Power Management changes that contain the changes Pavel 
has been trying to push to you for a couple of weeks now. They have been 
split up into individual changesets and hand merged to be a bit cleaner 
than the original patches. 

These also contain initial efforts to start cleaning up swsusp by 
splitting out shareable functionality and moving the whole lot from 
kernel/suspend.c into kernel/power/*.c. 

The tree can be pulled from:

	bk://kernel.bkbits.net/home/mochel/linux-2.5-power

The changesets are described below. 

Individual patches can be viewed here: 

	http://developer.osdl.org/~mochel/patches/aug4/power/

I will not be sending them, as some of them are quite large (from moving 
files/directories). 

Pavel: please review and let me know if I missed anything important, so I 
can (quickly) fix it up. 

Thanks,


	-pat

 drivers/power/Makefile         |    2 
 drivers/power/process.c        |  120 ---
 drivers/power/swsusp.c         | 1179 ----------------------------------
 kernel/suspend.c               | 1281 --------------------------------------
 arch/i386/Kconfig              |   11 
 arch/i386/kernel/Makefile      |    2 
 arch/i386/kernel/suspend.c     |    6 
 arch/i386/kernel/suspend_asm.S |   26 
 arch/i386/kernel/sysenter.c    |    2 
 drivers/Makefile               |    2 
 drivers/acpi/Kconfig           |    4 
 drivers/acpi/sleep/main.c      |   12 
 drivers/base/power.c           |    6 
 drivers/power/Makefile         |    2 
 drivers/power/process.c        |  120 +++
 drivers/power/swsusp.c         | 1382 ++++++++++++++++++++++++++++++++++++++---
 include/linux/suspend.h        |   35 -
 kernel/Makefile                |    3 
 kernel/power/Makefile          |    4 
 kernel/power/console.c         |   40 +
 kernel/power/power.h           |    9 
 kernel/power/process.c         |  155 ++++
 kernel/power/swsusp.c          | 1268 +++++++++++++++++++++++++++++++++++--
 23 files changed, 2836 insertions(+), 2835 deletions(-)
-----

ChangeSet@1.1519, 2003-08-04 17:39:28-07:00, mochel@osdl.org
  [power] Make sure ACPI prepares a console during S3.
  
  Orginally from Pavel Machek.

 drivers/acpi/sleep/main.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)


ChangeSet@1.1518, 2003-08-04 17:35:30-07:00, mochel@osdl.org
  [power] Divorce suspend console code from swsusp.
  
  - Create kernel/power/console.c
  - Rename prepare_suspend_console() to pm_prepare_console() and 
    restore_console() to pm_restore_console().
  - Add prototypes to include/linux/suspend.h.
  - Make kernel/power/console.o dependent only on CONFIG_PM
  - Simplify logic for SUSPEND_CONSOLE define
  - Make software_resume() prepare console much earlier, so we can localize
    the loglevel variables in console.c. 
  - Remove #ifdef CONFIG_VT from console.c, and just check for SUSPEND_CONSOLE.
    (Perhaps we should make entire file dependent on CONFIG_VT_CONSOLE?)
  - Add kernel/power/power.h to share things across local files.

 include/linux/suspend.h |    4 +++
 kernel/power/Makefile   |    2 -
 kernel/power/console.c  |   40 ++++++++++++++++++++++++++++++
 kernel/power/power.h    |    9 ++++++
 kernel/power/swsusp.c   |   62 ++++++------------------------------------------
 5 files changed, 62 insertions(+), 55 deletions(-)


ChangeSet@1.1517, 2003-08-04 17:14:08-07:00, mochel@osdl.org
  [power] Minor swsusp cleanups.
  
  - Call blk_run_queues() from do_software_suspend() directly, instead of 
    wrapping it in helper function.
  - Get rid of ominous compiler warning. 
  - Change BUG_ON(in_interrupt()) to might_sleep() in software_suspend(), so
    we still get back trace, but don't actually BUG().
  
  Orginally from Pavel Machek.

 kernel/power/swsusp.c |   22 ++++------------------
 1 files changed, 4 insertions(+), 18 deletions(-)


ChangeSet@1.1516, 2003-08-04 16:08:22-07:00, mochel@osdl.org
  [power] Fix up refrigerator to work with ^Z-ed processes
  
  Originally from Pavel Machek: 
  
  schedule() added makes processes start at exactly that point, making
  printouts nicer.

 kernel/power/process.c |   35 +++++++++++++++++++++--------------
 1 files changed, 21 insertions(+), 14 deletions(-)


ChangeSet@1.1515, 2003-08-04 15:49:17-07:00, mochel@osdl.org
  [power] Kill some unnessecary printk()s. 
  
  From Pavel Machek.
  
  
  

 arch/i386/kernel/sysenter.c |    2 --
 drivers/acpi/sleep/main.c   |    2 +-
 drivers/base/power.c        |    6 ------
 kernel/power/swsusp.c       |    5 +----
 4 files changed, 2 insertions(+), 13 deletions(-)


ChangeSet@1.1514, 2003-08-04 15:45:48-07:00, mochel@osdl.org
  [power] Move drivers/power/ to kernel/power/

 drivers/power/Makefile  |    2 
 drivers/power/process.c |  120 ----
 drivers/power/swsusp.c  | 1179 ------------------------------------------------
 drivers/Makefile        |    1 
 kernel/Makefile         |    2 
 kernel/power/Makefile   |    2 
 kernel/power/process.c  |  120 ++++
 kernel/power/swsusp.c   | 1179 ++++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 1302 insertions(+), 1303 deletions(-)


ChangeSet@1.1511, 2003-07-17 19:33:59-07:00, mochel@osdl.org
  [power] Remove duplicate target. 

 arch/i386/kernel/Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


ChangeSet@1.1510, 2003-07-17 19:29:29-07:00, mochel@osdl.org
  [power] Make CONFIG_ACPI_SLEEP and CONFIG_SOFTWARE_SUSPEND independent. 
  
  - Each dependent on CONFIG_PM only.
  - From Pavel Machek.

 arch/i386/Kconfig    |   11 +++--------
 drivers/acpi/Kconfig |    4 ++--
 2 files changed, 5 insertions(+), 10 deletions(-)


ChangeSet@1.1509, 2003-07-17 19:28:09-07:00, mochel@osdl.org
  [power] Move saved_context_* variables.
  
  - From arch/i386/kernel/suspend_asm.S to arch/i386/kernel/suspend.c
  - Allows usage by both swsusp and ACPI independently on one another.

 arch/i386/kernel/suspend.c     |    6 ++++++
 arch/i386/kernel/suspend_asm.S |   26 --------------------------
 2 files changed, 6 insertions(+), 26 deletions(-)


ChangeSet@1.1508, 2003-07-17 19:26:48-07:00, mochel@osdl.org
  [power] Move process suspension functions to their own file.
  
  - Now in drivers/power/process.c
  - Make those functions only dependent on CONFIG_PM, not CONFIG_SOFTWARE_SUSPEND.

 drivers/power/Makefile  |    1 
 drivers/power/process.c |  120 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/swsusp.c  |  101 ----------------------------------------
 include/linux/suspend.h |   31 ++++++++----
 4 files changed, 143 insertions(+), 110 deletions(-)


ChangeSet@1.1507, 2003-07-17 18:50:02-07:00, mochel@osdl.org
  [power] Create drivers/power/
  
  Move kernel/suspend.c -> drivers/power/swsusp.c

 kernel/suspend.c       | 1281 -------------------------------------------------
 drivers/Makefile       |    1 
 drivers/power/Makefile |    1 
 drivers/power/swsusp.c | 1281 +++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/Makefile        |    1 
 5 files changed, 1283 insertions(+), 1282 deletions(-)



