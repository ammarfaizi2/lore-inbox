Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273066AbRIJAgB>; Sun, 9 Sep 2001 20:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273113AbRIJAfx>; Sun, 9 Sep 2001 20:35:53 -0400
Received: from johnson.mail.mindspring.net ([207.69.200.177]:17963 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273066AbRIJAfj>; Sun, 9 Sep 2001 20:35:39 -0400
Subject: Re: [PATCH] Documentation/sysctl/vm.txt Updating
From: Robert Love <rml@tech9.net>
To: laughing@shared-source.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.08.07.08 (Preview Release)
Date: 09 Sep 2001 20:36:24 -0400
Message-Id: <1000082187.18579.3.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-09-09 at 20:29, Robert Love wrote:
> the bdflush_param and the resulting /proc/vm/bdflush interface has
> changed since Documentation/sysctl/vm.txt was written, and vm.txt has
> not been updated.
> 
> the following patch, against 2.4.10-pre6, updates the documentation for
> the revised structure along with more information.
> 
> I also stick a notice into fs/buffer.c (after another such notice) to
> keep the file in sync with changes to the structure.
> 
> please, apply.

Alan, here is a diff against 2.4.9-ac10, too.


--- linux-2.4.9-ac10/Documentation/sysctl/vm.txt	Sun Sep  9 20:18:08 2001
+++ linux/Documentation/sysctl/vm.txt	Sun Sep  9 20:20:21 2001
@@ -34,32 +34,29 @@
 This file controls the operation of the bdflush kernel
 daemon. The source code to this struct can be found in
 linux/fs/buffer.c. It currently contains 9 integer values,
-of which 6 are actually used by the kernel.
+of which 4 are actually used by the kernel.
 
 From linux/fs/buffer.c:
 --------------------------------------------------------------
-union bdflush_param{
-    struct {
-        int nfract;      /* Percentage of buffer cache dirty to
-                            activate bdflush */
-        int ndirty;      /* Maximum number of dirty blocks to
-                            write out per wake-cycle */
-        int nrefill;     /* Number of clean buffers to try to
-                            obtain each time we call refill */
-        int nref_dirt;   /* Dirty buffer threshold for activating
-                            bdflush when trying to refill buffers. */
-        int dummy1;      /* unused */
-        int age_buffer;  /* Time for normal buffer to age before
-                            we flush it */
-        int age_super;   /* Time for superblock to age before we
-                            flush it */
-        int dummy2;      /* unused */
-        int dummy3;      /* unused */
-    } b_un;
-    unsigned int data[N_PARAM];
-} bdf_prm = {{40, 500, 64, 256, 15, 30*HZ, 5*HZ, 1884, 2}};
+union bdflush_param {
+	struct {
+		int nfract;	/* Percentage of buffer cache dirty to 
+				   activate bdflush */
+		int dummy1;	/* old "ndirty" */
+		int dummy2;	/* old "nrefill" */
+		int dummy3;	/* unused */
+		int interval;	/* jiffies delay between kupdate flushes */
+		int age_buffer;	/* Time for normal buffer to age */
+		int nfract_sync;/* Percentage of buffer cache dirty to 
+				   activate bdflush synchronously */
+		int dummy4;	/* unused */
+		int dummy5;	/* unused */
+	} b_un;
+	unsigned int data[N_PARAM];
+} bdf_prm = {{30, 64, 64, 256, 5*HZ, 30*HZ, 60, 0, 0}};
 --------------------------------------------------------------
 
+int nfract:
 The first parameter governs the maximum number of dirty
 buffers in the buffer cache. Dirty means that the contents
 of the buffer still have to be written to disk (as opposed
@@ -67,32 +64,31 @@
 Setting this to a high value means that Linux can delay disk
 writes for a long time, but it also means that it will have
 to do a lot of I/O at once when memory becomes short. A low
-value will spread out disk I/O more evenly.
-
-The second parameter (ndirty) gives the maximum number of
-dirty buffers that bdflush can write to the disk in one time.
-A high value will mean delayed, bursty I/O, while a small
-value can lead to memory shortage when bdflush isn't woken
-up often enough...
-
-The third parameter (nrefill) is the number of buffers that
-bdflush will add to the list of free buffers when
-refill_freelist() is called. It is necessary to allocate free
-buffers beforehand, since the buffers often are of a different
-size than memory pages and some bookkeeping needs to be done
-beforehand. The higher the number, the more memory will be
-wasted and the less often refill_freelist() will need to run.
-
-When refill_freelist() comes across more than nref_dirt dirty
-buffers, it will wake up bdflush.
-
-Finally, the age_buffer and age_super parameters govern the
-maximum time Linux waits before writing out a dirty buffer
-to disk. The value is expressed in jiffies (clockticks), the
-number of jiffies per second is 100, except on Alpha machines
-(1024). Age_buffer is the maximum age for data blocks, while
-age_super is for filesystem metadata.
-
+value will spread out disk I/O more evenly, at the cost of
+more frequent I/O operations.  The default value is 30%,
+the minimum is 0%, and the maximum is 100%.
+
+int interval:
+The fifth parameter, interval, is the minimum rate at
+which kupdate will wake and flush.  The value is expressed in
+jiffies (clockticks), the number of jiffies per second is
+normally 100 (Alpha is 1024). Thus, x*HZ is x seconds.  The
+default value is 5 seconds, the minimum is 0 seconds, and the
+maximum is 600 seconds.
+
+int age_buffer:
+The sixth parameter, age_buffer, governs the maximum time
+Linux waits before writing out a dirty buffer to disk.  The
+value is in jiffies.  The default value is 30 seconds,
+the minimum is 1 second, and the maximum 6,000 seconds.
+
+int nfract_sync:
+The seventh parameter, nfract_sync, governs the percentage
+of buffer cache that is dirty before bdflush activates
+synchronously.  This can be viewed as the hard limit before
+bdflush forces buffers to disk.  The default is 60%, the
+minimum is 0%, and the maximum is 100%.
+ 
 ==============================================================
 buffermem:
 
--- linux-2.4.9-ac10/fs/buffer.c	Sun Sep  9 20:18:08 2001
+++ linux/fs/buffer.c	Sun Sep  9 20:20:21 2001
@@ -105,7 +105,8 @@
 atomic_t buffermem_pages = ATOMIC_INIT(0);
 
 /* Here is the parameter block for the bdflush process. If you add or
- * remove any of the parameters, make sure to update kernel/sysctl.c.
+ * remove any of the parameters, make sure to update kernel/sysctl.c
+ * and the documentation at linux/Documentation/sysctl/vm.txt.
  */
 
 #define N_PARAM 9



-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

