Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267542AbSLFDu3>; Thu, 5 Dec 2002 22:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267544AbSLFDuX>; Thu, 5 Dec 2002 22:50:23 -0500
Received: from dp.samba.org ([66.70.73.150]:4002 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267541AbSLFDuU>;
	Thu, 5 Dec 2002 22:50:20 -0500
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Re: setrlimit incorrectly allows hard limits to exceed soft limits
Date: Fri, 06 Dec 2002 14:26:30 +1100
Message-Id: <20021206035756.2CD1A2C28C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Kingsley Cheung <kingsley@aurema.com>

  Oops, should be after the copy :-(
  

> In 2.4.19 (also 2.5.46) setrlimit code only ever makes a comparison to
> check the old soft limit with the new soft limit and the new hard
> limit with the old hard limit.  There is never a check to ensure the
> new soft limit never exceeds the new hard limit. 
> 
> Just try "ulimit -H -m 10000" for memory limits that were not
> previously set.  You end up with (hard limit = 10000) < (soft limit =
> unlimited).
> 
> Fix is trivial.


--- trivial-2.5-bk/kernel/sys.c.orig	2002-12-06 13:56:43.000000000 +1100
+++ trivial-2.5-bk/kernel/sys.c	2002-12-06 13:56:43.000000000 +1100
@@ -1233,6 +1233,8 @@
 		return -EINVAL;
 	if(copy_from_user(&new_rlim, rlim, sizeof(*rlim)))
 		return -EFAULT;
+       if (new_rlim.rlim_cur > new_rlim.rlim_max)
+               return -EINVAL;
 	old_rlim = current->rlim + resource;
 	if (((new_rlim.rlim_cur > old_rlim->rlim_max) ||
 	     (new_rlim.rlim_max > old_rlim->rlim_max)) &&
-- 
  Don't blame me: the Monkey is driving
  File: Kingsley Cheung <kingsley@aurema.com>: Re: [PATCH] setrlimit incorrectly allows hard limits to exceed soft limits
