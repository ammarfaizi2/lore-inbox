Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264559AbTDPTcE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 15:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264556AbTDPTcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 15:32:04 -0400
Received: from smtp.hccnet.nl ([62.251.0.13]:21471 "EHLO smtp.hccnet.nl")
	by vger.kernel.org with ESMTP id S264555AbTDPTcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 15:32:00 -0400
Message-ID: <3E9DB2D2.4070401@hccnet.nl>
Date: Wed, 16 Apr 2003 21:45:22 +0200
From: Gert Vervoort <gert.vervoort@hccnet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mansfield <patmans@us.ibm.com>
CC: tconnors@astro.swin.edu.au, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.67: ppa driver & preempt == oops
References: <3E982AAC.3060606@hccnet.nl> <1050172083.2291.459.camel@localhost> <3E993C54.40805@hccnet.nl> <1050255133.733.6.camel@localhost> <3E99A1E4.30904@hccnet.nl> <20030415120000.A30422@beaverton.ibm.com> <3E9C6F10.10001@hccnet.nl> <20030415144051.A31514@beaverton.ibm.com> <3E9D984F.20402@hccnet.nl> <20030416110529.A5782@beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Patrick Mansfield wrote:

>There was a missing call to scsi_queue_next_request for door locking (the
>ioctl in the scsi log output, ALLOW_MEDIUM_REMOVAL value 30, or 0x1e),
>Mike A posted this patch to linux-scsi in response to some debugging leg
>work of Alan Stern, does this fix your problem?
>
>  
>
Yes, this fixes the problem. So far, the zip disk seems to work normal 
(mount/umount, eject a disk, reading from disk).

>Not sure if it patches clean against 2.5.67, but it's pretty simple.
>  
>
The following workaround is needed to make the patch compile  (otherwise 
the linker complains about scsi_queue_next_request not being defined):

--- scsi_lib.c.1        2003-04-16 21:23:37.000000000 +0200
+++ scsi_lib.c  2003-04-16 21:23:46.000000000 +0200
@@ -351,7 +351,7 @@
  *             permutations grows as 2**N, and if too many more special 
cases
  *             get added, we start to get screwed.
  */
-static void scsi_queue_next_request(request_queue_t *q, struct 
scsi_cmnd *cmd)
+/*static*/ void scsi_queue_next_request(request_queue_t *q, struct 
scsi_cmnd *cmd)
 {
        struct scsi_device *sdev, *sdev2;
        struct Scsi_Host *shost;


    Gert

>DESC
>The patch adds a call to scsi_queue_next_request from scsi_release_request. It
>also removes a call in scsi_eh_lock_done to scsi_put_command.
>scsi_release_request will do a call to scsi_put_command if needed.
>EDESC
>
>
> drivers/scsi/scsi.c       |    2 ++
> drivers/scsi/scsi_error.c |    4 ----
> 2 files changed, 2 insertions(+), 4 deletions(-)
>
>diff -puN drivers/scsi/scsi.c~scsi-release-req drivers/scsi/scsi.c
>--- sysfs-bleed-2.5/drivers/scsi/scsi.c~scsi-release-req	Mon Apr 14 15:34:14 2003
>+++ sysfs-bleed-2.5-andmike/drivers/scsi/scsi.c	Mon Apr 14 15:34:14 2003
>@@ -224,8 +224,10 @@ void scsi_release_request(Scsi_Request *
> {
> 	if( req->sr_command != NULL )
> 	{
>+    		request_queue_t *q = req->sr_device->request_queue;
> 		scsi_put_command(req->sr_command);
> 		req->sr_command = NULL;
>+		scsi_queue_next_request(q, NULL);
> 	}
> 
> 	kfree(req);
>diff -puN drivers/scsi/scsi_error.c~scsi-release-req drivers/scsi/scsi_error.c
>--- sysfs-bleed-2.5/drivers/scsi/scsi_error.c~scsi-release-req	Mon Apr 14 15:34:14 2003
>+++ sysfs-bleed-2.5-andmike/drivers/scsi/scsi_error.c	Mon Apr 14 15:34:14 2003
>@@ -1334,10 +1334,6 @@ static void scsi_eh_lock_done(struct scs
> {
> 	struct scsi_request *sreq = scmd->sc_request;
> 
>-	scmd->sc_request = NULL;
>-	sreq->sr_command = NULL;
>-
>-	scsi_put_command(scmd);
> 	scsi_release_request(sreq);
> }
>
>.
>
>  
>



