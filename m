Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbSJDWsh>; Fri, 4 Oct 2002 18:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261711AbSJDWsh>; Fri, 4 Oct 2002 18:48:37 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:6119 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261581AbSJDWsf>;
	Fri, 4 Oct 2002 18:48:35 -0400
Message-ID: <3D9E1BEA.7060804@us.ibm.com>
Date: Fri, 04 Oct 2002 15:53:30 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] HZ as a config option
Content-Type: multipart/mixed;
 boundary="------------010305090208000403090605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010305090208000403090605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

On large systems (like NUMA-Q, Intel Profusion, etc...), latency and 
user responsiveness become much less important.  The extra scheduling 
overhead caused by higher HZ is bad.

This is x86-only right now.  Is there any wider desire to tune this at 
config time?  Do any architecutures have strict rules as to what this 
can be set to?
-- 
Dave Hansen
haveblue@us.ibm.com

--------------010305090208000403090605
Content-Type: text/plain;
 name="config_hz-2.5.40-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config_hz-2.5.40-1.patch"

diff -ur linux-2.5.40/arch/i386/Config.help linux-2.5.40-hz_config/arch/i386/Config.help
--- linux-2.5.40/arch/i386/Config.help	2002-10-01 00:06:17.000000000 -0700
+++ linux-2.5.40-hz_config/arch/i386/Config.help	2002-10-04 15:25:52.000000000 -0700
@@ -850,6 +850,17 @@
 
   If in doubt, say N.
 
+CONFIG_HZ
+  This is unrelated to your processor's speed.  This variable alters
+  how often the system is asked to generate timer interrupts.  A larger
+  value can lead to a more responsive system, but also causes extra 
+  overhead from the increased number of context switches.
+
+  In older kernels, this was set to 100.  In 2.5, it was set to 1000.
+  HZ must be greater than 11 and less than 1536.
+
+  If in doubt, leave it at the default of 1000. 
+
 CONFIG_CPU_FREQ_24_API
   This enables the /proc/sys/cpu/ sysctl interface for controlling
   CPUFreq, as known from the 2.4.-kernel patches for CPUFreq. Note
diff -ur linux-2.5.40/arch/i386/config.in linux-2.5.40-hz_config/arch/i386/config.in
--- linux-2.5.40/arch/i386/config.in	2002-10-04 14:25:29.000000000 -0700
+++ linux-2.5.40-hz_config/arch/i386/config.in	2002-10-04 15:21:21.000000000 -0700
@@ -208,6 +208,10 @@
    fi
 fi
 
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+	int 'Kernel Timer Frequency (HZ)' CONFIG_HZ 1000
+fi
+		  
 tristate 'Toshiba Laptop support' CONFIG_TOSHIBA
 tristate 'Dell laptop support' CONFIG_I8K
 
diff -ur linux-2.5.40/include/asm-i386/param.h linux-2.5.40-hz_config/include/asm-i386/param.h
--- linux-2.5.40/include/asm-i386/param.h	2002-10-01 00:06:20.000000000 -0700
+++ linux-2.5.40-hz_config/include/asm-i386/param.h	2002-10-04 14:54:04.000000000 -0700
@@ -2,7 +2,7 @@
 #define _ASMi386_PARAM_H
 
 #ifdef __KERNEL__
-# define HZ		1000		/* Internal kernel timer frequency */
+# define HZ		CONFIG_HZ	/* Internal kernel timer frequency */
 # define USER_HZ	100		/* .. some user interfaces are in "ticks" */
 # define CLOCKS_PER_SEC	(USER_HZ)	/* like times() */
 #endif
diff -ur linux-2.5.40/include/linux/timex.h linux-2.5.40-hz_config/include/linux/timex.h
--- linux-2.5.40/include/linux/timex.h	2002-10-01 00:06:15.000000000 -0700
+++ linux-2.5.40-hz_config/include/linux/timex.h	2002-10-04 15:24:04.000000000 -0700
@@ -76,7 +76,7 @@
 #elif HZ >= 768 && HZ < 1536
 # define SHIFT_HZ	10
 #else
-# error You lose.
+# error Please use a HZ value which is between 12 and 1536 
 #endif
 
 /*

--------------010305090208000403090605--

