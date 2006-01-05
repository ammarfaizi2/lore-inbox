Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWAEIgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWAEIgs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 03:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbWAEIgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 03:36:48 -0500
Received: from koto.vergenet.net ([210.128.90.7]:54170 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1750857AbWAEIgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 03:36:47 -0500
Date: Thu, 5 Jan 2006 17:29:02 +0900
From: Horms <horms@verge.net.au>
To: Linux kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, dannf@debian.org,
       micah@riseup.net
Subject: [PATCH, 2.4] wan sdla: fix probable security hole
Message-ID: <20060105082858.GA5872@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104130816.GA11280@informatik.uni-bremen.de>
X-Cluestick: seven
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  From: Chris Wright <chrisw@osdl.org>
>  Date: Mon, 19 Apr 2004 08:26:30 +0000 (-0400)
>  Subject: [PATCH] wan sdla:  fix probable security hole
>  X-Git-Tag: v2.6.6-rc2
>  X-Git-Url: http://www.kernel.org/git/?p=linux/kernel/git/tglx/history.git;a=commitdiff;h=98cd917c1ac348d5cd94beabecc3011dcaa0a0f2
>
>  [PATCH] wan sdla:  fix probable security hole
>
>  > [BUG] minor
>  > /home/kash/linux/linux-2.6.5/drivers/net/wan/sdla.c:1206:sdla_xfer:
>  > ERROR:TAINT: 1201:1206:Passing unbounded user value "(mem).len" as arg 0
>  > to function "kmalloc", which uses it unsafely in model
>  > [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)]
>  > [SINK_MODEL=(lib,kmalloc,user,trustingsink)]  [MINOR]  [PATH=] [Also
>  > used at, line 1219 in argument 0 to function "kmalloc"]
>  > static int sdla_xfer(struct net_device *dev, struct sdla_mem *info, int
>  > read)
>  > {
>  > 	struct sdla_mem mem;
>  > 	char	*temp;
>  >
>  > Start --->
>  > 	if(copy_from_user(&mem, info, sizeof(mem)))
>  > 		return -EFAULT;
>  >
>  > 	if (read)
>  > 	{
>  > Error --->
>  > 		temp = kmalloc(mem.len, GFP_KERNEL);
>  > 		if (!temp)
>  > 			return(-ENOMEM);
>  > 		sdla_read(dev, mem.addr, temp, mem.len);
>
>  Hrm, I believe you could use this to read 128k of kernel memory.
>  sdla_read() takes len as a short, whereas mem.len is an int.  So,
>  if mem.len == 0x20000, the allocation could still succeed.  When cast
>  to short, len will be 0x0, causing the read loop to copy nothing into
>  the buffer.  At least it's protected by a capable() check.  I don't
>  know what proper upper bound is for this hardware, or how much it's
>  used/cared about.  Simple memset() is trivial fix.

This seems to be applicable to 2.4

Signed-Off-By: Horms <horms@verge.net.au>

diff --git a/drivers/net/wan/sdla.c b/drivers/net/wan/sdla.c
index 75fa993..fe74a21 100644
--- a/drivers/net/wan/sdla.c
+++ b/drivers/net/wan/sdla.c
@@ -1201,6 +1201,7 @@ static int sdla_xfer(struct net_device *
 		temp = kmalloc(mem.len, GFP_KERNEL);
 		if (!temp)
 			return(-ENOMEM);
+		memset(temp, 0, mem.len);
 		sdla_read(dev, mem.addr, temp, mem.len);
 		if(copy_to_user(mem.data, temp, mem.len))
 		{
