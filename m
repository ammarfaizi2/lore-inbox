Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVGNQYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVGNQYv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 12:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVGNQYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 12:24:50 -0400
Received: from ns1.pioneer-pra.com ([65.205.244.70]:24767 "EHLO
	mail2.dmz.sj.pioneer-pra.com") by vger.kernel.org with ESMTP
	id S261379AbVGNQYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 12:24:48 -0400
Message-ID: <42D69154.6040608@kesh.com>
Date: Thu, 14 Jul 2005 09:22:44 -0700
From: Elias Kesh <linux@kesh.com>
Reply-To: linux@kesh.com
Organization: CELinux Forum
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.8b) Gecko/20050709
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] RealTimeSync Patch
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would like to get some feedback on this patch for the kernel.  It's sole purpose is to help in reducing boot time by not waiting to synchronize the clock edge with the hardware clock. This when combined with other boot reduction patched can bring the kernel boot time to well under 10 seconds, in most cases two or three seconds.  In a desktop system this patch is probably insignificant, howerver several patches like this in a set top box or cell phone will be signicant.

 I understand that there may be some concerns with patches like these so I would like to start a discussion so that I can better understand what the issues are. The members of the CELinux Forum have quite a bit we would like to contribute.

Looking at the archives I see that a an intel patch was submitted back in October but I am unable to determine what the resolution was.

This patch included is for PPC but other architecutres are available on the patch web site below.

Detailed information on the patch can be found here:
http://tree.celinuxforum.org/CelfPubWiki/RTCNoSync

In addition, other patches for boot time reduction can be found here:
http://tree.celinuxforum.org/CelfPubWiki/PatchArchive

Elias Kesh
linux@kesh.com


* Fast boot options
*
Fast boot options (FASTBOOT) [N/y/?] (NEW) y
  Disable synch on read of Real Time Clock (RTC_NO_SYNC) [N/y/?] (NEW) y



diff -u -pruN -X ../dontdiff linux-2.6.12/arch/ppc/kernel/time.c linux-2.6.12_rtc_patch/arch/ppc/kernel/time.c
--- linux-2.6.12/arch/ppc/kernel/time.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12_rtc_patch/arch/ppc/kernel/time.c	2005-07-02 00:27:37.000000000 +0200
@@ -282,8 +282,12 @@ EXPORT_SYMBOL(do_settimeofday);
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
@@ -308,6 +312,7 @@ void __init time_init(void)
 	stamp = get_native_tbl();
 	if (ppc_md.get_rtc_time) {
 		sec = ppc_md.get_rtc_time();
+#ifndef CONFIG_RTC_NO_SYNC
 		elapsed = 0;
 		do {
 			old_stamp = stamp;
@@ -320,6 +325,7 @@ void __init time_init(void)
 		} while ( sec == old_sec && elapsed < 2*HZ*tb_ticks_per_jiffy);
 		if (sec==old_sec)
 			printk("Warning: real time clock seems stuck!\n");
+#endif
 		xtime.tv_sec = sec;
 		xtime.tv_nsec = 0;
 		/* No update now, we just read the time from the RTC ! */
diff -u -pruN -X ../dontdiff linux-2.6.12/init/Kconfig linux-2.6.12_rtc_patch/init/Kconfig
--- linux-2.6.12/init/Kconfig	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12_rtc_patch/init/Kconfig	2005-07-02 00:27:37.000000000 +0200
@@ -275,6 +275,33 @@ config KALLSYMS_EXTRA_PASS
 	   reported.  KALLSYMS_EXTRA_PASS is only a temporary workaround while
 	   you wait for kallsyms to be fixed.
 
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
+          the RTC's state has just changed.  If you enable this feature,
+          this synchronization will not be performed.  The result is that
+	  the machine will boot up to 1 second faster. 
+
+	  A drawback is that, with this option enabled, your system
+	  clock may drift from the correct value over the course
+	  of several boot cycles (under certain circumstances).
+
+	  If unsure, say N.
 
 config PRINTK
 	default y


