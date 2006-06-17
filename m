Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWFQS3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWFQS3X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 14:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWFQS3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 14:29:23 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:17514 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750806AbWFQS3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 14:29:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Iez1kag03dr/mhtFtuPQixLhORBnX+CTU8ZeLbCk0pFeLQCF8wm4V9n6D2H3N/tMAd8ZHUu6sONv9kkJj6+a7q4uSBfDjwmfFe1ZT0baDr15MK4adL5xXV1Rfsgo3TjMg8GBXeYvJJXL1JXVldjFPtnUw5P07Lky/MlFHyJuctM=
Message-ID: <449449FF.9000402@gmail.com>
Date: Sat, 17 Jun 2006 12:29:19 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch -mm 07/20] chardev: GPIO for SCx200 & PC-8736x: refactor scx200_probe
 to better segregate _gpio initialization
References: <448DB57F.2050006@gmail.com> <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
In-Reply-To: <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

7/20. patch.init-refactor

Pull shadow-reg initialization into separate function now, rather than
doing it 2x later (scx200, pc8736x).  When we revisit 2nd drvr below,
it will be to reimplement an init function, rather than another
refactor.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

---

diffstat gpio-scx/patch.init-refactor
 scx200.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff -ruNp -X dontdiff -X exclude-diffs ax-6/arch/i386/kernel/scx200.c ax-7/arch/i386/kernel/scx200.c
--- ax-6/arch/i386/kernel/scx200.c	2006-06-17 01:13:26.000000000 -0600
+++ ax-7/arch/i386/kernel/scx200.c	2006-06-17 01:17:11.000000000 -0600
@@ -47,9 +47,17 @@ static struct pci_driver scx200_pci_driv
 
 static DEFINE_SPINLOCK(scx200_gpio_config_lock);
 
-static int __devinit scx200_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+static void __devinit scx200_init_shadow(void)
 {
 	int bank;
+
+	/* read the current values driven on the GPIO signals */
+	for (bank = 0; bank < 2; ++bank)
+		scx200_gpio_shadow[bank] = inl(scx200_gpio_base + 0x10 * bank);
+}
+
+static int __devinit scx200_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
 	unsigned base;
 
 	if (pdev->device == PCI_DEVICE_ID_NS_SCx200_BRIDGE ||
@@ -63,10 +71,7 @@ static int __devinit scx200_probe(struct
 		}
 
 		scx200_gpio_base = base;
-
-		/* read the current values driven on the GPIO signals */
-		for (bank = 0; bank < 2; ++bank)
-			scx200_gpio_shadow[bank] = inl(scx200_gpio_base + 0x10 * bank);
+		scx200_init_shadow();
 
 	} else {
 		/* find the base of the Configuration Block */


