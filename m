Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270685AbUJUK4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270685AbUJUK4o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 06:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270670AbUJUKzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 06:55:19 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:21171 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S270651AbUJUKve
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 06:51:34 -0400
Message-ID: <417794AC.8060604@in.ibm.com>
Date: Thu, 21 Oct 2004 16:21:24 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Vara Prasad <varap@us.ibm.com>
Subject: Re: [PATCH][3/4] kexec based dump: Minor bug fixes
References: <417792BA.8090205@in.ibm.com> <41779345.8080009@in.ibm.com> <41779431.5090104@in.ibm.com>
In-Reply-To: <41779431.5090104@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------090906050305070802060608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090906050305070802060608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes a problem where the kernel compilation was 
failing upon disabling PROC_FS. It also ensures the 
reboot-on-panic kernel is pointed to by a different 
variable, thereby separating the normal use of kexec from 
the crashdump situation.

Regards, Hari

--------------090906050305070802060608
Content-Type: text/plain;
 name="kd-misc-changes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kd-misc-changes.patch"


Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
Signed-off-by: Hariprasad Nellitheertha <hari@in.ibm.com>
---

 linux-2.6.9-rc4-hari/Documentation/kdump.txt    |   24 ++++++++----------------
 linux-2.6.9-rc4-hari/include/linux/crash_dump.h |   11 ++++++++---
 linux-2.6.9-rc4-hari/kernel/crash.c             |    5 ++++-
 3 files changed, 20 insertions(+), 20 deletions(-)

diff -puN Documentation/kdump.txt~kd-misc-changes Documentation/kdump.txt
--- linux-2.6.9-rc4/Documentation/kdump.txt~kd-misc-changes	2004-10-21 15:10:58.000000000 +0530
+++ linux-2.6.9-rc4-hari/Documentation/kdump.txt	2004-10-21 15:10:58.000000000 +0530
@@ -27,19 +27,11 @@ SETUP
 1) Obtain the appropriate -mm tree patch and apply it on to the vanilla
    kernel tree.
 
-2) In order to enable the kernel to boot from a non-default location, the
-   following patches (by Eric Biederman) needs to be applied.
-
-   http://www.xmission.com/~ebiederm/files/kexec/2.6.8.1-kexec3/
-	broken-out/highbzImage.i386.patch
-   http://www.xmission.com/~ebiederm/files/kexec/2.6.8.1-kexec3/
-	broken-out/vmlinux-lds.i386.patch
-
-3) Two kernels need to be built in order to get this feature working.
+2) Two kernels need to be built in order to get this feature working.
 
    For the first kernel, choose the default values for the following options.
 
-   a) Physical address where the kernel expects to be loaded
+   a) Physical address where the kernel is loaded
    b) kexec system call
    c) kernel crash dumps
 
@@ -51,28 +43,28 @@ SETUP
 
    Also ensure you have CONFIG_HIGHMEM on.
 
-4) Boot into the first kernel. You are now ready to try out kexec based crash
+3) Boot into the first kernel. You are now ready to try out kexec based crash
    dumps.
 
-5) Load the second kernel to be booted using
+4) Load the second kernel to be booted using
 
-   kexec -l <second-kernel> --args-linux --append="root=<root-dev> dump
+   kexec -p <second-kernel> --args-linux --append="root=<root-dev> dump
    init 1 memmap=exactmap memmap=640k@0 memmap=32M@16M"
 
    Note that <second-kernel> has to be a vmlinux image. bzImage will not
    work, as of now.
 
-6) Enable kexec based dumping by
+5) Enable kexec based dumping by
 
    echo 1 > /proc/kexec-dump
 
    If this is not set, the system will not do a kexec reboot in the event
    of a panic.
 
-7) System reboots into the second kernel when a panic occurs.
+6) System reboots into the second kernel when a panic occurs.
    You could write a module to call panic, for testing purposes.
 
-8) Write out the dump file using
+7) Write out the dump file using
 
    cp /proc/vmcore <dump-file>
 
diff -puN include/linux/crash_dump.h~kd-misc-changes include/linux/crash_dump.h
--- linux-2.6.9-rc4/include/linux/crash_dump.h~kd-misc-changes	2004-10-21 15:10:58.000000000 +0530
+++ linux-2.6.9-rc4-hari/include/linux/crash_dump.h	2004-10-21 15:10:58.000000000 +0530
@@ -15,15 +15,20 @@ extern void elf_kcore_store_hdr(char *, 
 #ifdef CONFIG_CRASH_DUMP
 extern ssize_t copy_oldmem_page(unsigned long, char *, size_t, int);
 extern void __crash_machine_kexec(void);
-extern void crash_enable_by_proc(void);
-extern void crash_create_proc_entry(void);
 extern int crash_dump_on;
 static inline void crash_machine_kexec(void)
 {
 	 __crash_machine_kexec();
 }
 #else
+#define crash_machine_kexec()	do { } while(0)
+#endif
+
+
+#if defined(CONFIG_CRASH_DUMP) && defined(CONFIG_PROC_FS)
+extern void crash_enable_by_proc(void);
+extern void crash_create_proc_entry(void);
+#else
 #define crash_enable_by_proc() do { } while(0)
 #define crash_create_proc_entry() do { } while(0)
-#define crash_machine_kexec()	do { } while(0)
 #endif
diff -puN kernel/crash.c~kd-misc-changes kernel/crash.c
--- linux-2.6.9-rc4/kernel/crash.c~kd-misc-changes	2004-10-21 15:10:58.000000000 +0530
+++ linux-2.6.9-rc4-hari/kernel/crash.c	2004-10-21 15:10:58.000000000 +0530
@@ -16,6 +16,7 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
+#ifdef CONFIG_PROC_FS
 /*
  * Enable kexec reboot upon panic; for dumping
  */
@@ -57,6 +58,8 @@ void crash_create_proc_entry(void)
 	}
 }
 
+#endif /* CONFIG_PROC_FS */
+
 void __crash_machine_kexec(void)
 {
 	struct kimage *image;
@@ -64,7 +67,7 @@ void __crash_machine_kexec(void)
 	if ((!crash_dump_on) || (crashed))
 		return;
 
-	image = xchg(&kexec_image, 0);
+	image = xchg(&kexec_crash_image, 0);
 	if (image) {
 		crashed = 1;
 		printk(KERN_EMERG "kexec: opening parachute\n");
_

--------------090906050305070802060608--
