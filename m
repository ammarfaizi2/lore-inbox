Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVG1W0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVG1W0V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 18:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVG1WYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 18:24:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61064 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261582AbVG1WWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 18:22:03 -0400
Date: Thu, 28 Jul 2005 07:22:25 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Grant Coady <lkml@dodo.com.au>
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Linux 2.4.32-pre2
Message-ID: <20050728102225.GA7661@dmt.cnet>
References: <20050727080512.GD7368@dmt.cnet> <2i7he1lgg2237n66ec5p3e007tdsjos531@4ax.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <2i7he1lgg2237n66ec5p3e007tdsjos531@4ax.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 28, 2005 at 07:02:30PM +1000, Grant Coady wrote:
> On Wed, 27 Jul 2005 05:05:12 -0300, Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> >
> >Here goes another -pre, after a long period.
> 
> Breaks Toshiba laptop: hard lockup --> what is on screen is same as 
> working dmesg up to point: "host/uhci.c: detected 2 port"
> 
> Same .config as for 2.4.31-hf3 or 2.4.32-pre1
> http://scatter.mine.nu/test/linux-2.4/tosh/

Please try to revert the attached? 

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4.32-pre2-usbuhci.diff"


    [PATCH] file_storage and UHCI bugfixes

    The patch below (as547) corrects two minor errors, one in the
    file_storage gadget driver (need to send a length-zero packet if a
    control response is short) and one in the alternate UHCI driver (need
    to set the QH bit in the frame list). Both of these are back-ports of
    things that have been in 2.6 for several releases.

diff --git a/drivers/usb/gadget/file_storage.c b/drivers/usb/gadget/file_storage.c
--- a/drivers/usb/gadget/file_storage.c
+++ b/drivers/usb/gadget/file_storage.c
@@ -1454,6 +1454,7 @@ static int fsg_setup(struct usb_gadget *
 	/* Respond with data/status or defer until later? */
 	if (rc >= 0 && rc != DELAYED_STATUS) {
 		fsg->ep0req->length = rc;
+		fsg->ep0req->zero = (rc < ctrl->wLength);
 		fsg->ep0req_name = (ctrl->bRequestType & USB_DIR_IN ?
 				"ep0-in" : "ep0-out");
 		rc = ep0_queue(fsg);
diff --git a/drivers/usb/host/uhci.c b/drivers/usb/host/uhci.c
--- a/drivers/usb/host/uhci.c
+++ b/drivers/usb/host/uhci.c
@@ -2924,7 +2924,7 @@ static int alloc_uhci(struct pci_dev *de
 		}
 
 		/* Only place we don't use the frame list routines */
-		uhci->fl->frame[i] =  uhci->skeltd[irq]->dma_handle;
+		uhci->fl->frame[i] = uhci->skeltd[irq]->dma_handle | UHCI_PTR_QH;
 	}
 
 	start_hc(uhci);

--UlVJffcvxoiEqYs2--
