Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266898AbUGMV6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266898AbUGMV6D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 17:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266904AbUGMV6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 17:58:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36245 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266898AbUGMV4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 17:56:43 -0400
Date: Tue, 13 Jul 2004 14:56:28 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: <Stuart_Hayes@Dell.com>
Cc: <whbeers@mbio.ncsu.edu>, <david-b@pacbell.net>, <olh@suse.de>,
       <Gary_Lerhaupt@Dell.com>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>, zaitcev@redhat.com
Subject: Re: [linux-usb-devel] [PATCH] proper bios handoff in ehci-hcd
Message-Id: <20040713145628.27ae43e7@lembas.zaitcev.lan>
In-Reply-To: <7A8F92187EF7A249BF847F1BF4903C046304CF@ausx2kmpc103.aus.amer.dell.com>
References: <7A8F92187EF7A249BF847F1BF4903C046304CF@ausx2kmpc103.aus.amer.dell.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jul 2004 15:52:43 -0500
<Stuart_Hayes@Dell.com> wrote:

> the "OS wants the controller" bit is getting written to 1 (first part of
> the Linux write, which the system broke into pieces)

If something breaks word writes into pieces, all hell breaks lose.
I don't believe it can happen.

I hit regressions when we implemented the proper handoff as requested
by Stuart @Dell, so I think for the moment the right thing would be this:

--- linux-2.4.21-15.18.EL/drivers/usb/host/ehci-hcd.c	2004-07-01
08:07:56.000000000 -0700
+++ linux-2.4.21-15.18-usb/drivers/usb/host/ehci-hcd.c	2004-07-08
15:15:05.944863675 -0700
@@ -302,7 +302,8 @@
 		if (cap & (1 << 16)) {
 			ehci_err (ehci, "BIOS handoff failed (%d, %04x)\n",
 				where, cap);
-			return 1;
+			pci_write_config_dword (ehci->hcd.pdev, where, 0);
+			return 0;
 		} 
 		ehci_dbg (ehci, "BIOS handoff succeeded\n");
 	}

Essentially, here I insist on doing the right thing with cap|=(1<<24),
which fixes Dell boxes which implement proper handoff, but then if we
time out as on Thinkpads, write zero as the old code did (probably
pointless, but just to be safe) and continue.

David, any comment?

-- Pete
