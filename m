Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUGFQLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUGFQLV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 12:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbUGFQLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 12:11:21 -0400
Received: from ida.rowland.org ([192.131.102.52]:24836 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264085AbUGFQLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 12:11:19 -0400
Date: Tue, 6 Jul 2004 12:11:19 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: Jesse Stockall <stockall@magma.ca>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: PATCH: (as339) Interpret down_trylock() result code correctly in
 usb.c
Message-ID: <Pine.LNX.4.44L0.0407061202340.5551-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg:

As Andrew Morton has already spotted, I messed up the interpretation of
the result codes from various _trylock() routines.  I didn't notice that
down_trylock() and down_read_trylock() use opposite conventions for
indicating success!  This patch fixes the incorrect interpretation of
down_trylock().  That error may well be responsible for some of the
problems cropping up recently with OHCI controllers.  Please apply.

Alan Stern



Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

===== drivers/usb/core/usb.c 1.281 vs edited =====
--- 1.281/drivers/usb/core/usb.c	Wed Jun 30 09:44:26 2004
+++ edited/drivers/usb/core/usb.c	Tue Jul  6 12:00:32 2004
@@ -871,7 +871,7 @@
 {
 	if (!down_read_trylock(&usb_all_devices_rwsem))
 		return 0;
-	if (!down_trylock(&udev->serialize)) {
+	if (down_trylock(&udev->serialize)) {
 		up_read(&usb_all_devices_rwsem);
 		return 0;
 	}



