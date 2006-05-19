Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWESSq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWESSq4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 14:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbWESSqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 14:46:55 -0400
Received: from outmx020.isp.belgacom.be ([195.238.4.201]:39588 "EHLO
	outmx020.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S964794AbWESSqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 14:46:54 -0400
Date: Fri, 19 May 2006 20:46:37 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ben Dooks <ben-linux@fluff.org>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>
Subject: [WATCHDOG] v2.6.17-rc4 watchdog patches
Message-ID: <20060519184637.GA4349@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from 'master' branch of
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git

This will update the following files:

 Documentation/watchdog/watchdog-api.txt |    3 +++
 drivers/char/watchdog/i8xx_tco.c        |   16 +++++-----------
 drivers/char/watchdog/s3c2410_wdt.c     |    6 ++++++
 drivers/char/watchdog/sc1200wdt.c       |    2 +-
 4 files changed, 15 insertions(+), 12 deletions(-)

with these Changes:

Author: Ben Dooks <ben-linux@fluff.org>
Date:   Wed Apr 19 23:02:56 2006 +0100

    [WATCHDOG] s3c2410_wdt.c stop watchdog after boot
    
    If the s3c2410 watchdog timer is not enabled by
    the driver at startup, ensure that it is stopped
    in-case the boot process has enabled it.
    
    Signed-off-by: Ben Dooks <ben-linux@fluff.org>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sun Apr 16 12:52:35 2006 +0200

    [WATCHDOG] i8xx_tco.c - remove support for ICH6 + ICH7
    
    Temporary remove support for ICH6 + ICH7. In these newer TCO's
    the watchdog timer has changed: the TCO_TMR register is not at
    the TCOBASE+0x1 offset, but changed it's place to TCOBASE+0x12
    and became 10 bit long [0:9]. (Kernel BUG 6031).
    
    ICH6 + ICH7 support will be added in a new driver. Code is
    under test.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    

Author: Randy Dunlap <rdunlap@xenotime.net>
Date:   Tue Apr 4 20:17:26 2006 -0700

    [WATCHDOG] Documentation/watchdog/watchdog-api.txt - fix watchdog daemon
    
    Fix the simple watchdog daemon program in Doc/watchdog/watchdog-api.txt
    to build cleanly.
    
    Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    

Author: Dave Jones <davej@redhat.com>
Date:   Mon Apr 3 16:04:48 2006 -0700

    [WATCHDOG] sc1200wdt.c printk fix
    
    Fix printk output.
    
    sc1200wdt: build 20020303<3>sc1200wdt: io parameter must be specified
    
    Signed-off-by: Dave Jones <davej@redhat.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    


The Changes can also be looked at on:
	http://www.kernel.org/git/?p=linux/kernel/git/wim/linux-2.6-watchdog.git;a=summary

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/Documentation/watchdog/watchdog-api.txt b/Documentation/watchdog/watchdog-api.txt
index c5beb54..21ed511 100644
--- a/Documentation/watchdog/watchdog-api.txt
+++ b/Documentation/watchdog/watchdog-api.txt
@@ -36,6 +36,9 @@ timeout or margin.  The simplest way to 
 some data to the device.  So a very simple watchdog daemon would look
 like this:
 
+#include <stdlib.h>
+#include <fcntl.h>
+
 int main(int argc, const char *argv[]) {
 	int fd=open("/dev/watchdog",O_WRONLY);
 	if (fd==-1) {
diff --git a/drivers/char/watchdog/i8xx_tco.c b/drivers/char/watchdog/i8xx_tco.c
index a13395e..fa2ba9e 100644
--- a/drivers/char/watchdog/i8xx_tco.c
+++ b/drivers/char/watchdog/i8xx_tco.c
@@ -33,11 +33,6 @@
  *	82801E   (C-ICH)  : document number 273599-001, 273645-002,
  *	82801EB  (ICH5)   : document number 252516-001, 252517-003,
  *	82801ER  (ICH5R)  : document number 252516-001, 252517-003,
- *	82801FB  (ICH6)   : document number 301473-002, 301474-007,
- *	82801FR  (ICH6R)  : document number 301473-002, 301474-007,
- *	82801FBM (ICH6-M) : document number 301473-002, 301474-007,
- *	82801FW  (ICH6W)  : document number 301473-001, 301474-007,
- *	82801FRW (ICH6RW) : document number 301473-001, 301474-007
  *
  *  20000710 Nils Faerber
  *	Initial Version 0.01
@@ -66,6 +61,10 @@
  *  20050807 Wim Van Sebroeck <wim@iguana.be>
  *	0.08 Make sure that the watchdog is only "armed" when started.
  *	     (Kernel Bug 4251)
+ *  20060416 Wim Van Sebroeck <wim@iguana.be>
+ *	0.09 Remove support for the ICH6, ICH6R, ICH6-M, ICH6W and ICH6RW and
+ *	     ICH7 chipsets. (See Kernel Bug 6031 - other code will support these
+ *	     chipsets)
  */
 
 /*
@@ -90,7 +89,7 @@
 #include "i8xx_tco.h"
 
 /* Module and version information */
-#define TCO_VERSION "0.08"
+#define TCO_VERSION "0.09"
 #define TCO_MODULE_NAME "i8xx TCO timer"
 #define TCO_DRIVER_NAME   TCO_MODULE_NAME ", v" TCO_VERSION
 #define PFX TCO_MODULE_NAME ": "
@@ -391,11 +390,6 @@ static struct pci_device_id i8xx_tco_pci
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_12,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801E_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_0,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_1,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_2,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_0,	PCI_ANY_ID, PCI_ANY_ID, },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_1,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_1,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },			/* End of list */
 };
diff --git a/drivers/char/watchdog/s3c2410_wdt.c b/drivers/char/watchdog/s3c2410_wdt.c
index 9dc5473..1ea04e9 100644
--- a/drivers/char/watchdog/s3c2410_wdt.c
+++ b/drivers/char/watchdog/s3c2410_wdt.c
@@ -423,6 +423,12 @@ static int s3c2410wdt_probe(struct platf
 	if (tmr_atboot && started == 0) {
 		printk(KERN_INFO PFX "Starting Watchdog Timer\n");
 		s3c2410wdt_start();
+	} else if (!tmr_atboot) {
+		/* if we're not enabling the watchdog, then ensure it is
+		 * disabled if it has been left running from the bootloader
+		 * or other source */
+
+		s3c2410wdt_stop();
 	}
 
 	return 0;
diff --git a/drivers/char/watchdog/sc1200wdt.c b/drivers/char/watchdog/sc1200wdt.c
index 515ce75..20b88f9 100644
--- a/drivers/char/watchdog/sc1200wdt.c
+++ b/drivers/char/watchdog/sc1200wdt.c
@@ -377,7 +377,7 @@ static int __init sc1200wdt_init(void)
 {
 	int ret;
 
-	printk(banner);
+	printk("%s\n", banner);
 
 	spin_lock_init(&sc1200wdt_lock);
 	sema_init(&open_sem, 1);
