Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752724AbWKBW54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbWKBW54 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 17:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752720AbWKBW54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 17:57:56 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:18372 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1752717AbWKBW5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 17:57:55 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH -mm][Experimental] suspend: Do not freeze md_threads
Date: Thu, 2 Nov 2006 23:55:52 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, linux-raid@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611022355.52856.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If there's a swap file on a software RAID, it should be possible to use this
file for saving the swsusp's suspend image.  Also, this file should be
available to the memory management subsystem when memory is being freed before
the suspend image is created.

For the above reasons it seems that md_threads should not be frozen during
the suspend and the appended patch makes this happen, but then there is the
question if they don't cause any data to be written to disks after the
suspend image has been created, provided that all filesystems are frozen
at that time.

Please advise.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/md/md.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.19-rc4-mm2/drivers/md/md.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/drivers/md/md.c	2006-11-02 20:51:51.000000000 +0100
+++ linux-2.6.19-rc4-mm2/drivers/md/md.c	2006-11-02 23:25:59.000000000 +0100
@@ -4489,6 +4489,7 @@ static int md_thread(void * arg)
 	 * many dirty RAID5 blocks.
 	 */
 
+	current->flags |= PF_NOFREEZE;
 	allow_signal(SIGKILL);
 	while (!kthread_should_stop()) {
 
@@ -4505,7 +4506,6 @@ static int md_thread(void * arg)
 			 test_bit(THREAD_WAKEUP, &thread->flags)
 			 || kthread_should_stop(),
 			 thread->timeout);
-		try_to_freeze();
 
 		clear_bit(THREAD_WAKEUP, &thread->flags);
 
