Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWCSQgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWCSQgD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 11:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWCSQgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 11:36:01 -0500
Received: from main.gmane.org ([80.91.229.2]:24542 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932141AbWCSQgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 11:36:00 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: [PATCH 001/001] PCI: PCI quirk for Asus A8V and A8V Deluxe motherboards
Date: Sun, 19 Mar 2006 16:35:43 +0000
Message-ID: <yw1xslpez928.fsf@agrajag.inprovide.com>
References: <20060305192709.GA3789@skyscraper.unix9.prv> <dve3j9$r50$1@sea.gmane.org> <20060317143303.GR20746@lug-owl.de> <dvehv7$j9r$1@sea.gmane.org> <20060317144920.GS20746@lug-owl.de> <dveugj$aob$1@sea.gmane.org> <yw1xmzfo98em.fsf@agrajag.inprovide.com> <dvh3rb$ui8$1@sea.gmane.org> <yw1x64mb7rwm.fsf@agrajag.inprovide.com> <dvh7aj$95v$1@sea.gmane.org> <yw1xoe0368yj.fsf@agrajag.inprovide.com> <dvjcb4$as2$1@sea.gmane.org> <yw1xd5gi381h.fsf@agrajag.inprovide.com> <dvjsa6$i92$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82.153.166.94
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (linux)
Cancel-Lock: sha1:tISoYVgrUtUCXT3aGFZDfjOzjLc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andras Mantia <amantia@kde.org> writes:

> Måns Rullgård wrote:
>
>> This is the interesting bit.  Curiously enough, it is exactly the same
>> as mine.  I can't see any reason why it shouldn't match on your board.
>> 
>> Try sticking some printk()s in there and find out what values are
>> actually seen.
>
> I found why it didn't work on my PC before. I wrote that I not only enabled
> for every PCI id, but removed the following check:
>
>       if (likely(!asus_hides_ac97))
>                 return;
>
> This was the bit which made it work. After putting some debugging
> information it turned out that asus_hides_ac97_lpc was called *before*
> asus_hides_ac97_device, so the asus_hides_ac97 remained 0 in that check.
>
> As far as I know this problem appears on all VT8237 boards (I found in
> several forums), I suggest to completely drop the asus_hides_ac97_device
> function and the above if clause.

Hmm, we seem to be using different patches.  Here's what I'm using:

--- drivers/pci/quirks.c.orig   2006-01-03 03:21:10.000000000 +0000
+++ drivers/pci/quirks.c        2006-03-19 16:34:02.021338158 +0000
@@ -1074,6 +1074,33 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,     PCI_DEVICE_ID_SI_963,          quirk_sis_96x_smbus );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,     PCI_DEVICE_ID_SI_LPC,          quirk_sis_96x_smbus );
 
+/*
+ * On ASUS A8V and A8V Deluxe boards, the onboard AC97 audio controller
+ * and MC97 modem controller are disabled when a second PCI soundcard is
+ * present. This patch, tweaking the VT8237 ISA bridge, enables them.
+ * -- bjd
+ */
+static void __init asus_hides_ac97_lpc(struct pci_dev *dev)
+{
+       u8 val;
+
+       if (dev->subsystem_vendor != PCI_VENDOR_ID_ASUSTEK)
+               return;
+       if (dev->device != PCI_DEVICE_ID_VIA_8237)
+               return;
+
+       pci_read_config_byte(dev, 0x50, &val);
+       if (val & 0xc0) {
+               pci_write_config_byte(dev, 0x50, val & (~0xc0));
+               pci_read_config_byte(dev, 0x50, &val);
+               if (val & 0xc0)
+                       printk(KERN_INFO "PCI: Failed to enable onboard AC97/MC97 devices: 0x%x\n", val);
+               else
+                       printk(KERN_INFO "PCI: enabled onboard AC97/MC97 devices\n");
+       }
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,    PCI_DEVICE_ID_VIA_8237, asus_hides_ac97_lpc );
+
 #ifdef CONFIG_X86_IO_APIC
 static void __init quirk_alder_ioapic(struct pci_dev *pdev)
 {


-- 
Måns Rullgård
mru@inprovide.com

