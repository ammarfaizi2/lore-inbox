Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264189AbTKKAnL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 19:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264191AbTKKAnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 19:43:11 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:59308 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S264189AbTKKAnG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 19:43:06 -0500
Date: Mon, 10 Nov 2003 21:42:46 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: =?ISO-8859-1?Q?Ram=F3n?= Rey Vicente <ramon.rey@hispalinux.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test9-mm2] Badness in as_put_request at
 drivers/block/as-iosched.c:1783
Message-Id: <20031110214246.525aaf71.vmlinuz386@yahoo.com.ar>
In-Reply-To: <1068500134.2060.3.camel@debian>
References: <1068500134.2060.3.camel@debian>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Nov 2003 22:35:35 +0100, Ramón Rey Vicente wrote:
>Hi.
>
>Trying to scan de ide-scsi devices of my system, I get this
>
>arq->state 4
>Badness in as_put_request at drivers/block/as-iosched.c:1783
>Call Trace:
> [<c01dc908>] as_put_request+0x48/0xa0
> [<c01d47d3>] elv_put_request+0x13/0x20
> [<c01d69f2>] __blk_put_request+0x52/0xa0
> [<c01d6a61>] blk_put_request+0x21/0x40
> [<c01d9d0e>] sg_io+0x2ee/0x440
> [<c01da5c0>] scsi_cmd_ioctl+0x3c0/0x480
> [<c0124b49>] update_process_times+0x29/0x40
> [<c011949c>] schedule+0x31c/0x620
> [<d093bb65>] cdrom_ioctl+0x25/0xd60 [cdrom]
> [<c012eb33>] do_clock_nanosleep+0x1b3/0x300
> [<c0119800>] default_wake_function+0x0/0x20
> [<c01d86fa>] blkdev_ioctl+0x7a/0x383
> [<c01584be>] block_ioctl+0x1e/0x40
> [<c016158f>] sys_ioctl+0xef/0x260
> [<c0257c57>] syscall_call+0x7/0xb
>-- 
>Ramón Rey Vicente       <ramon dot rey at hispalinux dot es>
>        jabber ID       <rreylinux at jabber dot org>
>GPG public key ID 	0xBEBD71D5 -> http://pgp.escomposlinux.org/
>

I resolved this issue with this patch from Nick.

On Mon, 10 Nov 2003 11:53:28 +1100, Nick Piggin wrote:
>Thanks for the report guys,
>Please test the following patch with mm2 and let me know if you still
>have problems with it.
>
>Nick
>
>

 linux-2.6-npiggin/drivers/block/as-iosched.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff -puN drivers/block/as-iosched.c~as-full drivers/block/as-iosched.c
--- linux-2.6/drivers/block/as-iosched.c~as-full	2003-11-08 01:40:49.000000000 +1100
+++ linux-2.6-npiggin/drivers/block/as-iosched.c	2003-11-08 02:04:45.000000000 +1100
@@ -962,7 +962,7 @@ static void as_completed_request(request
 	}
 
 	if (!blk_fs_request(rq))
-		return;
+		goto out;
 
 	if (ad->changed_batch && ad->nr_dispatched == 1) {
 		WARN_ON(ad->batch_data_dir == arq->is_sync);
@@ -982,7 +982,6 @@ static void as_completed_request(request
 	 * and writeback caches
 	 */
 	if (ad->new_batch && ad->batch_data_dir == arq->is_sync) {
-		WARN_ON(ad->batch_data_dir != REQ_SYNC);
 		update_write_batch(ad);
 		ad->current_batch_expires = jiffies +
 				ad->batch_expire[REQ_SYNC];
@@ -1508,8 +1507,10 @@ as_insert_request(request_queue_t *q, st
 
 	/* barriers must flush the reorder queue */
 	if (unlikely(rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER)
-			&& where == ELEVATOR_INSERT_SORT))
+			&& where == ELEVATOR_INSERT_SORT)) {
+		WARN_ON(1);
 		where = ELEVATOR_INSERT_BACK;
+	}
 
 	switch (where) {
 		case ELEVATOR_INSERT_BACK:


chau,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
