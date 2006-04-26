Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWDZS3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWDZS3E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 14:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWDZS3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 14:29:03 -0400
Received: from fmr17.intel.com ([134.134.136.16]:46787 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S964797AbWDZS3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 14:29:02 -0400
Date: Wed, 26 Apr 2006 11:26:38 -0700
From: mark gross <mgross@linux.intel.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: "Gross, Mark" <mark.gross@intel.com>, minyard@acm.org,
       alan@lxorguk.ukuu.org.uk, bluesmoke-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, steven.carbonari@intel.com,
       soo.keong.ong@intel.com, zhenyu.z.wang@intel.com
Subject: Re: Problems with EDAC coexisting with BIOS
Message-ID: <20060426182638.GA28792@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <5389061B65D50446B1783B97DFDB392DA97BD0@orsmsx411.amr.corp.intel.com> <20060425193405.0ee50691.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060425193405.0ee50691.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 07:34:05PM -0700, Randy.Dunlap wrote:
> On Tue, 25 Apr 2006 16:25:59 -0700 Gross, Mark wrote:
> 
> > 
> > How about printing nothing like it used too?
> > 
> > See attached.  
> > 
> > Signed-off-by: Mark Gross
> 
> Hi Mark,
> 
> This small patch will need some cleaning up:
> 
> 1.  Signed-off-by: Mark Gross <mark.gross@intel.com>
> 
> 2.  Try not to use attachments.  If you must, then make the attachment
> 	type be text instead of octet-stream.
> 
> 3.  No need to init to 0:
> +static int force_function_unhide = 0;
> 
> 4.  Typos:
> 
> +	/* check to see if device 0 function 1 is enbaled if it isn't we
>                                                   enabled; it it isn't, we
> +	 * assume the BIOS has reserved it for a reason and is expecting
> +	 * exclusive access, we take care to not violate that assumption and
>                                           not to violate
> +	 * fail the probe. */
> 
> 5.  indentation, typos, and at least one trailing space:
> 
> +	if (!force_function_unhide && !(stat8 & (1 << 5))) {
> +		printk(KERN_INFO "contact your bios vendor to see if the " 
>                                   Contact your BIOS
> +		"E752x error registers can be safely un-hidden\n");
> 		^indent one more tab
> 
Signed-off-by: Mark Gross <mark.gross@intel.com>


Trying mutt.
thanks,


diff -urN -X linux-2.6.16/Documentation/dontdiff linux-2.6.16/drivers/edac/e752x_edac.c linux-2.6.16_edac/drivers/edac/e752x_edac.c
--- linux-2.6.16/drivers/edac/e752x_edac.c	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16_edac/drivers/edac/e752x_edac.c	2006-04-26 08:36:25.000000000 -0700
@@ -29,6 +29,7 @@
 
 #include "edac_mc.h"
 
+static int force_function_unhide;
 
 #ifndef PCI_DEVICE_ID_INTEL_7520_0
 #define PCI_DEVICE_ID_INTEL_7520_0      0x3590
@@ -755,8 +756,16 @@
 	debugf0("MC: " __FILE__ ": %s(): mci\n", __func__);
 	debugf0("Starting Probe1\n");
 
-	/* enable device 0 function 1 */
+	/* check to see if device 0 function 1 is enbaled; if it isn't, we
+	 * assume the BIOS has reserved it for a reason and is expecting
+	 * exclusive access, we take care not to violate that assumption and
+	 * fail the probe. */
 	pci_read_config_byte(pdev, E752X_DEVPRES1, &stat8);
+	if (!force_function_unhide && !(stat8 & (1 << 5))) {
+		printk(KERN_INFO "Contact your BIOS vendor to see if the "
+			"E752x error registers can be safely un-hidden\n");
+			goto fail;
+	}
 	stat8 |= (1 << 5);
 	pci_write_config_byte(pdev, E752X_DEVPRES1, stat8);
 
@@ -1069,3 +1078,8 @@
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Linux Networx (http://lnxi.com) Tom Zimmerman\n");
 MODULE_DESCRIPTION("MC support for Intel e752x memory controllers");
+
+module_param(force_function_unhide, int, 0444);
+MODULE_PARM_DESC(force_function_unhide, "if BIOS sets Dev0:Fun1 up as hidden:"
+" 1=force unhide and hope BIOS doesn't fight driver for Dev0:Fun1 access");
+
