Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264196AbSIQOrq>; Tue, 17 Sep 2002 10:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264210AbSIQOrq>; Tue, 17 Sep 2002 10:47:46 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:11254 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S264196AbSIQOro>; Tue, 17 Sep 2002 10:47:44 -0400
Message-ID: <3D87422B.3080300@drugphish.ch>
Date: Tue, 17 Sep 2002 16:54:35 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kirk Reiser <kirk@braille.uwo.ca>
Cc: Skip Ford <skip.ford@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.35 undefined reference to `wait_task_inactive'
References: <200209160644.g8G6iEvo006691@pool-141-150-241-241.delv.east.verizon.net> <x7sn08k7r0.fsf@speech.braille.uwo.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>A call to wait_task_inactive was added to fs/exec.c but that function is
>>not defined for UP.
> I haven't seen a fix for this yet?  

Err, I've done and sent a possible patch to LKML, I'm simply not sure if 
this is the right thing to do:

--- linux-2.5.35/kernel/sched.c Mon Sep 16 04:18:24 2002
+++ linux-2.5.35-ratz/kernel/sched.c    Mon Sep 16 13:29:28 2002
@@ -331,8 +331,6 @@
  #endif
  }

-#ifdef CONFIG_SMP
-
  /*
   * wait_task_inactive - wait for a thread to unschedule.
   *
@@ -366,7 +364,6 @@
         task_rq_unlock(rq, &flags);
         preempt_enable();
  }
-#endif

  /*
   * kick_if_running - kick the remote CPU if the task is running currently.

BTW, ACPI needs a few tunings too to be able to compile the stuff as 
modules, but I'm sure that also here it's not the right thing to do, I 
simply did a quick hack to have a running and bootable 2.5.35 kernel:

diff -ur linux-2.5.35/drivers/acpi/hardware/hwgpe.c 
linux-2.5.35-ratz/drivers/acpi/hardwar
e/hwgpe.c
--- linux-2.5.35/drivers/acpi/hardware/hwgpe.c  Mon Sep 16 04:18:17 2002
+++ linux-2.5.35-ratz/drivers/acpi/hardware/hwgpe.c     Mon Sep 16 
12:49:40 2002
@@ -28,7 +28,9 @@
  #include "acevents.h"

  #define _COMPONENT          ACPI_HARDWARE
+#ifdef MODULE
          ACPI_MODULE_NAME    ("hwgpe")
+#endif


 
/******************************************************************************
diff -ur linux-2.5.35/drivers/acpi/namespace/nsxfname.c 
linux-2.5.35-ratz/drivers/acpi/nam
espace/nsxfname.c
--- linux-2.5.35/drivers/acpi/namespace/nsxfname.c      Mon Sep 16 
04:18:23 2002
+++ linux-2.5.35-ratz/drivers/acpi/namespace/nsxfname.c Mon Sep 16 
13:00:34 2002
@@ -30,7 +30,9 @@


  #define _COMPONENT          ACPI_NAMESPACE
+#ifdef MODULE
          ACPI_MODULE_NAME    ("nsxfname")
+#endif


 
/****************************************************************************
diff -ur linux-2.5.35/drivers/acpi/namespace/nsxfobj.c 
linux-2.5.35-ratz/drivers/acpi/name
space/nsxfobj.c
--- linux-2.5.35/drivers/acpi/namespace/nsxfobj.c       Mon Sep 16 
04:18:15 2002
+++ linux-2.5.35-ratz/drivers/acpi/namespace/nsxfobj.c  Mon Sep 16 
13:00:52 2002
@@ -30,7 +30,9 @@


  #define _COMPONENT          ACPI_NAMESPACE
+#ifdef MODULE
          ACPI_MODULE_NAME    ("nsxfobj")
+#endif

 
/*******************************************************************************
   *
diff -ur linux-2.5.35/drivers/acpi/resources/rsdump.c 
linux-2.5.35-ratz/drivers/acpi/resou
rces/rsdump.c
--- linux-2.5.35/drivers/acpi/resources/rsdump.c        Mon Sep 16 
04:18:30 2002
+++ linux-2.5.35-ratz/drivers/acpi/resources/rsdump.c   Mon Sep 16 
13:01:26 2002
@@ -28,7 +28,9 @@
  #include "acresrc.h"

  #define _COMPONENT          ACPI_RESOURCES
+#ifdef MODULE
          ACPI_MODULE_NAME    ("rsdump")
+#endif


  #if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER)
diff -ur linux-2.5.35/drivers/acpi/utilities/utdebug.c 
linux-2.5.35-ratz/drivers/acpi/util
ities/utdebug.c
--- linux-2.5.35/drivers/acpi/utilities/utdebug.c       Mon Sep 16 
04:18:38 2002
+++ linux-2.5.35-ratz/drivers/acpi/utilities/utdebug.c  Mon Sep 16 
13:02:12 2002
@@ -27,7 +27,9 @@
  #include "acpi.h"

  #define _COMPONENT          ACPI_UTILITIES
+#ifdef MODULE
          ACPI_MODULE_NAME    ("utdebug")
+#endif


  #ifdef ACPI_DEBUG_OUTPUT
diff -ur linux-2.5.35/drivers/usb/storage/transport.c 
linux-2.5.35-ratz/drivers/usb/storag
e/transport.c
--- linux-2.5.35/drivers/usb/storage/transport.c        Mon Sep 16 
04:18:26 2002
+++ linux-2.5.35-ratz/drivers/usb/storage/transport.c   Mon Sep 16 
12:46:47 2002
@@ -55,6 +55,8 @@
  #include <linux/errno.h>
  #include <linux/slab.h>

+extern void show_trace(unsigned long* esp);
+
  /***********************************************************************
   * Helper routines
   ***********************************************************************/

Best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

