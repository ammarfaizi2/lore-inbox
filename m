Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265415AbUAFWk3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 17:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265433AbUAFWk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 17:40:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:61317 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265415AbUAFWkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 17:40:23 -0500
Date: Tue, 6 Jan 2004 14:40:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: patmans@ibm.com, neuffer@goofy.zdv.uni-mainz.de, a.arnold@kfa-juelich.de,
       linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.1-rc1: SCSI: `TIMEOUT' redefined
Message-Id: <20040106144059.0c896eea.akpm@osdl.org>
In-Reply-To: <20040106183325.GJ11523@fs.tum.de>
References: <Pine.LNX.4.58.0312310033110.30995@home.osdl.org>
	<20040106183325.GJ11523@fs.tum.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
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

eww, bad idea.  I count more than twenty #defines of TIMEOUT in the kernel
tree.

We should change scsi.h - "TIMEOUT" is waaay too collision-prone.

In fact, a lot of those identifiers are quite poorly chosen:

#define NEEDS_RETRY     0x2001
#define SUCCESS         0x2002
#define FAILED          0x2003
#define QUEUED          0x2004
#define SOFT_ERROR      0x2005
#define ADD_TO_MLQUEUE  0x2006
#define TIMEOUT         0x2007

That's just asking for it.

This untested patch purports to fix just the TIMEOUT thing:

(hmm, SD_TIMEOUT is already taken, too).


diff -puN drivers/scsi/scsi.c~scsi-rename-TIMEOUT drivers/scsi/scsi.c
--- 25/drivers/scsi/scsi.c~scsi-rename-TIMEOUT	Tue Jan  6 14:37:24 2004
+++ 25-akpm/drivers/scsi/scsi.c	Tue Jan  6 14:37:35 2004
@@ -441,7 +441,7 @@ void scsi_log_completion(struct scsi_cmn
 			case FAILED:
 				printk("FAILED ");
 				break;
-			case TIMEOUT:
+			case SD_CMD_TIMEOUT:
 				/* 
 				 * If called via scsi_times_out.
 				 */
diff -puN drivers/scsi/scsi_error.c~scsi-rename-TIMEOUT drivers/scsi/scsi_error.c
--- 25/drivers/scsi/scsi_error.c~scsi-rename-TIMEOUT	Tue Jan  6 14:37:24 2004
+++ 25-akpm/drivers/scsi/scsi_error.c	Tue Jan  6 14:37:45 2004
@@ -164,7 +164,7 @@ int scsi_delete_timer(struct scsi_cmnd *
  **/
 void scsi_times_out(struct scsi_cmnd *scmd)
 {
-	scsi_log_completion(scmd, TIMEOUT);
+	scsi_log_completion(scmd, SD_CMD_TIMEOUT);
 	if (unlikely(!scsi_eh_scmd_add(scmd, SCSI_EH_CANCEL_CMD))) {
 		panic("Error handler thread not present at %p %p %s %d",
 		      scmd, scmd->device->host, __FILE__, __LINE__);
diff -puN include/scsi/scsi.h~scsi-rename-TIMEOUT include/scsi/scsi.h
--- 25/include/scsi/scsi.h~scsi-rename-TIMEOUT	Tue Jan  6 14:37:24 2004
+++ 25-akpm/include/scsi/scsi.h	Tue Jan  6 14:37:54 2004
@@ -302,7 +302,7 @@ struct scsi_lun {
 #define QUEUED          0x2004
 #define SOFT_ERROR      0x2005
 #define ADD_TO_MLQUEUE  0x2006
-#define TIMEOUT         0x2007
+#define SD_CMD_TIMEOUT  0x2007
 
 /*
  * Midlevel queue return values.

_

