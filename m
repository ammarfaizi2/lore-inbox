Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbVBAXzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVBAXzT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 18:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVBAXyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 18:54:18 -0500
Received: from mail1.fw-sj.sony.com ([160.33.82.68]:47594 "EHLO
	mail1.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S262190AbVBAXxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 18:53:22 -0500
Message-ID: <4200166A.6050309@am.sony.com>
Date: Tue, 01 Feb 2005 15:53:14 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A2)
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com>	 <41FFFD4F.9050900@am.sony.com> <1107298089.2040.184.camel@cog.beaverton.ibm.com>
In-Reply-To: <1107298089.2040.184.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> I believe you're right. Although we don't call read_persistent_clock()
> very frequently, nor do we call it in ways we don't already call
> get_cmos_time(). So I'm not sure exactly what the concern is.

Sorry - I should have given more context.  I am worried about
suspend and resume times.  An extra (up-to-a) second delay on
suspend it pretty painful for CE devices.  (See my SIG for
my other hat in the forum.)

>
> Since we call read_persistent_clock(), it should return right as the
> second changes, thus we will be marking the new second as closely as
> possible with the timesource value. If the order was reversed, I think
> it would be a concern.
>

It sounds like for your code, this synchronization is a valuable.
For many CE products, the synchronization is not needed.  I have a
patch that removes the synchronization for i386 and ppc, but
I haven't submitted it because I didn't want to mess up
non-boot-context callers of get_cmos_time which have valid
synchronization needs.

As you can see below, the patch is pretty braindead.
I was wondering if this conflicted with your new timer system or
not.

diffstat:
 arch/ppc/kernel/time.c                    |   10 ++++++++--
 include/asm-i386/mach-default/mach_time.h |    6 +++++-
 init/Kconfig                              |   27 +++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 3 deletions(-)

Signed-off-by: Tim Bird <tim.bird@am.sony.com>

-----------------------
diff -pruN -X /home/tbird/dontdiff linux-2.6.10.orig/arch/ppc/kernel/time.c linux-2.6.10/arch/ppc/kernel/time.c
--- linux-2.6.10.orig/arch/ppc/kernel/time.c	2004-12-24 13:35:23.000000000 -0800
+++ linux-2.6.10/arch/ppc/kernel/time.c	2005-02-01 15:28:42.539108108 -0800
@@ -291,8 +291,12 @@ EXPORT_SYMBOL(do_settimeofday);
 /* This function is only called on the boot processor */
 void __init time_init(void)
 {
-	time_t sec, old_sec;
-	unsigned old_stamp, stamp, elapsed;
+	time_t sec;
+	unsigned stamp;
+#ifndef CONFIG_RTC_NO_SYNC
+	time_t old_sec;
+	unsigned old_stamp, elapsed;
+#endif

         if (ppc_md.time_init != NULL)
                 time_offset = ppc_md.time_init();
@@ -317,6 +321,7 @@ void __init time_init(void)
 	stamp = get_native_tbl();
 	if (ppc_md.get_rtc_time) {
 		sec = ppc_md.get_rtc_time();
+#ifndef CONFIG_RTC_NO_SYNC
 		elapsed = 0;
 		do {
 			old_stamp = stamp;
@@ -329,6 +334,7 @@ void __init time_init(void)
 		} while ( sec == old_sec && elapsed < 2*HZ*tb_ticks_per_jiffy);
 		if (sec==old_sec)
 			printk("Warning: real time clock seems stuck!\n");
+#endif
 		xtime.tv_sec = sec;
 		xtime.tv_nsec = 0;
 		/* No update now, we just read the time from the RTC ! */
diff -pruN -X /home/tbird/dontdiff linux-2.6.10.orig/include/asm-i386/mach-default/mach_time.h linux-2.6.10/include/asm-i386/mach-default/mach_time.h
--- linux-2.6.10.orig/include/asm-i386/mach-default/mach_time.h	2004-12-24 13:34:30.000000000 -0800
+++ linux-2.6.10/include/asm-i386/mach-default/mach_time.h	2005-02-01 15:28:48.245009070 -0800
@@ -89,6 +89,7 @@ static inline unsigned long mach_get_cmo
 	 * RTC registers show the second which has precisely just started.
 	 * Let's hope other operating systems interpret the RTC the same way.
 	 */
+#ifndef CONFIG_RTC_NO_SYNC_ON_READ
 	/* read RTC exactly on falling edge of update flag */
 	for (i = 0 ; i < 1000000 ; i++)	/* may take up to 1 second... */
 		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP)
@@ -96,7 +97,10 @@ static inline unsigned long mach_get_cmo
 	for (i = 0 ; i < 1000000 ; i++)	/* must try at least 2.228 ms */
 		if (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
 			break;
-	do { /* Isn't this overkill ? UIP above should guarantee consistency */
+/* The following is probably overkill because
+ * UIP above should guarantee consistency */
+#endif
+	do {
 		sec = CMOS_READ(RTC_SECONDS);
 		min = CMOS_READ(RTC_MINUTES);
 		hour = CMOS_READ(RTC_HOURS);
diff -pruN -X /home/tbird/dontdiff linux-2.6.10.orig/init/Kconfig linux-2.6.10/init/Kconfig
--- linux-2.6.10.orig/init/Kconfig	2004-12-24 13:35:24.000000000 -0800
+++ linux-2.6.10/init/Kconfig	2005-02-01 15:28:48.281002137 -0800
@@ -248,6 +248,33 @@ config IKCONFIG_PROC
 	  This option enables access to the kernel configuration file
 	  through /proc/config.gz.

+menuconfig FASTBOOT
+	bool "Fast boot options"
+	help
+	  Say Y here to select among various options that can decrease
+	  kernel boot time.  These options may involve providing
+	  hardcoded values for some parameters that the kernel usually
+	  determines automatically.
+
+	  This option is useful primarily on embedded systems.
+
+	  If unsure, say N.
+
+config RTC_NO_SYNC
+	bool "Disable synch on read of Real Time Clock" if FASTBOOT
+	default n
+	help
+	  The Real Time Clock is read aligned by default. That means a
+	  series of reads of the RTC are done until it's verified that
+	  the RTC's state has just changed.  If you enable this feature,
+	  this synchronization will not be performed.  The result is that
+	  the machine will boot up to 1 second faster.
+
+	  A drawback is that, with this option enabled, your system
+	  clock may drift from the correct value over the course
+	  of several boot cycles (under certain circumstances).
+
+	  If unsure, say N.

 menuconfig EMBEDDED
 	bool "Configure standard kernel features (for small systems)"

