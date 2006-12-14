Return-Path: <linux-kernel-owner+w=401wt.eu-S1751939AbWLNBZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbWLNBZg (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 20:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751940AbWLNBZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 20:25:35 -0500
Received: from web50109.mail.yahoo.com ([206.190.38.37]:32247 "HELO
	web50109.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751939AbWLNBZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 20:25:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=dLgwdPH+jh85edSVld7znl9lktFCqHlGYf6zMvzqvmb1eckNuASzxbjnZKnQoZQRxs0AwEhey7dXlz4N5aDgA2vbxbA915uJj5RD6ksuuI5H0WETa09eLrVxuUfPJNPjRChsegqqergtj3LatNnZ5Xprt0q9Teo/iFJDOzdZRfU=  ;
Message-ID: <20061214011853.74832.qmail@web50109.mail.yahoo.com>
X-YMail-OSG: _o01BZUVM1lP6dqVK4GF8b7oV6JsfLdB08xf8LWtQL9RjCUSNVGWHt0Lj32MmzvzSupNlf.8WFZukfx7WPOpljKyxDfeBDcLFzx5IHV38txUJQjC81M_0uQwR9.jRckD6JJOdJQ8TFGaewR_tQhynklUhvB8TSs8hYLMfd9V2XcgUEsBubjQVv4w
Date: Wed, 13 Dec 2006 17:18:53 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [PATCH 2/3] EDAC: Add memory scrubbing controls API to core
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frithiof Jensen <frithiof.jensen@ericson.com>

 This patch is meant for Kernel version 2.6.19
 
 This is an attempt of providing an interface for memory 
 scrubbing control in EDAC.
 
 This patch modifies the EDAC Core to provide the Interface
 for memory controller modules to implment.

 The following things are still outstanding:
 
 - K8 is the first implemenation,
 
   The patch provide a method of configuring the K8 hardware memory 
   scrubber via the 'mcX' sysfs directory. There should be some 
   fallback to a generic scrubber implemented in software if the 
   hardware does not support scrubbing.
 
   Or .. the scrubbing sysfs entry should not be visible at all.
 
 - Only works with SDRAM, not cache,
 
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

Frithiof Jensen

edac_mc.c and its .h file is a CORE helper module for EDAC
driver modules. This provides the abstraction for device specific
drivers. It is fine to modify this CORE to provide help for
new features of the the drivers

doug thompson
 
Signed-off-by: Frithiof Jensen <frithiof.jensen@ericson.com>
Signed-off-by: doug thompson <norsk5@xmission.com>

 Documentation/drivers/edac/edac.txt |   16 +++++++++-
 drivers/edac/edac_mc.c              |   57
++++++++++++++++++++++++++++++++++++
 drivers/edac/edac_mc.h              |   12 +++++++
 3 files changed, 84 insertions(+), 1 deletion(-)

Index: linux-2.6.19/drivers/edac/edac_mc.c
===================================================================
--- linux-2.6.19.orig/drivers/edac/edac_mc.c
+++ linux-2.6.19/drivers/edac/edac_mc.c
@@ -926,6 +926,59 @@ static ssize_t mci_reset_counters_store(
 	return count;
 }
 
+/* memory scrubbing */
+static ssize_t mci_sdram_scrub_rate_store(struct mem_ctl_info *mci,
+					const char *data, size_t count)
+{
+	u32 bandwidth = -1;
+
+	if (mci->set_sdram_scrub_rate) {
+
+		memctrl_int_store(&bandwidth, data, count);
+
+		if (!(*mci->set_sdram_scrub_rate)(mci, &bandwidth)) {
+				edac_printk(KERN_DEBUG, EDAC_MC,
+				"Scrub rate set successfully, applied: %d\n",
+				bandwidth);
+		} else {
+			/* FIXME: error codes maybe? */
+			edac_printk(KERN_DEBUG, EDAC_MC,
+				"Scrub rate set FAILED, could not apply: %d\n",
+				bandwidth);
+		}
+
+	} else {
+		/* FIXME: produce "not implemented" ERROR for user-side. */
+		edac_printk(KERN_WARNING, EDAC_MC,
+			"Memory scrubbing 'set'control is not implemented!\n");
+	}
+	return count;
+}
+
+static ssize_t mci_sdram_scrub_rate_show(struct mem_ctl_info *mci,
char *data)
+{
+	u32 bandwidth = -1;
+
+	if (mci->get_sdram_scrub_rate) {
+		if (!(*mci->get_sdram_scrub_rate)(mci, &bandwidth)) {
+			edac_printk(KERN_DEBUG, EDAC_MC,
+				"Scrub rate successfully, fetched: %d\n",
+				bandwidth);
+		} else {
+			/* FIXME: error codes maybe? */
+			edac_printk(KERN_DEBUG, EDAC_MC,
+				"Scrub rate fetch FAILED, got: %d\n",
+				bandwidth);
+		}
+
+	} else {
+		/* FIXME: produce "not implemented" ERROR for user-side.  */
+		edac_printk(KERN_WARNING, EDAC_MC,
+			"Memory scrubbing 'get' control is not implemented!\n");
+	}
+	return sprintf(data,"%d\n", bandwidth);
+}
+
 /* default attribute files for the MCI object */
 static ssize_t mci_ue_count_show(struct mem_ctl_info *mci, char *data)
 {
@@ -1032,6 +1085,9 @@ MCIDEV_ATTR(ce_noinfo_count,S_IRUGO,mci_
 MCIDEV_ATTR(ue_count,S_IRUGO,mci_ue_count_show,NULL);
 MCIDEV_ATTR(ce_count,S_IRUGO,mci_ce_count_show,NULL);
 
+/* memory scrubber attribute file */
+MCIDEV_ATTR(sdram_scrub_rate,S_IRUGO|S_IWUSR,mci_sdram_scrub_rate_show,mci_sdram_scrub_rate_store);
+
 static struct mcidev_attribute *mci_attr[] = {
 	&mci_attr_reset_counters,
 	&mci_attr_mc_name,
@@ -1041,6 +1097,7 @@ static struct mcidev_attribute *mci_attr
 	&mci_attr_ce_noinfo_count,
 	&mci_attr_ue_count,
 	&mci_attr_ce_count,
+	&mci_attr_sdram_scrub_rate,
 	NULL
 };
 
Index: linux-2.6.19/drivers/edac/edac_mc.h
===================================================================
--- linux-2.6.19.orig/drivers/edac/edac_mc.h
+++ linux-2.6.19/drivers/edac/edac_mc.h
@@ -315,6 +315,18 @@ struct mem_ctl_info {
 	unsigned long scrub_cap;	/* chipset scrub capabilities */
 	enum scrub_type scrub_mode;	/* current scrub mode */
 
+	/* Translates sdram memory scrub rate given in bytes/sec to the
+	   internal representation and configures whatever else needs
+	   to be configured.
+	*/
+	int (*set_sdram_scrub_rate) (struct mem_ctl_info *mci, u32 *bw);
+
+	/* Get the current sdram memory scrub rate from the internal
+	   representation and converts it to the closest matching
+	   bandwith in bytes/sec.
+	*/
+	int (*get_sdram_scrub_rate) (struct mem_ctl_info *mci, u32 *bw);
+
 	/* pointer to edac checking routine */
 	void (*edac_check) (struct mem_ctl_info * mci);
 	/*
Index: linux-2.6.19/Documentation/drivers/edac/edac.txt
===================================================================
--- linux-2.6.19.orig/Documentation/drivers/edac/edac.txt
+++ linux-2.6.19/Documentation/drivers/edac/edac.txt
@@ -339,7 +339,21 @@ Device Symlink:
 
 	'device'
 
-	Symlink to the memory controller device
+	Symlink to the memory controller device.
+
+Sdram memory scrubbing rate:
+
+	'sdram_scrub_rate'
+
+	Read/Write attribute file that controls memory scrubbing. The
scrubbing
+	rate is set by writing a minimum bandwith in bytes/sec to the
attribute
+	file. The rate will be translated to an internal value that gives at
+	least the specified rate.
+
+	Reading the file will return the actual scrubbing rate employed.
+
+	If configuration fails or memory scrubbing is not implemented, the
value
+	of the attribute file will be -1.
 
 

"If you think Education is expensive, just try Ignorance"
 "Don&#39;t tell people HOW to do things, tell them WHAT you
want and they will surprise you with their ingenuity."
                   Gen George Patton

