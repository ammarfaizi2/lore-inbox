Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbTLQLlp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 06:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbTLQLlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 06:41:45 -0500
Received: from ns2.uk.superh.com ([193.128.105.170]:25846 "EHLO
	smtp.uk.superh.com") by vger.kernel.org with ESMTP id S264376AbTLQLlm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 06:41:42 -0500
Date: Wed, 17 Dec 2003 11:41:25 +0000
From: Richard Curnow <Richard.Curnow@superh.com>
To: David Brownell <dbrownell@users.sourceforge.net>, Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Handling of bounce buffers by rh_call_control
Message-ID: <20031217114125.GA20057@malvern.uk.w2k.superh.com>
Mail-Followup-To: David Brownell <dbrownell@users.sourceforge.net>,
	Greg KH <greg@kroah.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-OS: Linux 2.4.22 i686
User-Agent: Mutt/1.5.4i
X-OriginalArrivalTime: 17 Dec 2003 11:42:40.0603 (UTC) FILETIME=[E06D3AB0:01C3C492]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch

===== drivers/usb/hcd.c 1.10 vs edited =====
--- 1.10/drivers/usb/hcd.c      Mon Mar 31 14:22:42 2003
+++ edited/drivers/usb/hcd.c    Wed Dec 17 11:26:53 2003
@@ -323,7 +323,7 @@
        struct usb_ctrlrequest *cmd = (struct usb_ctrlrequest *) urb->setup_packet;
        u16             typeReq, wValue, wIndex, wLength;
        const u8        *bufp = 0;
-       u8              *ubuf = urb->transfer_buffer;
+       u8              *ubuf = (u8 *) urb->transfer_dma;
        int             len = 0;
 
        typeReq  = (cmd->bRequestType << 8) | cmd->bRequest;

seems to be needed to make the following code later in the function work

	if (bufp) {
		if (urb->transfer_buffer_length < len)
			len = urb->transfer_buffer_length;
		urb->actual_length = len;
		// always USB_DIR_IN, toward host
		memcpy (ubuf, bufp, len);
	}

in the case where bounce buffers are being used to implement PCI DMA
operations.  Without the patch, the subsequent pci_unmap_single copies
the contents of the bounce buffer over the top of urb->transfer_buffer,
destroying what the memcpy() put there.

My USB knowledge is pretty limited, so I've no idea whether this patch
adversely affects anything else in rh_call_control.

The patch is against 2.4.23-pre-something, but I see the code's the same
in 2.6.

-- 
Richard \\\ SH-4/SH-5 Core & Debug Architect
Curnow  \\\         SuperH (UK) Ltd, Bristol
