Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUDSTJR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 15:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbUDSTJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 15:09:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:51597 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261718AbUDSTJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 15:09:13 -0400
Date: Mon, 19 Apr 2004 12:09:08 -0700
From: Chris Wright <chrisw@osdl.org>
To: Ken Ashcraft <ken@coverity.com>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu,
       linux-aacraid-devel@dell.com
Subject: Re: [CHECKER] Probable security holes in 2.6.5
Message-ID: <20040419120908.I22989@build.pdx.osdl.net>
References: <1082134916.19301.7.camel@dns.coverity.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1082134916.19301.7.camel@dns.coverity.int>; from ken@coverity.com on Fri, Apr 16, 2004 at 10:01:57AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [BUG]
> /home/kash/linux/linux-2.6.5/drivers/scsi/aacraid/commctrl.c:419:aac_send_raw_srb: ERROR:TAINT: 413:419:Passing unbounded user value "fibsize" as arg 2 to function "copy_from_user", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(lib,copy_from_user,user,trustingsink)]  [MINOR] [CAPABILTY] [PATH=] 
> 	}
> 	fib_init(srbfib);
> 
> 	srbcmd = (struct aac_srb*) fib_data(srbfib);
> 
> Start --->
> 	if(copy_from_user((void*)&fibsize,
> (void*)&user_srb->count,sizeof(u32))){
> 		printk(KERN_DEBUG"aacraid: Could not copy data size from user\n"); 
> 		rcode = -EFAULT;
> 		goto cleanup;
> 	}
> 
> Error --->
> 	if(copy_from_user(srbcmd, user_srb,fibsize)){
> 		printk(KERN_DEBUG"aacraid: Could not copy srb from user\n"); 
> 		rcode = -EFAULT;
> 		goto cleanup;
> ---------------------------------------------------------

Yup, it's protected by capable(), but...  Simple check eliminate possible
overflow.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

===== drivers/scsi/aacraid/commctrl.c 1.4 vs edited =====
--- 1.4/drivers/scsi/aacraid/commctrl.c	Wed Nov 19 10:38:25 2003
+++ edited/drivers/scsi/aacraid/commctrl.c	Mon Apr 19 12:02:12 2004
@@ -416,6 +416,11 @@
 		goto cleanup;
 	}
 
+	if (fibsize > FIB_DATA_SIZE_IN_BYTES) {
+		rcode = -EINVAL;
+		goto cleanup;
+	}
+
 	if(copy_from_user(srbcmd, user_srb,fibsize)){
 		printk(KERN_DEBUG"aacraid: Could not copy srb from user\n"); 
 		rcode = -EFAULT;
