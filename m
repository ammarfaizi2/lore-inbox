Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265840AbUFDPyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265840AbUFDPyE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 11:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265794AbUFDPyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 11:54:03 -0400
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:17331 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S265840AbUFDPvy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 11:51:54 -0400
Date: Fri, 4 Jun 2004 17:49:11 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Patch]: Fix rivafb's OF parsing
Message-ID: <20040604154911.GD10869@bogon.ms20.nix>
References: <20040601041604.GA2344@bogon.ms20.nix> <1086064086.1978.0.camel@gaston> <20040601135335.GA5406@bogon.ms20.nix> <1086302421.1838.45.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1086302421.1838.45.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 08:40:21AM +1000, Benjamin Herrenschmidt wrote:
> > the attached patch fixes the EDID parsing for PPC on rivafb. It actually
> > finds the EDID info in the OF Tree now. I grabbed this from BenHs Tree as
> > of 2.6.5-rc3. The current code has no chance to work since it doesn't
> > walk the device tree.
> > This helps rivafb on PPC at least a bit further...
> > Cheers,
> 
> Your tab/spacing seem to be broken.. Fix the tabs or check that your
> mailer isn't screwing them up.
Next try:
 signed-off-by: Guido Guenther <agx@sigxcpu.org>

--- 2.6/linux-2.6.7-rc2.orig/drivers/video/riva/fbdev.c	2004-06-04 17:40:30.842899312 +0200
+++ current/drivers/video/riva/fbdev.c	2004-06-04 15:38:00.136376560 +0200
@@ -1620,14 +1655,27 @@
 	struct riva_par *par = (struct riva_par *) info->par;
 	struct device_node *dp;
 	unsigned char *pedid = NULL;
+	unsigned char *disptype = NULL;
+	static char *propnames[] = {
+		"DFP,EDID", "LCD,EDID", "EDID", "EDID1", "EDID,B", "EDID,A", NULL };
+	int i;
 
 	dp = pci_device_to_OF_node(pd);
-	pedid = (unsigned char *)get_property(dp, "EDID,B", 0);
-
-	if (pedid) {
+	for (; dp != NULL; dp = dp->child) {
+		disptype = (unsigned char *)get_property(dp, "display-type", NULL);
+		if (disptype == NULL)
+			continue;
+		if (strncmp(disptype, "LCD", 3) != 0)
+			continue;
+		for (i = 0; propnames[i] != NULL; ++i) {
+			pedid = (unsigned char *)
+				get_property(dp, propnames[i], NULL);
+			if (pedid != NULL) {
 		par->EDID = pedid;
 		return 1;
-	} else
+			}
+		}
+	}
 		return 0;
 }
 #endif /* CONFIG_PPC_OF */

