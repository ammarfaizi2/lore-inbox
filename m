Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267227AbTBIMI7>; Sun, 9 Feb 2003 07:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267260AbTBIMId>; Sun, 9 Feb 2003 07:08:33 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:12112
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267227AbTBIL7y>; Sun, 9 Feb 2003 06:59:54 -0500
Date: Sun, 9 Feb 2003 07:08:39 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5][15/15] smp_call_function/_on_cpu - fallout
Message-ID: <Pine.LNX.4.50.0302090701410.2812-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes smp_call_function users in none architecture specific 
code.

 drivers/char/agp/agp.h   |    2 +-
 drivers/s390/char/sclp.c |    2 +-
 drivers/s390/net/iucv.c  |    4 ++--
 fs/buffer.c              |    2 +-
 mm/slab.c                |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.5.59-bk/drivers/char/agp/agp.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/drivers/char/agp/agp.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 agp.h
--- linux-2.5.59-bk/drivers/char/agp/agp.h	9 Feb 2003 09:08:43 -0000	1.1.1.1
+++ linux-2.5.59-bk/drivers/char/agp/agp.h	9 Feb 2003 09:23:29 -0000
@@ -42,7 +42,7 @@
 
 static void __attribute__((unused)) global_cache_flush(void)
 {
-	if (smp_call_function(ipi_handler, NULL, 1, 1) != 0)
+	if (smp_call_function(ipi_handler, NULL, 1) != 0)
 		panic(PFX "timed out waiting for the other CPUs!\n");
 	flush_agp_cache();
 }
Index: linux-2.5.59-bk/drivers/s390/char/sclp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/drivers/s390/char/sclp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 sclp.c
--- linux-2.5.59-bk/drivers/s390/char/sclp.c	9 Feb 2003 09:08:59 -0000	1.1.1.1
+++ linux-2.5.59-bk/drivers/s390/char/sclp.c	9 Feb 2003 09:23:29 -0000
@@ -481,7 +481,7 @@
 do_machine_quiesce(void)
 {
 	cpu_quiesce_map = cpu_online_map;
-	smp_call_function(do_load_quiesce_psw, NULL, 0, 0);
+	smp_call_function(do_load_quiesce_psw, NULL, 0);
 	do_load_quiesce_psw(NULL);
 }
 #else
Index: linux-2.5.59-bk/drivers/s390/net/iucv.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/drivers/s390/net/iucv.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 iucv.c
--- linux-2.5.59-bk/drivers/s390/net/iucv.c	9 Feb 2003 09:09:00 -0000	1.1.1.1
+++ linux-2.5.59-bk/drivers/s390/net/iucv.c	9 Feb 2003 09:23:29 -0000
@@ -620,7 +620,7 @@
 	if (smp_processor_id() == 0)
 		iucv_declare_buffer_cpu0(&b2f0_result);
 	else
-		smp_call_function(iucv_declare_buffer_cpu0, &b2f0_result, 0, 1);
+		smp_call_function(iucv_declare_buffer_cpu0, &b2f0_result, 1);
 	iucv_debug(1, "Address of EIB = %p", iucv_external_int_buffer);
 	if (b2f0_result == 0x0deadbeef)
 	    b2f0_result = 0xaa;
@@ -642,7 +642,7 @@
 		if (smp_processor_id() == 0)
 			iucv_retrieve_buffer_cpu0(0);
 		else
-			smp_call_function(iucv_retrieve_buffer_cpu0, 0, 0, 1);
+			smp_call_function(iucv_retrieve_buffer_cpu0, NULL, 1);
 		declare_flag = 0;
 	}
 	iucv_debug(1, "exiting");
Index: linux-2.5.59-bk/fs/buffer.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/fs/buffer.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 buffer.c
--- linux-2.5.59-bk/fs/buffer.c	9 Feb 2003 09:09:10 -0000	1.1.1.1
+++ linux-2.5.59-bk/fs/buffer.c	9 Feb 2003 09:23:29 -0000
@@ -1408,7 +1408,7 @@
 {
 	preempt_disable();
 	invalidate_bh_lru(NULL);
-	smp_call_function(invalidate_bh_lru, NULL, 1, 1);
+	smp_call_function(invalidate_bh_lru, NULL, 1);
 	preempt_enable();
 }
 
Index: linux-2.5.59-bk/mm/slab.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/mm/slab.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 slab.c
--- linux-2.5.59-bk/mm/slab.c	9 Feb 2003 09:09:35 -0000	1.1.1.1
+++ linux-2.5.59-bk/mm/slab.c	9 Feb 2003 09:23:29 -0000
@@ -1121,7 +1121,7 @@
 	func(arg);
 	local_irq_enable();
 
-	if (smp_call_function(func, arg, 1, 1))
+	if (smp_call_function(func, arg, 1))
 		BUG();
 }
 
