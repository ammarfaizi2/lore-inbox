Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131240AbRCMW4B>; Tue, 13 Mar 2001 17:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131241AbRCMWzz>; Tue, 13 Mar 2001 17:55:55 -0500
Received: from ns.suse.de ([213.95.15.193]:23816 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131240AbRCMWzj>;
	Tue, 13 Mar 2001 17:55:39 -0500
Date: Tue, 13 Mar 2001 23:54:58 +0100
From: Olaf Hering <olh@suse.de>
To: "Jeffrey W. Baker" <jwbaker@acm.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.4.3-pre3 add PBG4 native LCD mode to modedb.c
Message-ID: <20010313235458.A25562@suse.de>
In-Reply-To: <Pine.LNX.4.33.0103131224340.252-200000@desktop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0103131224340.252-200000@desktop>; from jwbaker@acm.org on Tue, Mar 13, 2001 at 12:37:16PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 13, Jeffrey W. Baker wrote:

> The attached patch adds the a new mode to the modedb, used by the ATI,
> 3Dfx, and Amiga frame buffer devices.  The new mode is the native,
> slightly wide resolution of the new Apple laptops.  It isn't obvious how
> popular a mode has to be before it goes into modedb.c.

It proably depends also on your own popularity as a kernel hacker ;)

Do it right and put the stuff into aty128fb.c. The various models can be
autodetected via the OpenFirmware "compatible" property.
The attached patch forces the known models into a sane video mode.
It adds also a vmode:22 for the 22" Apple Cinema display, there is
currently no way in the kernel to use that one.
It adds PCI_DEVICE_ID_ATI_RAGE128_TR for the new iMacs.
It adds vmode:21 for that Titanium PowerBook.


(Btw, someone should have at the new aic7xxx, make distclean is broken.)



Gruss Olaf

-- 
 $ man clone

BUGS
       Main feature not yet implemented...

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4.2-ac20.macmodes.dif"

diff -urN linux-2.4.2-ac20/drivers/video/aty128fb.c linux-2.4.2-ac20.macmodes/drivers/video/aty128fb.c
--- linux-2.4.2-ac20/drivers/video/aty128fb.c	Tue Mar 13 23:10:48 2001
+++ linux-2.4.2-ac20.macmodes/drivers/video/aty128fb.c	Tue Mar 13 23:13:31 2001
@@ -176,6 +176,7 @@
     {"Rage128 RL", PCI_DEVICE_ID_ATI_RAGE128_RL, rage_128, "AGP" },
     {"Rage128 Pro PF", PCI_DEVICE_ID_ATI_RAGE128_PF, rage_128_pro, "AGP" },
     {"Rage128 Pro PR", PCI_DEVICE_ID_ATI_RAGE128_PR, rage_128_pro, "PCI" },
+    {"Rage128 Pro TR", PCI_DEVICE_ID_ATI_RAGE128_TR, rage_128_pro, "AGP" },
     {"Rage Mobility M3", PCI_DEVICE_ID_ATI_RAGE128_LE, rage_M3, "PCI" },
     {"Rage Mobility M3", PCI_DEVICE_ID_ATI_RAGE128_LF, rage_M3, "AGP" },
     {NULL, 0, rage_128, NULL }
@@ -1701,6 +1702,28 @@
         } else {
             if (default_vmode <= 0 || default_vmode > VMODE_MAX)
                 default_vmode = VMODE_1024_768_60;
+
+	    /* iMacs need that resolution
+	     * PowerMac2,1 first r128 iMacs
+	     * PowerMac2,2 summer 2000 iMacs
+	     * PowerMac4,1 januar 2001 iMacs "flower power"
+	     */
+	    if (machine_is_compatible("PowerMac2,1") ||
+		machine_is_compatible("PowerMac2,2") ||
+		machine_is_compatible("PowerMac4,1"))
+		default_vmode = VMODE_1024_768_75;
+
+	    /* PowerBook Firewire (Pismo) */
+	    if (machine_is_compatible("PowerBook3,1"))
+		default_vmode = VMODE_1024_768_60;
+
+	    /* PowerBook Titanium */
+	    if (machine_is_compatible("PowerBook3,2"))
+		default_vmode = VMODE_1152_768_60;
+
+	    /* iBook Firewire */
+	    if (machine_is_compatible("PowerBook2,2"))
+		default_vmode = VMODE_800_600_60;
 
             if (default_cmode < CMODE_8 || default_cmode > CMODE_32)
                 default_cmode = CMODE_8;
diff -urN linux-2.4.2-ac20/drivers/video/macmodes.c linux-2.4.2-ac20.macmodes/drivers/video/macmodes.c
--- linux-2.4.2-ac20/drivers/video/macmodes.c	Tue Mar 13 23:10:48 2001
+++ linux-2.4.2-ac20.macmodes/drivers/video/macmodes.c	Tue Mar 13 23:12:32 2001
@@ -94,7 +94,15 @@
 	/* 1280x1024, 75 Hz, Non-Interlaced (135.00 MHz dotclock) */
 	"mac20", 75, 1280, 1024, 7408, 232, 64, 38, 1, 112, 3,
 	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
-    },
+    }, {
+	/* 1152x768, 60 Hz, Titanium PowerBook */
+	"mac21", 75, 1152, 768, 15386, 158, 26, 29, 3, 136, 6,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    }, {
+	/* 1600x1024, 60 Hz, Non-Interlaced (112.27 MHz dotclock) */
+	"mac22", 75, 1600, 1024, 8908, 88, 104, 1, 10, 16, 1,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+    }
 
 #if 0
     /* Anyone who has timings for these? */
@@ -154,12 +162,15 @@
     { VMODE_1024_768_75V, &mac_modedb[9] },
     { VMODE_1024_768_70, &mac_modedb[8] },
     { VMODE_1024_768_60, &mac_modedb[7] },
+    { VMODE_1152_768_60, &mac_modedb[14] },
     /* 1152x870 */
     { VMODE_1152_870_75, &mac_modedb[11] },
     /* 1280x960 */
     { VMODE_1280_960_75, &mac_modedb[12] },
     /* 1280x1024 */
     { VMODE_1280_1024_75, &mac_modedb[13] },
+    /* 1600x1024 */
+    { VMODE_1600_1024_60, &mac_modedb[15] },
     { -1, NULL }
 };
 
@@ -191,6 +202,7 @@
     { 0x730, VMODE_768_576_50I },	/* PAL (Alternate) */
     { 0x73a, VMODE_1152_870_75 },	/* 3rd party 19" */
     { 0x73f, VMODE_640_480_67 },	/* no sense lines connected at all */
+    { 0xBEEF, VMODE_1600_1024_60 },	/* 22" Apple Cinema Display */
     { -1,    VMODE_640_480_60 },	/* catch-all, must be last */
 };
 
diff -urN linux-2.4.2-ac20/include/linux/pci_ids.h linux-2.4.2-ac20.macmodes/include/linux/pci_ids.h
--- linux-2.4.2-ac20/include/linux/pci_ids.h	Tue Mar 13 23:10:53 2001
+++ linux-2.4.2-ac20.macmodes/include/linux/pci_ids.h	Tue Mar 13 23:14:04 2001
@@ -194,6 +194,7 @@
 #define PCI_DEVICE_ID_ATI_RAGE128_PP	0x5050
 #define PCI_DEVICE_ID_ATI_RAGE128_PQ	0x5051
 #define PCI_DEVICE_ID_ATI_RAGE128_PR	0x5052
+#define PCI_DEVICE_ID_ATI_RAGE128_TR	0x5452
 #define PCI_DEVICE_ID_ATI_RAGE128_PS	0x5053
 #define PCI_DEVICE_ID_ATI_RAGE128_PT	0x5054
 #define PCI_DEVICE_ID_ATI_RAGE128_PU	0x5055
diff -urN linux-2.4.2-ac20/include/video/macmodes.h linux-2.4.2-ac20.macmodes/include/video/macmodes.h
--- linux-2.4.2-ac20/include/video/macmodes.h	Thu Feb 10 04:43:57 2000
+++ linux-2.4.2-ac20.macmodes/include/video/macmodes.h	Tue Mar 13 23:12:32 2001
@@ -38,7 +38,9 @@
 #define VMODE_1152_870_75	18	/* 1152x870, 75Hz */
 #define VMODE_1280_960_75	19	/* 1280x960, 75Hz */
 #define VMODE_1280_1024_75	20	/* 1280x1024, 75Hz */
-#define VMODE_MAX		20
+#define VMODE_1152_768_60	21	/* 1152x768, 60Hz     Titanium PowerBook */
+#define VMODE_1600_1024_60	22	/* 1600x1024, 60Hz 22" Cinema Display */
+#define VMODE_MAX		22
 #define VMODE_CHOOSE		99
 
 #define CMODE_NVRAM		-1

--T4sUOijqQbZv57TR--
