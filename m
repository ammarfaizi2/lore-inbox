Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129404AbQKOW7Z>; Wed, 15 Nov 2000 17:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbQKOW7Q>; Wed, 15 Nov 2000 17:59:16 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:41354 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129404AbQKOW7H>;
	Wed, 15 Nov 2000 17:59:07 -0500
Date: Wed, 15 Nov 2000 17:29:05 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] misc fixes to 11-pre5
Message-ID: <Pine.GSO.4.21.0011151715060.8442-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	* baycom_epp: yet another missed x86_capability instance.
	* soundmodem/sm.h: ditto.
	* wan/comx.c: fixed typo in call of remove_proc_entry() (the second
argument is proc_dir_entry *, not **)
	* scsi/gdth.c::gdth_flush() had a path with use of uninitialized
variable:

	/* bar is not initialized */
	if (foo)
		bar = baz();
	if (foo && bar) {
		/* code that doesn't change foo or bar */
	}
	/* If foo was NULL we have random junk in bar */
	if (bar)
		quux(bar);
	if (foo)
		barf(foo);
	return;

Fixed variant:

	if (!foo)
		return;
	bar = baz();
	if (bar) {
		/* same code */
		quux(bar);
	}
	barf(foo);
	return;

- same, except that we don't do bogus if (bar) quux(bar); in case if bar
had never been initialized.

	Please, apply. And yes, it really passes compile ;-/
								Cheers,
									Al
diff -urN rc11-pre5/drivers/net/hamradio/baycom_epp.c linux-test/drivers/net/hamradio/baycom_epp.c
--- rc11-pre5/drivers/net/hamradio/baycom_epp.c	Thu Nov  2 22:38:36 2000
+++ linux-test/drivers/net/hamradio/baycom_epp.c	Wed Nov 15 04:26:44 2000
@@ -814,7 +814,7 @@
 #ifdef __i386__
 #define GETTICK(x)                                                \
 ({                                                                \
-	if (current_cpu_data.x86_capability & X86_FEATURE_TSC)    \
+	if (test_bit(X86_FEATURE_TSC, &current_cpu_data.x86_capability))    \
 		__asm__ __volatile__("rdtsc" : "=a" (x) : : "dx");\
 })
 #else /* __i386__ */
diff -urN rc11-pre5/drivers/net/hamradio/soundmodem/sm.h linux-test/drivers/net/hamradio/soundmodem/sm.h
--- rc11-pre5/drivers/net/hamradio/soundmodem/sm.h	Sun Sep 12 20:43:29 1999
+++ linux-test/drivers/net/hamradio/soundmodem/sm.h	Wed Nov 15 04:35:00 2000
@@ -299,7 +299,7 @@
 
 #ifdef __i386__
 
-#define HAS_RDTSC (current_cpu_data.x86_capability & X86_FEATURE_TSC)
+#define HAS_RDTSC (test_bit(X86_FEATURE_TSC, &current_cpu_data.x86_capability))
 
 /*
  * only do 32bit cycle counter arithmetic; we hope we won't overflow.
diff -urN rc11-pre5/drivers/net/wan/comx.c linux-test/drivers/net/wan/comx.c
--- rc11-pre5/drivers/net/wan/comx.c	Tue Nov 14 20:26:21 2000
+++ linux-test/drivers/net/wan/comx.c	Wed Nov 15 07:36:03 2000
@@ -855,7 +855,7 @@
 cleanup_filename_hardware:
 	remove_proc_entry(FILENAME_HARDWARE, new_dir);
 cleanup_new_dir:
-	remove_proc_entry(dentry->d_name.name, &comx_root_dir);
+	remove_proc_entry(dentry->d_name.name, comx_root_dir);
 cleanup_dev:
 	kfree(dev);
 	return ret;
diff -urN rc11-pre5/drivers/scsi/gdth.c linux-test/drivers/scsi/gdth.c
--- rc11-pre5/drivers/scsi/gdth.c	Tue Nov 14 20:26:25 2000
+++ linux-test/drivers/scsi/gdth.c	Wed Nov 15 07:38:23 2000
@@ -3577,11 +3577,12 @@
     ha = HADATA(gdth_ctr_tab[hanum]);
 
     sdev = scsi_get_host_dev(gdth_ctr_tab[hanum]);
-    if(sdev)
-    	scp  = scsi_allocate_device(sdev, 1, FALSE);
-    
-    if(sdev!= NULL && scp != NULL)
-    {
+    if (!sdev)
+	return;
+
+    scp  = scsi_allocate_device(sdev, 1, FALSE);
+
+    if (scp) {
         scp->cmd_len = 12;
         scp->use_sg = 0;
 
@@ -3597,11 +3598,9 @@
                  gdth_do_cmd(scp, &gdtcmd, 30);
             }
         }
-    }
-    if(scp!=NULL)
     	scsi_release_command(scp);
-    if(sdev!=NULL)
-        scsi_free_host_dev(sdev);
+    }
+    scsi_free_host_dev(sdev);
 }
 
 /* shutdown routine */


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
