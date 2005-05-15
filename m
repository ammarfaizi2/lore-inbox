Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVEOBP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVEOBP6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 21:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVEOBP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 21:15:58 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:55568 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261526AbVEOBPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 21:15:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=CQzFk6t9L+9yc03u6w633MlK2uRMlS9qWeMFzbhMaUoMD1jiveIGla8Er5/MFeYZ3ZqsZ9dCiop2BcPqlK82yzfaPZtLO+SUAu9DsNqaj3WWDGJ8FeENLi+91EVjbIvlUogo8Uzao7CqZUrMjKkvmn/q9ixU5TFis4hL+f/gCGY=
Date: Sun, 15 May 2005 10:15:32 +0900
From: Tejun Heo <htejun@gmail.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, Christoph Hellwig <hch@infradead.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 04/04] scsi: remove unnecessary scsi_wait_req_end_io()
Message-ID: <20050515011532.GA26421@htj.dyndns.org>
References: <20050514135610.81030F26@htj.dyndns.org> <20050514135610.50606F9C@htj.dyndns.org> <1116084383.5049.18.camel@mulgrave> <20050514154733.GA5557@htj.dyndns.org> <1116087547.5049.25.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116087547.5049.25.camel@mulgrave>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2005 at 12:19:07PM -0400, James Bottomley wrote:
> On Sun, 2005-05-15 at 00:47 +0900, Tejun Heo wrote:
> >  BLKPREP_KILL is only used to kill illegal (unpreparable, way-off)
> > requests.  Actually, for special requests, the only tests performed
> > are req->flags and CDB_SIZE tests.  I don't think anyone does/will
> > submit that illegal requests via scsi_wait_req().  And if so, it will
> > be a bug.
> 
> True, but without the code you're removing it will simply hang the
> system, which isn't a correct response to a detected bug.  And if I had
> a shilling for every time someone's predicated a code change on "oh,
> users will never do this" ... I'd be reasonably rich.
> 
> This also leads naturally into the next observation:  Checking in the
> request function should be done.  However, it makes little sense wasting
> resources preparing requests we know are going to be killed, so the
> correct thing to do seems to be to abstract the checks and do them in
> both prep_fn and request_fn.

 I've made two new versions of the same patch.  The first one just
BUG() such cases, and the second one makes scsi_prep_fn() tell
scsi_request_fn() to kill requests instead of doing itself w/
BLKPREP_KILL.  In both cases, I made req->flags error case a BUG().
If you don't like it, feel free to drop that part.

 Oh... one more thing.  I forgot to mention the scsi_kill_requests()
path.  As it's a temporary fix, I just left it as it is (terminate
commands w/ end_that_*).  I guess this patch should be pushed after
removal of that kludge.  But with or without this patch, that path
will leak resources.

 I'm attaching the first version here and the other version in the
next mail.  Please let me know which one you like better.


Index: scsi-reqfn-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_lib.c	2005-05-15 08:49:40.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_lib.c	2005-05-15 09:38:25.000000000 +0900
@@ -265,16 +265,6 @@ static void scsi_wait_done(struct scsi_c
 		complete(req->waiting);
 }
 
-/* This is the end routine we get to if a command was never attached
- * to the request.  Simply complete the request without changing
- * rq_status; this will cause a DRIVER_ERROR. */
-static void scsi_wait_req_end_io(struct request *req)
-{
-	BUG_ON(!req->waiting);
-
-	complete(req->waiting);
-}
-
 void scsi_wait_req(struct scsi_request *sreq, const void *cmnd, void *buffer,
 		   unsigned bufflen, int timeout, int retries)
 {
@@ -282,7 +272,6 @@ void scsi_wait_req(struct scsi_request *
 	
 	sreq->sr_request->waiting = &wait;
 	sreq->sr_request->rq_status = RQ_SCSI_BUSY;
-	sreq->sr_request->end_io = scsi_wait_req_end_io;
 	scsi_do_req(sreq, cmnd, buffer, bufflen, scsi_wait_done,
 			timeout, retries);
 	wait_for_completion(&wait);
@@ -1072,7 +1061,8 @@ static int scsi_prep_fn(struct request_q
 			cmd = req->special;
 	} else {
 		blk_dump_rq_flags(req, "SCSI bad req");
-		return BLKPREP_KILL;
+		BUG();
+		cmd = NULL; /* shut up, gcc */
 	}
 	
 	/* note the overloading of req->special.  When the tag
@@ -1161,7 +1151,13 @@ static int scsi_prep_fn(struct request_q
 	 * request because this will complete at the request level
 	 * (req->end_io), not the scsi command level, so no scsi
 	 * routine will get to free the associated resources.
+	 *
+	 * Due to lack of end_io routine, special requests can't be
+	 * terminated by the block layer.  So, BUG() it and let the
+	 * source of the problem be fixed as they're only used by
+	 * kernel proper.
 	 */
+	BUG_ON(req->flags & REQ_SPECIAL);
 	scsi_release_buffers(cmd);
 	scsi_put_command(cmd);
 	return BLKPREP_KILL;
