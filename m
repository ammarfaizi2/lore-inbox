Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266218AbUHYWxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266218AbUHYWxI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266292AbUHYWvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:51:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:33435 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266233AbUHYWg7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 18:36:59 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9-rc1
In-Reply-To: <10934733873593@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Wed, 25 Aug 2004 15:36:27 -0700
Message-Id: <1093473387351@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1803.64.4, 2004/08/10 14:49:28-07:00, thomas.koeller@baslerweb.com

[PATCH] Driver Core: fix minor class reference counting issue on the error path

Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/class.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)


diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	2004-08-25 14:56:30 -07:00
+++ b/drivers/base/class.c	2004-08-25 14:56:30 -07:00
@@ -349,13 +349,18 @@
 
 int class_device_add(struct class_device *class_dev)
 {
-	struct class * parent;
+	struct class * parent = NULL;
 	struct class_interface * class_intf;
 	int error;
 
 	class_dev = class_device_get(class_dev);
-	if (!class_dev || !strlen(class_dev->class_id))
+	if (!class_dev)
 		return -EINVAL;
+
+	if (!strlen(class_dev->class_id)) {
+		error = -EINVAL;
+		goto register_done;
+	}
 
 	parent = class_get(class_dev->class);
 

