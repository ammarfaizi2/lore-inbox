Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267773AbRGUR5T>; Sat, 21 Jul 2001 13:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267782AbRGUR5J>; Sat, 21 Jul 2001 13:57:09 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:30480 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267773AbRGUR4x>; Sat, 21 Jul 2001 13:56:53 -0400
Date: Sat, 21 Jul 2001 13:56:54 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: patch to ide-tape once again
Message-ID: <20010721135654.A20306@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I am disappointed that my fix did not make it into 2.4.7,
but perhaps it had something to do with the diff filenames?
I tried to work through a maintainer, but apparently Gadi quit
(Andre told me).

http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=38404
 (data corruption while reading near EOF mark).

--- linux-2.4.7/drivers/ide/ide-tape.c	Sat Jul 21 10:44:24 2001
+++ linux-2.4.7-tr5/drivers/ide/ide-tape.c	Sat Jul 21 10:45:41 2001
@@ -4099,9 +4099,14 @@
 	}
 	if (rq_ptr->errors == IDETAPE_ERROR_EOD)
 		return 0;
-	else if (rq_ptr->errors == IDETAPE_ERROR_FILEMARK)
+	if (rq_ptr->errors == IDETAPE_ERROR_FILEMARK) {
+		idetape_switch_buffers (tape, tape->first_stage);
 		set_bit (IDETAPE_FILEMARK, &tape->flags);
-	else {
+#if USE_IOTRACE
+		IO_trace(IO_IDETAPE_FIFO, tape->pipeline_head, tape->buffer_head, tape->tape_head, tape->minor);
+#endif
+		calculate_speeds(drive);
+	} else {
 		idetape_switch_buffers (tape, tape->first_stage);
 		if (rq_ptr->errors == IDETAPE_ERROR_GENERAL) {
 #if ONSTREAM_DEBUG
