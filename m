Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263649AbUDPUYK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 16:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263719AbUDPUYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 16:24:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:19410 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263649AbUDPUYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 16:24:02 -0400
Date: Fri, 16 Apr 2004 13:23:51 -0700
From: Chris Wright <chrisw@osdl.org>
To: Ken Ashcraft <ken@coverity.com>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu,
       james.bottomley@steeleye.com
Subject: Re: [CHECKER] Probable security holes in 2.6.5
Message-ID: <20040416132351.B22989@build.pdx.osdl.net>
References: <1082134916.19301.7.camel@dns.coverity.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1082134916.19301.7.camel@dns.coverity.int>; from ken@coverity.com on Fri, Apr 16, 2004 at 10:01:57AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [BUG] probably
> /home/kash/linux/linux-2.6.5/drivers/message/fusion/mptctl.c:2704:mptctl_hp_targetinfo: ERROR:TAINT: 2597:2704:Using user value "((karg).hdr).id" without first performing bounds checks [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [PATH= "pg0_alloc != 0" on line 2626 is false => "(*(*ioc).sh).host_no != ((karg).hdr).host" on line 2619 is false => "(*ioc).sh == 0" on line 2616 is false => "((*ioc).spi_data).sdp0length == 0" on line 2616 is false => "(*ioc).chip_type <= 2345" on line 2613 is false => "ioc == 0" on line 2604 is false => "iocnum = mpt_verify_adapter < 0" on line 2604 is false => "copy_from_user != 0" on line 2597 is false]    
> 	CONFIGPARMS	 	cfg;
> 	ConfigPageHeader_t	hdr;
> 	int			tmp, np, rc = 0;
> 
> 	dctlprintk((": mptctl_hp_targetinfo called.\n"));
> Start --->
> 	if (copy_from_user(&karg, uarg, sizeof(hp_target_info_t))) {
> 
> 	... DELETED 101 lines ...
> 
> 			pci_free_consistent(ioc->pcidev, data_sz, (u8 *) pg3_alloc,
> page_dma);
> 		}
> 	}
> 	hd = (MPT_SCSI_HOST *) ioc->sh->hostdata;
> 	if (hd != NULL)
> Error --->
> 		karg.select_timeouts = hd->sel_timeout[karg.hdr.id];
> 
> 	/* Copy the data from kernel memory to user memory
> 	 */

Yup.  Looks like it's intended to be just 8 bits, considering:
  cfg.pageAddr = (karg.hdr.channel << 8) | karg.hdr.id;

And it indexes into an array sized by:
  #define MPT_MAX_FC_DEVICES              255

Patch below sanity checks id.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

===== drivers/message/fusion/mptctl.c 1.20 vs edited =====
--- 1.20/drivers/message/fusion/mptctl.c	Sat Mar 27 07:38:07 2004
+++ edited/drivers/message/fusion/mptctl.c	Fri Apr 16 13:20:33 2004
@@ -2608,6 +2608,9 @@
 		return -ENODEV;
 	}
 
+	if (karg.hdr.id >= MPT_MAX_FC_DEVICES)
+		return -EINVAL;
+
 	/*  There is nothing to do for FCP parts.
 	 */
 	if ((int) ioc->chip_type <= (int) FC929)
