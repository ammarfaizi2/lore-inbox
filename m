Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264920AbUE0RrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264920AbUE0RrP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 13:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUE0RpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 13:45:23 -0400
Received: from outmx006.isp.belgacom.be ([195.238.2.99]:58243 "EHLO
	outmx006.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S264918AbUE0Roe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 13:44:34 -0400
Subject: Re: [2.6.7-rc1-mm1] lp int copy_to_user replaced
From: FabF <fabian.frederick@skynet.be>
To: arjanv@redhat.com
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1085679588.7179.9.camel@laptop.fenrus.com>
References: <1085679127.2070.21.camel@localhost.localdomain>
	 <1085679588.7179.9.camel@laptop.fenrus.com>
Content-Type: multipart/mixed; boundary="=-MOKftr6tvtcXFXewx6aN"
Message-Id: <1085679935.2070.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 27 May 2004 19:45:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MOKftr6tvtcXFXewx6aN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here it is.

FabF

On Thu, 2004-05-27 at 19:39, Arjan van de Ven wrote:
> On Thu, 2004-05-27 at 19:32, FabF wrote:
> > Andrew,
> > 
> > 	Here's a patch to have standard __put_user for integer transfers in lp
> > driver.Is it correct ?
> 
> no it's not. You need to use put_user() not __put_user() at least, to
> make sure the destination address is checked to not be in kernel
> space...
> 

--=-MOKftr6tvtcXFXewx6aN
Content-Disposition: attachment; filename=lp2.diff
Content-Type: text/x-patch; name=lp2.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -Naur orig/drivers/char/lp.c edited/drivers/char/lp.c
--- orig/drivers/char/lp.c	2004-05-10 04:31:58.000000000 +0200
+++ edited/drivers/char/lp.c	2004-05-27 19:43:43.649316720 +0200
@@ -31,6 +31,8 @@
  * Obsoleted and removed all the lowlevel stuff implemented in the last
  * month to use the IEEE1284 functions (that handle the _new_ compatibilty
  * mode fine).
+ *
+ * 27-MAY-2004  Replace int copy_to_user with put_user (Fabian Frederick)
  */
 
 /* This driver should, in theory, work with any parallel port that has an
@@ -603,16 +605,14 @@
 			return -EINVAL;
 			break;
 		case LPGETIRQ:
-			if (copy_to_user((int *) arg, &LP_IRQ(minor),
-					sizeof(int)))
+			if (put_user(LP_IRQ(minor), (int *) arg))
 				return -EFAULT;
 			break;
 		case LPGETSTATUS:
 			lp_claim_parport_or_block (&lp_table[minor]);
 			status = r_str(minor);
 			lp_release_parport (&lp_table[minor]);
-
-			if (copy_to_user((int *) arg, &status, sizeof(int)))
+			if (put_user(status, (int *) arg))
 				return -EFAULT;
 			break;
 		case LPRESET:
@@ -630,7 +630,7 @@
 #endif
  		case LPGETFLAGS:
  			status = LP_F(minor);
-			if (copy_to_user((int *) arg, &status, sizeof(int)))
+			if (put_user(status, (int *) arg))
 				return -EFAULT;
 			break;
 

--=-MOKftr6tvtcXFXewx6aN--

