Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132535AbRDEAJ6>; Wed, 4 Apr 2001 20:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132536AbRDEAJt>; Wed, 4 Apr 2001 20:09:49 -0400
Received: from ns2.cypress.com ([157.95.67.5]:17321 "EHLO ns2.cypress.com")
	by vger.kernel.org with ESMTP id <S132535AbRDEAJm>;
	Wed, 4 Apr 2001 20:09:42 -0400
Message-ID: <3ACBB763.DC728EA3@cypress.com>
Date: Wed, 04 Apr 2001 19:08:03 -0500
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor Southeast Design Center
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, de-CH, de, zh-TW, zh-CN, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: David Brownell <david-b@pacbell.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Contacts within AMD?  AMD-756 USB host-controller blacklisted dueto
In-Reply-To: <Pine.LNX.4.21.0104050004060.21943-100000@campari.convergence.de> <052c01c0bd5b$0843ab60$6800000a@brownell.org>
Content-Type: multipart/mixed;
 boundary="------------70B81BC49D313155265A84A1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------70B81BC49D313155265A84A1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

David Brownell wrote:
> > please correct me if i'm wrong i only don't want to blacklist complete
> > chipset-series
> 
> Then feel free to develop and submit a better fix.  That'd
> be more practical if AMD's workaround were public.  As I
> understand it, the bulk of the production chips have this
> erratum.  More power to RedHat getting info from AMD.
> Meanwhile, this patch improves robustness.

Comprimise?

This patch make it a config option to enable the AMD-756.
It's marked DANGEROUS and EXPERIMENTAL, and is only
available if CONFIG_EXPERIMENTAL is set.

This makes the default to blacklist the AMD-756
but it can be used if one wants to try.

	-Thomas
--------------70B81BC49D313155265A84A1
Content-Type: text/plain; charset=us-ascii;
 name="AMD-USB.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="AMD-USB.patch"

diff -u --new-file --recursive linux-2.4.3-ac2.orig/drivers/usb/Config.in linux-2.4.3-ac2/drivers/usb/Config.in
--- linux-2.4.3-ac2.orig/drivers/usb/Config.in  Wed Apr  4 15:23:13 2001
+++ linux-2.4.3-ac2/drivers/usb/Config.in       Wed Apr  4 16:13:52 2001
@@ -24,6 +24,9 @@
       dep_tristate '  UHCI Alternate Driver (JE) support' CONFIG_USB_UHCI_ALT $CONFIG_USB
    fi
    dep_tristate '  OHCI (Compaq, iMacs, OPTi, SiS, ALi, ...) support' CONFIG_USB_OHCI $CONFIG_USB
+   if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+      bool '  AMD-756 OHCI support (DANGEROUS)(EXPERIMENTAL)' CONFIG_AMD_OHCI_OK
+   fi

    comment 'USB Device Class drivers'
    dep_tristate '  USB Audio support' CONFIG_USB_AUDIO $CONFIG_USB $CONFIG_SOUND
diff -u --new-file --recursive linux-2.4.3-ac2.orig/drivers/usb/usb-ohci.c linux-2.4.3-ac2/drivers/usb/usb-ohci.c
--- linux-2.4.3-ac2.orig/drivers/usb/usb-ohci.c Wed Apr  4 15:23:15 2001
+++ linux-2.4.3-ac2/drivers/usb/usb-ohci.c      Wed Apr  4 16:18:01 2001
@@ -2332,13 +2332,14 @@
        unsigned long mem_resource, mem_len;
        void *mem_base;

+#ifndef CONFIG_AMD_OHCI_OK
        /* blacklisted hardware? */
        if (id->driver_data) {
                info ("%s (%s): %s", dev->slot_name,
                        dev->name, (char *) id->driver_data);
                return -ENODEV;
        }
-
+#endif
        if (pci_enable_device(dev) < 0)
                return -ENODEV;

@@ -2508,6 +2509,7 @@
         * AMD-756 [Viper] USB has a serious erratum when used with
         * lowspeed devices like mice; oopses have been seen.  The
         * vendor workaround needs an NDA ... for now, blacklist it.
+        * Use CONFIG_AMD_OHCI_OK to try anyway.
         */
        vendor:         0x1022,
        device:         0x740c,


--------------70B81BC49D313155265A84A1--

