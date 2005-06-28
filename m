Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVF1LBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVF1LBk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 07:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVF1LBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 07:01:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52949 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261244AbVF1LBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 07:01:19 -0400
Date: Tue, 28 Jun 2005 04:00:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: "d binderman" <dcb314@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re:
Message-Id: <20050628040045.7a829f77.akpm@osdl.org>
In-Reply-To: <BAY19-F38CD6342E8B675570A6E179CE10@phx.gbl>
References: <BAY19-F38CD6342E8B675570A6E179CE10@phx.gbl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"d binderman" <dcb314@hotmail.com> wrote:
>
> I just tried to compile the Linux Kernel version 2.6.11.12
>  with the most excellent Intel C compiler. It said
> 
>  drivers/usb/host/ohci-hub.c(424): warning #175: subscript out of range
>          desc->bitmap [2] = desc->bitmap [3] = 0xff;
>                             ^
> 
>  This is clearly broken code, since there are only up to 16 ports.
> 
>  Suggest avoid trying to initialise bitmap[ 3].

This is queued in -mm:


From: "KAMBAROV, ZAUR" <kambarov@berkeley.edu>

The length of the array desc->bitmap is 3, and not 4:

Definitions involved:

In drivers/usb/core/hcd.h

464  	#define bitmap 	DeviceRemovable

In drivers/usb/host/ohci-hub.c

395  		struct usb_hub_descriptor	*desc

In drivers/usb/core/hub.h

130  	struct usb_hub_descriptor {
131  		__u8  bDescLength;
132  		__u8  bDescriptorType;
133  		__u8  bNbrPorts;
134  		__u16 wHubCharacteristics;
135  		__u8  bPwrOn2PwrGood;
136  		__u8  bHubContrCurrent;
137  		    	/* add 1 bit for hub status change; round to bytes */
138  		__u8  DeviceRemovable[(USB_MAXCHILDREN + 1 + 7) / 8];
139  		__u8  PortPwrCtrlMask[(USB_MAXCHILDREN + 1 + 7) / 8];
140  	} __attribute__ ((packed));

In include/linux/usb.h

306  	#define USB_MAXCHILDREN		(16)

This defect was found automatically by Coverity Prevent, a static analysis
tool.

(akpm: this code should be shot.  Field `bitmap' doesn't exist in struct
usb_hub_descriptor.  And this .c file is #included in
drivers/usb/host/ohci-hcd.c, and someone somewhere #defines `bitmap' to
`DeviceRemovable'.

>From a maintainability POV it would be better to memset the whole array
beforehand - I changed the patch to do that)

Signed-off-by: Zaur Kambarov <zkambarov@coverity.com>
Cc: <linux-usb-devel@lists.sourceforge.net?
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/usb/host/ohci-hub.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/usb/host/ohci-hub.c~coverity-desc-bitmap-overrun-fix drivers/usb/host/ohci-hub.c
--- 25/drivers/usb/host/ohci-hub.c~coverity-desc-bitmap-overrun-fix	2005-06-24 22:11:00.000000000 -0700
+++ 25-akpm/drivers/usb/host/ohci-hub.c	2005-06-24 22:19:48.000000000 -0700
@@ -419,10 +419,11 @@ ohci_hub_descriptor (
 
 	/* two bitmaps:  ports removable, and usb 1.0 legacy PortPwrCtrlMask */
 	rh = roothub_b (ohci);
+	memset(desc->bitmap, 0xff, sizeof(desc->bitmap));
 	desc->bitmap [0] = rh & RH_B_DR;
 	if (ports > 7) {
 		desc->bitmap [1] = (rh & RH_B_DR) >> 8;
-		desc->bitmap [2] = desc->bitmap [3] = 0xff;
+		desc->bitmap [2] = 0xff;
 	} else
 		desc->bitmap [1] = 0xff;
 }
_

