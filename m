Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271721AbRHQViF>; Fri, 17 Aug 2001 17:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271722AbRHQVhz>; Fri, 17 Aug 2001 17:37:55 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:31884 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S271721AbRHQVhj>; Fri, 17 Aug 2001 17:37:39 -0400
Message-Id: <5.1.0.14.2.20010817223250.04561a10@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 17 Aug 2001 22:37:53 +0100
To: "Michel A. S. Pereira - KIDMumU|ResolveBucha" 
	<michelcultivo@uol.com.br>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Vmware and 2.4.9
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B7D7FA8.7E57F2AB@uol.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 21:33 17/08/2001, Michel A. S. Pereira - KIDMumU|ResolveBucha wrote:
>         Who has or have made a patch to vmware run on Kernel 2.4.9?

Hi, The below patches make it compile for me on 2.4.9 and the modules load. 
And vmware start and boots. I haven't had a chance to install a guest os so 
I can't guarantee the modules work but you can try them. (-;

Appologies in advance if Eudora mangles the white space. I can email actual 
attachments on request if anyone is interested...

Best regards,

         Anton

--- patch 1 for vmmon module ---
diff -urN vmmon-only/common/hostif.h 
/usr/lib/vmware/modules/source/vmmon-only/common/hostif.h
--- vmmon-only/common/hostif.h  Thu May 10 02:33:58 2001
+++ /usr/lib/vmware/modules/source/vmmon-only/common/hostif.h   Thu Aug 16 
00:31:31 2001
@@ -32,10 +32,10 @@

  #ifdef KERNEL_2_1
  # include "vm_types.h"
-# undef PAGE_SIZE
-# undef PAGE_MASK
-# undef PAGE_OFFSET
-# undef APIC_ID_MASK
+//# undef PAGE_SIZE
+//# undef PAGE_MASK
+//# undef PAGE_OFFSET
+//# undef APIC_ID_MASK
  # include <asm/page.h>
  # ifndef __PAGE_OFFSET
  #  error __PAGE_OFFSET not defined
diff -urN vmmon-only/common/task.c 
/usr/lib/vmware/modules/source/vmmon-only/common/task.c
--- vmmon-only/common/task.c    Thu May 10 02:33:58 2001
+++ /usr/lib/vmware/modules/source/vmmon-only/common/task.c     Thu Aug 16 
00:41:56 2001
@@ -133,7 +133,7 @@
  #define APICR_LVT1       0x36
  #define APIC_LVT_MASK            0x10000
  #define APIC_LVT_DELVMODE_NMI    0x400
-#define APIC_LVT_MASKED(_lvt)    (_lvt & APIC_LVT_MASK)
+#define APIC_LVT_MASKED_VMWARE(_lvt)    (_lvt & APIC_LVT_MASK)
  #define APIC_LVT_DELVMODE(_lvt)  (_lvt & 0x700)
  #define APIC_LINT0_REG(_apic)    (_apic[APICR_LVT0][0])
  #define APIC_LINT1_REG(_apic)   (_apic[APICR_LVT1][0])
@@ -145,13 +145,13 @@
     if (vm->hostAPIC) {
        reg = APIC_LINT0_REG(vm->hostAPIC);
        if ((APIC_LVT_DELVMODE(reg) == APIC_LVT_DELVMODE_NMI) &&
-         (! APIC_LVT_MASKED(reg))) {
+         (! APIC_LVT_MASKED_VMWARE(reg))) {
          APIC_LINT0_REG(vm->hostAPIC) = reg | APIC_LVT_MASK;
          *lint0NMI = TRUE;
        }
        reg = APIC_LINT1_REG(vm->hostAPIC);
        if ((APIC_LVT_DELVMODE(reg) == APIC_LVT_DELVMODE_NMI) &&
-         (! APIC_LVT_MASKED(reg))) {
+         (! APIC_LVT_MASKED_VMWARE(reg))) {
          APIC_LINT1_REG(vm->hostAPIC) = reg | APIC_LVT_MASK;
          *lint1NMI = TRUE;
        }
diff -urN vmmon-only/include/vm_types.h 
/usr/lib/vmware/modules/source/vmmon-only/include/vm_types.h
--- vmmon-only/include/vm_types.h       Thu May 10 02:33:58 2001
+++ /usr/lib/vmware/modules/source/vmmon-only/include/vm_types.h        Thu 
Aug 16 00:32:48 2001
@@ -16,6 +16,7 @@
  #define _VM_TYPES_H_

  #include "vm_basic_types.h"
+#include <asm/page.h>

  #define EXTERN        extern
  /*
diff -urN vmmon-only/include/x86.h 
/usr/lib/vmware/modules/source/vmmon-only/include/x86.h
--- vmmon-only/include/x86.h    Thu May 10 02:33:58 2001
+++ /usr/lib/vmware/modules/source/vmmon-only/include/x86.h     Thu Aug 16 
00:37:48 2001
@@ -8,7 +8,7 @@
  #define _X86_H_

  #include "vm_types.h"
-
+#include <asm/apicdef.h>

  #define SIZE_8BIT  1
  #define SIZE_16BIT 2
diff -urN vmmon-only/linux/driver.c 
/usr/lib/vmware/modules/source/vmmon-only/linux/driver.c
--- vmmon-only/linux/driver.c   Thu May 10 02:33:58 2001
+++ /usr/lib/vmware/modules/source/vmmon-only/linux/driver.c    Thu Aug 16 
00:28:49 2001
@@ -925,7 +925,7 @@
           current->fsuid == current->uid &&
            current->egid == current->gid &&
           current->fsgid == current->gid) {
-        current->dumpable = 1;
+        current->mm->dumpable = 1;
        }
        break;

--- patch 1 end ---
--- patch 2 for vmppuser module ---
diff -urN vmppuser-only/ppdev.c 
/usr/lib/vmware/modules/source/vmppuser-only/ppdev.c
--- vmppuser-only/ppdev.c       Thu May 10 02:33:58 2001
+++ /usr/lib/vmware/modules/source/vmppuser-only/ppdev.c        Fri Aug 17 
22:22:44 2001
@@ -64,8 +64,8 @@
  #define CHRDEV "ppuser"
  #endif

-#ifndef min
-#define min(a,b) ((a) < (b) ? (a) : (b))
+#ifndef _min
+#define _min(a,b) ((a) < (b) ? (a) : (b))
  #endif

  struct pp_struct {
@@ -123,12 +123,12 @@
                 return -EINVAL;
         }

-       kbuffer = kmalloc (min (count, PP_BUFFER_SIZE), GFP_KERNEL);
+       kbuffer = kmalloc (_min (count, PP_BUFFER_SIZE), GFP_KERNEL);
         if (!kbuffer)
                 return -ENOMEM;

         while (bytes_read < count) {
-               ssize_t need = min(count - bytes_read, PP_BUFFER_SIZE);
+               ssize_t need = _min(count - bytes_read, PP_BUFFER_SIZE);

                 got = parport_read (pp->pdev->port, kbuffer, need);

@@ -177,12 +177,12 @@
                 return -EINVAL;
         }

-       kbuffer = kmalloc (min (count, PP_BUFFER_SIZE), GFP_KERNEL);
+       kbuffer = kmalloc (_min (count, PP_BUFFER_SIZE), GFP_KERNEL);
         if (!kbuffer)
                 return -ENOMEM;

         while (bytes_written < count) {
-               ssize_t n = min(count - bytes_written, PP_BUFFER_SIZE);
+               ssize_t n = _min(count - bytes_written, PP_BUFFER_SIZE);

                 if (copy_from_user (kbuffer, buf + bytes_written, n)) {
                         bytes_written = -EFAULT;
@@ -650,16 +650,13 @@
  }

  static struct file_operations pp_fops = {
-       pp_lseek,
-       pp_read,
-       pp_write,
-       NULL,   /* pp_readdir */
-       pp_poll,
-       pp_ioctl,
-       NULL,   /* pp_mmap */
-       pp_open,
-       NULL,   /* pp_flush */
-       pp_release
+       llseek:         pp_lseek,
+       read:           pp_read,
+       write:          pp_write,
+       poll:           pp_poll,
+       ioctl:          pp_ioctl,
+       open:           pp_open,
+       release:        pp_release,
  };

  /* FIXME: Check __attribute__((unused)) with gcc-2.7.2 */
diff -urN vmppuser-only/ppuser.c 
/usr/lib/vmware/modules/source/vmppuser-only/ppuser.c
--- vmppuser-only/ppuser.c      Thu May 10 02:33:58 2001
+++ /usr/lib/vmware/modules/source/vmppuser-only/ppuser.c       Fri Aug 17 
22:20:58 2001
@@ -23,8 +23,8 @@

  #define PP_VERSION "ppuser: User-space parallel port driver"

-#ifndef min
-#define min(a,b) ((a) < (b) ? (a) : (b))
+#ifndef _min
+#define _min(a,b) ((a) < (b) ? (a) : (b))
  #endif

  /* The device minor encodes the parport number and (arbitrary)
@@ -93,7 +93,7 @@
                 return -EPERM;
         }

-       kbuffer = kmalloc (min (count, PP_BUFFER_SIZE), GFP_KERNEL);
+       kbuffer = kmalloc (_min (count, PP_BUFFER_SIZE), GFP_KERNEL);
         if (!kbuffer)
                 return -ENOMEM;

@@ -101,7 +101,7 @@
                 struct callback_info cbinfo;
                 init_waitqueue (&cbinfo.waitq);
                 while (bytes_read < count) {
-                       ssize_t need = min(count - bytes_read, PP_BUFFER_SIZE);
+                       ssize_t need = _min(count - bytes_read, 
PP_BUFFER_SIZE);

                         cbinfo.n = 0;
                         error = port->ops->ecp_read_block (port, kbuffer, 
need,
@@ -127,7 +127,7 @@
         else if (mode == PARPORT_MODE_PCEPP) {
                 ssize_t got;
                 while (bytes_read < count) {
-                       ssize_t need = min(count - bytes_read, PP_BUFFER_SIZE);
+                       ssize_t need = _min(count - bytes_read, 
PP_BUFFER_SIZE);

                         got = port->ops->epp_read_block (port, kbuffer, need);

@@ -173,7 +173,7 @@
                 return -EPERM;
         }

-       kbuffer = kmalloc (min (count, PP_BUFFER_SIZE), GFP_KERNEL);
+       kbuffer = kmalloc (_min (count, PP_BUFFER_SIZE), GFP_KERNEL);
         if (!kbuffer)
                 return -ENOMEM;

@@ -181,7 +181,7 @@
                 struct callback_info cbinfo;
                 init_waitqueue (&cbinfo.waitq);
                 while (bytes_written < count) {
-                       ssize_t n = min(count - bytes_written, PP_BUFFER_SIZE);
+                       ssize_t n = _min(count - bytes_written, 
PP_BUFFER_SIZE);

                         error = -EFAULT;
                         if (copy_from_user (kbuffer, buf + bytes_written, n))
@@ -207,7 +207,7 @@
         else if (mode == PARPORT_MODE_PCEPP) {
                 ssize_t wrote;
                 while (bytes_written < count) {
-                       ssize_t n = min(count - bytes_written, PP_BUFFER_SIZE);
+                       ssize_t n = _min(count - bytes_written, 
PP_BUFFER_SIZE);

                         error = -EFAULT;
                         if (copy_from_user (kbuffer, buf + bytes_written, n))
--- patch 2 end ---


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

