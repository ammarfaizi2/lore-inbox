Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264212AbTDWShr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 14:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264215AbTDWShr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 14:37:47 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:22054 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264212AbTDWShj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 14:37:39 -0400
Date: Wed, 23 Apr 2003 14:49:47 -0400
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.20 - intel AGP update (rev 3)
Message-ID: <20030423144947.A8931@devserv.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Again, AGP support for i852GM/i855GM/i855PM/i865G. Mostly
by David Dawes (<dawes@tungstengraphics.com>)

Changes from previous:
- remove any support for 'integrated graphics' on i855PM... there's
  no such thing. (oops)

Bill

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.20-intel-agp.patch"

diff -ru linux-2.4.20/drivers/char/agp/agpgart_be.c /usr/src/linux-2.4.20-9/drivers/char/agp/agpgart_be.c
--- linux-2.4.20/drivers/char/agp/agpgart_be.c	2003-04-23 14:14:46.000000000 -0400
+++ /usr/src/linux-2.4.20-9/drivers/char/agp/agpgart_be.c	2003-04-23 14:09:30.000000000 -0400
@@ -23,6 +23,12 @@
  * OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  *
  */
+
+/*
+ * Intel(R) 855GM/852GM and 865G support, added by
+ * David Dawes <dawes@tungstengraphics.com>.
+ */
+
 #include <linux/config.h>
 #include <linux/version.h>
 #include <linux/module.h>
@@ -1112,34 +1118,64 @@
 	u16 gmch_ctrl;
 	int gtt_entries;
 	u8 rdct;
+	int local = 0;
 	static const int ddt[4] = { 0, 16, 32, 64 };
 
 	pci_read_config_word(agp_bridge.dev,I830_GMCH_CTRL,&gmch_ctrl);
 
-	switch (gmch_ctrl & I830_GMCH_GMS_MASK) {
-	case I830_GMCH_GMS_STOLEN_512:
-		gtt_entries = KB(512) - KB(132);
-		printk(KERN_INFO PFX "detected %dK stolen memory.\n",gtt_entries / KB(1));
-		break;
-	case I830_GMCH_GMS_STOLEN_1024:
-		gtt_entries = MB(1) - KB(132);
-		printk(KERN_INFO PFX "detected %dK stolen memory.\n",gtt_entries / KB(1));
-		break;
-	case I830_GMCH_GMS_STOLEN_8192:
-		gtt_entries = MB(8) - KB(132);
-		printk(KERN_INFO PFX "detected %dK stolen memory.\n",gtt_entries / KB(1));
-		break;
-	case I830_GMCH_GMS_LOCAL:
-		rdct = INREG8(intel_i830_private.registers,I830_RDRAM_CHANNEL_TYPE);
-		gtt_entries = (I830_RDRAM_ND(rdct) + 1) * MB(ddt[I830_RDRAM_DDT(rdct)]);
-		printk(KERN_INFO PFX "detected %dK local memory.\n",gtt_entries / KB(1));
-		break;
-	default:
-		printk(KERN_INFO PFX "no video memory detected.\n");
-		gtt_entries = 0;
-		break;
+	if (agp_bridge.dev->device != PCI_DEVICE_ID_INTEL_830_M_0 &&
+	    agp_bridge.dev->device != PCI_DEVICE_ID_INTEL_845_G_0) {
+		switch (gmch_ctrl & I855_GMCH_GMS_MASK) {
+		case I855_GMCH_GMS_STOLEN_1M:
+			gtt_entries = MB(1) - KB(132);
+			break;
+		case I855_GMCH_GMS_STOLEN_4M:
+			gtt_entries = MB(4) - KB(132);
+			break;
+		case I855_GMCH_GMS_STOLEN_8M:
+			gtt_entries = MB(8) - KB(132);
+			break;
+		case I855_GMCH_GMS_STOLEN_16M:
+			gtt_entries = MB(16) - KB(132);
+			break;
+		case I855_GMCH_GMS_STOLEN_32M:
+			gtt_entries = MB(32) - KB(132);
+			break;
+		default:
+			gtt_entries = 0;
+			break;
+		}
+	} else
+	{
+		switch (gmch_ctrl & I830_GMCH_GMS_MASK) {
+		case I830_GMCH_GMS_STOLEN_512:
+			gtt_entries = KB(512) - KB(132);
+			break;
+		case I830_GMCH_GMS_STOLEN_1024:
+			gtt_entries = MB(1) - KB(132);
+			break;
+		case I830_GMCH_GMS_STOLEN_8192:
+			gtt_entries = MB(8) - KB(132);
+			break;
+		case I830_GMCH_GMS_LOCAL:
+			rdct = INREG8(intel_i830_private.registers,
+				      I830_RDRAM_CHANNEL_TYPE);
+			gtt_entries = (I830_RDRAM_ND(rdct) + 1) *
+				      MB(ddt[I830_RDRAM_DDT(rdct)]);
+			local = 1;
+			break;
+		default:
+			gtt_entries = 0;
+			break;
+		}
 	}
 
+	if (gtt_entries > 0)
+		printk(KERN_INFO PFX "Detected %dK %s memory.\n",
+		       gtt_entries / KB(1), local ? "local" : "stolen");
+	else
+		printk(KERN_INFO PFX
+		       "No pre-allocated video memory detected.\n");
 	gtt_entries /= KB(4);
 
 	intel_i830_private.gtt_entries = gtt_entries;
@@ -1192,9 +1228,16 @@
 	u16 gmch_ctrl;
 	aper_size_info_fixed *values;
 
-	pci_read_config_word(agp_bridge.dev,I830_GMCH_CTRL,&gmch_ctrl);
 	values = A_SIZE_FIX(agp_bridge.aperture_sizes);
 
+	if (agp_bridge.dev->device != PCI_DEVICE_ID_INTEL_830_M_0 &&
+	    agp_bridge.dev->device != PCI_DEVICE_ID_INTEL_845_G_0) {
+		agp_bridge.previous_size = agp_bridge.current_size = (void *) values;
+		agp_bridge.aperture_size_idx = 0;
+		return(values[0].size);
+	}
+		
+	pci_read_config_word(agp_bridge.dev,I830_GMCH_CTRL,&gmch_ctrl);
 	if ((gmch_ctrl & I830_GMCH_MEM_MASK) == I830_GMCH_MEM_128M) {
 		agp_bridge.previous_size = agp_bridge.current_size = (void *) values;
 		agp_bridge.aperture_size_idx = 0;
@@ -4516,15 +4559,38 @@
 	{ PCI_DEVICE_ID_INTEL_830_M_0,
 		PCI_VENDOR_ID_INTEL,
 		INTEL_I830_M,
-		"Intel",
-		"i830M",
+		"Intel(R)",
+		"830M",
 		intel_830mp_setup },
-    { PCI_DEVICE_ID_INTEL_845_G_0,
+	
+	{ PCI_DEVICE_ID_INTEL_845_G_0,
 		 PCI_VENDOR_ID_INTEL,
 		 INTEL_I845_G,
-		 "Intel",
-		 "i845G",
+		 "Intel(R)",
+		 "845G",
 		 intel_845_setup },
+
+	{ PCI_DEVICE_ID_INTEL_855_GM_0,
+		 PCI_VENDOR_ID_INTEL,
+		 INTEL_I855_GM,
+		 "Intel(R)",
+		 "855GM",
+		 intel_845_setup },
+
+	{ PCI_DEVICE_ID_INTEL_855_PM_0,
+		 PCI_VENDOR_ID_INTEL,
+		 INTEL_I855_PM,
+		 "Intel(R)",
+		 "855PM",
+		 intel_845_setup },
+
+	{ PCI_DEVICE_ID_INTEL_865_G_0,
+		PCI_VENDOR_ID_INTEL,
+		INTEL_I865_G,
+		"Intel(R)",
+		"865G",
+		 intel_845_setup },
+
 	{ PCI_DEVICE_ID_INTEL_840_0,
 		PCI_VENDOR_ID_INTEL,
 		INTEL_I840,
@@ -4888,10 +4960,14 @@
                                  * with an external graphics
                                  * card. It will be initialized later 
                                  */
+				printk(KERN_ERR PFX "Detected an "
+				       "Intel(R) 845G, but could not find the"
+				       " secondary device. Assuming a "
+				       "non-integrated video card.\n");
 				agp_bridge.type = INTEL_I845_G;
 				break;
 			}
-			printk(KERN_INFO PFX "Detected an Intel "
+			printk(KERN_INFO PFX "Detected an Intel(R) "
 				   "845G Chipset.\n");
 			agp_bridge.type = INTEL_I810;
 			return intel_i830_setup(i810_dev);
@@ -4913,10 +4989,77 @@
 				agp_bridge.type = INTEL_I830_M;
 				break;
 			}
-			printk(KERN_INFO PFX "Detected an Intel "
+			printk(KERN_INFO PFX "Detected an Intel(R) "
 				   "830M Chipset.\n");
 			agp_bridge.type = INTEL_I810;
 			return intel_i830_setup(i810_dev);
+		case PCI_DEVICE_ID_INTEL_855_GM_0:
+			i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
+					PCI_DEVICE_ID_INTEL_855_GM_1, NULL);
+			if(i810_dev && PCI_FUNC(i810_dev->devfn) != 0) {
+				i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
+					PCI_DEVICE_ID_INTEL_855_GM_1, i810_dev);
+			}
+			if (i810_dev == NULL) {
+                                /* 
+                                 * We probably have an 855GM chipset
+                                 * with an external graphics
+                                 * card. It will be initialized later.
+                                 */
+				agp_bridge.type = INTEL_I855_GM;
+				break;
+			}
+			{
+				u32 capval = 0;
+				const char *name = "855GM/852GM";
+
+				pci_read_config_dword(dev, I85X_CAPID, &capval);
+				switch ((capval >> I85X_VARIANT_SHIFT) &
+					I85X_VARIANT_MASK) {
+				case I855_GME:
+					name = "855GME";
+					break;
+				case I855_GM:
+					name = "855GM";
+					break;
+				case I852_GME:
+					name = "852GME";
+					break;
+				case I852_GM:
+					name = "852GM";
+					break;
+				}
+				printk(KERN_INFO PFX "Detected an Intel(R) "
+					"%s Chipset.\n", name);
+			}
+			agp_bridge.type = INTEL_I810;
+			return intel_i830_setup(i810_dev);
+		case PCI_DEVICE_ID_INTEL_865_G_0:
+			i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
+					PCI_DEVICE_ID_INTEL_865_G_1, NULL);
+			if(i810_dev && PCI_FUNC(i810_dev->devfn) != 0) {
+				i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
+					PCI_DEVICE_ID_INTEL_865_G_1, i810_dev);
+			}
+
+			if (i810_dev == NULL) {
+                                /* 
+                                 * We probably have a 865G chipset
+                                 * with an external graphics
+                                 * card. It will be initialized later 
+                                 */
+				printk(KERN_ERR PFX "Detected an "
+				       "Intel(R) 865G, but could not"
+				       " find the"
+				       " secondary device. Assuming a "
+				       "non-integrated video card.\n");
+				agp_bridge.type = INTEL_I865_G;
+				break;
+			}
+			printk(KERN_INFO PFX "Detected an Intel(R) "
+				   "865G Chipset.\n");
+			agp_bridge.type = INTEL_I810;
+			return intel_i830_setup(i810_dev);
 		default:
 			break;
 		}
diff -ru linux-2.4.20/drivers/char/agp/agp.h /usr/src/linux-2.4.20-9/drivers/char/agp/agp.h
--- linux-2.4.20/drivers/char/agp/agp.h	2003-04-23 14:14:46.000000000 -0400
+++ /usr/src/linux-2.4.20-9/drivers/char/agp/agp.h	2003-04-23 14:06:08.000000000 -0400
@@ -184,6 +184,21 @@
 #ifndef PCI_DEVICE_ID_INTEL_830_M_1
 #define PCI_DEVICE_ID_INTEL_830_M_1     0x3577
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_855_GM_0
+#define PCI_DEVICE_ID_INTEL_855_GM_0	0x3580
+#endif
+#ifndef PCI_DEVICE_ID_INTEL_855_GM_1
+#define PCI_DEVICE_ID_INTEL_855_GM_1	0x3582
+#endif
+#ifndef PCI_DEVICE_ID_INTEL_855_PM_0
+#define PCI_DEVICE_ID_INTEL_855_PM_0	0x3340
+#endif
+#ifndef PCI_DEVICE_ID_INTEL_865_G_0
+#define PCI_DEVICE_ID_INTEL_865_G_0	0x2570
+#endif
+#ifndef PCI_DEVICE_ID_INTEL_865_G_1
+#define PCI_DEVICE_ID_INTEL_865_G_1	0x2572
+#endif
 #ifndef PCI_DEVICE_ID_INTEL_820_0
 #define PCI_DEVICE_ID_INTEL_820_0       0x2500
 #endif
@@ -280,6 +295,24 @@
 #define INTEL_NBXCFG    0x50
 #define INTEL_ERRSTS    0x91
 
+/* Intel 855GM/852GM registers */
+#define I855_GMCH_CTRL             0x52
+#define I855_GMCH_ENABLED          0x4
+#define I855_GMCH_GMS_MASK         (0x7 << 4)
+#define I855_GMCH_GMS_STOLEN_0M    0x0
+#define I855_GMCH_GMS_STOLEN_1M    (0x1 << 4)
+#define I855_GMCH_GMS_STOLEN_4M    (0x2 << 4)
+#define I855_GMCH_GMS_STOLEN_8M    (0x3 << 4)
+#define I855_GMCH_GMS_STOLEN_16M   (0x4 << 4)
+#define I855_GMCH_GMS_STOLEN_32M   (0x5 << 4)
+#define I85X_CAPID                 0x44
+#define I85X_VARIANT_MASK          0x7
+#define I85X_VARIANT_SHIFT         5
+#define I855_GME                   0x0
+#define I855_GM                    0x4
+#define I852_GME                   0x2
+#define I852_GM                    0x5
+
 /* intel i830 registers */
 #define I830_GMCH_CTRL             0x52
 #define I830_GMCH_ENABLED          0x4
diff -ru linux-2.4.20/include/linux/agp_backend.h linux-2.4.20/include/linux/agp_backend.h
--- linux-2.4.20/include/linux/agp_backend.h	2003-04-23 14:14:58.000000000 -0400
+++ linux-2.4.20/include/linux/agp_backend.h	2003-04-02 13:13:31.000000000 -0500
@@ -49,6 +49,9 @@
 	INTEL_I820,
 	INTEL_I830_M,
 	INTEL_I845_G,
+	INTEL_I855_PM,
+	INTEL_I855_GM,
+	INTEL_I865_G,
 	INTEL_I840,
 	INTEL_I845,
 	INTEL_I850,

--r5Pyd7+fXNt84Ff3--
