Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265048AbUFAN52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265048AbUFAN52 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 09:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265058AbUFAN52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 09:57:28 -0400
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:17629 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S265048AbUFAN5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 09:57:19 -0400
Date: Tue, 1 Jun 2004 10:53:36 -0300
From: Guido Guenther <agx@sigxcpu.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Patch]: Fix rivafb's OF parsing
Message-ID: <20040601135335.GA5406@bogon.ms20.nix>
References: <20040601041604.GA2344@bogon.ms20.nix> <1086064086.1978.0.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1086064086.1978.0.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 02:28:06PM +1000, Benjamin Herrenschmidt wrote:
> You'll have more chances getting the patch picked up quickly if you send
> it in the body of the mail, not as an attachment. Attachement are an
> order of magnitude more painful to process for us.
Next try:

the attached patch fixes the EDID parsing for PPC on rivafb. It actually
finds the EDID info in the OF Tree now. I grabbed this from BenHs Tree as
of 2.6.5-rc3. The current code has no chance to work since it doesn't
walk the device tree.
This helps rivafb on PPC at least a bit further...
Cheers,
 -- Guido

signed-off-by: Guido Günther <agx@sigxpu.org>

--- ../linux-2.6.7-rc2.orig/drivers/video/riva/fbdev.c	2004-05-30 11:40:32.000000000 -0300
+++ drivers/video/riva/fbdev.c	2004-06-01 00:57:37.060599712 -0300
@@ -1620,14 +1632,27 @@
 	struct riva_par *par = (struct riva_par *) info->par;
 	struct device_node *dp;
 	unsigned char *pedid = NULL;
+        unsigned char *disptype = NULL;
+        static char *propnames[] = {
+        	"DFP,EDID", "LCD,EDID", "EDID", "EDID1", "EDID,B", "EDID,A", NULL };
+        int i;  
 
 	dp = pci_device_to_OF_node(pd);
-	pedid = (unsigned char *)get_property(dp, "EDID,B", 0);
-
-	if (pedid) {
+        for (; dp != NULL; dp = dp->child) {
+               	disptype = (unsigned char *)get_property(dp, "display-type", NULL);
+                if (disptype == NULL)
+                	continue;
+                if (strncmp(disptype, "LCD", 3) != 0)
+                	continue;
+                for (i = 0; propnames[i] != NULL; ++i) {
+                        pedid = (unsigned char *)
+                                get_property(dp, propnames[i], NULL);
+                        if (pedid != NULL) {
 		par->EDID = pedid;
 		return 1;
-	} else
+                        }
+                }
+        }
 		return 0;
 }
 #endif /* CONFIG_PPC_OF */
