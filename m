Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271679AbRH0Jod>; Mon, 27 Aug 2001 05:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271683AbRH0JoY>; Mon, 27 Aug 2001 05:44:24 -0400
Received: from subcentral.mendosus.org ([195.196.16.180]:58119 "EHLO
	subcentral.mendosus.org") by vger.kernel.org with ESMTP
	id <S271679AbRH0JoN>; Mon, 27 Aug 2001 05:44:13 -0400
Date: Mon, 27 Aug 2001 10:43:16 +0200 (CEST)
From: Per Niva <pna@mendosus.org>
To: <hpa@zytor.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Added devfs support for i386 msr/cpuid driver
Message-ID: <Pine.LNX.4.33.0108271031010.12684-102000@subcentral.mendosus.org>
Organization: Mendosus
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-993807344-580412850-998901796=:12684"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---993807344-580412850-998901796=:12684
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi all,

I added devfs support to the i386 msr/cpuid driver,
along the lines in the microcode/mtrr drivers.

Please CC me any replies personally, as I don't
regularly follow the list.


Regards,


	Per Niva


----------------------------------------------------
pna@mendosus.org                     +46 705 509 654
"Beware - the world will never be the same again..."



--- arch/i386/kernel/msr.c.orig	Wed Aug 22 18:24:39 2001
+++ arch/i386/kernel/msr.c	Wed Aug 22 17:35:24 2001
@@ -22,6 +22,11 @@
  *
  * This driver uses /dev/cpu/%d/msr where %d is the minor number, and on
  * an SMP box will direct the access to CPU %d.
+ *
+ * ChangeLog
+ *
+ * 2001-08-22   Per Niva <pna@mendosus.org>
+ *              Added support for devfs
  */

 #include <linux/module.h>
@@ -34,12 +39,17 @@
 #include <linux/poll.h>
 #include <linux/smp.h>
 #include <linux/major.h>
+#include <linux/devfs_fs_kernel.h>

 #include <asm/processor.h>
 #include <asm/msr.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>

+
+static devfs_handle_t devfs_handle;
+
+
 /* Note: "err" is handled in a funny way below.  Otherwise one version
    of gcc or another breaks. */

@@ -250,18 +260,28 @@

 int __init msr_init(void)
 {
+#ifdef CONFIG_DEVFS_FS
+    devfs_handle = devfs_register(NULL, "cpu/msr", DEVFS_FL_DEFAULT, 0, 0,
+                                  S_IFREG | S_IRUGO | S_IWUSR,
+                                  &msr_fops, NULL);
+#else
   if (register_chrdev(MSR_MAJOR, "cpu/msr", &msr_fops)) {
     printk(KERN_ERR "msr: unable to get major %d for msr\n",
 	   MSR_MAJOR);
     return -EBUSY;
   }
+#endif

   return 0;
 }

 void __exit msr_exit(void)
 {
+#ifdef CONFIG_DEVFS_FS
+    devfs_unregister(devfs_handle);
+#else
   unregister_chrdev(MSR_MAJOR, "cpu/msr");
+#endif
 }

 module_init(msr_init);



--- arch/i386/kernel/cpuid.c.orig	Wed Aug 22 18:24:31 2001
+++ arch/i386/kernel/cpuid.c	Wed Aug 22 18:18:03 2001
@@ -23,6 +23,11 @@
  *
  * This driver uses /dev/cpu/%d/cpuid where %d is the minor number, and on
  * an SMP box will direct the access to CPU %d.
+ *
+ * ChangeLog
+ *
+ * 2001-08-22   Per Niva <pna@mendosus.org>
+ *              Added support for devfs
  */

 #include <linux/module.h>
@@ -35,12 +40,17 @@
 #include <linux/poll.h>
 #include <linux/smp.h>
 #include <linux/major.h>
+#include <linux/devfs_fs_kernel.h>

 #include <asm/processor.h>
 #include <asm/msr.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>

+
+static devfs_handle_t devfs_handle;
+
+
 #ifdef CONFIG_SMP

 struct cpuid_command {
@@ -142,18 +152,27 @@

 int __init cpuid_init(void)
 {
+#ifdef CONFIG_DEVFS_FS
+    devfs_handle = devfs_register(NULL, "cpu/cpuid", DEVFS_FL_DEFAULT, 0, 0,
+                                  S_IFREG | S_IRUGO | S_IWUSR,
+                                  &cpuid_fops, NULL);
+#else
   if (register_chrdev(CPUID_MAJOR, "cpu/cpuid", &cpuid_fops)) {
     printk(KERN_ERR "cpuid: unable to get major %d for cpuid\n",
 	   CPUID_MAJOR);
     return -EBUSY;
   }
-
+#endif
   return 0;
 }

 void __exit cpuid_exit(void)
 {
-  unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");
+#ifdef CONFIG_DEVFS_FS
+    devfs_unregister(devfs_handle);
+#else
+    unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");
+#endif
 }

 module_init(cpuid_init);

---993807344-580412850-998901796=:12684
Content-Type: APPLICATION/x-gzip; name="patch-2.4.9-devfs-msr.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0108271043160.12684@subcentral.mendosus.org>
Content-Description: 
Content-Disposition: attachment; filename="patch-2.4.9-devfs-msr.gz"

H4sICD8FijsAA3BhdGNoLTIuNC45LWRldmZzLW1zcgCVU39v0zAU/Jt8ilMn
ULekTX9soytjahntNOjaqaUgJKQoTZzWLLEjO1k3wb47z8ko64AJrCRy/N49
n++ea7UafBWsXN7uHLpXTAkWu4lW9aAuFV8++8RC9PMlWi00O93Wfrd9hFaj
0bRs2/4LcAvzsts+IFiJ6fVQa7WcQ9j0bTbR61nAnnnxYcU1QsWvmUKumYYb
sms3SHP3eWjKYr1iiuF5CMrLVgwJF1JB5MmCKQe+CCFFUckXmF1cYiFvsOZx
jJArFmQFxg8CpgkucXo5p1p1y6bt6cXpyhdLNpLLzYohXGt0iC+AS2I15tc+
jlPh9xImQqlzTQotT4rkrdEPQxJA52kqVYaIWNJRIm3IuRYs7HARxHnIcBxz
kd+4iQzzmNVXJ4U+7X2n2YLdPnKaLwuBHqenMo5N8m8BnaR/XE/8r1KZiP04
UvDy6CntK9AP8b5O3FRJI1pZ4VHM2P37al7K/IeIvtUZS8ptbMvWmZ/xoFTH
IwPCmHnZ1u8rk2bB3cNYZqyLClOqYjqgDFMzCPiIciFusfZvsWCxXNeBCbmt
1lwzagoG6inNi+4AZIRlEIBM8YU0WVgo5l/pemlO0aEHDafZoR49bDitTuGB
RRtl8DwueAY6dTGpXkse7lr4ZoSNQhbhdDIenp95bwcfhzNvOKPWoPHwPHh9
/6vYkpMWqjqej0YOKqbRqW7FwT14RFWG/fnog4OGecpaT4+Zdz6cDs7w3cym
87NJOfs0n03/Cf/CnCySqXZgaO2S+jss1swIxyNUf5L2gpWiY1QvZlPvov9u
Mt06wKbK7i5JUxROFcl3VX0/mI69wXSKCqV0kQt/QZLQbVwyUtV0qbnf5sJQ
/IuoOBaeEXqzDREqyimW5UqgNngzn30u1u4MUxHyyPxYv1IaFL0z9hmryD92
c++fmfyXf7nYWPbQ0C2NfuU8pVAJKckW3Mr7X7bUz96ipB8OgREUmgUAAA==
---993807344-580412850-998901796=:12684
Content-Type: APPLICATION/x-gzip; name="patch-2.4.9-devfs-cpuid.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0108271043161.12684@subcentral.mendosus.org>
Content-Description: 
Content-Disposition: attachment; filename="patch-2.4.9-devfs-cpuid.gz"

H4sICD8FijsAA3BhdGNoLTIuNC45LWRldmZzLWNwdWlkAJVUYU/bMBD9vPyK
E4ipXZKmSYFVjKF20CK2UlBLhyZNikLspB6JHdlJYdr47zs7QEvHNhY5lWPf
e3737lzXdSGS8dxjne6ud00lp5kXFxUjrbglJEtfXVIC/SqFIAC/uxds73V8
CNpt37Jt+4/QNRSOdqdG9XrgBh1nF2z89X3o9SyAN/qFizlTQCRbUAmVogo8
Qhea0dsiNTHczKmksEUAI8s5hZxxIYFX+RWVDkScgOCGK+IwPT2HK3ELNyzL
gDBJ49JgojimCuECDs9nyNWybBSALxzOI57SkUgfV7Rkt911MQ2Ac9Q1ZosI
9gse9XLKiVCVQpfSAxP85OkTghaoqiiELCFBlZhMorQ4zwILNhmPs4pQ2M8Y
r269XJAqo635gXGos+P4Adjbbcd/ayxaDy9Elung3zZUXjy7nkffhNQ79vqO
0RXiqEto0Kv4SOVeIYU2rWZY28vVc6tVbfMzO+q7KmleH2NbtiqjksW1OyEW
gGQ0LJ98vtNhmiUhNIHDs/Hw5DjE6mqZqpQV1tV0RxiLPNc98MN46G8Hjt8F
298JnKB20QLGSwhDxtkDRk8bC8FI00Kc/fSQo8Hn4TQcTrG8+Kxqgvf3n5Km
DPORjfFsNHJgQ7erYd5w4B4+Qp5hfza6cKCtR83292cangwng2P4qWeT2fFZ
PbucTScvwr+us0tEoRzQ0pro4ibNFMUOBJZA40F4GM8lptLAy3ByFJ72P55N
1tJY4Wo20SRzQCHRyuvGp8FkHA4mE4NgZA8qHl2hPXi7UlqC6Tp9X/UFMBFf
+YZjwStkWDkQxRlSSctKcnAHH2bTL2btznK1bk5YYi0D2rh3p8upC4f1pLeP
9dTTZT1dQEEvzdRY9M/6L/kaqw2x9NfE/uep9wmanOp/groxlz2KYb8AJldG
ZqwFAAA=
---993807344-580412850-998901796=:12684--
