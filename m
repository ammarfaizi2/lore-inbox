Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTEXV4t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 17:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbTEXV4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 17:56:49 -0400
Received: from CTS219103106071.cts.ne.jp ([219.103.106.71]:7685 "EHLO
	localhost") by vger.kernel.org with ESMTP id S261180AbTEXV4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 17:56:47 -0400
Date: Sun, 25 May 2003 07:09:26 +0900
From: =?ISO-2022-JP?B?GyRCNUg7MxsoQiAbJEI5OBsoQg==?= 
	<yosshy@debian.or.jp>
To: linux-kernel@vger.kernel.org
Subject: sound driver problem for CyberAlladin
Message-Id: <20030525070926.5a91e161.yosshy@debian.or.jp>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have a problem for using Linux 2.4.2x on my laptop, and it may happen on
some other laptops.

My laptop has PemtiumIII-M 933Hz CPU and CyberAlladin(XP?) chipset
(contains an Ali5451 sound chip). If it ran Linux with AC-powered, system
hangs up on loading trident.o. But, If without AC-powered, system doesn't
hang up. (good)

I think the different is CPU clocks. I guessed that PentiumIII-M ran low
clock rate without AC-powered, so delaying code works fine. But if with
AC-powered, that doesn't works fine and takes hanging-up.

(messages on fine cases:)
Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro PCI Audio, version 0.14.10h, 16:45:46 May 13 2003
ALi Audio Accelerator found at IO 0xe000, IRQ 11
ac97_codec: AC97 Audio codec, id: ADS116(Unknown)
ac97_codec: AC97 Audio codec, id: ADS116(Unknown)

(messages on bad cases:)
Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro PCI Audio, version 0.14.10h, 16:45:46 May 13 2003
ALi Audio Accelerator found at IO 0xe000, IRQ 11
(and system freezes)

I tried to find the problem point with printk(). It seems below:

---
static int ali_reset_5451(struct trident_card *card)
{
        struct pci_dev *pci_dev = NULL;
        unsigned int   dwVal;
        unsigned short wCount, wReg;

        pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, pci_dev);
        if (pci_dev == NULL)
                return -1;
        
        pci_read_config_dword(pci_dev, 0x7c, &dwVal);
        pci_write_config_dword(pci_dev, 0x7c, dwVal | 0x08000000);
/* the last working printk() */
        udelay(5000);
/* non-working printk() */
        pci_read_config_dword(pci_dev, 0x7c, &dwVal);
        pci_write_config_dword(pci_dev, 0x7c, dwVal & 0xf7ffffff);
        udelay(5000);

        pci_dev = card->pci_dev;
        if (pci_dev == NULL)
                return -1;
---

Any advice? Thank you.

	A.Yoshiyama <yosshy@debian.or.jp>
