Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129075AbRBNR6p>; Wed, 14 Feb 2001 12:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129623AbRBNR6f>; Wed, 14 Feb 2001 12:58:35 -0500
Received: from colorfullife.com ([216.156.138.34]:32266 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129075AbRBNR63>;
	Wed, 14 Feb 2001 12:58:29 -0500
Message-ID: <3A8AC6B6.9790FF9C@colorfullife.com>
Date: Wed, 14 Feb 2001 18:56:06 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-ac12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: David Hinds <dhinds@sonic.net>
CC: Andrew Morton <andrewm@uow.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] network driver updates
In-Reply-To: <Pine.LNX.3.96.1010214020707.28011E-100000@mandrakesoft.mandrakesoft.com> <3A8A7159.AF0E6180@colorfullife.com> <3A8A8937.A77BA18D@uow.edu.au> <20010214093859.B20503@sonic.net>
Content-Type: multipart/mixed;
 boundary="------------713F0A6DBC754855474028D0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------713F0A6DBC754855474028D0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

David Hinds wrote:
> 
> Say the driver is linked into the kernel.  Hot plug drivers should not
> all complain about not finding their hardware.
>

That's handled by pci_module_init(), check <linux/pci.h>:
if CONFIG_HOTPLUG is enabled, then pci_module_init() never returns with
-ENODEV.

Which means that eisa cards will never be probed in a hotplug enabled
kernel.

And loading the current 3c59x.c into a non CONFIG_HOTPLUG non EISA
kernel results in a disconnected driver:
it's _not_ registered as a pci driver, pci_module_init() calls
pci_unregister_driver().

What about the attached patch?
--------------713F0A6DBC754855474028D0
Content-Type: text/plain; charset=us-ascii;
 name="patch-hinds"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-hinds"

--- 2.4/drivers/net/3c59x.c	Wed Feb 14 10:50:50 2001
+++ build-2.4/drivers/net/3c59x.c	Wed Feb 14 18:51:55 2001
@@ -2661,13 +2661,16 @@
 	
 	rc = pci_module_init(&vortex_driver);
 	if (rc < 0) {
-		rc = vortex_eisa_init();
-		if (rc > 0)
-			vortex_have_eisa = 1;
+		if (rc != -ENODEV)
+			return rc;
 	} else {
 		vortex_have_pci = 1;
 	}
 
+	if (vortex_eisa_init() > 0) {
+		vortex_have_eisa = 1;
+		rc = 0;
+	}
 	return rc;
 }
 

--------------713F0A6DBC754855474028D0--


