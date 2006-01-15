Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751829AbWAOEH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbWAOEH3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 23:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbWAOEH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 23:07:29 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:51095 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751829AbWAOEH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 23:07:28 -0500
Date: Sun, 15 Jan 2006 05:07:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-mm4
Message-ID: <20060115040741.GA23968@elte.hu>
References: <43C919ED.8070801@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C919ED.8070801@ens-lyon.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:

> Hi Andrew,
> 
> I get the following badness when booting mm4 on my thinkpad T43:
> 
> hdaps: IBM ThinkPad T43 detected.
> hdaps: initial latch check good (0x01).
> Time: acpi_pm clocksource has been installed.
> input: hdaps as /class/input/input3
> hdaps: driver successfully loaded.
> Non-volatile memory driver v1.2
> Badness in __mutex_trylock_slowpath at kernel/mutex.c:281
>  [<c01251cf>] mutex_trylock+0x5a/0xe7
>  [<e09c02d2>] hdaps_inputdev_poll+0xd/0xbd [hdaps]
>  [<c011befc>] run_timer_softirq+0x105/0x147
>  [<c0118a0b>] __do_softirq+0x34/0x7d
>  [<c0118a76>] do_softirq+0x22/0x26
>  [<c0104a64>] do_IRQ+0x22/0x2a
>  [<c01033ce>] common_interrupt+0x1a/0x20
> kjournald starting.  Commit interval 5 seconds

Could you try the patch below?

	Ingo

--
undo hdaps.c mutex conversion - hdaps_inputdev_poll() is used in an irq 
context.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
----
 drivers/hwmon/hdaps.c |   37 ++++++++++++++++++-------------------
 1 files changed, 18 insertions(+), 19 deletions(-)

Index: linux-2.6.15-mm4.q/drivers/hwmon/hdaps.c
===================================================================
--- linux-2.6.15-mm4.q.orig/drivers/hwmon/hdaps.c
+++ linux-2.6.15-mm4.q/drivers/hwmon/hdaps.c
@@ -33,7 +33,6 @@
 #include <linux/module.h>
 #include <linux/timer.h>
 #include <linux/dmi.h>
-#include <linux/mutex.h>
 #include <asm/io.h>
 
 #define HDAPS_LOW_PORT		0x1600	/* first port used by hdaps */
@@ -77,10 +76,10 @@ static u8 km_activity;
 static int rest_x;
 static int rest_y;
 
-static DEFINE_MUTEX(hdaps_mutex);
+static DECLARE_MUTEX(hdaps_sem);
 
 /*
- * __get_latch - Get the value from a given port.  Callers must hold hdaps_mutex.
+ * __get_latch - Get the value from a given port.  Callers must hold hdaps_sem.
  */
 static inline u8 __get_latch(u16 port)
 {
@@ -89,7 +88,7 @@ static inline u8 __get_latch(u16 port)
 
 /*
  * __check_latch - Check a port latch for a given value.  Returns zero if the
- * port contains the given value.  Callers must hold hdaps_mutex.
+ * port contains the given value.  Callers must hold hdaps_sem.
  */
 static inline int __check_latch(u16 port, u8 val)
 {
@@ -100,7 +99,7 @@ static inline int __check_latch(u16 port
 
 /*
  * __wait_latch - Wait up to 100us for a port latch to get a certain value,
- * returning zero if the value is obtained.  Callers must hold hdaps_mutex.
+ * returning zero if the value is obtained.  Callers must hold hdaps_sem.
  */
 static int __wait_latch(u16 port, u8 val)
 {
@@ -117,7 +116,7 @@ static int __wait_latch(u16 port, u8 val
 
 /*
  * __device_refresh - request a refresh from the accelerometer.  Does not wait
- * for refresh to complete.  Callers must hold hdaps_mutex.
+ * for refresh to complete.  Callers must hold hdaps_sem.
  */
 static void __device_refresh(void)
 {
@@ -131,7 +130,7 @@ static void __device_refresh(void)
 /*
  * __device_refresh_sync - request a synchronous refresh from the
  * accelerometer.  We wait for the refresh to complete.  Returns zero if
- * successful and nonzero on error.  Callers must hold hdaps_mutex.
+ * successful and nonzero on error.  Callers must hold hdaps_sem.
  */
 static int __device_refresh_sync(void)
 {
@@ -141,7 +140,7 @@ static int __device_refresh_sync(void)
 
 /*
  * __device_complete - indicate to the accelerometer that we are done reading
- * data, and then initiate an async refresh.  Callers must hold hdaps_mutex.
+ * data, and then initiate an async refresh.  Callers must hold hdaps_sem.
  */
 static inline void __device_complete(void)
 {
@@ -159,7 +158,7 @@ static int hdaps_readb_one(unsigned int 
 {
 	int ret;
 
-	mutex_lock(&hdaps_mutex);
+	down(&hdaps_sem);
 
 	/* do a sync refresh -- we need to be sure that we read fresh data */
 	ret = __device_refresh_sync();
@@ -170,7 +169,7 @@ static int hdaps_readb_one(unsigned int 
 	__device_complete();
 
 out:
-	mutex_unlock(&hdaps_mutex);
+	up(&hdaps_sem);
 	return ret;
 }
 
@@ -205,9 +204,9 @@ static int hdaps_read_pair(unsigned int 
 {
 	int ret;
 
-	mutex_lock(&hdaps_mutex);
+	down(&hdaps_sem);
 	ret = __hdaps_read_pair(port1, port2, val1, val2);
-	mutex_unlock(&hdaps_mutex);
+	up(&hdaps_sem);
 
 	return ret;
 }
@@ -220,7 +219,7 @@ static int hdaps_device_init(void)
 {
 	int total, ret = -ENXIO;
 
-	mutex_lock(&hdaps_mutex);
+	down(&hdaps_sem);
 
 	outb(0x13, 0x1610);
 	outb(0x01, 0x161f);
@@ -286,13 +285,13 @@ static int hdaps_device_init(void)
 	}
 
 out:
-	mutex_unlock(&hdaps_mutex);
+	up(&hdaps_sem);
 	return ret;
 }
 
 
 /*
- * hdaps_calibrate - Set our "resting" values.  Callers must hold hdaps_mutex.
+ * hdaps_calibrate - Set our "resting" values.  Callers must hold hdaps_sem.
  */
 static void hdaps_calibrate(void)
 {
@@ -304,7 +303,7 @@ static void hdaps_inputdev_poll(unsigned
 	int x, y;
 
 	/* Cannot sleep.  Try nonblockingly.  If we fail, try again later. */
-	if (!mutex_trylock(&hdaps_mutex)) {
+	if (down_trylock(&hdaps_sem)) {
 		mod_timer(&hdaps_timer, jiffies + HDAPS_POLL_PERIOD);
 		return;
 	}
@@ -319,7 +318,7 @@ static void hdaps_inputdev_poll(unsigned
 	mod_timer(&hdaps_timer, jiffies + HDAPS_POLL_PERIOD);
 
  out:
-	mutex_unlock(&hdaps_mutex);
+	up(&hdaps_sem);
 }
 
 
@@ -399,9 +398,9 @@ static ssize_t hdaps_calibrate_store(str
 				     struct device_attribute *attr,
 				     const char *buf, size_t count)
 {
-	mutex_lock(&hdaps_mutex);
+	down(&hdaps_sem);
 	hdaps_calibrate();
-	mutex_unlock(&hdaps_mutex);
+	up(&hdaps_sem);
 
 	return count;
 }
