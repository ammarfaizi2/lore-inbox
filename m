Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUDHRB3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 13:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbUDHRB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 13:01:29 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:41379 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262020AbUDHRB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 13:01:26 -0400
Date: Thu, 08 Apr 2004 09:59:33 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
       "Linux/m68k" <linux-m68k@lists.linux-m68k.org>
cc: geert@sonycom.com, Hanna Linder <hannal@us.ibm.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <greg@kroah.com>, noring@nocrew.org, lars@nocrew.org,
       tomas@nocrew.org
Subject: Re: [PATCH 2.6] add class support to dsp56k.c 
Message-ID: <74830000.1081443573@dyn318071bld.beaverton.ibm.com>
In-Reply-To: <Pine.GSO.4.58.0404080952171.9729@waterleaf.sonytel.be>
References: <61760000.1081379610@dyn318071bld.beaverton.ibm.com> <Pine.GSO.4.58.0404080952171.9729@waterleaf.sonytel.be>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Thursday, April 08, 2004 10:12:19 AM +0200 Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Wed, 7 Apr 2004, Hanna Linder wrote:
>> Here is a patch that adds sysfs class support to /drivers/char/dsp56k.c
>> 
>> I dont have the hardware or a cross compiler... If someone could test it
>> I would appreciate it.
> 
> Cross-compiles fine here, but further untested due to lack of hardware.

Thanks!

>> +out_chrdev:
>> +	unregister_chrdev(DSP56K_MAJOR, "sdp56k");
>> +out:

I just noticed this error. Here is the fixed patch:

diff -Nrup -Xdontdiff linux-2.6.5/drivers/char/dsp56k.c linux-2.6.5p/drivers/char/dsp56k.c
--- linux-2.6.5/drivers/char/dsp56k.c	2004-04-03 19:37:07.000000000 -0800
+++ linux-2.6.5p/drivers/char/dsp56k.c	2004-04-08 09:53:57.000000000 -0700
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
+#include <linux/device.h>
 
 #include <asm/atarihw.h>
 #include <asm/traps.h>
@@ -149,6 +150,8 @@ static struct dsp56k_device {
 	int tx_wsize, rx_wsize;
 } dsp56k;
 
+static struct class_simple *dsp56k_class;
+
 static int dsp56k_reset(void)
 {
 	u_char status;
@@ -502,6 +505,8 @@ static char banner[] __initdata = KERN_I
 
 static int __init dsp56k_init_driver(void)
 {
+	int err = 0;
+
 	if(!MACH_IS_ATARI || !ATARIHW_PRESENT(DSP56K)) {
 		printk("DSP56k driver: Hardware not present\n");
 		return -ENODEV;
@@ -511,17 +516,35 @@ static int __init dsp56k_init_driver(voi
 		printk("DSP56k driver: Unable to register driver\n");
 		return -ENODEV;
 	}
+	dsp56k_class = class_simple_create(THIS_MODULE, "dsp56k");
+	if (IS_ERR(dsp56k_class)) {
+		err = PTR_ERR(dsp56k_class);
+		goto out_chrdev;
+	}
+	class_simple_device_add(dsp56k_class, MKDEV(DSP56K_MAJOR, 0), NULL, "dsp56k");
 
-	devfs_mk_cdev(MKDEV(DSP56K_MAJOR, 0),
+	err = devfs_mk_cdev(MKDEV(DSP56K_MAJOR, 0),
 		      S_IFCHR | S_IRUSR | S_IWUSR, "dsp56k");
+	if(err)
+		goto out_class;
 
 	printk(banner);
-	return 0;
+	goto out;
+
+out_class:
+	class_simple_device_remove(MKDEV(DSP56K_MAJOR, 0));
+	class_simple_destroy(dsp56k_class);
+out_chrdev:
+	unregister_chrdev(DSP56K_MAJOR, "dsp56k");
+out:
+	return err;
 }
 module_init(dsp56k_init_driver);
 
 static void __exit dsp56k_cleanup_driver(void)
 {
+	class_simple_device_remove(MKDEV(DSP56K_MAJOR, 0));
+	class_simple_destroy(dsp56k_class);
 	unregister_chrdev(DSP56K_MAJOR, "dsp56k");
 	devfs_remove("dsp56k");
 }



