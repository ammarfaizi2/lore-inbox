Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbUDSUim (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 16:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbUDSUim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 16:38:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:5578 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262029AbUDSUik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 16:38:40 -0400
Date: Mon, 19 Apr 2004 13:38:32 -0700
From: Chris Wright <chrisw@osdl.org>
To: Ken Ashcraft <ken@coverity.com>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu, dm@uk.sistina.com
Subject: Re: [CHECKER] Probable security holes in 2.6.5
Message-ID: <20040419133832.J22989@build.pdx.osdl.net>
References: <1082134916.19301.7.camel@dns.coverity.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1082134916.19301.7.camel@dns.coverity.int>; from ken@coverity.com on Fri, Apr 16, 2004 at 10:01:57AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [BUG] minor
> /home/kash/linux/linux-2.6.5/drivers/md/dm-ioctl.c:1180:copy_params:
> ERROR:TAINT: 1174:1180:Passing unbounded user value "(tmp).data_size" as
> arg 0 to function "vmalloc", which uses it unsafely in model
> [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)]
> [SINK_MODEL=(lib,vmalloc,user,trustingsink)] [BOUNDS= Lower bound on
> line 1177] [MINOR]  [PATH=] 
> 
> static int copy_params(struct dm_ioctl *user, struct dm_ioctl **param)
> {
> 	struct dm_ioctl tmp, *dmi;
> 
> Start --->
> 	if (copy_from_user(&tmp, user, sizeof(tmp)))
> 		return -EFAULT;
> 
> 	if (tmp.data_size < sizeof(tmp))
> 		return -EINVAL;
> 
> Error --->
> 	dmi = (struct dm_ioctl *) vmalloc(tmp.data_size);
> 	if (!dmi)
> 		return -ENOMEM;
> 

Looks like dm_ioctl() has a free form untyped buffer at the end of the
dm_ioctl struct, which makes it rough to figure the appropriate max for
data_size, esp, those that can be a list.  It's protected by capable(),
not clear if there's a good fix, and I don't see an overflow just a way
to vmalloc() a large bit of memory.  Perhaps there's a case where one
could rename to a name larger than DM_NAME_LEN, then no longer be able to
lookup based on ->name (only ->uuid).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
