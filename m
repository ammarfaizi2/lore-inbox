Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264346AbUHTJ2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbUHTJ2W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 05:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265099AbUHTJ2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 05:28:22 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:53733 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S264346AbUHTJ2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 05:28:12 -0400
Date: Fri, 20 Aug 2004 11:28:25 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [WATCHDOG] v2.6.8.1 - watchdog-patches
Message-ID: <20040820092825.GO4908@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.6-watchdog-mm

This will update the following files:

 Documentation/watchdog/pcwd-watchdog.txt |    3 ++-
 drivers/char/watchdog/cpu5wdt.c          |    3 ++-
 drivers/char/watchdog/ib700wdt.c         |    1 +
 drivers/char/watchdog/indydog.c          |    1 +
 drivers/char/watchdog/ixp4xx_wdt.c       |    1 +
 drivers/char/watchdog/machzwd.c          |    1 +
 drivers/char/watchdog/mixcomwd.c         |    1 +
 drivers/char/watchdog/sa1100_wdt.c       |    1 +
 drivers/char/watchdog/sc1200wdt.c        |    1 +
 drivers/char/watchdog/scx200_wdt.c       |    1 +
 drivers/char/watchdog/wdt285.c           |    1 +
 drivers/char/watchdog/wdt977.c           |    1 +
 include/linux/compat_ioctl.h             |    6 ++++--
 13 files changed, 18 insertions(+), 4 deletions(-)

through these ChangeSets:

<arnd@arndb.de> (04/08/20 1.1838)
   [WATCHDOG] v2.6.8.1 compat_ioctl-patch
   
   The watchdog ioctl interface is defined correctly for 32 bit emulation,
   although WIOC_GETSUPPORT was not marked as such, for an unclear reason.
   WDIOC_SETTIMEOUT and WDIOC_GETTIMEOUT were added in may 2002 to the
   code but never to the ioctl list. This adds all three definitions.
   
   Signed-off-by: Arnd Bergmann <arnd@arndb.de>
   Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

<fl@fl.priv.at> (04/08/20 1.1839)
   [WATCHDOG] pcwd-watchdog.txt-patch
   
   Fix example program in pcwd-watchdog.txt document.

<wim@iguana.be> (04/08/20 1.1840)
   [WATCHDOG] v2.6.8.1 cpu5wdt.c-nonseekable_open-patch
   
   cpu5wdt also contains a VFS and thus should be "nonseekable_open"

<wim@iguana.be> (04/08/20 1.1841)
   [WATCHDOG] v2.6.8.1 watchdog-llseek-patch
   
   The watchdog drivers use a VFS implementation and thus should not be
   lseek'able, so we put a '.llseek = no_llseek' in the file_operations
   structure.


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog-mm

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/include/linux/compat_ioctl.h b/include/linux/compat_ioctl.h
--- a/include/linux/compat_ioctl.h	2004-08-20 11:23:33 +02:00
+++ b/include/linux/compat_ioctl.h	2004-08-20 11:23:33 +02:00
@@ -592,13 +592,15 @@
 COMPATIBLE_IOCTL(ATMTCP_REMOVE)
 COMPATIBLE_IOCTL(ATMMPC_CTRL)
 COMPATIBLE_IOCTL(ATMMPC_DATA)
-/* Big W */
-/* WIOC_GETSUPPORT not yet implemented -E */
+/* Watchdog */
+COMPATIBLE_IOCTL(WDIOC_GETSUPPORT)
 COMPATIBLE_IOCTL(WDIOC_GETSTATUS)
 COMPATIBLE_IOCTL(WDIOC_GETBOOTSTATUS)
 COMPATIBLE_IOCTL(WDIOC_GETTEMP)
 COMPATIBLE_IOCTL(WDIOC_SETOPTIONS)
 COMPATIBLE_IOCTL(WDIOC_KEEPALIVE)
+COMPATIBLE_IOCTL(WDIOC_SETTIMEOUT)
+COMPATIBLE_IOCTL(WDIOC_GETTIMEOUT)
 /* Big R */
 COMPATIBLE_IOCTL(RNDGETENTCNT)
 COMPATIBLE_IOCTL(RNDADDTOENTCNT)
diff -Nru a/Documentation/watchdog/pcwd-watchdog.txt b/Documentation/watchdog/pcwd-watchdog.txt
--- a/Documentation/watchdog/pcwd-watchdog.txt	2004-08-20 11:23:36 +02:00
+++ b/Documentation/watchdog/pcwd-watchdog.txt	2004-08-20 11:23:36 +02:00
@@ -35,7 +35,8 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <sys/ioctl.h>
-#include <linux/pcwd.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
 
 int fd;
 
diff -Nru a/drivers/char/watchdog/cpu5wdt.c b/drivers/char/watchdog/cpu5wdt.c
--- a/drivers/char/watchdog/cpu5wdt.c	2004-08-20 11:23:38 +02:00
+++ b/drivers/char/watchdog/cpu5wdt.c	2004-08-20 11:23:38 +02:00
@@ -134,7 +134,7 @@
 	if ( test_and_set_bit(0, &cpu5wdt_device.inuse) )
 		return -EBUSY;
 
-	return 0;
+	return nonseekable_open(inode, file);
 }
 
 static int cpu5wdt_release(struct inode *inode, struct file *file)
@@ -198,6 +198,7 @@
 
 static struct file_operations cpu5wdt_fops = {
 	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
 	.ioctl		= cpu5wdt_ioctl,
 	.open		= cpu5wdt_open,
 	.write		= cpu5wdt_write,
diff -Nru a/drivers/char/watchdog/ib700wdt.c b/drivers/char/watchdog/ib700wdt.c
--- a/drivers/char/watchdog/ib700wdt.c	2004-08-20 11:23:41 +02:00
+++ b/drivers/char/watchdog/ib700wdt.c	2004-08-20 11:23:41 +02:00
@@ -263,6 +263,7 @@
 
 static struct file_operations ibwdt_fops = {
 	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
 	.write		= ibwdt_write,
 	.ioctl		= ibwdt_ioctl,
 	.open		= ibwdt_open,
diff -Nru a/drivers/char/watchdog/indydog.c b/drivers/char/watchdog/indydog.c
--- a/drivers/char/watchdog/indydog.c	2004-08-20 11:23:41 +02:00
+++ b/drivers/char/watchdog/indydog.c	2004-08-20 11:23:41 +02:00
@@ -162,6 +162,7 @@
 
 static struct file_operations indydog_fops = {
 	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
 	.write		= indydog_write,
 	.ioctl		= indydog_ioctl,
 	.open		= indydog_open,
diff -Nru a/drivers/char/watchdog/ixp4xx_wdt.c b/drivers/char/watchdog/ixp4xx_wdt.c
--- a/drivers/char/watchdog/ixp4xx_wdt.c	2004-08-20 11:23:41 +02:00
+++ b/drivers/char/watchdog/ixp4xx_wdt.c	2004-08-20 11:23:41 +02:00
@@ -170,6 +170,7 @@
 static struct file_operations ixp4xx_wdt_fops =
 {
 	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
 	.write		= ixp4xx_wdt_write,
 	.ioctl		= ixp4xx_wdt_ioctl,
 	.open		= ixp4xx_wdt_open,
diff -Nru a/drivers/char/watchdog/machzwd.c b/drivers/char/watchdog/machzwd.c
--- a/drivers/char/watchdog/machzwd.c	2004-08-20 11:23:41 +02:00
+++ b/drivers/char/watchdog/machzwd.c	2004-08-20 11:23:41 +02:00
@@ -425,6 +425,7 @@
 
 static struct file_operations zf_fops = {
 	.owner          = THIS_MODULE,
+	.llseek         = no_llseek,
 	.write          = zf_write,
 	.ioctl          = zf_ioctl,
 	.open           = zf_open,
diff -Nru a/drivers/char/watchdog/mixcomwd.c b/drivers/char/watchdog/mixcomwd.c
--- a/drivers/char/watchdog/mixcomwd.c	2004-08-20 11:23:41 +02:00
+++ b/drivers/char/watchdog/mixcomwd.c	2004-08-20 11:23:41 +02:00
@@ -197,6 +197,7 @@
 static struct file_operations mixcomwd_fops=
 {
 	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
 	.write		= mixcomwd_write,
 	.ioctl		= mixcomwd_ioctl,
 	.open		= mixcomwd_open,
diff -Nru a/drivers/char/watchdog/sa1100_wdt.c b/drivers/char/watchdog/sa1100_wdt.c
--- a/drivers/char/watchdog/sa1100_wdt.c	2004-08-20 11:23:41 +02:00
+++ b/drivers/char/watchdog/sa1100_wdt.c	2004-08-20 11:23:41 +02:00
@@ -162,6 +162,7 @@
 static struct file_operations sa1100dog_fops =
 {
 	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
 	.write		= sa1100dog_write,
 	.ioctl		= sa1100dog_ioctl,
 	.open		= sa1100dog_open,
diff -Nru a/drivers/char/watchdog/sc1200wdt.c b/drivers/char/watchdog/sc1200wdt.c
--- a/drivers/char/watchdog/sc1200wdt.c	2004-08-20 11:23:41 +02:00
+++ b/drivers/char/watchdog/sc1200wdt.c	2004-08-20 11:23:41 +02:00
@@ -301,6 +301,7 @@
 static struct file_operations sc1200wdt_fops =
 {
 	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
 	.write		= sc1200wdt_write,
 	.ioctl		= sc1200wdt_ioctl,
 	.open		= sc1200wdt_open,
diff -Nru a/drivers/char/watchdog/scx200_wdt.c b/drivers/char/watchdog/scx200_wdt.c
--- a/drivers/char/watchdog/scx200_wdt.c	2004-08-20 11:23:41 +02:00
+++ b/drivers/char/watchdog/scx200_wdt.c	2004-08-20 11:23:41 +02:00
@@ -201,6 +201,7 @@
 
 static struct file_operations scx200_wdt_fops = {
 	.owner	 = THIS_MODULE,
+	.llseek	 = no_llseek,
 	.write   = scx200_wdt_write,
 	.ioctl   = scx200_wdt_ioctl,
 	.open    = scx200_wdt_open,
diff -Nru a/drivers/char/watchdog/wdt285.c b/drivers/char/watchdog/wdt285.c
--- a/drivers/char/watchdog/wdt285.c	2004-08-20 11:23:41 +02:00
+++ b/drivers/char/watchdog/wdt285.c	2004-08-20 11:23:41 +02:00
@@ -180,6 +180,7 @@
 
 static struct file_operations watchdog_fops = {
 	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
 	.write		= watchdog_write,
 	.ioctl		= watchdog_ioctl,
 	.open		= watchdog_open,
diff -Nru a/drivers/char/watchdog/wdt977.c b/drivers/char/watchdog/wdt977.c
--- a/drivers/char/watchdog/wdt977.c	2004-08-20 11:23:41 +02:00
+++ b/drivers/char/watchdog/wdt977.c	2004-08-20 11:23:41 +02:00
@@ -392,6 +392,7 @@
 static struct file_operations wdt977_fops=
 {
 	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
 	.write		= wdt977_write,
 	.ioctl		= wdt977_ioctl,
 	.open		= wdt977_open,
