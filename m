Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbUDPSWx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 14:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbUDPSWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 14:22:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:59629 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263229AbUDPSWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 14:22:51 -0400
Date: Fri, 16 Apr 2004 11:20:51 -0700
From: Chris Wright <chrisw@osdl.org>
To: Ken Ashcraft <ken@coverity.com>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu, scott.feldman@intel.com,
       jgarzik@pobox.com
Subject: Re: [CHECKER] Probable security holes in 2.6.5
Message-ID: <20040416112051.V22989@build.pdx.osdl.net>
References: <1082134916.19301.7.camel@dns.coverity.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1082134916.19301.7.camel@dns.coverity.int>; from ken@coverity.com on Fri, Apr 16, 2004 at 10:01:57AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ken Ashcraft (ken@coverity.com) wrote:
> [BUG]
> /home/kash/linux/linux-2.6.5/drivers/net/e1000/e1000_ethtool.c:1494:e1000_ethtool_ioctl: ERROR:TAINT: 1487:1494:Passing unbounded user value "(regs).len" as arg 2 to function "copy_to_user", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(lib,copy_to_user,user,trustingsink)]    [PATH=] 
> 	}
> 	case ETHTOOL_GREGS: {
> 		struct ethtool_regs regs = {ETHTOOL_GREGS};
> 		uint32_t regs_buff[E1000_REGS_LEN];
> 
> Start --->
> 		if(copy_from_user(&regs, addr, sizeof(regs)))
> 			return -EFAULT;
> 		e1000_ethtool_gregs(adapter, &regs, regs_buff);
> 		if(copy_to_user(addr, &regs, sizeof(regs)))
> 			return -EFAULT;
> 
> 		addr += offsetof(struct ethtool_regs, data);
> Error --->
> 		if(copy_to_user(addr, regs_buff, regs.len))
> 			return -EFAULT;
> 
> 		return 0;

Looks like a bug.  Possible patch below zeros the buffer (since it's not
filled completely by e1000_ethtool_gregs()), and truncates len.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

===== drivers/net/e1000/e1000_ethtool.c 1.42 vs edited =====
--- 1.42/drivers/net/e1000/e1000_ethtool.c	Fri Apr  9 16:39:34 2004
+++ edited/drivers/net/e1000/e1000_ethtool.c	Fri Apr 16 11:20:03 2004
@@ -1514,6 +1514,9 @@
 
 		if(copy_from_user(&regs, addr, sizeof(regs)))
 			return -EFAULT;
+		memset(regs_buff, 0, sizeof(regs_buff));
+		if (regs.len > E1000_REGS_LEN)
+			regs.len = E1000_REGS_LEN;
 		e1000_ethtool_gregs(adapter, &regs, regs_buff);
 		if(copy_to_user(addr, &regs, sizeof(regs)))
 			return -EFAULT;
