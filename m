Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbWJBUgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbWJBUgW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbWJBUgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:36:22 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:37771 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S964999AbWJBUgU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:36:20 -0400
From: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
To: rolandd@cisco.com
Subject: [PATCH 2.6.19-rc1 1/2] ehca: fix ehca device registration
Date: Mon, 2 Oct 2006 22:32:49 +0200
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openib-general@openib.org, openfabrics-ewg@openib.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xdXIFb16LD7PgHy"
Message-Id: <200610022232.49540.hnguyen@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_xdXIFb16LD7PgHy
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Roland!
Below is a patch of ehca, which fixes a bug (crash) that occured when ib_ehca
is loaded after ib_ipoib. This patch initializes struct ehca_shca with
struct device*, then creates internal resources and finally registers the
ehca IB device. And that is the proper sequence to do.
Thanks!
Nam Nguyen


Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_main.c |   36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)


diff -Nurp infiniband_orig/drivers/infiniband/hw/ehca/ehca_main.c infiniband_work/drivers/infiniband/hw/ehca/ehca_main.c
--- infiniband_orig/drivers/infiniband/hw/ehca/ehca_main.c 2006-10-02 22:08:57.000000000 +0200
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_main.c 2006-10-02 18:29:53.000000000 +0200
@@ -49,7 +49,7 @@
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Christoph Raisch <raisch@de.ibm.com>");
 MODULE_DESCRIPTION("IBM eServer HCA InfiniBand Device Driver");
-MODULE_VERSION("SVNEHCA_0016");
+MODULE_VERSION("SVNEHCA_0017");
 
 int ehca_open_aqp1     = 0;
 int ehca_debug_level   = 0;
@@ -239,7 +239,7 @@ init_node_guid1:
  return ret;
 }
 
-int ehca_register_device(struct ehca_shca *shca)
+int ehca_init_device(struct ehca_shca *shca)
 {
  int ret;
 
@@ -317,11 +317,6 @@ int ehca_register_device(struct ehca_shc
  /* shca->ib_device.process_mad     = ehca_process_mad;     */
  shca->ib_device.mmap      = ehca_mmap;
 
- ret = ib_register_device(&shca->ib_device);
- if (ret)
-  ehca_err(&shca->ib_device,
-    "ib_register_device() failed ret=%x", ret);
-
  return ret;
 }
 
@@ -561,9 +556,9 @@ static int __devinit ehca_probe(struct i
   goto probe1;
  }
 
- ret = ehca_register_device(shca);
+ ret = ehca_init_device(shca);
  if (ret) {
-  ehca_gen_err("Cannot register Infiniband device");
+  ehca_gen_err("Cannot init ehca  device struct");
   goto probe1;
  }
 
@@ -571,7 +566,7 @@ static int __devinit ehca_probe(struct i
  ret = ehca_create_eq(shca, &shca->eq, EHCA_EQ, 2048);
  if (ret) {
   ehca_err(&shca->ib_device, "Cannot create EQ.");
-  goto probe2;
+  goto probe1;
  }
 
  ret = ehca_create_eq(shca, &shca->neq, EHCA_NEQ, 513);
@@ -600,6 +595,13 @@ static int __devinit ehca_probe(struct i
   goto probe5;
  }
 
+ ret = ib_register_device(&shca->ib_device);
+ if (ret) {
+  ehca_err(&shca->ib_device,
+    "ib_register_device() failed ret=%x", ret);
+  goto probe6;
+ }
+
  /* create AQP1 for port 1 */
  if (ehca_open_aqp1 == 1) {
   shca->sport[0].port_state = IB_PORT_DOWN;
@@ -607,7 +609,7 @@ static int __devinit ehca_probe(struct i
   if (ret) {
    ehca_err(&shca->ib_device,
      "Cannot create AQP1 for port 1.");
-   goto probe6;
+   goto probe7;
   }
  }
 
@@ -618,7 +620,7 @@ static int __devinit ehca_probe(struct i
   if (ret) {
    ehca_err(&shca->ib_device,
      "Cannot create AQP1 for port 2.");
-   goto probe7;
+   goto probe8;
   }
  }
 
@@ -630,12 +632,15 @@ static int __devinit ehca_probe(struct i
 
  return 0;
 
-probe7:
+probe8:
  ret = ehca_destroy_aqp1(&shca->sport[0]);
  if (ret)
   ehca_err(&shca->ib_device,
     "Cannot destroy AQP1 for port 1. ret=%x", ret);
 
+probe7:
+ ib_unregister_device(&shca->ib_device);
+
 probe6:
  ret = ehca_dereg_internal_maxmr(shca);
  if (ret)
@@ -660,9 +665,6 @@ probe3:
   ehca_err(&shca->ib_device,
     "Cannot destroy EQ. ret=%x", ret);
 
-probe2:
- ib_unregister_device(&shca->ib_device);
-
 probe1:
  ib_dealloc_device(&shca->ib_device);
 
@@ -750,7 +752,7 @@ int __init ehca_module_init(void)
  int ret;
 
  printk(KERN_INFO "eHCA Infiniband Device Driver "
-                  "(Rel.: SVNEHCA_0016)\n");
+                  "(Rel.: SVNEHCA_0017)\n");
  idr_init(&ehca_qp_idr);
  idr_init(&ehca_cq_idr);
  spin_lock_init(&ehca_qp_idr_lock);

--Boundary-00=_xdXIFb16LD7PgHy
Content-Type: text/x-diff;
  charset="us-ascii";
  name="svnehca_0017_roland_git.patch1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="svnehca_0017_roland_git.patch1"

diff -Nurp infiniband_orig/drivers/infiniband/hw/ehca/ehca_main.c infiniband_work/drivers/infiniband/hw/ehca/ehca_main.c
--- infiniband_orig/drivers/infiniband/hw/ehca/ehca_main.c	2006-10-02 22:08:57.000000000 +0200
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_main.c	2006-10-02 18:29:53.000000000 +0200
@@ -49,7 +49,7 @@
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Christoph Raisch <raisch@de.ibm.com>");
 MODULE_DESCRIPTION("IBM eServer HCA InfiniBand Device Driver");
-MODULE_VERSION("SVNEHCA_0016");
+MODULE_VERSION("SVNEHCA_0017");
 
 int ehca_open_aqp1     = 0;
 int ehca_debug_level   = 0;
@@ -239,7 +239,7 @@ init_node_guid1:
 	return ret;
 }
 
-int ehca_register_device(struct ehca_shca *shca)
+int ehca_init_device(struct ehca_shca *shca)
 {
 	int ret;
 
@@ -317,11 +317,6 @@ int ehca_register_device(struct ehca_shc
 	/* shca->ib_device.process_mad	    = ehca_process_mad;	    */
 	shca->ib_device.mmap		    = ehca_mmap;
 
-	ret = ib_register_device(&shca->ib_device);
-	if (ret)
-		ehca_err(&shca->ib_device,
-			 "ib_register_device() failed ret=%x", ret);
-
 	return ret;
 }
 
@@ -561,9 +556,9 @@ static int __devinit ehca_probe(struct i
 		goto probe1;
 	}
 
-	ret = ehca_register_device(shca);
+	ret = ehca_init_device(shca);
 	if (ret) {
-		ehca_gen_err("Cannot register Infiniband device");
+		ehca_gen_err("Cannot init ehca  device struct");
 		goto probe1;
 	}
 
@@ -571,7 +566,7 @@ static int __devinit ehca_probe(struct i
 	ret = ehca_create_eq(shca, &shca->eq, EHCA_EQ, 2048);
 	if (ret) {
 		ehca_err(&shca->ib_device, "Cannot create EQ.");
-		goto probe2;
+		goto probe1;
 	}
 
 	ret = ehca_create_eq(shca, &shca->neq, EHCA_NEQ, 513);
@@ -600,6 +595,13 @@ static int __devinit ehca_probe(struct i
 		goto probe5;
 	}
 
+	ret = ib_register_device(&shca->ib_device);
+	if (ret) {
+		ehca_err(&shca->ib_device,
+			 "ib_register_device() failed ret=%x", ret);
+		goto probe6;
+	}
+
 	/* create AQP1 for port 1 */
 	if (ehca_open_aqp1 == 1) {
 		shca->sport[0].port_state = IB_PORT_DOWN;
@@ -607,7 +609,7 @@ static int __devinit ehca_probe(struct i
 		if (ret) {
 			ehca_err(&shca->ib_device,
 				 "Cannot create AQP1 for port 1.");
-			goto probe6;
+			goto probe7;
 		}
 	}
 
@@ -618,7 +620,7 @@ static int __devinit ehca_probe(struct i
 		if (ret) {
 			ehca_err(&shca->ib_device,
 				 "Cannot create AQP1 for port 2.");
-			goto probe7;
+			goto probe8;
 		}
 	}
 
@@ -630,12 +632,15 @@ static int __devinit ehca_probe(struct i
 
 	return 0;
 
-probe7:
+probe8:
 	ret = ehca_destroy_aqp1(&shca->sport[0]);
 	if (ret)
 		ehca_err(&shca->ib_device,
 			 "Cannot destroy AQP1 for port 1. ret=%x", ret);
 
+probe7:
+	ib_unregister_device(&shca->ib_device);
+
 probe6:
 	ret = ehca_dereg_internal_maxmr(shca);
 	if (ret)
@@ -660,9 +665,6 @@ probe3:
 		ehca_err(&shca->ib_device,
 			 "Cannot destroy EQ. ret=%x", ret);
 
-probe2:
-	ib_unregister_device(&shca->ib_device);
-
 probe1:
 	ib_dealloc_device(&shca->ib_device);
 
@@ -750,7 +752,7 @@ int __init ehca_module_init(void)
 	int ret;
 
 	printk(KERN_INFO "eHCA Infiniband Device Driver "
-	                 "(Rel.: SVNEHCA_0016)\n");
+	                 "(Rel.: SVNEHCA_0017)\n");
 	idr_init(&ehca_qp_idr);
 	idr_init(&ehca_cq_idr);
 	spin_lock_init(&ehca_qp_idr_lock);

--Boundary-00=_xdXIFb16LD7PgHy--
