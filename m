Return-Path: <linux-kernel-owner+w=401wt.eu-S1752139AbXACAOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbXACAOi (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 19:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752417AbXACAOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 19:14:38 -0500
Received: from web50112.mail.yahoo.com ([206.190.39.149]:38391 "HELO
	web50112.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752139AbXACAOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 19:14:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=SaYnsq6icsdHmDfuXj5++RzjHZKLitwOv0uzTSpXeIQsQAbIZO4sT3krx6BXk8OOkckoL6A+84gRRB4mae9L2pa8mSQ3CUOZRZNCa/qflhgqKugdGVgUJwKHziIczlrev2Iddr0jfzKTcVInC53GaLxhbroK431F4NfGCKGV1Uk=;
X-YMail-OSG: pg4B74gVM1mqE2AgZqXZLVHLqTeITV1d1n._vIRPMfcp8euKIN2XZjkkV6pD2j3i7A--
Date: Tue, 2 Jan 2007 16:14:35 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Subject: [PATCH 2/2] EDAC: K8 Memory scrubbing patch
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <411976.37299.qm@web50112.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from:	Frithiof Jensen <frithiof.jensen@ericson.com>

 This patch is meant for Kernel version 2.6.19
 
 This is a first, naive, attempt of providing an interface for memory 
 scrubbing in EDAC.
 
 The following things are still outstanding:
 
 - Only the K8 driver has been refactored with a HW scrub function
 
   The patch provide a method of configuring the K8 hardware memory 
   scrubber via the 'mcX' sysfs directory. There should be some 
   fallback to a generic scrubber implemented in software if the 
   hardware does not support scrubbing.
 
   Or .. the scrubbing sysfs entry should not be visible at all.
 
 - Only works with SDRAM,
 
   The K8 can scrub cache and l2cache also - but I think this is
   not so useful as the cache is busy all the time (one hopes). 
 
   One would also expect that cache scrubbing requires hardware
   support.
 
 - Error Handling, 
 
   I would like that errors are returned to the user in 
   "terms of file system". 
 
 - Presentation, 
 
   I chose Bandwidth in Bytes/Second as a representation of 
   the scrubbing rate for the following reasons:
 
   I like that the sysfs entries are sort-of textual, related 
   to something that makes sense instead of magical values 
   that must be looked up. 
 
   "My People" wants "% main memory scrubbed per hour" others 
   prefer "% memory bandwidth used" as representation, "bandwith 
   used" makes it easy to calculate both versions in one-liner 
   scripts.  
 
   If one later wants to scrub cache, the scaling becomes wierd
   for K8 changing from "blocks of 64 byte memory" to "blocks of
   64 cache lines" to "blocks of 64 bit". Using "bandwidth used" 
   makes sense in all three cases, (I.M.O. anyway ;-).
 
 - Discovery,
 
   There is no way to discover the possible settings and what 
   they do without reading the code and the documentation. 
   
   *I* do not know how to make that work in a practical way.
 
 - Bugs(??),
 
   other tools can set invalid values in the memory scrub 
   control register, those will read back as '-1', requiring
   the user to reset the scrub rate. This is how *I* think it
   should be.  
 
 - Afflicting other areas of code,
 
   I made changes to edac_mc.c and edac_mc.h which will show up
   globally - this is not nice, it would be better that the 
   memory scrubbing fuctionality and interface could be entirely
   contained within the memory controller it applies to. 
 
 
Signed-off-by: Frithiof Jensen <frithiof.jensen@ericson.com>
Signed-off-by: doug thompson <norsk5@xmission.com>
 
 k8_edac.c |  135
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

Index: linux-2.6.19/drivers/edac/k8_edac.c
===================================================================
--- linux-2.6.19.orig/drivers/edac/k8_edac.c
+++ linux-2.6.19/drivers/edac/k8_edac.c
@@ -254,6 +254,17 @@
 				 *  7:0  Err addr high 39:32
 				 */
 
+#define K8_SCRCTRL      0x58    /* Memory scrub control register.
+				 *
+				 * 30:21 reserved
+				 * 20:16 dcache scrub
+				 * 15:13 reserved
+				 * 12:8  L2Scrub
+				 * 7:5   reserved
+				 * 4:0   dramscrub
+				 *
+				 */
+
 #define K8_NBCAP	0xE8	/* MCA NB capabilities (32b)
 				 *
 				 * 31:9  reserved
@@ -412,6 +423,45 @@ static const struct k8_dev_info k8_devs[
 		     .misc_ctl = PCI_DEVICE_ID_AMD_OPT_3_MISCCTL},
 };
 
+/* Valid scrub rates for the K8 hardware memory scrubber. We map
+   maps the scrubbing bandwith to a valid bit pattern. The 'set'
+   operation finds the 'matching- or higher value'.
+
+   FIXME: Produce a better mapping/linearisation.
+*/
+
+# define SDRATE_EOD 0xFFFFFFFF
+
+static struct scrubrate {
+	u32 scrubval;		/* bit pattern for scrub rate */
+	u32 bandwidth;		/* bandwidth consumed by scrubbing in bytes/sec */
+} scrubrates[] = {
+	{0x00,          0UL},	/* Scrubbing Off */
+	{0x16,        761UL},	/* Slowest Rate  */
+	{0x15,       1523UL},
+	{0x14,       3051UL},
+	{0x13,       6101UL},
+	{0x12,      12213UL},
+	{0x11,      24427UL},
+	{0x10,      48854UL},
+	{0x0F,      97650UL},
+	{0x0E,     195300UL},
+	{0x0D,     390720UL},
+	{0x0C,     781440UL},
+	{0x0B,    1560975UL},
+	{0x0A,    3121951UL},
+	{0x09,    6274509UL},
+	{0x08,   12284069UL},
+	{0x07,   25000000UL},
+	{0x06,   50000000UL},
+	{0x05,  100000000UL},
+	{0x04,  200000000UL},
+	{0x03,  400000000UL},
+	{0x02,  800000000UL},
+	{0x01, 1600000000UL},
+	{0x00, SDRATE_EOD}		/* End Of Data */
+};
+
 static struct pci_dev * pci_get_related_function(unsigned int vendor,
 		unsigned int device, struct pci_dev *related)
 {
@@ -428,6 +478,88 @@ static struct pci_dev * pci_get_related_
 	return dev;
 }
 
+/* Memory scrubber control interface. For the K8 memory scrubbing is
+   handled by hardware and can involve the cache and the dcache as
+   well as the main memory. This causes the "units" for the scrubbing
+   speed to vary from 64 byte blocks (sdram) over cache lines (cache)
+   to bits (dcache).
+
+   This is nasty, so we will use bandwith in bytes/sec  for the
setting.
+
+   Currently, we only do scrubbing of sdram - the caches are assumed
+   to be excercised always by running code and if the scrubber is done
+   in software on other archs, we might not have access to the
+   caches directly.
+*/
+
+static int set_sdram_scrub_rate(struct mem_ctl_info *mci, u32 *bw)
+{
+	struct k8_pvt *pvt;
+	u32 scrubval;
+	int status = -1;
+	int i;
+
+	pvt = (struct k8_pvt *) mci->pvt_info;
+
+	/* translate the configured rate to a value specific to
+	   the K8 memory controller and apply.
+	   search for the bandwith that is eq or gt than the
+	   setting and program that.
+	*/
+	for (i=0; scrubrates[i].bandwidth != SDRATE_EOD; i++) {
+
+		if (scrubrates[i].bandwidth >= *bw) {
+			scrubval = scrubrates[i].scrubval;
+			pci_write_bits32(pvt->misc_ctl, K8_SCRCTRL,
+						scrubval, 0x001F);
+			status = 0;
+			break;
+		}
+	}
+	return status;
+}
+
+static int get_sdram_scrub_rate(struct mem_ctl_info *mci, u32 *bw)
+{
+	struct k8_pvt *pvt;
+	u32 scrubval = 0;
+	int status = -1;
+	int i;
+
+	pvt = (struct k8_pvt *) mci->pvt_info;
+
+	/* find the bandwith matching the memory scrubber configuration
+	   and return that value in *bw.
+	*/
+	pci_read_config_dword(pvt->misc_ctl, K8_SCRCTRL, &scrubval);
+	scrubval = scrubval & 0x001F;
+
+	edac_printk(KERN_DEBUG, EDAC_MC,
+		"pci-read, sdram scrub control value: %d \n",scrubval);
+
+	for (i=0; scrubrates[i].bandwidth != SDRATE_EOD; i++) {
+
+		if (scrubrates[i].scrubval == scrubval) {
+			*bw = scrubrates[i].bandwidth;
+			status = 0;
+			break;
+		}
+	}
+
+	/* the bit pattern is invalid - we might fix it
+	   by applying the slowest scrub rate as this is
+	   closest to the valid value, but we do not!
+	*/
+
+	if (scrubrates[i].bandwidth == SDRATE_EOD) {
+		edac_printk(KERN_WARNING, EDAC_MC,
+				"Invalid sdram scrub control value: %d \n",
+				scrubval);
+		status = -1;
+	}
+	return status;
+}
+
 /* FIXME - stolen from msr.c - the calls in msr.c could be exported */
 struct msr_command {
 	int cpu;
@@ -1801,6 +1933,9 @@ static int k8_probe1(struct pci_dev *pde
 	mci->ctl_name = k8_devs[dev_idx].ctl_name;
 	mci->edac_check = k8_check;
 	mci->ctl_page_to_phys = NULL;
+	/* memory scrubber interface */
+	mci->set_sdram_scrub_rate = set_sdram_scrub_rate;
+	mci->get_sdram_scrub_rate = get_sdram_scrub_rate;
 
 	if (k8_init_csrows(mci)) {
 		debugf1("Setting mci->edac_cap to EDAC_FLAG_NONE "

