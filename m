Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265434AbUAFWm0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 17:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265443AbUAFWmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 17:42:25 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:24540 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265434AbUAFWmR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 17:42:17 -0500
Date: Tue, 6 Jan 2004 14:40:33 -0800
From: Patrick Mansfield <patmans@ibm.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: neuffer@goofy.zdv.uni-mainz.de, a.arnold@kfa-juelich.de,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: [PATCH] Re: 2.6.1-rc1: SCSI: `TIMEOUT' redefined
Message-ID: <20040106144033.A13031@beaverton.ibm.com>
References: <Pine.LNX.4.58.0312310033110.30995@home.osdl.org> <20040106183325.GJ11523@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040106183325.GJ11523@fs.tum.de>; from bunk@fs.tum.de on Tue, Jan 06, 2004 at 07:33:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 07:33:25PM +0100, Adrian Bunk wrote:
> On Wed, Dec 31, 2003 at 12:36:49AM -0800, Linus Torvalds wrote:
> >...
> > Summary of changes from v2.6.0 to v2.6.1-rc1
> > ============================================
> >...
> > Patrick Mansfield:
> >   o consolidate and log scsi command on send and completion
> >...
> 
> This adds a #define TIMEOUT to scsi.h conflicting with a different 
> TIMEOUT #define in drivers/scsi/eata_generic.h:

Sorry Adrian, here is a patch renaming TIMEOUT to TIMEOUT_ERROR.  Still
not a good name for the usage in SCSI core, but it does not conflict, and
matches the other names for the IO completion results (SUCCESS, FAILED,
etc., they and others should really be prefixed with at least SCSI).

eata does not use the TIMEOUT it defines, but there are enough defines of
TIMEOUT that it could be a problem in other drivers.

Only compile tested for eata driver.

--- 1.132/drivers/scsi/scsi.c	Tue Sep 30 07:24:17 2003
+++ edited/drivers/scsi/scsi.c	Tue Jan  6 13:13:34 2004
@@ -441,7 +441,7 @@
 			case FAILED:
 				printk("FAILED ");
 				break;
-			case TIMEOUT:
+			case TIMEOUT_ERROR:
 				/* 
 				 * If called via scsi_times_out.
 				 */
===== drivers/scsi/scsi_error.c 1.67 vs edited =====
--- 1.67/drivers/scsi/scsi_error.c	Mon Sep 29 05:37:28 2003
+++ edited/drivers/scsi/scsi_error.c	Tue Jan  6 13:12:58 2004
@@ -164,7 +164,7 @@
  **/
 void scsi_times_out(struct scsi_cmnd *scmd)
 {
-	scsi_log_completion(scmd, TIMEOUT);
+	scsi_log_completion(scmd, TIMEOUT_ERROR);
 	if (unlikely(!scsi_eh_scmd_add(scmd, SCSI_EH_CANCEL_CMD))) {
 		panic("Error handler thread not present at %p %p %s %d",
 		      scmd, scmd->device->host, __FILE__, __LINE__);
===== include/scsi/scsi.h 1.15 vs edited =====
--- 1.15/include/scsi/scsi.h	Mon Sep 29 05:39:10 2003
+++ edited/include/scsi/scsi.h	Tue Jan  6 13:12:42 2004
@@ -302,7 +302,7 @@
 #define QUEUED          0x2004
 #define SOFT_ERROR      0x2005
 #define ADD_TO_MLQUEUE  0x2006
-#define TIMEOUT         0x2007
+#define TIMEOUT_ERROR   0x2007
 
 /*
  * Midlevel queue return values.
