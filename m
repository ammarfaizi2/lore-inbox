Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263575AbTCUXqH>; Fri, 21 Mar 2003 18:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264314AbTCUXqE>; Fri, 21 Mar 2003 18:46:04 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:37368 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S263575AbTCUXp6>; Fri, 21 Mar 2003 18:45:58 -0500
Date: Fri, 21 Mar 2003 15:55:47 -0800
From: Chris Wright <chris@wirex.com>
To: Junfeng Yang <yjf@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu, kas@fi.muni.cz
Subject: Re: [CHECKER] potential dereference of user pointer errors
Message-ID: <20030321155547.C646@figure1.int.wirex.com>
Mail-Followup-To: Junfeng Yang <yjf@stanford.edu>,
	linux-kernel@vger.kernel.org, mc@cs.stanford.edu, kas@fi.muni.cz
References: <200303041112.h24BCRW22235@csl.stanford.edu> <Pine.GSO.4.44.0303202226230.24869-100000@elaine24.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.44.0303202226230.24869-100000@elaine24.Stanford.EDU>; from yjf@stanford.edu on Thu, Mar 20, 2003 at 10:33:45PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Junfeng Yang (yjf@stanford.edu) wrote:
> 
> [BUG] cosa_getidstr calls copy_to_user on arg, which implies arg is
> tainted.

True, arg is a pointer from userspace call to ioctl().

> /home/junfeng/linux-2.5.63/drivers/net/wan/cosa.c:1109:cosa_readmem:
> ERROR:TAINTED deferencing "d" tainted by [dist=2][called by
> cosa_ioctl_common:parm3 calling cosa_getidstr:parm1 calling
> copy_to_user:parm0]

Both cosa_readmem and cosa_download don't seem to do any validation of
the user supplied ptr at all before dereferncing it in get_user.  And
it'd make sense to use 'code' in cosa_reamdme (as in cosa_download)
instead of 'd->code'.  Jan, does this look OK?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

===== drivers/net/wan/cosa.c 1.17 vs edited =====
--- 1.17/drivers/net/wan/cosa.c	Mon Jan 13 17:11:59 2003
+++ edited/drivers/net/wan/cosa.c	Fri Mar 21 15:53:38 2003
@@ -1057,7 +1057,8 @@
 		return -EPERM;
 	}
 
-	if (get_user(addr, &(d->addr)) ||
+	if (verify_area(VERIFY_READ, d, sizeof(*d)) ||
+	    __get_user(addr, &(d->addr)) ||
 	    __get_user(len, &(d->len)) ||
 	    __get_user(code, &(d->code)))
 		return -EFAULT;
@@ -1098,7 +1099,8 @@
 		return -EPERM;
 	}
 
-	if (get_user(addr, &(d->addr)) ||
+	if (verify_area(VERIFY_READ, d, sizeof(*d)) ||
+	    __get_user(addr, &(d->addr)) ||
 	    __get_user(len, &(d->len)) ||
 	    __get_user(code, &(d->code)))
 		return -EFAULT;
@@ -1106,7 +1108,7 @@
 	/* If something fails, force the user to reset the card */
 	cosa->firmware_status &= ~COSA_FW_RESET;
 
-	if ((i=readmem(cosa, d->code, len, addr)) < 0) {
+	if ((i=readmem(cosa, code, len, addr)) < 0) {
 		printk(KERN_NOTICE "cosa%d: reading memory failed: %d\n",
 			cosa->num, i);
 		return -EIO;
