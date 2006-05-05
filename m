Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbWEEMUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWEEMUI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 08:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbWEEMUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 08:20:07 -0400
Received: from mail.gondor.com ([212.117.64.182]:18956 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S1751456AbWEEMUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 08:20:06 -0400
Date: Fri, 5 May 2006 14:18:56 +0200
From: Jan Niehusmann <jan@gondor.com>
To: urban@teststation.com
Cc: linux-kernel@vger.kernel.org, samba@samba.org
Subject: [PATCH] smbfs: Fix slab corruption in samba error path
Message-ID: <20060505121856.GA20033@knautsch.gondor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday, I got the following error with 2.6.16.13 during a file copy
from a smb filesystem over a wireless link. I guess there was some error
on the wireless link, which in turn caused an error condition for the
smb filesystem.

In the log, smb_file_read reports error=4294966784 (0xfffffe00), which
also shows up in the slab dumps, and also is -ERESTARTSYS. Error code
27499 corresponds to 0x6b6b, so the rq_errno field seems to be the only
one being set after freeing the slab.

In smb_add_request (which is the only place in smbfs where I found
ERESTARTSYS), I found the following:

        if (!timeleft || signal_pending(current)) {
                /*
                 * On timeout or on interrupt we want to try and remove the
                 * request from the recvq/xmitq.
                 */
                smb_lock_server(server);
                if (!(req->rq_flags & SMB_REQ_RECEIVED)) {
                        list_del_init(&req->rq_queue);
                        smb_rput(req);
                }
                smb_unlock_server(server);
        }
	[...]
        if (signal_pending(current))
                req->rq_errno = -ERESTARTSYS;

I guess that some codepath like smbiod_flush() caused the request
to be removed from the queue, and smb_rput(req) be called, without
SMB_REQ_RECEIVED being set. This violates an asumption made by the
quoted code.

Then, the above code calls smb_rput(req) again, the req gets freed,
and req->rq_errno = -ERESTARTSYS writes into the already freed slab.  As
list_del_init doesn't cause an error if called multiple times, that does
cause the observed behaviour (freed slab with rq_errno=-ERESTARTSYS).

If this observation is correct, the following patch should fix it.

I wonder why the smb code uses list_del_init everywhere - using
list_del instead would catch such situations by poisoning the next and
prev pointers.

Signed-off-by: Jan Niehusmann <jan@gondor.com>

---

May  4 23:29:21 knautsch kernel: [17180085.456000] ipw2200: Firmware error detected.  Restarting.
May  4 23:29:21 knautsch kernel: [17180085.456000] ipw2200: Sysfs 'error' log captured.
May  4 23:33:02 knautsch kernel: [17180306.316000] ipw2200: Firmware error detected.  Restarting.
May  4 23:33:02 knautsch kernel: [17180306.316000] ipw2200: Sysfs 'error' log already exists.
May  4 23:33:02 knautsch kernel: [17180306.968000] smb_file_read: //some_file validation failed, error=4294966784
May  4 23:34:18 knautsch kernel: [17180383.256000] smb_file_read: //some_file validation failed, error=4294966784
May  4 23:34:18 knautsch kernel: [17180383.284000] SMB connection re-established (-5)
May  4 23:37:19 knautsch kernel: [17180563.956000] smb_file_read: //some_file validation failed, error=4294966784
May  4 23:40:09 knautsch kernel: [17180733.636000] smb_file_read: //some_file validation failed, error=4294966784
May  4 23:40:26 knautsch kernel: [17180750.700000] smb_file_read: //some_file validation failed, error=4294966784
May  4 23:43:02 knautsch kernel: [17180907.304000] smb_file_read: //some_file validation failed, error=4294966784
May  4 23:43:08 knautsch kernel: [17180912.324000] smb_file_read: //some_file validation failed, error=4294966784
May  4 23:43:34 knautsch kernel: [17180938.416000] smb_errno: class Unknown, code 27499 from command 0x6b
May  4 23:43:34 knautsch kernel: [17180938.416000] Slab corruption: start=c4ebe09c, len=244
May  4 23:43:34 knautsch kernel: [17180938.416000] Redzone: 0x5a2cf071/0x5a2cf071.
May  4 23:43:34 knautsch kernel: [17180938.416000] Last user: [<e087b903>](smb_rput+0x53/0x90 [smbfs])
May  4 23:43:34 knautsch kernel: [17180938.416000] 000: 6b 6b 6b 6b 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b
May  4 23:43:34 knautsch kernel: [17180938.416000] 0f0: 00 fe ff ff
May  4 23:43:34 knautsch kernel: [17180938.416000] Next obj: start=c4ebe19c, len=244
May  4 23:43:34 knautsch kernel: [17180938.416000] Redzone: 0x5a2cf071/0x5a2cf071.
May  4 23:43:34 knautsch kernel: [17180938.416000] Last user: [<00000000>](_stext+0x3feffde0/0x30)
May  4 23:43:34 knautsch kernel: [17180938.416000] 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
May  4 23:43:34 knautsch kernel: [17180938.416000] 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
May  4 23:43:34 knautsch kernel: [17180938.460000] SMB connection re-established (-5)
May  4 23:43:42 knautsch kernel: [17180946.292000] ipw2200: Firmware error detected.  Restarting.
May  4 23:43:42 knautsch kernel: [17180946.292000] ipw2200: Sysfs 'error' log already exists.
May  4 23:45:04 knautsch kernel: [17181028.752000] ipw2200: Firmware error detected.  Restarting.
May  4 23:45:04 knautsch kernel: [17181028.752000] ipw2200: Sysfs 'error' log already exists.
May  4 23:45:05 knautsch kernel: [17181029.868000] smb_file_read: //some_file validation failed, error=4294966784
May  4 23:45:36 knautsch kernel: [17181060.984000] smb_errno: class Unknown, code 27499 from command 0x6b
May  4 23:45:36 knautsch kernel: [17181060.984000] Slab corruption: start=c4ebe09c, len=244
May  4 23:45:36 knautsch kernel: [17181060.984000] Redzone: 0x5a2cf071/0x5a2cf071.
May  4 23:45:36 knautsch kernel: [17181060.984000] Last user: [<e087b903>](smb_rput+0x53/0x90 [smbfs])
May  4 23:45:36 knautsch kernel: [17181060.984000] 000: 6b 6b 6b 6b 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b
May  4 23:45:36 knautsch kernel: [17181060.984000] 0f0: 00 fe ff ff
May  4 23:45:36 knautsch kernel: [17181060.984000] Next obj: start=c4ebe19c, len=244
May  4 23:45:36 knautsch kernel: [17181060.984000] Redzone: 0x5a2cf071/0x5a2cf071.
May  4 23:45:36 knautsch kernel: [17181060.984000] Last user: [<00000000>](_stext+0x3feffde0/0x30)
May  4 23:45:36 knautsch kernel: [17181060.984000] 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
May  4 23:45:36 knautsch kernel: [17181060.984000] 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
May  4 23:45:36 knautsch kernel: [17181061.024000] SMB connection re-established (-5)
May  4 23:46:17 knautsch kernel: [17181102.132000] smb_file_read: //some_file validation failed, error=4294966784
May  4 23:47:46 knautsch kernel: [17181190.468000] smb_errno: class Unknown, code 27499 from command 0x6b
May  4 23:47:46 knautsch kernel: [17181190.468000] Slab corruption: start=c4ebe09c, len=244
May  4 23:47:46 knautsch kernel: [17181190.468000] Redzone: 0x5a2cf071/0x5a2cf071.
May  4 23:47:46 knautsch kernel: [17181190.468000] Last user: [<e087b903>](smb_rput+0x53/0x90 [smbfs])
May  4 23:47:46 knautsch kernel: [17181190.468000] 000: 6b 6b 6b 6b 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b
May  4 23:47:46 knautsch kernel: [17181190.468000] 0f0: 00 fe ff ff
May  4 23:47:46 knautsch kernel: [17181190.468000] Next obj: start=c4ebe19c, len=244
May  4 23:47:46 knautsch kernel: [17181190.468000] Redzone: 0x5a2cf071/0x5a2cf071.
May  4 23:47:46 knautsch kernel: [17181190.468000] Last user: [<00000000>](_stext+0x3feffde0/0x30)
May  4 23:47:46 knautsch kernel: [17181190.468000] 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
May  4 23:47:46 knautsch kernel: [17181190.468000] 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
May  4 23:47:46 knautsch kernel: [17181190.492000] SMB connection re-established (-5)
May  4 23:49:20 knautsch kernel: [17181284.828000] smb_file_read: //some_file validation failed, error=4294966784
May  4 23:49:39 knautsch kernel: [17181303.896000] smb_file_read: //some_file validation failed, error=4294966784


diff --git a/fs/smbfs/request.c b/fs/smbfs/request.c
index c71c375..d2d8226 100644
--- a/fs/smbfs/request.c
+++ b/fs/smbfs/request.c
@@ -339,9 +339,11 @@ #endif
 		/*
 		 * On timeout or on interrupt we want to try and remove the
 		 * request from the recvq/xmitq.
+		 * First check if the request is still part of a queue. (May
+		 * have been removed by some error condition)
 		 */
 		smb_lock_server(server);
-		if (!(req->rq_flags & SMB_REQ_RECEIVED)) {
+		if (&req->rq_queue != req->rq_queue.next) {
 			list_del_init(&req->rq_queue);
 			smb_rput(req);
 		}

