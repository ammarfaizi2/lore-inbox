Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269623AbTHJOUI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 10:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269619AbTHJOSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 10:18:35 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:44046 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S269559AbTHJOSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 10:18:25 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH][2.6.0-test3] i386 msr.c devfs support 1/2
Date: Sun, 10 Aug 2003 18:16:48 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200308101251.03605.arvidjaar@mail.ru> <20030810135800.GA17154@redhat.com>
In-Reply-To: <20030810135800.GA17154@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QPlN/nLiNKCKK73"
Message-Id: <200308101816.48371.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_QPlN/nLiNKCKK73
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 10 August 2003 17:58, Dave Jones wrote:
> On Sun, Aug 10, 2003 at 12:51:03PM +0400, Andrey Borzenkov wrote:
>  > Please let me know if default permissions (644) are not appropriate.
>
> bogus. They should be set to 600. Non-root access to MSRs (even read
> only) can cause instant lockup/reboot on some CPUs if user tries to
> read non-existant MSR.
>

update patch attached.

-andrey
--Boundary-00=_QPlN/nLiNKCKK73
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.6.0-test3-msr_devfs-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.6.0-test3-msr_devfs-2.patch"

--- ../tmp/linux-2.6.0-test3/arch/i386/kernel/msr.c	2003-07-27 22:28:41.000000000 +0400
+++ linux-2.6.0-test3-smp/arch/i386/kernel/msr.c	2003-08-10 18:06:30.000000000 +0400
@@ -37,6 +37,8 @@
 #include <linux/major.h>
 #include <linux/fs.h>
 
+#include <linux/devfs_fs_kernel.h>
+
 #include <asm/processor.h>
 #include <asm/msr.h>
 #include <asm/uaccess.h>
@@ -263,17 +265,28 @@ static struct file_operations msr_fops =
 
 int __init msr_init(void)
 {
+  int i;
+
   if (register_chrdev(MSR_MAJOR, "cpu/msr", &msr_fops)) {
     printk(KERN_ERR "msr: unable to get major %d for msr\n",
 	   MSR_MAJOR);
     return -EBUSY;
   }
+
+  for (i = 0; i < NR_CPUS; i++)
+    devfs_mk_cdev(MKDEV(MSR_MAJOR, i), S_IFCHR | S_IRUSR | S_IWUSR,
+		  "cpu/%d/msr", i);
   
   return 0;
 }
 
 void __exit msr_exit(void)
 {
+  int i;
+
+  for (i = 0; i < NR_CPUS; i++)
+    devfs_remove("cpu/%d/msr", i);
+  
   unregister_chrdev(MSR_MAJOR, "cpu/msr");
 }
 

--Boundary-00=_QPlN/nLiNKCKK73--

