Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbRBIUbL>; Fri, 9 Feb 2001 15:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129259AbRBIUav>; Fri, 9 Feb 2001 15:30:51 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:4356 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S129176AbRBIUao>;
	Fri, 9 Feb 2001 15:30:44 -0500
Date: Fri, 9 Feb 2001 21:30:32 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Dimitromanolakis Apostolos <apdim@ovelix.softnet.tuc.gr>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] drivers/media/radio/radio-maxiradio.c - 2.4.1-ac8
Message-ID: <20010209213032.A1191@se1.cogenit.fr>
In-Reply-To: <20010206224451.A24412@ensta.fr> <Pine.LNX.4.10.10102072245460.17074-300000@kythira.softlab.tuc.gr> <20010209210806.A1001@se1.cogenit.fr> <3A844FFC.D0087A3E@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3A844FFC.D0087A3E@mandrakesoft.com>
X-Organisation: Marie's fan club
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> écrit :
[...]
> Patch looks ok.  Further change:  move pci_enable_device above the
> request_region call.  request_region calls pci_resource_start(), which
> may not return a proper value if called before pci_enable_device.


--- linux-2.4.1-ac8.orig/drivers/media/radio/radio-maxiradio.c	Fri Feb  9 15:01:57 2001
+++ linux-2.4.1-ac8/drivers/media/radio/radio-maxiradio.c	Fri Feb  9 16:25:37 2001
@@ -318,15 +318,15 @@
 
 static int __devinit maxiradio_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
+	if (pci_enable_device(pdev))
+	        goto err_out;
+
 	if(!request_region(pci_resource_start(pdev, 0),
 	                   pci_resource_len(pdev, 0), "Maxi Radio FM 2000")) {
 	        printk(KERN_ERR "radio-maxiradio: can't reserve I/O ports\n");
 	        goto err_out;
 	}
 
-	if (pci_enable_device(pdev))
-	        goto err_out_free_region;
-
 	radio_unit.io = pci_resource_start(pdev, 0);
 	init_MUTEX(&radio_unit.lock);
 	maxiradio_radio.priv = &radio_unit;
@@ -376,9 +376,7 @@
 
 int __init maxiradio_radio_init(void)
 {
-	int count = pci_register_driver(&maxiradio_driver);
-	
-	if(count > 0) return 0; else return -ENODEV;
+	return pci_module_init(&maxiradio_driver);
 }
 
 void __exit maxiradio_radio_exit(void)
-- 
Ueimor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
