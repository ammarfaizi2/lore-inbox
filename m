Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWDZTkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWDZTkk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 15:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbWDZTkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 15:40:40 -0400
Received: from fmr18.intel.com ([134.134.136.17]:38537 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S964855AbWDZTkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 15:40:39 -0400
Date: Wed, 26 Apr 2006 12:39:15 -0700
From: mark gross <mgross@linux.intel.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: mark.gross@intel.com, minyard@acm.org, alan@lxorguk.ukuu.org.uk,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       steven.carbonari@intel.com, soo.keong.ong@intel.com,
       zhenyu.z.wang@intel.com
Subject: Re: Problems with EDAC coexisting with BIOS
Message-ID: <20060426193915.GA30953@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <5389061B65D50446B1783B97DFDB392DA97BD0@orsmsx411.amr.corp.intel.com> <20060425193405.0ee50691.rdunlap@xenotime.net> <20060426182638.GA28792@linux.intel.com> <20060426113835.e3a05749.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060426113835.e3a05749.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 11:38:35AM -0700, Randy.Dunlap wrote:
> On Wed, 26 Apr 2006 11:26:38 -0700 mark gross wrote:
> 
> > Signed-off-by: Mark Gross <mark.gross@intel.com>
> > 
> > 
> > Trying mutt.
> 
> Yes, much better.  Almost there.
> 
> 
> > diff -urN -X linux-2.6.16/Documentation/dontdiff linux-2.6.16/drivers/edac/e752x_edac.c linux-2.6.16_edac/drivers/edac/e752x_edac.c
> > --- linux-2.6.16/drivers/edac/e752x_edac.c	2006-03-19 21:53:29.000000000 -0800
> > +++ linux-2.6.16_edac/drivers/edac/e752x_edac.c	2006-04-26 08:36:25.000000000 -0700
> > @@ -755,8 +756,16 @@
> >  	debugf0("MC: " __FILE__ ": %s(): mci\n", __func__);
> >  	debugf0("Starting Probe1\n");
> >  
> > -	/* enable device 0 function 1 */
> > +	/* check to see if device 0 function 1 is enbaled; if it isn't, we
> 
> "enabled"
> 
> > +	 * assume the BIOS has reserved it for a reason and is expecting
> > +	 * exclusive access, we take care not to violate that assumption and
> > +	 * fail the probe. */
> >  	pci_read_config_byte(pdev, E752X_DEVPRES1, &stat8);
> > +	if (!force_function_unhide && !(stat8 & (1 << 5))) {
> > +		printk(KERN_INFO "Contact your BIOS vendor to see if the "
> > +			"E752x error registers can be safely un-hidden\n");
> > +			goto fail;
> 
> The goto is indented too much...
> 
> > +	}
>

Sorry about that.  trying again.

Signed-off-by: Mark Gross <mark.gross@intel.com>

diff -urN -X linux-2.6.16/Documentation/dontdiff linux-2.6.16/drivers/edac/e752x_edac.c linux-2.6.16_edac/drivers/edac/e752x_edac.c
--- linux-2.6.16/drivers/edac/e752x_edac.c	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16_edac/drivers/edac/e752x_edac.c	2006-04-26 12:31:51.000000000 -0700
@@ -29,6 +29,7 @@
 
 #include "edac_mc.h"
 
+static int force_function_unhide;
 
 #ifndef PCI_DEVICE_ID_INTEL_7520_0
 #define PCI_DEVICE_ID_INTEL_7520_0      0x3590
@@ -755,8 +756,16 @@
 	debugf0("MC: " __FILE__ ": %s(): mci\n", __func__);
 	debugf0("Starting Probe1\n");
 
-	/* enable device 0 function 1 */
+	/* check to see if device 0 function 1 is enabled; if it isn't, we
+	 * assume the BIOS has reserved it for a reason and is expecting
+	 * exclusive access, we take care not to violate that assumption and
+	 * fail the probe. */
 	pci_read_config_byte(pdev, E752X_DEVPRES1, &stat8);
+	if (!force_function_unhide && !(stat8 & (1 << 5))) {
+		printk(KERN_INFO "Contact your BIOS vendor to see if the "
+			"E752x error registers can be safely un-hidden\n");
+		goto fail;
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
