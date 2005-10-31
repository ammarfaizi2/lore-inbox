Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbVJaFiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbVJaFiz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 00:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbVJaFiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 00:38:54 -0500
Received: from ozlabs.org ([203.10.76.45]:7349 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751389AbVJaFiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 00:38:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17253.44515.562667.86040@cargo.ozlabs.ibm.com>
Date: Mon, 31 Oct 2005 16:38:43 +1100
From: Paul Mackerras <paulus@samba.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Fix drivers/macintosh/adbhid.c stupid breakage
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c7f7a569d9b4ea7c53ab6fcd1377895312d8372b ("[PATCH] Input:
convert drivers/macintosh to dynamic input_dev allocation") breaks any
machine with an ADB keyboard or mouse, which includes my G4
powerbook.  Was it given any testing at all?

The problem is that adbhid[]->input is NULL, so the kernel oopses with
a null pointer dereference as soon as I press a key.  The following
patch fixes it.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff -urN powerpc-merge/drivers/macintosh/adbhid.c merge-hack/drivers/macintosh/adbhid.c
--- powerpc-merge/drivers/macintosh/adbhid.c	2005-10-31 13:15:26.000000000 +1100
+++ merge-hack/drivers/macintosh/adbhid.c	2005-10-31 16:30:31.000000000 +1100
@@ -723,6 +723,7 @@
 
 	sprintf(hid->phys, "adb%d:%d.%02x/input", id, default_id, original_handler_id);
 
+	hid->input = input_dev;
 	hid->id = default_id;
 	hid->original_handler_id = original_handler_id;
 	hid->current_handler_id = current_handler_id;
