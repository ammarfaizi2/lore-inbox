Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVAaNON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVAaNON (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 08:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVAaNMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 08:12:45 -0500
Received: from borg.st.net.au ([65.23.158.22]:59848 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S261188AbVAaNJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 08:09:46 -0500
Message-ID: <41FE2DFB.1090801@torque.net>
Date: Mon, 31 Jan 2005 23:09:15 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Fabio Coatti <cova@ferrara.linux.it>, akpm@osdl.org,
       lkml <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: 2.6.11-rc[1,2]-mmX scsi cdrom problem, 2.6.10-mm2 ok
References: <200501310034.32005.cova@ferrara.linux.it> <20050131080021.GA9446@suse.de> <200501311108.19593.cova@ferrara.linux.it> <20050131110550.GA5058@suse.de> <41FE1B39.6030702@torque.net> <20050131114943.GD5058@suse.de>
In-Reply-To: <20050131114943.GD5058@suse.de>
Content-Type: multipart/mixed;
 boundary="------------090707080707000000020307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090707080707000000020307
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Jens Axboe wrote:
> On Mon, Jan 31 2005, Douglas Gilbert wrote:
>=20
>>Jens Axboe wrote:
>>
>>>On Mon, Jan 31 2005, Fabio Coatti wrote:
>>>
>>>
>>>>Alle 09:00, luned=EC 31 gennaio 2005, Jens Axboe ha scritto:
>>>>
>>>>
>>>>>>At this point k3b is stuck in D stat, needs reboot.

I was able to replicate this with a USB burner.
My system didn't need a reboot. The "D" state was locked
on "blk_execute_rq". The burner was still accessible via
sg.

>>>>>The most likely suspect is the REQ_BLOCK_PC scsi changes. Can you tr=
y
>>>>>2.6.11-rc2-mm1 with bk-scsi backed out? (attached)
>>>>
>>>>just tried, right guess :)
>>>>backing out that patch the problem disappears.
>>>>Let me know if you need to narrow further that issue.
>>>
>>>
>>>Doug, it looks like your REQ_BLOCK_PC changes are buggy. Let me know i=
f
>>>you cannot find the full post and I'll forward it to you.
>>
>>Jens,
>>Hmm. Found the thread on lkml. I got an almost identical
>>lock up in k3b with a USB external cd/dvd drive recently.
>>My laptop didn't need rebooting (probably since the root
>>fs is one an ide disk).
>>
>>That is a quite large patch that you referenced. I'll
>>try and replicate and report back.
>=20
>=20
> My guess would be the scsi_lib changes, I would suggest you start there=
.

Indeed. I'm not sure what I was thinking in
scsi_io_completion(). This small reversion
fixes my k3b problem; tested with a USB external
burner.

Signed-off-by: Douglas Gilbert <dougg@torque.net>





--------------090707080707000000020307
Content-Type: text/x-patch;
 name="scsi_lib2611rc2bk8.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scsi_lib2611rc2bk8.diff"

--- linux/drivers/scsi/scsi_lib.c	2005-01-31 17:46:31.000000000 +1000
+++ linux/drivers/scsi/scsi_lib.c2611r2b8_k3b	2005-01-31 22:46:04.000000000 +1000
@@ -692,6 +692,7 @@
 	int this_count = cmd->bufflen;
 	request_queue_t *q = cmd->device->request_queue;
 	struct request *req = cmd->request;
+	int clear_errors = 1;
 	struct scsi_sense_hdr sshdr;
 	int sense_valid = 0;
 	int sense_deferred = 0;
@@ -721,6 +722,7 @@
 	if (blk_pc_request(req)) { /* SG_IO ioctl from block level */
 		req->errors = result;
 		if (result) {
+			clear_errors = 0;
 			if (sense_valid) {
 				/*
 				 * SG_IO wants current and deferred errors
@@ -745,11 +747,6 @@
 	cmd->request_buffer = NULL;
 	cmd->request_bufflen = 0;
 
-	if (blk_pc_request(req)) { /* SG_IO ioctl from block level */
-		scsi_end_request(cmd, 1, good_bytes, 0);
-		return;
-	}
-
 	/*
 	 * Next deal with any sectors which we were able to correctly
 	 * handle.
@@ -759,7 +756,8 @@
 					      req->nr_sectors, good_bytes));
 		SCSI_LOG_HLCOMPLETE(1, printk("use_sg is %d\n", cmd->use_sg));
 
-		req->errors = 0;
+		if (clear_errors)
+			req->errors = 0;
 		/*
 		 * If multiple sectors are requested in one buffer, then
 		 * they will have been finished off by the first command.

--------------090707080707000000020307--

