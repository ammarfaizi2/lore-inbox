Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267219AbSLKQtG>; Wed, 11 Dec 2002 11:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267220AbSLKQtG>; Wed, 11 Dec 2002 11:49:06 -0500
Received: from halon.barra.com ([144.203.11.1]:55194 "EHLO halon.barra.com")
	by vger.kernel.org with ESMTP id <S267219AbSLKQtC>;
	Wed, 11 Dec 2002 11:49:02 -0500
From: Fedor Karpelevitch <fedor@apache.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.4]ALi M5451 sound hangs on init; workaround
Date: Wed, 11 Dec 2002 08:52:42 -0800
User-Agent: KMail/1.5
Cc: lkml <linux-kernel@vger.kernel.org>, Vicente Aguilar <bisente@bisente.com>,
       alsa-devel@lists.sourceforge.net,
       Debian-Laptops <debian-laptop@lists.debian.org>
References: <200212110715.20617.fedor@apache.org> <1039625298.18087.61.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1039625298.18087.61.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200212110852.42778.fedor@apache.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have ALi M5451 souncard in my laptop (Compaq Presario 900z for
> > those searching) and it hangs the machine with any kernel I tried
> > (currently 2.4.20-ac1 + hirofumi patch). I traced it down to the
> > line where it hangs - that is drivers/sound/trident.c:3379 which
> > says: pci_write_config_byte(pci_dev, 0xB8, ~temp);
>
> Looking at the docs it looks like the code Matt Wu added may have
> been meant to do
>
> 	pci_read_config_byte(pci_dev, 0x59, temp)
> 	temp &= ~0x80
> 	pci_write...
>

just to make sure I got it right, is the following what you suggest? 
(pseudo-patch):

--------
static int ali_close_multi_channels(void)
{
        char temp = 0;
        struct pci_dev *pci_dev = NULL;

	pci_dev =pci_find_device(PCI_VENDOR_ID_AL,PCI_DEVICE_ID_AL_M1533,
		pci_dev);
        if (pci_dev == NULL)
                return -1;
-       temp = 0x80;
+	pci_read_config_byte(pci_dev, 0x59, temp);
+      temp &= ~0x80;
-       pci_write_config_byte(pci_dev, 0x59, ~temp);
+	pci_write_config_byte(pci_dev, 0x59, temp);

        pci_dev = pci_find_device(PCI_VENDOR_ID_AL,
		PCI_DEVICE_ID_AL_M7101, pci_dev);
        if (pci_dev == NULL)
                return -1;

-       temp = 0x20;
+	pci_read_config_byte(pci_dev, 0xB8, temp);
+	temp &= ~0x20
-       pci_write_config_byte(pci_dev, 0xB8, ~temp);  // the line I 
+	pci_write_config_byte(pci_dev, 0xB8, temp);  //commented out

        return 0;
}
---------------------
I'll try it and will tell you what the result is. Anyway, what are 
those commands doing, i.e. what am I loosing when I comment it out? 
Is there some specific functionality I should test to see the result 
of these changes?

> and similarly for the other port
>
> (Ditto with fixing setup_multi_cannnels)
>
> Does it work sanely with those fixd ?
