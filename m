Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261224AbSI1LnU>; Sat, 28 Sep 2002 07:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261263AbSI1LnU>; Sat, 28 Sep 2002 07:43:20 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:36480 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S261224AbSI1LnT>; Sat, 28 Sep 2002 07:43:19 -0400
Date: Sat, 28 Sep 2002 13:44:57 +0200
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, cpufreq@www.linux.org.uk, hugang@soulinfo.com
Subject: [PATCH] Re: [2.5.39] (3/5) CPUfreq i386 drivers
Message-ID: <20020928134457.A14784@brodo.de>
References: <20020928112503.E1217@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20020928112503.E1217@brodo.de>; from linux@brodo.de on Sat, Sep 28, 2002 at 11:25:03AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This add-on patch is needed to abort on Dell Inspiron 8000 / 8100 which
would lock up during speedstep.c and to resolve an oops (thanks to Hu Gang
for reporting this)

	Dominik

--- linux/arch/i386/kernel/cpu/cpufreq/speedstep.c.original	Sat Sep 28 12:28:14 2002
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep.c	Sat Sep 28 12:32:04 2002
@@ -288,9 +288,32 @@
 			      PCI_ANY_ID,
 			      PCI_ANY_ID,
 			      NULL);
-	if (speedstep_chipset_dev)
-		return SPEEDSTEP_CHIPSET_ICH2M;
+	if (speedstep_chipset_dev) {
+		/* speedstep.c causes lockups on Dell Inspirons 8000 and
+		 * 8100 which use a pretty old revision of the 82815 
+		 * host brige. Abort on these systems.
+		 */
+		static struct pci_dev   *hostbridge;
+		u8			rev = 0;
+
+		hostbridge  = pci_find_subsys(PCI_VENDOR_ID_INTEL,
+			      PCI_DEVICE_ID_INTEL_82815_MC,
+			      PCI_ANY_ID,
+			      PCI_ANY_ID,
+			      NULL);
+
+		if (!hostbridge)
+			return SPEEDSTEP_CHIPSET_ICH2M;
+			
+		pci_read_config_byte(hostbridge, PCI_REVISION_ID, &rev);
+		if (rev < 5) {
+			dprintk(KERN_INFO "cpufreq: hostbrige does not support speedstep\n");
+			speedstep_chipset_dev = NULL;
+			return 0;
+		}
 
+		return SPEEDSTEP_CHIPSET_ICH2M;
+	}
 
 	return 0;
 }
@@ -504,6 +527,7 @@
 static int speedstep_detect_speeds (void)
 {
 	unsigned int    state;
+	unsigned int    low = 0, high = 0;
 	int             i, result;
     
 	for (i=0; i<2; i++) {
@@ -517,29 +541,32 @@
 			switch (speedstep_processor) {
 			case SPEEDSTEP_PROCESSOR_PIII_C:
 			case SPEEDSTEP_PROCESSOR_PIII_T:
-				speedstep_low_freq = pentium3_get_frequency();
+				low = pentium3_get_frequency();
 				break;
 			case SPEEDSTEP_PROCESSOR_P4M:
-				speedstep_low_freq = pentium4_get_frequency();
+				low = pentium4_get_frequency();
 			}
 			speedstep_set_state(SPEEDSTEP_HIGH);
 		} else {
 			switch (speedstep_processor) {
 			case SPEEDSTEP_PROCESSOR_PIII_C:
 			case SPEEDSTEP_PROCESSOR_PIII_T:
-				speedstep_high_freq = pentium3_get_frequency();
+				high = pentium3_get_frequency();
 				break;
 			case SPEEDSTEP_PROCESSOR_P4M:
-				speedstep_high_freq = pentium4_get_frequency();
+				high = pentium4_get_frequency();
 			}
 			speedstep_set_state(SPEEDSTEP_LOW);
 		}
 
-		if (!speedstep_low_freq || !speedstep_high_freq || 
+		if (!low || !high || 
 		    (speedstep_low_freq == speedstep_high_freq))
 			return -EIO;
 	}
 
+	speedstep_low_freq = low;
+	speedstep_high_freq = high;
+
 	return 0;
 }
 
@@ -632,6 +659,8 @@
 		return result;
 
 	/* detect low and high frequency */
+	speedstep_low_freq = 100000;
+	speedstep_high_freq = 200000;
 	result = speedstep_detect_speeds();
 	if (result)
 		return result;



