Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312543AbSCUW1P>; Thu, 21 Mar 2002 17:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312541AbSCUW1D>; Thu, 21 Mar 2002 17:27:03 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:47090 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S312540AbSCUW0x>; Thu, 21 Mar 2002 17:26:53 -0500
Date: Thu, 21 Mar 2002 14:26:35 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2 questions about SCSI initialization
Message-ID: <20020321142635.A6555@eng2.beaverton.ibm.com>
In-Reply-To: <20020321000553.A6704@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2002 at 12:05:53AM -0500, Pete Zaitcev wrote:

> #2: What does  if (GET_USE_COUNT(tpnt->module) != 0)  do in
> scsi_unregister_device? The circomstances are truly bizzare:
> a) the error code is NEVER used
> b) it can be called either from module unload.
> I would like to kill that check.

Is sd (or sg or whatever) *not* a module in your case?

I think the check is buggy, as it doesn't validate tpnt->module,
IMO you ought to add a check for tpnt->module, and call BUG()
rather than completely removing the check, see the patch below.

If the count is really non zero, the function should not be called
(rmmod won't call into it if the module is in use; if calling via
scsi_register_device_module on failure, it should be impossible
to increment count - it should be impossible to call sd_open or
sg_open).

Here's a patch against 2.4.18:

--- scsi.c.orig	Thu Mar 21 13:51:27 2002
+++ scsi.c	Thu Mar 21 13:52:54 2002
@@ -2331,8 +2331,8 @@
 	/*
 	 * If we are busy, this is not going to fly.
 	 */
-	if (GET_USE_COUNT(tpnt->module) != 0)
-		goto error_out;
+	if (tpnt->module && (GET_USE_COUNT(tpnt->module) != 0))
+		BUG();
 
 	/*
 	 * Next, detach the devices from the driver.
@@ -2366,9 +2366,6 @@
 	 * cleanup function.
 	 */
 	return 0;
-error_out:
-	unlock_kernel();
-	return -1;
 }


-- Patrick Mansfield
