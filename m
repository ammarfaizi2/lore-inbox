Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965140AbVJ1Gev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbVJ1Gev (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbVJ1Gbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:31:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:45546 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965146AbVJ1GbZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:25 -0400
Cc: dtor_core@ameritech.net
Subject: [PATCH] Input: convert net/bluetooth to dynamic input_dev allocation
In-Reply-To: <11304810252625@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:25 -0700
Message-Id: <11304810252231@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Input: convert net/bluetooth to dynamic input_dev allocation

Input: convert net/bluetooth to dynamic input_dev allocation

This is required for input_dev sysfs integration

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 08303093569fb58889c06a5920947fafc22b66ff
tree 319a26550cf85cb0d4220685bb9877815143d07e
parent 398edfe67704c8fe4ba6fbc79907cbcdc6111768
author Dmitry Torokhov <dtor_core@ameritech.net> Thu, 15 Sep 2005 02:01:40 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:05 -0700

 net/bluetooth/hidp/core.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index de8af5f..860444a 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
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

