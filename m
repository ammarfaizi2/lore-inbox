Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264568AbTLQWCl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 17:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbTLQWCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 17:02:41 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:32387 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S264568AbTLQWCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 17:02:39 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH] Fix 2.4 EFI RTC oops
Date: Wed, 17 Dec 2003 15:02:37 -0700
User-Agent: KMail/1.5.4
Cc: trini@mvista.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312171502.37511.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This recent change to 2.4:

	ChangeSet@1.1069.155.3, 2003-12-10 18:30:50-02:00, trini@mvista.com
	  [PATCH] Fix rtc leak

	  ===== arch/cris/drivers/ds1302.c 1.6 vs edited =====

broke efirtc.c (it causes a null pointer dereference on ia64).
The fix is below.  Please apply.

Bjorn

P.S.  The changeset above doesn't appear to be in 2.6 yet.  If/when
you submit it for 2.6, you might consider using this style:

	memset(&wtime, 0, sizeof(wtime));
	memset(wtime, 0, sizeof(*wtime));

which is more obviously correct than:

	memset(&wtime, 0, sizeof(struct rtc_time));
	memset(wtime, 0, sizeof(struct rtc_time));


===== drivers/char/efirtc.c 1.6 vs edited =====
--- 1.6/drivers/char/efirtc.c	Fri Oct 24 04:35:10 2003
+++ edited/drivers/char/efirtc.c	Wed Dec 17 14:33:08 2003
@@ -118,7 +118,7 @@
 static void
 convert_from_efi_time(efi_time_t *eft, struct rtc_time *wtime)
 {
-	memset(&wtime, 0, sizeof(struct rtc_time));
+	memset(wtime, 0, sizeof(struct rtc_time));
 	wtime->tm_sec  = eft->second;
 	wtime->tm_min  = eft->minute;
 	wtime->tm_hour = eft->hour;

