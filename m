Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbUDPUC1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 16:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbUDPUC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 16:02:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:14019 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262459AbUDPUCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 16:02:09 -0400
Date: Fri, 16 Apr 2004 13:02:01 -0700
From: Chris Wright <chrisw@osdl.org>
To: Ken Ashcraft <ken@coverity.com>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu,
       james.bottomley@steeleye.com
Subject: Re: [CHECKER] Probable security holes in 2.6.5
Message-ID: <20040416130201.A22989@build.pdx.osdl.net>
References: <1082134916.19301.7.camel@dns.coverity.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1082134916.19301.7.camel@dns.coverity.int>; from ken@coverity.com on Fri, Apr 16, 2004 at 10:01:57AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [BUG] signed int and unchecked
> /home/kash/linux/linux-2.6.5/drivers/message/fusion/mptctl.c:1313:mptctl_getiocinfo: ERROR:TAINT: 1229:1313:Using user value "port" without first performing bounds checks [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [PATH=]    
> 	else if (data_size == (sizeof(struct mpt_ioctl_iocinfo_rev0)+12))
> 		cim_rev = 0;	/* obsolete */
> 	else
> 		return -EFAULT;
> 
> Start --->
> 	if (copy_from_user(&karg, uarg, data_size)) {
> 
> 	... DELETED 78 lines ...
> 
> 	 */
> 	strncpy (karg.driverVersion, MPT_LINUX_PACKAGE_NAME,
> MPT_IOCTL_VERSION_LENGTH);
> 	karg.driverVersion[MPT_IOCTL_VERSION_LENGTH-1]='\0';
> 
> 	karg.busChangeEvent = 0;
> Error --->
> 	karg.hostId = ioc->pfacts[port].PortSCSIID;
> 	karg.rsvd[0] = karg.rsvd[1] = 0;

Agreed, port should be validated.  Looks like it can only be 0 or 1 if
it's only referencing pfacts[2]?  Patch below.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

===== drivers/message/fusion/mptctl.c 1.20 vs edited =====
--- 1.20/drivers/message/fusion/mptctl.c	Sat Mar 27 07:38:07 2004
+++ edited/drivers/message/fusion/mptctl.c	Fri Apr 16 12:53:20 2004
@@ -1208,7 +1208,7 @@
 	int			numDevices = 0;
 	unsigned int		max_id;
 	int			ii;
-	int			port;
+	unsigned int		port;
 	int			cim_rev;
 	u8			revision;
 
@@ -1240,9 +1240,7 @@
 		return -ENODEV;
 	}
 
-	/* Verify the data transfer size is correct.
-	 * Ignore the port setting.
-	 */
+	/* Verify the data transfer size is correct.  */
 	if (karg.hdr.maxDataSize != data_size) {
 		printk(KERN_ERR "%s@%d::mptctl_getiocinfo - "
 			"Structure size mismatch. Command not completed.\n",
@@ -1258,6 +1256,8 @@
 	else
 		karg.adapterType = MPT_IOCTL_INTERFACE_SCSI;
 
+	if (karg.hdr.port > 1)
+		return -EINVAL;
 	port = karg.hdr.port;
 
 	karg.port = port;
