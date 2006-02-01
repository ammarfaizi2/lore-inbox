Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbWBAFJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbWBAFJg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 00:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030318AbWBAFJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 00:09:19 -0500
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:17490 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030311AbWBAFJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 00:09:02 -0500
Message-Id: <20060201050733.733781000.dtor_core@ameritech.net>
References: <20060201045514.178498000.dtor_core@ameritech.net>
Date: Tue, 31 Jan 2006 23:55:18 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: [GIT PATCH 04/18] mousedev: fix memory leak
Content-Disposition: inline; filename=mousedev-fix-leak.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kimball Murray <kimball.murray@stratus.com>

Input: mousedev - fix memory leak

Apparently, "while true; do cat </dev/null >/dev/input/mice; done" causes
an OOM in a short amount of time. Funny that nobody noticed, it actually
is very easy to trigger just by switching between VT1 and VT7...

Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mousedev.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

Index: work/drivers/input/mousedev.c
===================================================================
--- work.orig/drivers/input/mousedev.c
+++ work/drivers/input/mousedev.c
@@ -356,7 +356,7 @@ static void mousedev_free(struct mousede
 	kfree(mousedev);
 }
 
-static int mixdev_release(void)
+static void mixdev_release(void)
 {
 	struct input_handle *handle;
 
@@ -370,8 +370,6 @@ static int mixdev_release(void)
 				mousedev_free(mousedev);
 		}
 	}
-
-	return 0;
 }
 
 static int mousedev_release(struct inode * inode, struct file * file)
@@ -384,9 +382,8 @@ static int mousedev_release(struct inode
 
 	if (!--list->mousedev->open) {
 		if (list->mousedev->minor == MOUSEDEV_MIX)
-			return mixdev_release();
-
-		if (!mousedev_mix.open) {
+			mixdev_release();
+		else if (!mousedev_mix.open) {
 			if (list->mousedev->exist)
 				input_close_device(&list->mousedev->handle);
 			else

