Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbQLFXaf>; Wed, 6 Dec 2000 18:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129765AbQLFXaZ>; Wed, 6 Dec 2000 18:30:25 -0500
Received: from smtp.lax.megapath.net ([216.34.237.2]:4883 "EHLO
	smtp.lax.megapath.net") by vger.kernel.org with ESMTP
	id <S129431AbQLFXaQ>; Wed, 6 Dec 2000 18:30:16 -0500
Message-ID: <3A2EC472.40900@megapathdsl.net>
Date: Wed, 06 Dec 2000 14:57:54 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12 i686; en-US; m18) Gecko/20001202
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jerdfelt@valinux.com, usb@in.tum.de
Subject: Re: test12-pre6
In-Reply-To: <20001206200803.C847@arthur.ubicom.tudelft.nl> <Pine.LNX.4.10.10012061131320.1873-100000@penguin.transmeta.com> <20001206210928.G847@arthur.ubicom.tudelft.nl> <3A2EAA62.1DB6FCCC@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm.  Your patch doesn't test whether pci_enable_device(dev)
was successful, does it?

I think what you want is:

diff -u --new-file drivers/usb/uhci.c~ drivers/usb/uhci.c
--- drivers/usb/uhci.c~	Tue Dec  5 23:55:38 2000
+++ drivers/usb/uhci.c	Wed Dec  6 14:50:00 2000
@@ -2380,8 +2380,10 @@
  	/* disable legacy emulation */
  	pci_write_config_word(dev, USBLEGSUP, 0);

- 
if (pci_enable_device(dev) < 0)
+ 
if (pci_enable_device(dev) < 0) {
+ 
         pci_set_master(dev);
  		return -ENODEV;
+ 
}

  	if (!dev->irq) {
  		err("found UHCI device with no IRQ assigned. check BIOS settings!");
diff -u --new-file drivers/usb/usb-uhci.c~ drivers/usb/usb-uhci.c
--- drivers/usb/usb-uhci.c~	Tue Dec  5 23:55:38 2000
+++ drivers/usb/usb-uhci.c	Wed Dec  6 14:50:09 2000
@@ -2939,8 +2939,10 @@
  {
  	int i;

- 
if (pci_enable_device(dev) < 0)
+ 
if (pci_enable_device(dev) < 0) {
+ 
         pci_set_master(dev);
  		return -ENODEV;
+ 
}
  	
  	/* Search for the IO base address.. */
  	for (i = 0; i < 6; i++) {
diff -u --new-file drivers/usb/usb-ohci.c# drivers/usb/usb-ohci.c
--- drivers/usb/usb-ohci.c#	Wed Dec  6 14:56:12 2000
+++ drivers/usb/usb-ohci.c	Wed Dec  6 14:49:34 2000
@@ -2320,8 +2320,10 @@
  	unsigned long mem_resource, mem_len;
  	void *mem_base;

- 
if (pci_enable_device(dev) < 0)
+ 
if (pci_enable_device(dev) < 0) {
+ 
         pci_set_master(dev);
  		return -ENODEV;
+ 
}
  	
  	/* we read its hardware registers as memory */
  	mem_resource = pci_resource_start(dev, 0);




>>         if (pci_enable_device(dev) < 0)
>>                 return -ENODEV;
>> 
>> +       pci_set_master(dev);
>> +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
