Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264020AbUDQAQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 20:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264021AbUDQAQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 20:16:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:34980 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264020AbUDQAQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 20:16:33 -0400
Date: Fri, 16 Apr 2004 17:16:28 -0700
From: Chris Wright <chrisw@osdl.org>
To: Ken Ashcraft <ken@coverity.com>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu, linux@3ware.com,
       James.Bottomley@steeleye.com
Subject: Re: [CHECKER] Probable security holes in 2.6.5
Message-ID: <20040416171628.F22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1082134916.19301.7.camel@dns.coverity.int>; from ken@coverity.com on Fri, Apr 16, 2004 at 10:01:57AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [BUG]
> /home/kash/linux/linux-2.6.5/drivers/scsi/3w-xxxx.c:780:tw_chrdev_ioctl:
> ERROR:TAINT: 673:780:Passing unbounded user value "((1025 +
> (*tw_ioctl).data_buffer_length) - 1)" as arg 2 to function
> "copy_to_user", which uses it unsafely in model
> [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)]
> [SINK_MODEL=(lib,copy_to_user,user,trustingsink)]    [PATH= "error != 0"
> on line 674 is false] 
> 	}
> 
> 	tw_ioctl = (TW_New_Ioctl *)cpu_addr;
> 
> 	/* Now copy down the entire ioctl */
> Start --->
> 	error = copy_from_user(tw_ioctl, (void *)arg, data_buffer_length +
> sizeof(TW_New_Ioctl) - 1);
> 
> 	... DELETED 101 lines ...
> 
> 			retval = -ENOTTY;
> 			goto out2;
> 	}
> 
> 	/* Now copy the response to userspace */
> Error --->
> 	error = copy_to_user((void *)arg, tw_ioctl, sizeof(TW_New_Ioctl) +
> tw_ioctl->data_buffer_length - 1);
> 	if (error == 0)
> 		retval = 0;
> out2:

The data_buffer_length was validated once, however upon second copy
it's conceivable it could've been maliciously changed, so just use
validated one.  Patch below.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

===== drivers/scsi/3w-xxxx.c 1.40 vs edited =====
--- 1.40/drivers/scsi/3w-xxxx.c	Tue Sep 23 08:00:30 2003
+++ edited/drivers/scsi/3w-xxxx.c	Fri Apr 16 14:48:24 2004
@@ -683,7 +683,7 @@
 			break;
 		case TW_OP_AEN_LISTEN:
 			dprintk(KERN_WARNING "3w-xxxx: tw_chrdev_ioctl(): caught TW_AEN_LISTEN.\n");
-			memset(tw_ioctl->data_buffer, 0, tw_ioctl->data_buffer_length);
+			memset(tw_ioctl->data_buffer, 0, data_buffer_length);
 
 			spin_lock_irqsave(tw_dev->host->host_lock, flags);
 			if (tw_dev->aen_head == tw_dev->aen_tail) {
@@ -777,7 +777,7 @@
 	}
 
 	/* Now copy the response to userspace */
-	error = copy_to_user((void *)arg, tw_ioctl, sizeof(TW_New_Ioctl) + tw_ioctl->data_buffer_length - 1);
+	error = copy_to_user((void *)arg, tw_ioctl, sizeof(TW_New_Ioctl) + data_buffer_length - 1);
 	if (error == 0)
 		retval = 0;
 out2:
