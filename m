Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267735AbUHJUyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267735AbUHJUyc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 16:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267744AbUHJUyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 16:54:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34262 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267735AbUHJUy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 16:54:29 -0400
Date: Tue, 10 Aug 2004 13:54:09 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org, spam99@2thebatcave.com,
       <km@westend.com>, david-b@pacbell.net
Subject: Re: uhci-hcd oops with 2.4.27/ intel D845GLVA
Message-Id: <20040810135409.44d31d1e@lembas.zaitcev.lan>
In-Reply-To: <mailman.1092163681.21436.linux-kernel2news@redhat.com>
References: <1092142777.1042.30.camel@bart.intern>
	<20040810171000.GC12702@logos.cnet>
	<mailman.1092163681.21436.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004 14:10:42 -0300
Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:

> And I'm unable to find the message you are responding to, 
> can you please forward me it?

http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&selm=2rhs2-6H8-11%40gated-at.bofh.it

The "uhci-hcd in 2.4.27" was launched by Nick, Kai simply reused that
header. I should note when I saw "uhci-hcd" I automatically ignored it,
because there's no uhci-hcd in 2.4.

> ehci_hcd 00:1d.7:  Bios handoff failed (104, 1010001)
> unable to handle kernel NULL pointer dereference at virtual address 00000048

This is a clue. I know that EHCI goes belly up if it fails to execute
the handoff.

The attached ought to fix Nick up (no way to tell about Kai because his
report had no data). It consists of two things. First, it fixes the
oops in the scan_async. Second, it prevents the oops from happening by
ignoring the handoff failure (as the old code did, in effect). Either
one should be sufficient, but this is why I use both. The if around
scan_async is the right fix, so it's there on merit. However, it yields
a non-working EHCI if your BIOS is buggy.

I know that David Brownlee disagrees with writing zero into the
configuration space, but it looks safer to me, because old code
did write that zero.

-- Pete

--- linux-2.4.27/drivers/usb/host/ehci-hcd.c	2004-08-10 13:43:36.691040600 -0700
+++ linux-2.4.21-17.EL-usb1/drivers/usb/host/ehci-hcd.c	2004-07-30 16:21:12.000000000 -0700
@@ -303,7 +302,8 @@
 		if (cap & (1 << 16)) {
 			ehci_err (ehci, "BIOS handoff failed (%d, %04x)\n",
 				where, cap);
-			return 1;
+			pci_write_config_dword (ehci->hcd.pdev, where, 0);
+			return 0;
 		} 
 		ehci_dbg (ehci, "BIOS handoff succeeded\n");
 	}
@@ -547,7 +547,8 @@
 
 	/* root hub is shut down separately (first, when possible) */
 	spin_lock_irq (&ehci->lock);
-	ehci_work (ehci, NULL);
+	if (ehci->async)
+		ehci_work (ehci, NULL);
 	spin_unlock_irq (&ehci->lock);
 	ehci_mem_cleanup (ehci);
 
