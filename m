Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbUDPSOS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 14:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbUDPSOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 14:14:18 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:29834 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S263599AbUDPSNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 14:13:53 -0400
Message-ID: <4080229B.4020307@pacbell.net>
Date: Fri, 16 Apr 2004 11:14:51 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Bill Nottingham <notting@redhat.com>
CC: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] oops when loading ehci_hcd
References: <20040416082311.GA2756@nostromo.devel.redhat.com>
In-Reply-To: <20040416082311.GA2756@nostromo.devel.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------010506030900090306080906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010506030900090306080906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Bill Nottingham wrote:
> With a 2.6.6-rc1 based kernel. Happened when loading ehci_hcd some
> 10 hours after booting, couldn't reproduce in initial attempts. I
> suppose the question is also why it failed to init, but it certainly
> didn't like the failure...

Hmm, no it didn't.  The "illegal capability" is the hardware acting
broken (what kind of EHCI hardware?); I've had reports of similar
stuff happening after ACPI resume (bogus PCI config space values,
in this case zero).

The "-19" means -ENODEV, which seem likely to be another case of a PCI
request not responding correctly:  handshake() failing because reading
a register returned 0xffffffff.

Looks like a cleanup path needs to handle early failure a bit better;
likely just having ehci_stop test for ehci->async non-null (before
calling scan-async to clean up any pending work) would suffice.

- Dave


> Bill
> 
> PCI: Enabling device 0000:00:1d.7 (0000 -> 0002)
> ehci_hcd 0000:00:1d.7: EHCI Host Controller
> ehci_hcd 0000:00:1d.7: illegal capability!
> PCI: Setting latency timer of device 0000:00:1d.7 to 64
> ehci_hcd 0000:00:1d.7: irq 11, pci mem 22946000
> ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
> ehci_hcd 0000:00:1d.7: init error -19ehci_hcd 0000:00:1d.7: remove, state 0
> Unable to handle kernel NULL pointer dereference at virtual address 00000048
> ...

--------------010506030900090306080906
Content-Type: text/plain;
 name="Diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Diff"

--- 1.75/drivers/usb/host/ehci-hcd.c	Wed Apr 14 20:20:58 2004
+++ edited/drivers/usb/host/ehci-hcd.c	Fri Apr 16 11:03:50 2004
@@ -592,7 +592,8 @@
 
 	/* root hub is shut down separately (first, when possible) */
 	spin_lock_irq (&ehci->lock);
-	ehci_work (ehci, NULL);
+	if (ehci->async)
+		ehci_work (ehci, NULL);
 	spin_unlock_irq (&ehci->lock);
 	ehci_mem_cleanup (ehci);
 

--------------010506030900090306080906--

