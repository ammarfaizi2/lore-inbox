Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbTIUSkX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 14:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbTIUSkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 14:40:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:51845 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262507AbTIUSkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 14:40:19 -0400
Date: Sun, 21 Sep 2003 11:39:30 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       zwane@linuxpower.ca, axboe@suse.de
Cc: arvidjaar@mail.ru, stoffel@lucent.com, barryn@pobox.com, torvalds@osdl.org
Subject: [PATCH] floppy I/O error handling => Oops
Message-Id: <20030921113930.4ce1f0a1.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


bad_flp_intr() in floppy.c can cause an Oops if the I/O request is
freed but <errors> still points into the I/O request block.

Here is a simple patch that fixes it.  The ordering of the if/else
conditionals might be improved, but this works (for me).

bad_flp_intr() oopsen reports:

Andrey: http://marc.theaimsgroup.com/?l=linux-kernel&m=105837886921297&w=2
John:   http://marc.theaimsgroup.com/?l=linux-kernel&m=106303650007125&w=2
Barry:  http://bugme.osdl.org/show_bug.cgi?id=1033

--
~Randy


patch_name:	floppyio_errors.patch
patch_version:	2003-09-21.11:10:08
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	don't use the <errors> pointer after calling cont->done();
		it can be invalid since it points into a req block
		which may have been freed;
product:	Linux
product_versions: 2.6.0-test5
diffstat:	=
 drivers/block/floppy.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

The ordering of the if/else conditionals may need to change.

diff -Naur ./drivers/block/floppy.c~flopio ./drivers/block/floppy.c
--- ./drivers/block/floppy.c~flopio	2003-09-08 12:49:53.000000000 -0700
+++ ./drivers/block/floppy.c	2003-09-21 11:03:17.000000000 -0700
@@ -2161,7 +2174,7 @@
 	INFBOUND(DRWE->badness, *errors);
 	if (*errors > DP->max_errors.abort)
 		cont->done(0);
-	if (*errors > DP->max_errors.reset)
+	else if (*errors > DP->max_errors.reset)
 		FDCS->reset = 1;
 	else if (*errors > DP->max_errors.recal)
 		DRS->track = NEED_2_RECAL;
