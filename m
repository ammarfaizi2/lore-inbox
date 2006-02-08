Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030415AbWBHNFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbWBHNFs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 08:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030416AbWBHNFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 08:05:47 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:15786 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1030415AbWBHNFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 08:05:47 -0500
Date: Wed, 8 Feb 2006 13:05:43 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org,
       sfr@canb.auug.org.au
Subject: [PATCH, RFC] [3/3] APM support for generic in-kernel AC status
Message-ID: <20060208130543.GC25659@srcf.ucam.org>
References: <20060208125753.GA25562@srcf.ucam.org> <20060208130422.GB25659@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208130422.GB25659@srcf.ucam.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds APM support for the generic in-kernel AC status code.

Signed-Off-By: Matthew Garrett <mjg59@srcf.ucam.org>

diff --git a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
index 6c8e483..e63f533 100644
--- a/arch/i386/kernel/apm.c
+++ b/arch/i386/kernel/apm.c
@@ -1627,6 +1627,18 @@ static int do_open(struct inode * inode,
 	return 0;
 }
 
+static int apm_get_online_status(void)
+{
+	unsigned short bx;
+	unsigned short cx;
+	unsigned short dx;
+
+	if (apm_get_power_status(&bx, &cx, &dx))
+		return 0;
+	
+	return ((bx >> 8) & 0xff);
+};
+
 static int apm_get_info(char *buf, char **start, off_t fpos, int length)
 {
 	char *		p;
@@ -2372,6 +2384,8 @@ static int __init apm_init(void)
 
 	misc_register(&apm_device);
 
+	pm_set_ac_status(apm_get_online_status);
+
 	if (HZ != 100)
 		idle_period = (idle_period * HZ) / 100;
 	if (idle_threshold < 100) {
@@ -2396,6 +2410,9 @@ static void __exit apm_exit(void)
 		 */
 		cpu_idle_wait();
 	}
+
+	pm_set_ac_status(NULL);
+
 	if (((apm_info.bios.flags & APM_BIOS_DISENGAGED) == 0)
 	    && (apm_info.connection_version > 0x0100)) {
 		error = apm_engage_power_management(APM_DEVICE_ALL, 0);

-- 
Matthew Garrett | mjg59@srcf.ucam.org
