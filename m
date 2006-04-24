Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWDXPFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWDXPFK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 11:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWDXPFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 11:05:10 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:23072 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750865AbWDXPFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 11:05:02 -0400
Date: Mon, 24 Apr 2006 17:05:04 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, shbader@de.ibm.com
Subject: [patch 9/13] s390: tape 3590 changes.
Message-ID: <20060424150504.GJ15613@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Bader <shbader@de.ibm.com>

[patch 9/13] s390: tape 3590 changes.

Added some changes that where proposed by Andrew Morton.
Added 3592 device type.

Signed-off-by: Stefan Bader <shbader@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/tape_3590.c |   22 +++++++++++-----------
 drivers/s390/char/tape_std.h  |    1 +
 2 files changed, 12 insertions(+), 11 deletions(-)

diff -urpN linux-2.6/drivers/s390/char/tape_3590.c linux-2.6-patched/drivers/s390/char/tape_3590.c
--- linux-2.6/drivers/s390/char/tape_3590.c	2006-04-24 16:47:00.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/tape_3590.c	2006-04-24 16:47:26.000000000 +0200
@@ -230,14 +230,16 @@ tape_3590_read_attmsg(struct tape_device
  * These functions are used to schedule follow-up actions from within an
  * interrupt context (like unsolicited interrupts).
  */
+struct work_handler_data {
+	struct tape_device *device;
+	enum tape_op        op;
+	struct work_struct  work;
+};
+
 static void
 tape_3590_work_handler(void *data)
 {
-	struct {
-		struct tape_device *device;
-		enum tape_op op;
-		struct work_struct work;
-	} *p = data;
+	struct work_handler_data *p = data;
 
 	switch (p->op) {
 	case TO_MSEN:
@@ -257,11 +259,7 @@ tape_3590_work_handler(void *data)
 static int
 tape_3590_schedule_work(struct tape_device *device, enum tape_op op)
 {
-	struct {
-		struct tape_device *device;
-		enum tape_op op;
-		struct work_struct work;
-	} *p;
+	struct work_handler_data *p;
 
 	if ((p = kzalloc(sizeof(*p), GFP_ATOMIC)) == NULL)
 		return -ENOMEM;
@@ -316,7 +314,7 @@ tape_3590_bread(struct tape_device *devi
 
 	rq_for_each_bio(bio, req) {
 		bio_for_each_segment(bv, bio, i) {
-			dst = kmap(bv->bv_page) + bv->bv_offset;
+			dst = page_address(bv->bv_page) + bv->bv_offset;
 			for (off = 0; off < bv->bv_len;
 			     off += TAPEBLOCK_HSEC_SIZE) {
 				ccw->flags = CCW_FLAG_CC;
@@ -1168,6 +1166,7 @@ tape_3590_setup_device(struct tape_devic
 static void
 tape_3590_cleanup_device(struct tape_device *device)
 {
+	flush_scheduled_work();
 	tape_std_unassign(device);
 
 	kfree(device->discdata);
@@ -1234,6 +1233,7 @@ static struct tape_discipline tape_disci
 
 static struct ccw_device_id tape_3590_ids[] = {
 	{CCW_DEVICE_DEVTYPE(0x3590, 0, 0x3590, 0), .driver_info = tape_3590},
+	{CCW_DEVICE_DEVTYPE(0x3592, 0, 0x3592, 0), .driver_info = tape_3592},
 	{ /* end of list */ }
 };
 
diff -urpN linux-2.6/drivers/s390/char/tape_std.h linux-2.6-patched/drivers/s390/char/tape_std.h
--- linux-2.6/drivers/s390/char/tape_std.h	2006-04-24 16:47:00.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/tape_std.h	2006-04-24 16:47:26.000000000 +0200
@@ -153,6 +153,7 @@ enum s390_tape_type {
         tape_3480,
         tape_3490,
         tape_3590,
+        tape_3592,
 };
 
 #endif // _TAPE_STD_H
