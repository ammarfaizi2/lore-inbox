Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261840AbSKCMZ3>; Sun, 3 Nov 2002 07:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261842AbSKCMZ3>; Sun, 3 Nov 2002 07:25:29 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:26499 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261840AbSKCMZZ>; Sun, 3 Nov 2002 07:25:25 -0500
Date: Sun, 3 Nov 2002 04:31:50 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: greg@kroah.com, jung-ik.lee@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch: 2.5.45 PCI Fixups for PCI HotPlug
Message-ID: <20021103043150.A1201@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greg KH wrote:
>Hm, in looking at this, I know the majority of people who want
>CONFIG_HOTPLUG probably do not run with CONFIG_PCI_HOTPLUG as the
>hardware's still quite rare.  To force those people to keep around all
>of the PCI quirks functions and tables after init happens, is a bit
>cruel.  I wonder if it's time to start having different subsystems
>modify __devinit depending on their config variables.

	Are there PCI bridge cards that use all of those?  For
example, I thought that Triton was a series of Intel motherboard
chipsets for 586 processors.  Perhaps you only need to keep a
few of those routines.

	Jung-Ik: perhaps you could to an lspci and an "lspci -n" on
your machine when the bridge card is plugged in, which should provide
enough information to determine which routines you really need to
keep.

>Does this sound like a good idea?  If so, I can probably knock up
>something for the PCI code pretty easily (yes, I'll keep in mind CardBus
>stuff, not all hotplug pci is on servers...)
>
>__pci_devinit anyone?  :)

	I posted a patch to define __usbinit and cousins to the
linux-kernel mailing list about two and a half years ago.  The change
has been sitting in my <linux/init.h> since then.  I just did a string
replacement to make the matching pci calls.  Here an an untested patch
that shows both.

	I believe that, theoretically, all __dev{init,exit}{,func}
should only be __dev<bus>{init,exit}{,func}.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diffs

--- linux-2.5.45/include/linux/init.h	2002-10-30 16:41:39.000000000 -0800
+++ linux/include/linux/init.h	2002-11-03 03:59:35.000000000 -0800
@@ -196,4 +196,33 @@
 #define __devexit_p(x) NULL
 #endif
 
+#ifdef CONFIG_PCI_HOTPLUG
+#define __pcidevinit
+#define __pcidevinitdata
+#define __pcidevexit
+#define __pcidevexitdata
+#else
+#define __pcidevinit		__init
+#define __pcidevinitdata	__initdata
+#define __pcidevexit		__exit
+#define __pcidevexitdata	__exitdata
+#endif
+
+/* Warning: without CONFIG_USB_HOTPLUG, you will also not support
+   hot plugging of USB *controllers*, even though they are usually PCI
+   devices, because they will generate USB hotplug events for their
+   attached devices when they (the controllers) are inserted or removed.
+*/
+#ifdef CONFIG_USB_HOTPLUG
+#define __usbdevinit
+#define __usbdevinitdata
+#define __usbdevexit
+#define __usbdevexitdata
+#else
+#define __usbdevinit		__init
+#define __usbdevinitdata	__initdata
+#define __usbdevexit		__exit
+#define __usbdevexitdata	__exitdata
+#endif
+
 #endif /* _LINUX_INIT_H */

--Nq2Wo0NMKNjxTN9z--
