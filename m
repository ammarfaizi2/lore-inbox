Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129380AbQKNAWh>; Mon, 13 Nov 2000 19:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129566AbQKNAW1>; Mon, 13 Nov 2000 19:22:27 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:23827 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129380AbQKNAWY>;
	Mon, 13 Nov 2000 19:22:24 -0500
Message-ID: <3A107EB7.542B997B@mandrakesoft.com>
Date: Mon, 13 Nov 2000 18:52:23 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Wyckoff <pw@osc.edu>
CC: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: ns558 pci/isa change
In-Reply-To: <20001113181530.A7954@quasar.osc.edu>
Content-Type: multipart/mixed;
 boundary="------------B35DDBB5D02433C2FD6C7407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B35DDBB5D02433C2FD6C7407
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Pete Wyckoff wrote:
>         i = pci_module_init(&ns558_pci_driver);
>         if (i == 0)
>                 have_pci_devices = 1;
> 
>  /*
>   * Probe for ISA ports.
>   */
> 
> +       i = 0;

you don't want to lose the error code.  what you want to do is something
like the attached patch...

-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
--------------B35DDBB5D02433C2FD6C7407
Content-Type: text/plain; charset=us-ascii;
 name="ns558.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ns558.patch"

Index: drivers/char/joystick/ns558.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/char/joystick/ns558.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 ns558.c
--- drivers/char/joystick/ns558.c	2000/10/22 23:21:03	1.1.1.3
+++ drivers/char/joystick/ns558.c	2000/11/13 23:51:49
@@ -58,7 +58,6 @@
 };
 	
 static struct ns558 *ns558;
-static int have_pci_devices;
 
 /*
  * ns558_isa_probe() tries to find an isa gameport at the
@@ -316,9 +315,8 @@
  * it is the least-invasive probe.
  */
 
-	i = pci_module_init(&ns558_pci_driver);
-	if (i == 0)
-		have_pci_devices = 1;
+	i = pci_register_driver(&ns558_pci_driver);
+	if (i < 0) return i;
 
 /*
  * Probe for ISA ports.
@@ -339,7 +337,7 @@
 	}
 #endif
 
-	return ns558 ? 0 : -ENODEV;
+	return 0;
 }
 
 void __exit ns558_exit(void)
@@ -368,8 +366,7 @@
 		port = port->next;
 	}
 
-	if (have_pci_devices)
-		pci_unregister_driver(&ns558_pci_driver);
+	pci_unregister_driver(&ns558_pci_driver);
 }
 
 module_init(ns558_init);

--------------B35DDBB5D02433C2FD6C7407--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
