Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbTIUTlZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 15:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbTIUTlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 15:41:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:3494 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262544AbTIUTlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 15:41:23 -0400
Date: Sun, 21 Sep 2003 12:40:38 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, zwane@linuxpower.ca,
       axboe@suse.de, arvidjaar@mail.ru, stoffel@lucent.com, barryn@pobox.com,
       torvalds@osdl.org
Subject: Re: [PATCH] floppy I/O error handling => Oops
Message-Id: <20030921124038.33e44375.rddunlap@osdl.org>
In-Reply-To: <20030921113930.4ce1f0a1.rddunlap@osdl.org>
References: <20030921113930.4ce1f0a1.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Sep 2003 11:39:30 -0700 "Randy.Dunlap" <rddunlap@osdl.org> wrote:

| 
| bad_flp_intr() in floppy.c can cause an Oops if the I/O request is
| freed but <errors> still points into the I/O request block.
| 
| bad_flp_intr() oopsen reports:
| 
| Andrey: http://marc.theaimsgroup.com/?l=linux-kernel&m=105837886921297&w=2
| John:   http://marc.theaimsgroup.com/?l=linux-kernel&m=106303650007125&w=2
| Barry:  http://bugme.osdl.org/show_bug.cgi?id=1033

Here's an alternate patch.  Is it preferable?
Still works for me.

--
~Randy


patch_name:	flopio2_errors.patch
patch_version:	2003-09-21.12:26:38
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	don't use <errors> pointer after calling cont->done();
		the request block can become invalid;
product:	Linux
product_versions: 2.6.0-test5
diffstat:	=
 drivers/block/floppy.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)


diff -Naur ./drivers/block/floppy.c~flopio ./drivers/block/floppy.c
--- ./drivers/block/floppy.c~flopio	2003-09-08 12:49:53.000000000 -0700
+++ ./drivers/block/floppy.c	2003-09-21 12:25:01.000000000 -0700
@@ -2152,18 +2152,20 @@
 
 static void bad_flp_intr(void)
 {
+	int errcount;
 	if (probing){
 		DRS->probed_format++;
 		if (!next_valid_format())
 			return;
 	}
 	(*errors)++;
+	errcount = *errors;
 	INFBOUND(DRWE->badness, *errors);
-	if (*errors > DP->max_errors.abort)
+	if (errcount > DP->max_errors.abort)
 		cont->done(0);
-	if (*errors > DP->max_errors.reset)
+	if (errcount > DP->max_errors.reset)
 		FDCS->reset = 1;
-	else if (*errors > DP->max_errors.recal)
+	else if (errcount > DP->max_errors.recal)
 		DRS->track = NEED_2_RECAL;
 }
 
