Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318246AbSHDTj6>; Sun, 4 Aug 2002 15:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318248AbSHDTj5>; Sun, 4 Aug 2002 15:39:57 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:45049 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318246AbSHDTjU>; Sun, 4 Aug 2002 15:39:20 -0400
Subject: Re: Linux 2.4.19-ac2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniela Engert <dani@ngrt.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200208041939.VAA15993@myway.myway.de>
References: <200208041939.VAA15993@myway.myway.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Aug 2002 22:01:16 +0100
Message-Id: <1028494876.15495.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-04 at 20:39, Daniela Engert wrote:
> On 04 Aug 2002 21:27:19 +0100, Alan Cox wrote:
> 
> > 	if((r9 & 0x0A) != 0x0A)		/* Legacy only */
> > 	/* Request programmability */
> > 	pci_write_config_byte(dev, PCI_CLASS_PROG, r9|0x05);
> 
> There is no guarantee that this will succeed. Quite some PCI IDE
> controller chips (f.e. ALi, SiS) may have config register 9 r/o locked
> by some other means.

If its locked read only then that is fine. The read back will see the
old value not 0x05 bits set. In which case it'll leave it alone 

	pci_write_config_byte(dev, PCI_CLASS_PROG, r9|0x05);
        pci_read_config_byte(dev, PCI_CLASS_PROG, &r9);

	if((r9 & 0x05) == 0x05)		/* Reprogrammable */
		return 1;

	/* Refused */
	return 0;

I'm just trying to get this right so we can do a sensible quick fix for
2.4.19. Its relatively easy to add pci_assign_device(dev) functionality
and make the IDE drivers do the right thing when they kick the devices
out of legacy mode. Thats the longer term right answer.

