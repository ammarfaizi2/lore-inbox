Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261850AbTCGWqd>; Fri, 7 Mar 2003 17:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261842AbTCGWqY>; Fri, 7 Mar 2003 17:46:24 -0500
Received: from nat9.steeleye.com ([65.114.3.137]:8708 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id <S261831AbTCGWp6>; Fri, 7 Mar 2003 17:45:58 -0500
Subject: Re: [PATCH] scsi_error fix
From: James Bottomley <James.Bottomley@steeleye.com>
To: Mike Anderson <andmike@us.ibm.com>
Cc: Andries.Brouwer@cwi.nl, Patrick Mansfield <patmans@us.ibm.com>,
       linux-kernel@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, torvalds@transmeta.com
In-Reply-To: <20030307224334.GC1148@beaverton.ibm.com>
References: <UTC200303072019.h27KJXX12872.aeb@smtp.cwi.nl>
	<20030307211732.GA1148@beaverton.ibm.com>
	<1047075661.3444.27.camel@mulgrave> 
	<20030307224334.GC1148@beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-wfqBEWQ+ClEkAkWkbykW"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 07 Mar 2003 16:56:16 -0600
Message-Id: <1047077779.4032.34.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wfqBEWQ+ClEkAkWkbykW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2003-03-07 at 16:43, Mike Anderson wrote:
> James Bottomley [James.Bottomley@steeleye.com] wrote:
> 
> > @@ -702,8 +701,14 @@
> >  		 * if the result was normal, then just pass it along to the
> >  		 * upper level.
> >  		 */
> > -		if (rtn == SUCCESS)
> > +		if (rtn == SUCCESS) {
> > +			/* we don't want this command reissued, just
> > +			 * finished with the sense data, so set
> > +			 * retries to the max allowed to ensure it
> > +			 * won't get reissued */
> > +			scmd->retries = scmd->allowed;
> >  			scsi_eh_finish_cmd(scmd, done_q);
> > +		}
> >  		if (rtn != NEEDS_RETRY)
> >  			continue;
> >  
> 
> We might need to cover the case down below if we succeed on retry without
> reaching allowed.
> 
> Another option is to look into re-sending the command from the
> scsi_queue_insert handler like we do with timeouts. The interface to the
> device should be the same from the LLDD's point of view just delayed
> some.

The attached should sweep up all of this.  For NEEDS_RETRY, we will
retry until we reach the max retry count.

James


--=-wfqBEWQ+ClEkAkWkbykW
Content-Disposition: attachment; filename=tmp.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=tmp.diff; charset=ISO-8859-1

=3D=3D=3D=3D=3D drivers/scsi/scsi_error.c 1.38 vs edited =3D=3D=3D=3D=3D
--- 1.38/drivers/scsi/scsi_error.c	Sat Feb 22 10:17:01 2003
+++ edited/drivers/scsi/scsi_error.c	Fri Mar  7 16:15:02 2003
@@ -515,7 +515,7 @@
 	 * actually did complete normally.
 	 */
 	if (rtn =3D=3D SUCCESS) {
-		int rtn =3D scsi_eh_completed_normally(scmd);
+		rtn =3D scsi_eh_completed_normally(scmd);
 		SCSI_LOG_ERROR_RECOVERY(3,
 			printk("%s: scsi_eh_completed_normally %x\n",
 			       __FUNCTION__, rtn));
@@ -545,20 +545,20 @@
 static int scsi_request_sense(struct scsi_cmnd *scmd)
 {
 	static unsigned char generic_sense[6] =3D
-	{REQUEST_SENSE, 0, 0, 0, 255, 0};
-	unsigned char scsi_result0[256], *scsi_result =3D &scsi_result0[0];
+	{REQUEST_SENSE, 0, 0, 0, 254, 0};
+	unsigned char *scsi_result;
 	int saved_result;
 	int rtn;
=20
 	memcpy(scmd->cmnd, generic_sense, sizeof(generic_sense));
=20
-	if (scmd->device->host->hostt->unchecked_isa_dma) {
-		scsi_result =3D kmalloc(512, GFP_ATOMIC | __GFP_DMA);
-		if (unlikely(!scsi_result)) {
-			printk(KERN_ERR "%s: cannot allocate scsi_result.\n",
-					__FUNCTION__);
-			return FAILED;
-		}
+	scsi_result =3D kmalloc(254, GFP_ATOMIC | (scmd->device->host->hostt->unc=
hecked_isa_dma) ? __GFP_DMA : 0);
+
+
+	if (unlikely(!scsi_result)) {
+		printk(KERN_ERR "%s: cannot allocate scsi_result.\n",
+		       __FUNCTION__);
+		return FAILED;
 	}
=20
 	/*
@@ -568,11 +568,11 @@
 	 * address (db).  0 is not a valid sense code.=20
 	 */
 	memset(scmd->sense_buffer, 0, sizeof(scmd->sense_buffer));
-	memset(scsi_result, 0, 256);
+	memset(scsi_result, 0, 254);
=20
 	saved_result =3D scmd->result;
 	scmd->request_buffer =3D scsi_result;
-	scmd->request_bufflen =3D 256;
+	scmd->request_bufflen =3D 254;
 	scmd->use_sg =3D 0;
 	scmd->cmd_len =3D COMMAND_SIZE(scmd->cmnd[0]);
 	scmd->sc_data_direction =3D SCSI_DATA_READ;
@@ -581,13 +581,12 @@
 	rtn =3D scsi_send_eh_cmnd(scmd, SENSE_TIMEOUT);
=20
 	/* last chance to have valid sense data */
-	if (!SCSI_SENSE_VALID(scmd)) {
+	if(!SCSI_SENSE_VALID(scmd)) {
 		memcpy(scmd->sense_buffer, scmd->request_buffer,
-				sizeof(scmd->sense_buffer));
+		       sizeof(scmd->sense_buffer));
 	}
=20
-	if (scsi_result !=3D &scsi_result0[0])
-		kfree(scsi_result);
+	kfree(scsi_result);
=20
 	/*
 	 * when we eventually call scsi_finish, we really wish to complete
@@ -703,25 +702,14 @@
 		 * upper level.
 		 */
 		if (rtn =3D=3D SUCCESS)
-			scsi_eh_finish_cmd(scmd, done_q);
-		if (rtn !=3D NEEDS_RETRY)
+			/* we don't want this command reissued, just
+			 * finished with the sense data, so set
+			 * retries to the max allowed to ensure it
+			 * won't get reissued */
+			scmd->retries =3D scmd->allowed;
+		else if (rtn !=3D NEEDS_RETRY)
 			continue;
=20
-		/*
-		 * we only come in here if we want to retry a
-		 * command.  the test to see whether the command
-		 * should be retried should be keeping track of the
-		 * number of tries, so we don't end up looping, of
-		 * course.
-		 */
-		scmd->state =3D NEEDS_RETRY;
-		rtn =3D scsi_eh_retry_cmd(scmd);
-		if (rtn !=3D SUCCESS)
-			continue;
-
-		/*
-		 * we eventually hand this one back to the top level.
-		 */
 		scsi_eh_finish_cmd(scmd, done_q);
 	}
=20
=3D=3D=3D=3D=3D drivers/scsi/scsi_lib.c 1.73 vs edited =3D=3D=3D=3D=3D
--- 1.73/drivers/scsi/scsi_lib.c	Sat Feb 22 14:35:33 2003
+++ edited/drivers/scsi/scsi_lib.c	Fri Mar  7 15:19:46 2003
@@ -265,7 +265,6 @@
 	cmd->serial_number =3D 0;
 	cmd->serial_number_at_timeout =3D 0;
 	cmd->flags =3D 0;
-	cmd->retries =3D 0;
 	cmd->abort_reason =3D 0;
=20
 	memset(cmd->sense_buffer, 0, sizeof cmd->sense_buffer);

--=-wfqBEWQ+ClEkAkWkbykW--

