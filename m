Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754569AbWKMMYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569AbWKMMYt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 07:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754570AbWKMMYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 07:24:11 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:49615 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1754540AbWKMMYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 07:24:00 -0500
Message-ID: <45586EB5.40409@in.ibm.com>
Date: Mon, 13 Nov 2006 18:40:13 +0530
From: Srinivasa Ds <srinivasa@in.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: anton@au1.ibm.com, paulus@samba.org
CC: linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH] cpu_hotplug on IBM JS20 system
Content-Type: multipart/mixed;
 boundary="------------010003070309090909070800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010003070309090909070800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi
when I tried to hot plug a cpu on IBM bladecentre JS20 system,it dropped 
in to xmon. On analyzing the problem,I found out that "self-stop" token  
is not exported
to the OS through rtas(Could be verified by looking in to 
/proc/device-tree/rtas file).

1:mon> e
cpu 0x1: Vector: 700 (Program Check) at [c00000000ff1bab0]
   pc: c00000000001b144: .rtas_stop_self+0x34/0x70
   lr: c0000000000439c0: .pSeries_mach_cpu_die+0x34/0x40
   sp: c00000000ff1bd30
  msr: 8000000000021032
 current = 0xc00000000ff050b0
 paca    = 0xc0000000005ec500
   pid   = 0, comm = swapper
kernel BUG in rtas_stop_self at arch/powerpc/kernel/rtas.c:829!
===========================================
void rtas_stop_self(void)
{
       struct rtas_args *rtas_args = &rtas_stop_self_args;

       local_irq_disable();

       BUG_ON(rtas_args->token == RTAS_UNKNOWN_SERVICE);
===================================================
#ifdef CONFIG_HOTPLUG_CPU
       rtas_stop_self_args.token = rtas_token("stop-self");
#endif /* CONFIG_HOTPLUG_CPU */
#ifdef CONFIG_RTAS_ERROR_LOGGING
       rtas_last_error_token = rtas_token("rtas-last-error");
===================================================

Since we are not supported by hardware for cpu hotplug. I have developed 
the patch which will disable cpu hotplug on IBM bladecentre JS20. Please 
let me know your comments on this please.

Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>




Thanks
Srinivasa DS



--------------010003070309090909070800
Content-Type: text/plain;
 name="cpu_hotplug.fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpu_hotplug.fix"

 arch/powerpc/kernel/rtas.c |    9 +++++++++
 kernel/cpu.c               |    4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

Index: linux-2.6.19-rc5/arch/powerpc/kernel/rtas.c
===================================================================
--- linux-2.6.19-rc5.orig/arch/powerpc/kernel/rtas.c	2006-11-08 07:54:20.000000000 +0530
+++ linux-2.6.19-rc5/arch/powerpc/kernel/rtas.c	2006-11-13 17:39:10.000000000 +0530
@@ -53,6 +53,9 @@
 
 unsigned long rtas_rmo_buf;
 
+extern  int cpu_hotplug_disabled;
+extern  struct mutex cpu_add_remove_lock;
+
 /*
  * If non-NULL, this gets called when the kernel terminates.
  * This is done like this so rtas_flash can be a module.
@@ -881,6 +884,12 @@
 
 #ifdef CONFIG_HOTPLUG_CPU
 	rtas_stop_self_args.token = rtas_token("stop-self");
+	if(rtas_stop_self_args.token == RTAS_UNKNOWN_SERVICE) {
+		mutex_lock(&cpu_add_remove_lock);
+		cpu_hotplug_disabled = 1;
+		mutex_unlock(&cpu_add_remove_lock);
+	}
+
 #endif /* CONFIG_HOTPLUG_CPU */
 #ifdef CONFIG_RTAS_ERROR_LOGGING
 	rtas_last_error_token = rtas_token("rtas-last-error");
Index: linux-2.6.19-rc5/kernel/cpu.c
===================================================================
--- linux-2.6.19-rc5.orig/kernel/cpu.c	2006-11-08 07:54:20.000000000 +0530
+++ linux-2.6.19-rc5/kernel/cpu.c	2006-11-13 17:36:22.000000000 +0530
@@ -16,7 +16,7 @@
 #include <linux/mutex.h>
 
 /* This protects CPUs going up and down... */
-static DEFINE_MUTEX(cpu_add_remove_lock);
+DEFINE_MUTEX(cpu_add_remove_lock);
 static DEFINE_MUTEX(cpu_bitmask_lock);
 
 static __cpuinitdata RAW_NOTIFIER_HEAD(cpu_chain);
@@ -24,7 +24,7 @@
 /* If set, cpu_up and cpu_down will return -EBUSY and do nothing.
  * Should always be manipulated under cpu_add_remove_lock
  */
-static int cpu_hotplug_disabled;
+int cpu_hotplug_disabled;
 
 #ifdef CONFIG_HOTPLUG_CPU
 

--------------010003070309090909070800--
