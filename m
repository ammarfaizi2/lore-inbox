Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbUKWHRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbUKWHRQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 02:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbUKWHRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 02:17:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24464 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262244AbUKWHRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 02:17:03 -0500
Date: Mon, 22 Nov 2004 23:16:50 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org
Subject: USB: fix ohci_complete_add
Message-ID: <20041122231650.5e259f8c@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a fix for a ludicrously stupid bug in my code in usb-ohci, which
only affects 2.4, fortunately. The problem should be obvious from the code:
when adding an element to the queue, an URB is lost if the queue contains
two or more elements already. The fix is to implement the queue correctly:
add to the tail and do not corrupt the list.

Fortunately for us, this situation is rare and its impact is limited.
More than two URBs have to complete in the same interrupt for this to
happen, and this typically takes several devices operating simultaneously.
When it happens, there is no memory leak and no oops, just a "lost callback"
sort of situation. I got to know about this when a customer reported that
a when three USB-serial adapters are connected to a system, they start to
lose interrupts when traffic gets heavy.

--- linux-2.4.28-bk3-ohci/drivers/usb/host/usb-ohci.c	2004-04-14 17:33:16.000000000 -0700
+++ linux-2.4.28-rc1-usb/drivers/usb/host/usb-ohci.c	2004-11-16 15:15:44.000000000 -0800
@@ -143,7 +143,7 @@ static void ohci_complete_add(struct ohc
 		ohci->complete_head = urb;
 		ohci->complete_tail = urb;
 	} else {
-		ohci->complete_head->hcpriv = urb;
+		ohci->complete_tail->hcpriv = urb;
 		ohci->complete_tail = urb;
 	}
 }
