Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbUKGGfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbUKGGfB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 01:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbUKGGfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 01:35:01 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:20925 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261548AbUKGGef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 01:34:35 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] panic_blink and i8042 unloading
Date: Sun, 7 Nov 2004 01:34:31 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411070134.31775.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At unload i8042 sets panic_blink to 0. This will cause problems if kernel
panics later as it will just use it assuming that the pointer is correct.

Please consider the patch below that checks if panic_blink is NULL right
in panic() and sets it to no_blink instead.
 
-- 
Dmitry


===================================================================


ChangeSet@1.1956, 2004-11-06 22:53:46-05:00, dtor_core@ameritech.net
  If panic_blink is NULL set it to no_blink before using.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 panic.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)


===================================================================



diff -Nru a/kernel/panic.c b/kernel/panic.c
--- a/kernel/panic.c	2004-11-07 01:31:36 -05:00
+++ b/kernel/panic.c	2004-11-07 01:31:36 -05:00
@@ -42,7 +42,7 @@
 }
 
 /* Returns how long it waited in ms */
-long (*panic_blink)(long time) = no_blink;
+long (*panic_blink)(long time);
 EXPORT_SYMBOL(panic_blink);
 
 /**
@@ -75,7 +75,10 @@
 	smp_send_stop();
 #endif
 
-       notifier_call_chain(&panic_notifier_list, 0, buf);
+	notifier_call_chain(&panic_notifier_list, 0, buf);
+
+	if (!panic_blink)
+		panic_blink = no_blink;
 
 	if (panic_timeout > 0)
 	{
