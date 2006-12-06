Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760110AbWLFFI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760110AbWLFFI6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 00:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760103AbWLFFI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 00:08:58 -0500
Received: from smtp.osdl.org ([65.172.181.25]:56217 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760102AbWLFFI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 00:08:57 -0500
Date: Tue, 5 Dec 2006 21:08:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: ltuikov@yahoo.com
Cc: mdr@sgi.com, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Infinite retries reading the partition table
Message-Id: <20061205210853.e2661207.akpm@osdl.org>
In-Reply-To: <794609.32071.qm@web31811.mail.mud.yahoo.com>
References: <4575D951.3010705@sgi.com>
	<794609.32071.qm@web31811.mail.mud.yahoo.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 5 Dec 2006 21:00:20 -0800 (PST) Luben Tuikov <ltuikov@yahoo.com> wrote:
> --- Michael Reed <mdr@sgi.com> wrote:
> > Luben Tuikov wrote:
> > ...snip...
> > > This statement in scsi_io_completion() causes the infinite retry loop:
> > >    if (scsi_end_request(cmd, 1, good_bytes, !!result) == NULL)
> > >          return;
> > 
> > The code in 2.6.19 is "result==0", not "!!result", which is logically
> > the same as "result!=0".  Did you mean to change the logic here?
> > Am I missing something?
> 
> Hmm, I think my trees have !!result from an earlier patch I posted.
> 
> In this case it would appear that the second chunk of the patch
> wouldn't be necessary, since result==0 would be false, and it
> wouldn't retry.
> 

I fixed things up.  The below is as-intended, yes?


diff -puN drivers/scsi/scsi_error.c~fix-sense-key-medium-error-processing-and-retry drivers/scsi/scsi_error.c
--- a/drivers/scsi/scsi_error.c~fix-sense-key-medium-error-processing-and-retry
+++ a/drivers/scsi/scsi_error.c
@@ -359,6 +359,11 @@ static int scsi_check_sense(struct scsi_
 		return SUCCESS;
 
 	case MEDIUM_ERROR:
+		if (sshdr.asc == 0x11 || /* UNRECOVERED READ ERR */
+		    sshdr.asc == 0x13 || /* AMNF DATA FIELD */
+		    sshdr.asc == 0x14) { /* RECORD NOT FOUND */
+			return SUCCESS;
+		}
 		return NEEDS_RETRY;
 
 	case HARDWARE_ERROR:
diff -puN drivers/scsi/scsi_lib.c~fix-sense-key-medium-error-processing-and-retry drivers/scsi/scsi_lib.c
--- a/drivers/scsi/scsi_lib.c~fix-sense-key-medium-error-processing-and-retry
+++ a/drivers/scsi/scsi_lib.c
@@ -871,7 +871,8 @@ void scsi_io_completion(struct scsi_cmnd
 	 * are leftovers and there is some kind of error
 	 * (result != 0), retry the rest.
 	 */
-	if (scsi_end_request(cmd, 1, good_bytes, result == 0) == NULL)
+	if (good_bytes &&
+	    scsi_end_request(cmd, 1, good_bytes, result == 0) == NULL)
 		return;
 
 	/* good_bytes = 0, or (inclusive) there were leftovers and
_

