Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266006AbUHWUMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbUHWUMZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266548AbUHWULY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:11:24 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:17157 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S267403AbUHWTBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 15:01:46 -0400
Date: Mon, 23 Aug 2004 14:01:31 -0500
From: Terence Ripperda <tripperda@nvidia.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Terence Ripperda <tripperda@nvidia.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Michael Geithe <warpy@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mastergoon@gmail.com
Subject: Re: 2.6.8.1-mm2 (nvidia breakage)
Message-ID: <20040823190131.GC1303@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <20040819092654.27bb9adf.akpm@osdl.org> <200408191603.55327.bjorn.helgaas@hp.com> <20040819225848.GE1263@hygelac> <200408230930.18659.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <200408230930.18659.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.7 
X-OriginalArrivalTime: 23 Aug 2004 19:01:33.0293 (UTC) FILETIME=[9B3459D0:01C48943]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 23, 2004 at 09:30:18AM -0600, bjorn.helgaas@hp.com wrote:
> Of course, the nvidia driver still won't work
> because it's looking at pci_dev->irq before calling pci_enable_device(),
> but that's a separate issue.

as Alan pointed out, the video device is bios configured, so may not
be hit by this. nonetheless, we've applied a patch along these lines
to our internal codebase.

Thanks,
Terence


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nv_enable_pci.patch"

--- nv/nv.c	2004-08-23 13:58:15.000000000 -0500
+++ nv.new/nv.c	2004-08-23 13:58:35.000000000 -0500
@@ -1225,6 +1225,7 @@
         {
             nv_state_t *nv = NV_STATE_PTR(&nv_linux_devices[i]);
             release_mem_region(nv->bar.regs.address, nv->bar.regs.size);
+            pci_disable_device(nv_linux_devices[i].dev);
         }
     }
 
@@ -3516,6 +3517,28 @@
         return -1;
     }
 
+    // enable io, mem, and bus-mastering in pci config space
+    if (pci_enable_device(dev) != 0)
+    {
+        nv_printf(NV_DBG_ERRORS,
+            "NVRM: pci_enable_device failed, aborting\n");
+        return -1;
+    }
+
+    // request ownership of our bars
+    // keeps other drivers from banging our registers.
+    // only do this for registers, as vesafb requests our framebuffer and will
+    // keep us from working properly
+    if (!request_mem_region(dev->resource[0].start,
+                            dev->resource[0].end - dev->resource[0].start + 1,
+                            "nvidia"))
+    {
+        nv_printf(NV_DBG_ERRORS,
+            "NVRM: pci_request_regions failed, aborting\n");
+        goto err_disable_dev;
+    }
+    pci_set_master(dev);
+
     /* initialize bus-dependent config state */
     nvl = &nv_linux_devices[num_nv_devices];
     nv  = NV_STATE_PTR(nvl);
@@ -3545,7 +3568,7 @@
         nv_printf(NV_DBG_ERRORS, "NVRM: Please check your BIOS settings.         \n");
         nv_printf(NV_DBG_ERRORS, "NVRM: [Plug & Play OS   ] should be set to NO  \n");
         nv_printf(NV_DBG_ERRORS, "NVRM: [Assign IRQ to VGA] should be set to YES \n");
-        return -1;
+        goto err_zero_dev;
     }
 
     /* sanity check the IO apertures */
@@ -3569,39 +3592,9 @@
                 nv->bar.fb.address, nv->bar.fb.size);
         }
 
-        /* Clear out the data */
-        os_mem_set(nvl, 0, sizeof(nv_linux_state_t));
-
-        return -1;
-    }
-
-    // request ownership of our bars
-    // keeps other drivers from banging our registers.
-    // only do this for registers, as vesafb requests our framebuffer and will
-    // keep us from working properly
-    if (!request_mem_region(nv->bar.regs.address, nv->bar.regs.size, "nvidia"))
-    {
-        nv_printf(NV_DBG_ERRORS,
-            "NVRM: pci_request_regions failed, aborting\n");
-
-        /* Clear out the data */
-        os_mem_set(nvl, 0, sizeof(nv_linux_state_t));
-
-        return -1;
+        goto err_zero_dev;
     }
 
-    // enable io, mem, and bus-mastering in pci config space
-    if (pci_enable_device(dev) != 0)
-    {
-        nv_printf(NV_DBG_ERRORS,
-            "NVRM: pci_enable_device failed, aborting\n");
-
-        pci_release_regions(dev);
-        os_mem_set(nvl, 0, sizeof(nv_linux_state_t));
-
-        return -1;
-    }
-    pci_set_master(nvl->dev);
 
 #if defined(NV_BUILD_NV_PAT_SUPPORT)
     if (nvos_find_pci_express_capability(nvl->dev))
@@ -3618,13 +3611,7 @@
     if (nv->bar.regs.map == NULL)
     {
         nv_printf(NV_DBG_ERRORS, "NVRM: failed to map registers!!\n");
-
-        pci_release_regions(dev);
-
-        /* Clear out the data */
-        os_mem_set(nvl, 0, sizeof(nv_linux_state_t));
-
-        return -1;
+        goto err_zero_dev;
     }
     nv->flags |= NV_FLAG_MAP_REGS_EARLY;
 #endif
@@ -3641,6 +3628,15 @@
     num_nv_devices++;
 
     return 0;
+
+err_zero_dev:
+    os_mem_set(nvl, 0, sizeof(nv_linux_state_t));
+    release_mem_region(dev->resource[0].start,
+                       dev->resource[0].end - dev->resource[0].start + 1);
+
+err_disable_dev:
+    pci_disable_device(dev);
+    return -1;
 }
 
 int NV_API_CALL nv_no_incoherent_mappings

--AqsLC8rIMeq19msA--
