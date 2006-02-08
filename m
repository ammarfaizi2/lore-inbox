Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161017AbWBHGtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbWBHGtt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161008AbWBHGt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:49:26 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:47488 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161007AbWBHGmk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:42:40 -0500
Message-Id: <20060208064856.592536000@sorel.sous-sol.org>
References: <20060208064503.924238000@sorel.sous-sol.org>
Date: Tue, 07 Feb 2006 22:45:09 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Kimball Murray <kimball.murray@stratus.com>,
       Pete Zaitcev <zaitcev@redhat.com>, Dmitry Torokhov <dtor@mail.ru>
Subject: [PATCH 06/23] Input: mousedev - fix memory leak
Content-Disposition: inline; filename=mousedev-fix-memory-leak.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Apparently, "while true; do cat </dev/null >/dev/input/mice; done" causes
an OOM in a short amount of time. Funny that nobody noticed, it actually
is very easy to trigger just by switching between VT1 and VT7...

Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/input/mousedev.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

Index: linux-2.6.15.3/drivers/input/mousedev.c
===================================================================
--- linux-2.6.15.3.orig/drivers/input/mousedev.c
+++ linux-2.6.15.3/drivers/input/mousedev.c
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

--
