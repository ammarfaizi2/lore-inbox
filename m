Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263313AbSLJSAr>; Tue, 10 Dec 2002 13:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbSLJSAr>; Tue, 10 Dec 2002 13:00:47 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:47882 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S263313AbSLJSAm>; Tue, 10 Dec 2002 13:00:42 -0500
Subject: Re: [BUG]: agpgart for i810 chipsets broken in 2.5.51
From: Antonino Daplas <adaplas@pol.net>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021210170542.GB577@codemonkey.org.uk>
References: <1039522886.1041.17.camel@localhost.localdomain>
	<20021210131143.GA26361@suse.de>
	<1039538881.2025.2.camel@localhost.localdomain>
	<20021210140301.GC26361@suse.de>
	<1039547210.1071.26.camel@localhost.localdomain>
	<20021210172320.A4586@suse.de>
	<1039539977.14251.40.camel@irongate.swansea.linux.org.uk> 
	<20021210170542.GB577@codemonkey.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1039553986.1054.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 02:00:47 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 22:05, Dave Jones wrote:
> On Tue, Dec 10, 2002 at 05:06:17PM +0000, Alan Cox wrote:
>  > Given how fragile the AGP code can be I would much rather we had the AGP
>  > continue to initialize late. If the AGP init function is something like
>  > 
>  > 
>  > int agp_required(void)
>  > {
>  > 	static int agp_inited = 0;
>  > 
>  > 	if(!agp_inited)
>  > 	{
>  > 		agp_inited = 1;
>  > 		agp_do_real_init();
>  > 	}
>  > }
>  > 
>  > module_init(agp_required);
>  > 
>  > 
>  > Then the i810 fb driver can do
>  > 
>  > 	agp_required();
>  > 
>  > and force the order change only if necessary.
> 
> That works for me. It's not ideal, but it's the cleanest
> solution suggested so far. I'll hack a check into
> agp_init() to do this, which should allow us to close bug #20 [*]
> 

Oops, Alan beat me into it. It's basically the same as what I've got
except I had an i810fb specific macro.  I guess the one without the
macro is cleaner.

Tony

diff -Naur linux-2.5.51/drivers/char/agp/backend.c linux/drivers/char/agp/backend.c
--- linux-2.5.51/drivers/char/agp/backend.c	2002-12-10 20:46:58.000000000 +0000
+++ linux/drivers/char/agp/backend.c	2002-12-10 20:46:26.000000000 +0000
@@ -269,7 +269,7 @@
 	return 0;
 }
 
-int __init agp_init(void)
+int __init do_agp_init(void)
 {
 	memset(&agp_bridge, 0, sizeof(struct agp_bridge_data));
 	agp_bridge.type = NOT_SUPPORTED;
@@ -279,6 +279,25 @@
 	return 0;
 }
 
+#ifdef CONFIG_FB_I810
+int __init agp_init(void) 
+{
+	static int agp_has_init = 0;
+
+	if (agp_has_init)
+		return 0;
+
+	agp_has_init = 1;
+
+	return do_agp_init();
+}
+#else
+static int __init agp_init(void)
+{
+	return do_agp_init();
+}
+#endif
+
 #ifndef CONFIG_GART_IOMMU
 module_init(agp_init);
 #endif
diff -Naur linux-2.5.51/drivers/char/agp/intel-agp.c linux/drivers/char/agp/intel-agp.c
--- linux-2.5.51/drivers/char/agp/intel-agp.c	2002-12-10 20:47:03.000000000 +0000
+++ linux/drivers/char/agp/intel-agp.c	2002-12-10 20:46:23.000000000 +0000
@@ -1470,7 +1470,7 @@
 	.probe		= agp_intel_probe,
 };
 
-static int __init agp_intel_init(void)
+static int __init do_agp_intel_init(void)
 {
 	int ret_val;
 
@@ -1487,6 +1487,25 @@
 	pci_unregister_driver(&agp_intel_pci_driver);
 }
 
+#ifdef CONFIG_FB_I810
+int __init agp_intel_init(void) 
+{
+	static int intel_agp_has_init = 0;
+
+	if (intel_agp_has_init)
+		return 0;
+
+	intel_agp_has_init = 1;
+
+	return do_agp_intel_init();
+}
+#else
+static int __init agp_intel_init(void)
+{
+	return do_agp_intel_init();
+}
+#endif
+
 module_init(agp_intel_init);
 module_exit(agp_intel_cleanup);
 

