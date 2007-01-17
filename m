Return-Path: <linux-kernel-owner+w=401wt.eu-S1751986AbXAQDIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbXAQDIX (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 22:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbXAQDIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 22:08:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:38881 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986AbXAQDIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 22:08:22 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,198,1167638400"; 
   d="scan'208"; a="188938970:sNHT18678345"
Date: Wed, 17 Jan 2007 11:07:54 +0800
From: Wang Zhenyu <zhenyu.z.wang@intel.com>
To: davej@redhat.com
Cc: LKML <linux-kernel@vger.kernel.org>, Keith Packard <keithp@keithp.com>,
       Eric Anholt <eric@anholt.net>
Subject: [PATCH] intel_agp: restore graphics device's pci space early in resume
Message-ID: <20070117030754.GA30564@zhen-devel.sh.intel.com>
Mail-Followup-To: davej@redhat.com, LKML <linux-kernel@vger.kernel.org>,
	Keith Packard <keithp@keithp.com>, Eric Anholt <eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Mailer: mutt
X-Operating-System: Linux 2.6.15-1.2054_FC5smp i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dave, 

Currently in resuming path graphics device's pci space restore is 
behind host bridge, so resume function wrongly accesses graphics 
device's space. This makes resuming failure which crashed X. So 
here's a patch to restore device's pci space early, which makes
resuming ok with X. Patch against 2.6.20-rc5.

Signed-off-by: Wang Zhenyu <zhenyu.z.wang@intel.com>

---
diff --git a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.c
index ab0a9c0..7af734b 100644
--- a/drivers/char/agp/intel-agp.c
+++ b/drivers/char/agp/intel-agp.c
@@ -1955,6 +1955,15 @@ static int agp_intel_resume(struct pci_d
 
 	pci_restore_state(pdev);
 
+	/* We should restore our graphics device's config space,
+	 * as host bridge (00:00) resumes before graphics device (02:00),
+	 * then our access to its pci space can work right. 
+	 */
+	if (intel_i810_private.i810_dev)
+		pci_restore_state(intel_i810_private.i810_dev);
+	if (intel_i830_private.i830_dev)
+		pci_restore_state(intel_i830_private.i830_dev);
+
 	if (bridge->driver == &intel_generic_driver)
 		intel_configure();
 	else if (bridge->driver == &intel_850_driver)
