Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbUL1Oi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbUL1Oi0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 09:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUL1Oi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 09:38:26 -0500
Received: from invernomuto.emilianotomei.it ([212.239.40.246]:63137 "EHLO
	gwydion.nuisoft.it") by vger.kernel.org with ESMTP id S261768AbUL1OiS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 09:38:18 -0500
Message-ID: <41D17016.5040105@nuisoft.it>
Date: Tue, 28 Dec 2004 15:39:18 +0100
From: Marco Matarazzo <mmatarazzo@nuisoft.it>
Organization: NuiSoft
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Recognition for ECS K7VTA3 integrated VIA 8233A in via82xx.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a fast little patch to add automatic recognition of some (older?) model of
VIA8233A integrated audio that have to be configured with dxs_support = 4 (NO_VRA).

With dxs_support set to 1 (ENABLE) or 3 (48K, default without that) the audio works but
it's REALLY REALLY REALLY poor.

I see that ECS K7VTA3 support is already there, but mine shows a different vendor/device
codes. I tried to find out what revision my board is, and i THINK it's a 6.0a, I'm not
sure (it's not clear on both manual and board itself, at least to me). I tried that patch
with a friend's board (same version, we bought them togheter) and it works. I hope to
hear from someone else that have the same version I have.

diff -ur linux-2.6.10/sound/pci/via82xx.c linux-2.6.10-storm/sound/pci/via82xx.c
--- linux-2.6.10/sound/pci/via82xx.c	2004-12-24 22:35:24.000000000 +0100
+++ linux-2.6.10-storm/sound/pci/via82xx.c	2004-12-27 17:26:07.368716640 +0100
@@ -2094,6 +2094,7 @@
		{ .vendor = 0x1005, .device = 0x4710, .action = VIA_DXS_ENABLE }, /* Avance Logic Mobo */
		{ .vendor = 0x1019, .device = 0x0996, .action = VIA_DXS_48K },
		{ .vendor = 0x1019, .device = 0x0a81, .action = VIA_DXS_NO_VRA }, /* ECS K7VTA3 v8.0 */
+		{ .vendor = 0x1019, .device = 0x1841, .action = VIA_DXS_NO_VRA }, /* ECS K7VTA3 (maybe v6.0a) */
		{ .vendor = 0x1019, .device = 0x0a85, .action = VIA_DXS_NO_VRA }, /* ECS L7VMM2 */
		{ .vendor = 0x1025, .device = 0x0033, .action = VIA_DXS_NO_VRA }, /* Acer Inspire 1353LM */
		{ .vendor = 0x1043, .device = 0x8095, .action = VIA_DXS_NO_VRA }, /* ASUS A7V8X (FIXME: possibly VIA_DXS_ENABLE?)*/


I also applied the following patch to identify vendor/device codes.

BTW, i would like to have some explainations here. I can accept an answer
like "Go Learn By Yourself" :-)

I wrote this patch using an approach that needs not so much knowledge of
hardware, I just looked in the code and understood more or less how it works.
I guess the two codes that come out from :

         pci_read_config_word(pci, PCI_SUBSYSTEM_VENDOR_ID, &subsystem_vendor);
         pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &subsystem_device);

*should* be the vendor id and the device id, as usual. BUT these are not, as
shown in /proc/pci:

[...]
   Bus  0, device  17, function  5:
     Class 0401: PCI device 1106:3059 (rev 80).
       IRQ 5.
       I/O at 0xe400 [0xe4ff].
[...]

and in fact the following patch (that i used to find the two values) shown
something else.

I know that probably I am wrong, and probably these pairs are simply
different things. Can someone can enlighten me or point me somewhere to read anything?

Noobish thanks =)

diff -ur linux-2.6.10/sound/pci/via82xx.c linux-2.6.10-storm/sound/pci/via82xx.c
--- linux-2.6.10/sound/pci/via82xx.c	2004-12-24 22:35:24.000000000 +0100
+++ linux-2.6.10-storm/sound/pci/via82xx.c	2004-12-27 17:26:07.368716640 +0100
@@ -2146,6 +2147,7 @@
	printk(KERN_INFO "via82xx: Assuming DXS channels with 48k fixed sample rate.\n");
	printk(KERN_INFO "         Please try dxs_support=1 or dxs_support=4 option\n");
	printk(KERN_INFO "         and report if it works on your machine.\n");
+	printk(KERN_INFO "         (vendor = 0x%x , device = 0x%x).\n", subsystem_vendor, subsystem_device);
	return VIA_DXS_48K;
};


BTW2: the [PATCH] tag have to/should/could be used when submitting patches like that?

