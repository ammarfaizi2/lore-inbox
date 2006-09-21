Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWIUOyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWIUOyd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 10:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWIUOyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 10:54:33 -0400
Received: from slimak.dkm.cz ([62.24.64.34]:21458 "HELO slimak.dkm.cz")
	by vger.kernel.org with SMTP id S1751099AbWIUOyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 10:54:32 -0400
Date: Thu, 21 Sep 2006 16:54:24 +0200
From: iSteve <isteve@rulez.cz>
To: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: modules.isapnpmap vs modules.alias (now: modules.usbmap vs
 alias)
Message-ID: <20060921165424.139138e5@silver>
In-Reply-To: <20060920102248.ebb55960.rdunlap@xenotime.net>
References: <20060920185301.21dcf9bc@silver>
	<20060920102248.ebb55960.rdunlap@xenotime.net>
X-Mailer: Sylpheed-Claws 2.4.0cvs175 (GTK+ 2.10.1; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006 10:22:48 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> It's defined in the MS ISA PNP spec from
> http://www.microsoft.com/whdc/resources/respec/specs/pnpisa.mspx
> 
> I just went thru the bit fiddling exercise, so holler if you
> want/need help with it.  (I'd rather just teach you how to fish
> instead of giving you fish.)

Mhm, thanks, I've got it... (also, I've found the fish itself;)

I've got one more question, this time regarding modules.usbmap.

-modules.usbmap:
ibmcam 0x000f 0x0545 0x8080 0x0002 0x0002 0x00 0x00 0x00 0x00 0x00 0x00 0x0
ibmcam 0x000f 0x0545 0x8080 0x030a 0x030a 0x00 0x00 0x00 0x00 0x00 0x00 0x0
ibmcam 0x000f 0x0545 0x8080 0x0301 0x0301 0x00 0x00 0x00 0x00 0x00 0x00 0x0
ibmcam 0x000f 0x0545 0x8002 0x030a 0x030a 0x00 0x00 0x00 0x00 0x00 0x00 0x0
ibmcam 0x000f 0x0545 0x800c 0x030a 0x030a 0x00 0x00 0x00 0x00 0x00 0x00 0x0
ibmcam 0x000f 0x0545 0x800d 0x030a 0x030a 0x00 0x00 0x00 0x00 0x00 0x00 0x0
-EOF

-With corresponding aliases:
alias usb:v0545p8080d0002dc*dsc*dp*ic*isc*ip* ibmcam
alias usb:v0545p8080d030[10-9]dc*dsc*dp*ic*isc*ip* ibmcam
alias usb:v0545p8080d0301dc*dsc*dp*ic*isc*ip* ibmcam
alias usb:v0545p8002d030[10-9]dc*dsc*dp*ic*isc*ip* ibmcam
alias usb:v0545p800Cd030[10-9]dc*dsc*dp*ic*isc*ip* ibmcam
alias usb:v0545p800Dd030[10-9]dc*dsc*dp*ic*isc*ip* ibmcam
-EOF

I absolutely do not understand the d030[10-9], where fields bcdDevice_lo and
bcdDevice_hi are 0x030a...

Looking at drivers/usb/core/usb.c, it'd seem that the MODALIAS sent upon device
event doesn't have anything like this -- it would have "[...]d030A[...]". So I
wonder, how it got generated?

-The relevant items in ibmcam.c:
static struct usb_device_id id_table[] = {
        { USB_DEVICE_VER(IBMCAM_VENDOR_ID, IBMCAM_PRODUCT_ID, 0x0002, 0x0002) },
        { USB_DEVICE_VER(IBMCAM_VENDOR_ID, IBMCAM_PRODUCT_ID, 0x030a, 0x030a) },
        { USB_DEVICE_VER(IBMCAM_VENDOR_ID, IBMCAM_PRODUCT_ID, 0x0301, 0x0301) },
        { USB_DEVICE_VER(IBMCAM_VENDOR_ID, NETCAM_PRODUCT_ID, 0x030a, 0x030a) },
        { USB_DEVICE_VER(IBMCAM_VENDOR_ID, VEO_800C_PRODUCT_ID, 0x030a, 0x030a) },
        { USB_DEVICE_VER(IBMCAM_VENDOR_ID, VEO_800D_PRODUCT_ID, 0x030a, 0x030a) },
        { }
};
-EOF

-And the resulting alias part of modinfo:
alias: usb:v0545p8080d0002dc*dsc*dp*ic*isc*ip*
alias: usb:v0545p8080d030[10-9]dc*dsc*dp*ic*isc*ip*
alias: usb:v0545p8080d0301dc*dsc*dp*ic*isc*ip*
alias: usb:v0545p8002d030[10-9]dc*dsc*dp*ic*isc*ip*
alias: usb:v0545p800Cd030[10-9]dc*dsc*dp*ic*isc*ip*
alias: usb:v0545p800Dd030[10-9]dc*dsc*dp*ic*isc*ip*
-EOF

Thanks in advance for any pointers
-- 
 -- iSteve
