Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291026AbSBXUMX>; Sun, 24 Feb 2002 15:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291036AbSBXUMN>; Sun, 24 Feb 2002 15:12:13 -0500
Received: from gate.perex.cz ([194.212.165.105]:15889 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S291026AbSBXUMB>;
	Sun, 24 Feb 2002 15:12:01 -0500
Date: Sun, 24 Feb 2002 21:10:45 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: LKML <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Patch - sharing RTC timer between kernel and user space
Message-ID: <Pine.LNX.4.31.0202242103490.535-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

	it would be really nice to include this patch to allow using of
RTC timer inside the kernel space. We can use the RTC timer as timing
source for ALSA sequencer.
	The patch adds these three functions and one structure to rtc.h
and rtc.c:

typedef struct rtc_task {
       void (*func)(void *private_data);
       void *private_data;
} rtc_task_t;

int rtc_register(rtc_task_t *task);
int rtc_unregister(rtc_task_t *task);
int rtc_control(rtc_task_t *t, unsigned int cmd, unsigned long arg);

					Jaroslav


# This is a BitKeeper generated patch for the following project:
# Project Name: Perex's Linux 2.5 Tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.5     -> 1.6
#	drivers/char/Makefile	1.1     -> 1.2
#	  drivers/char/rtc.c	1.1     -> 1.3
#	 include/linux/rtc.h	1.1     -> 1.3
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/02/24	perex@perex.cz	1.6
# Kernel access functions for RTC timer by Takashi
# --------------------------------------------
#
diff -Nru a/drivers/char/Makefile b/drivers/char/Makefile
--- a/drivers/char/Makefile	Sun Feb 24 19:02:47 2002
+++ b/drivers/char/Makefile	Sun Feb 24 19:02:47 2002
@@ -23,7 +23,7 @@

 export-objs     :=	busmouse.o console.o keyboard.o sysrq.o \
 			misc.o pty.o random.o selection.o serial.o \
-			sonypi.o tty_io.o tty_ioctl.o generic_serial.o
+			sonypi.o tty_io.o tty_ioctl.o generic_serial.o rtc.o

 mod-subdirs	:=	ftape drm pcmcia

diff -Nru a/drivers/char/rtc.c b/drivers/char/rtc.c
--- a/drivers/char/rtc.c	Sun Feb 24 19:02:47 2002
+++ b/drivers/char/rtc.c	Sun Feb 24 19:02:47 2002
@@ -41,9 +41,11 @@
  *	1.10c	Cesar Barros: SMP locking fixes and cleanup
  *	1.10d	Paul Gortmaker: delete paranoia check in rtc_exit
  *	1.10e	Maciej W. Rozycki: Handle DECstation's year weirdness.
+ *      1.11    Takashi Iwai: Kernel access functions
+ *			      rtc_register/rtc_unregister/rtc_control
  */

-#define RTC_VERSION		"1.10e"
+#define RTC_VERSION		"1.11"

 #define RTC_IO_EXTENT	0x10	/* Only really two ports, but...	*/

@@ -139,6 +141,11 @@
 static unsigned long rtc_freq = 0;	/* Current periodic IRQ rate	*/
 static unsigned long rtc_irq_data = 0;	/* our output to the world	*/

+#if RTC_IRQ
+static spinlock_t rtc_task_lock = SPIN_LOCK_UNLOCKED;
+static rtc_task_t *rtc_callback = NULL;
+#endif
+
 /*
  *	If this driver ever becomes modularised, it will be really nice
  *	to make the epoch retain its value across module reload...
@@ -180,6 +187,10 @@
 	spin_unlock (&rtc_lock);

 	/* Now do the rest of the actions */
+	spin_lock(&rtc_task_lock);
+	if (rtc_callback)
+		rtc_callback->func(rtc_callback->private_data);
+	spin_unlock(&rtc_task_lock);
 	wake_up_interruptible(&rtc_wait);

 	kill_fasync (&rtc_async_queue, SIGIO, POLL_IN);
@@ -244,8 +255,7 @@
 #endif
 }

-static int rtc_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-		     unsigned long arg)
+static int rtc_do_ioctl(unsigned int cmd, unsigned long arg, int kernel)
 {
 	struct rtc_time wtime;

@@ -295,7 +305,7 @@
 		 * We don't really want Joe User enabling more
 		 * than 64Hz of interrupts on a multi-user machine.
 		 */
-		if ((rtc_freq > 64) && (!capable(CAP_SYS_RESOURCE)))
+		if (!kernel && (rtc_freq > 64) && (!capable(CAP_SYS_RESOURCE)))
 			return -EACCES;

 		if (!(rtc_status & RTC_TIMER_ON)) {
@@ -493,7 +503,7 @@
 		 * We don't really want Joe User generating more
 		 * than 64Hz of interrupts on a multi-user machine.
 		 */
-		if ((arg > 64) && (!capable(CAP_SYS_RESOURCE)))
+		if (!kernel && (arg > 64) && (!capable(CAP_SYS_RESOURCE)))
 			return -EACCES;

 		while (arg > (1<<tmp))
@@ -539,6 +549,12 @@
 	return copy_to_user((void *)arg, &wtime, sizeof wtime) ? -EFAULT : 0;
 }

+static int rtc_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+		     unsigned long arg)
+{
+	return rtc_do_ioctl(cmd, arg, 0);
+}
+
 /*
  *	We enforce only one user at a time here with the open/close.
  *	Also clear the previous interrupt data on an open, and clean
@@ -606,11 +622,8 @@

 	spin_lock_irq (&rtc_lock);
 	rtc_irq_data = 0;
-	spin_unlock_irq (&rtc_lock);
-
-	/* No need for locking -- nobody else can do anything until this rmw is
-	 * committed, and no timer is running. */
 	rtc_status &= ~RTC_IS_OPEN;
+	spin_unlock_irq (&rtc_lock);
 	return 0;
 }

@@ -636,6 +649,88 @@
 #endif

 /*
+ * exported stuffs
+ */
+
+EXPORT_SYMBOL(rtc_register);
+EXPORT_SYMBOL(rtc_unregister);
+EXPORT_SYMBOL(rtc_control);
+
+int rtc_register(rtc_task_t *task)
+{
+#if !RTC_IRQ
+	return -EIO;
+#else
+	if (task == NULL || task->func == NULL)
+		return -EINVAL;
+	spin_lock_irq(&rtc_lock);
+	if (rtc_status & RTC_IS_OPEN) {
+		spin_unlock_irq(&rtc_lock);
+		return -EBUSY;
+	}
+	spin_lock(&rtc_task_lock);
+	if (rtc_callback) {
+		spin_unlock(&rtc_task_lock);
+		spin_unlock_irq(&rtc_lock);
+		return -EBUSY;
+	}
+	rtc_status |= RTC_IS_OPEN;
+	rtc_callback = task;
+	spin_unlock(&rtc_task_lock);
+	spin_unlock_irq(&rtc_lock);
+	return 0;
+#endif
+}
+
+int rtc_unregister(rtc_task_t *task)
+{
+#if !RTC_IRQ
+	return -EIO;
+#else
+	unsigned char tmp;
+
+	spin_lock_irq(&rtc_task_lock);
+	if (rtc_callback != task) {
+		spin_unlock_irq(&rtc_task_lock);
+		return -ENXIO;
+	}
+	rtc_callback = NULL;
+	spin_lock(&rtc_lock);
+	/* disable controls */
+	tmp = CMOS_READ(RTC_CONTROL);
+	tmp &= ~RTC_PIE;
+	tmp &= ~RTC_AIE;
+	tmp &= ~RTC_UIE;
+	CMOS_WRITE(tmp, RTC_CONTROL);
+	CMOS_READ(RTC_INTR_FLAGS);
+	if (rtc_status & RTC_TIMER_ON) {
+		rtc_status &= ~RTC_TIMER_ON;
+		del_timer(&rtc_irq_timer);
+	}
+	rtc_status &= ~RTC_IS_OPEN;
+	spin_unlock(&rtc_lock);
+	spin_unlock_irq(&rtc_task_lock);
+	return 0;
+#endif
+}
+
+int rtc_control(rtc_task_t *task, unsigned int cmd, unsigned long arg)
+{
+#if !RTC_IRQ
+	return -EIO;
+#else
+	spin_lock_irq(&rtc_task_lock);
+	if (rtc_callback != task) {
+		spin_unlock_irq(&rtc_task_lock);
+		return -ENXIO;
+	}
+	spin_unlock_irq(&rtc_task_lock);
+	return rtc_do_ioctl(cmd, arg, 1);
+#endif
+}
+
+
+/*
  *	The various file operations we support.
  */

@@ -822,7 +917,6 @@

 module_init(rtc_init);
 module_exit(rtc_exit);
-EXPORT_NO_SYMBOLS;

 #if RTC_IRQ
 /*
diff -Nru a/include/linux/rtc.h b/include/linux/rtc.h
--- a/include/linux/rtc.h	Sun Feb 24 19:02:47 2002
+++ b/include/linux/rtc.h	Sun Feb 24 19:02:47 2002
@@ -66,4 +66,17 @@
 #define RTC_WKALM_SET	_IOW('p', 0x0f, struct rtc_wkalrm)/* Set wakeup alarm*/
 #define RTC_WKALM_RD	_IOR('p', 0x10, struct rtc_wkalrm)/* Get wakeup alarm*/

+#ifdef __KERNEL__
+
+typedef struct rtc_task {
+	void (*func)(void *private_data);
+	void *private_data;
+} rtc_task_t;
+
+int rtc_register(rtc_task_t *task);
+int rtc_unregister(rtc_task_t *task);
+int rtc_control(rtc_task_t *t, unsigned int cmd, unsigned long arg);
+
+#endif /* __KERNEL__ */
+
 #endif /* _LINUX_RTC_H_ */

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

