Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbUKQBAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbUKQBAW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 20:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbUKQBAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 20:00:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61404 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262147AbUKQBAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 20:00:08 -0500
Date: Tue, 16 Nov 2004 16:59:41 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: <marcelo.tosatti@cyclades.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: USB: fix ohci_complete_add
Message-ID: <20041116165941.3b44caca@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Marcelo:

This is a fix for a ludicrously stupid bug in my code in usb-ohci, which
only affects 2.4, fortunately. The problem should be obvious from the code:
when adding an element to the queue, an URB is lost if the queue contains
two or more elements already. The fix is to implement the queue correctly:
add to the tail and do not corrupt the list.

Fortunately for us, this situation is rare and its impact is limited.
More than two URBs have to complete in the same interrupt for this to
happen, and this typically takes several devices operating simultaneously.
When it happens, there is no memory leak and no oops, just a "lost callback"
sort of situation. So, the priority of this is entirely at your discretion,
but personally I'd like to see this in the next full release (2.4.28).

Yours,
-- Pete

--- linux-2.4.28-rc1/drivers/usb/host/usb-ohci.c	2004-04-14 17:33:16.000000000 -0700
+++ linux-2.4.28-rc1-usb/drivers/usb/host/usb-ohci.c	2004-11-16 15:15:44.669540982 -0800
@@ -143,7 +143,7 @@ static void ohci_complete_add(struct ohc
 		ohci->complete_head = urb;
 		ohci->complete_tail = urb;
 	} else {
-		ohci->complete_head->hcpriv = urb;
+		ohci->complete_tail->hcpriv = urb;
 		ohci->complete_tail = urb;
 	}
 }
