Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263634AbUDQBC6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 21:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbUDQBC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 21:02:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:2496 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263634AbUDQBC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 21:02:56 -0400
Date: Fri, 16 Apr 2004 18:00:57 -0700
From: Chris Wright <chrisw@osdl.org>
To: Ken Ashcraft <ken@coverity.com>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu, jgarzik@pobox.com
Subject: Re: [CHECKER] Probable security holes in 2.6.5
Message-ID: <20040416180057.G22989@build.pdx.osdl.net>
References: <1082134916.19301.7.camel@dns.coverity.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1082134916.19301.7.camel@dns.coverity.int>; from ken@coverity.com on Fri, Apr 16, 2004 at 10:01:57AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [BUG] minor
> /home/kash/linux/linux-2.6.5/drivers/net/wan/sdla.c:1206:sdla_xfer:
> ERROR:TAINT: 1201:1206:Passing unbounded user value "(mem).len" as arg 0
> to function "kmalloc", which uses it unsafely in model
> [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)]
> [SINK_MODEL=(lib,kmalloc,user,trustingsink)]  [MINOR]  [PATH=] [Also
> used at, line 1219 in argument 0 to function "kmalloc"]
> static int sdla_xfer(struct net_device *dev, struct sdla_mem *info, int
> read)
> {
> 	struct sdla_mem mem;
> 	char	*temp;
> 
> Start --->
> 	if(copy_from_user(&mem, info, sizeof(mem)))
> 		return -EFAULT;
> 		
> 	if (read)
> 	{	
> Error --->
> 		temp = kmalloc(mem.len, GFP_KERNEL);
> 		if (!temp)
> 			return(-ENOMEM);
> 		sdla_read(dev, mem.addr, temp, mem.len);

Hrm, I believe you could use this to read 128k of kernel memory.
sdla_read() takes len as a short, whereas mem.len is an int.  So,
if mem.len == 0x20000, the allocation could still succeed.  When cast
to short, len will be 0x0, causing the read loop to copy nothing into
the buffer.  At least it's protected by a capable() check.  I don't
know what proper upper bound is for this hardware, or how much it's
used/cared about.  Simple memset() is trivial fix.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

===== drivers/net/wan/sdla.c 1.19 vs edited =====
--- 1.19/drivers/net/wan/sdla.c	Sat Jan 10 16:15:24 2004
+++ edited/drivers/net/wan/sdla.c	Fri Apr 16 17:55:18 2004
@@ -1206,6 +1206,7 @@
 		temp = kmalloc(mem.len, GFP_KERNEL);
 		if (!temp)
 			return(-ENOMEM);
+		memset(temp, 0, mem.len);
 		sdla_read(dev, mem.addr, temp, mem.len);
 		if(copy_to_user(mem.data, temp, mem.len))
 		{
