Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030454AbVIOHIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030454AbVIOHIQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030442AbVIOHEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:04:09 -0400
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:6551 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030434AbVIOHEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:04:01 -0400
Message-Id: <20050915070302.931769000.dtor_core@ameritech.net>
References: <20050915070131.813650000.dtor_core@ameritech.net>
Date: Thu, 15 Sep 2005 02:01:40 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>
Subject: [patch 09/28] Input: convert net/bluetooth to dynamic input_dev allocation
Content-Disposition: inline; filename=input-dynalloc-bluetooth.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: convert net/bluetooth to dynamic input_dev allocation

This is required for input_dev sysfs integration

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 net/bluetooth/hidp/core.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

Index: work/net/bluetooth/hidp/core.c
===================================================================
--- work.orig/net/bluetooth/hidp/core.c
+++ work/net/bluetooth/hidp/core.c
@@ -520,7 +520,7 @@ static int hidp_session(void *arg)
 
 	if (session->input) {
 		input_unregister_device(session->input);
-		kfree(session->input);
+		session->input = NULL;
 	}
 
 	up_write(&hidp_session_sem);
@@ -536,6 +536,8 @@ static inline void hidp_setup_input(stru
 
 	input->private = session;
 
+	input->name = "Bluetooth HID Boot Protocol Device";
+
 	input->id.bustype = BUS_BLUETOOTH;
 	input->id.vendor  = req->vendor;
 	input->id.product = req->product;
@@ -582,16 +584,15 @@ int hidp_add_connection(struct hidp_conn
 		return -ENOTUNIQ;
 
 	session = kmalloc(sizeof(struct hidp_session), GFP_KERNEL);
-	if (!session) 
+	if (!session)
 		return -ENOMEM;
 	memset(session, 0, sizeof(struct hidp_session));
 
-	session->input = kmalloc(sizeof(struct input_dev), GFP_KERNEL);
+	session->input = input_allocate_device();
 	if (!session->input) {
 		kfree(session);
 		return -ENOMEM;
 	}
-	memset(session->input, 0, sizeof(struct input_dev));
 
 	down_write(&hidp_session_sem);
 
@@ -651,8 +652,10 @@ unlink:
 
 	__hidp_unlink_session(session);
 
-	if (session->input)
+	if (session->input) {
 		input_unregister_device(session->input);
+		session->input = NULL; /* don't try to free it here */
+	}
 
 failed:
 	up_write(&hidp_session_sem);

