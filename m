Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbVJJL6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbVJJL6R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 07:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVJJL6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 07:58:17 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:29104 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1750755AbVJJL6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 07:58:16 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Manu Abraham <manu@linuxtv.org>
Subject: Re: PCI driver
Date: Mon, 10 Oct 2005 14:02:56 +0200
User-Agent: KMail/1.8.2
References: <4327EE94.2040405@kromtek.com> <43287712.3040503@gmail.com> <4328A3C8.6010501@linuxtv.org>
In-Reply-To: <4328A3C8.6010501@linuxtv.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1421155.yCyJ8sDeVN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510101403.02578@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1421155.yCyJ8sDeVN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Donnerstag, 15. September 2005 00:27 schrieben Sie:
>Jiri Slaby wrote:
>> Manu Abraham napsal(a):
>>> Jiri Slaby wrote:
>>>> Manu Abraham napsal(a):
>>>>> Jiri Slaby wrote:
>>>>>> you do NOT do this at all, because you have pdev already (the param
>>>>>> of the probe function)
>>>>>
>>>>> I rewrote the entire thing like this including the pci_remove
>>>>> function too, but now it so seems that in the remove function,
>>>>> pci_get_drvdata(pdev) returns NULL, and hence i get an Oops at
>>>>> module removal.
>>>
>>> I just found that, pci_enable_device() fails. So what's the way to go
>>> ahead ?
>>
>> JESUS.
>
>Hmm.. i finally got it to work. It seems pci_get_device() is necessary,
>i can't seem to enable the device or request for an IRQ the way you
>suggested. It looks some quirks are there though ..
>
>If only i could explain why it works this way and not the other way ..
>
>Thanks for the help,
>Regards,
>Manu
>
>
>
>[   81.269655] mantis_pci_probe: Got a device
>[   81.269825] mantis_pci_probe: We got an IRQ
>[   81.269987] mantis_pci_probe: We finally enabled the device
>[   81.270191] Mantis Rev 1, irq: 23, latency: 32
>[   81.270289] memory: 0xefeff000, mmio: f9218000
>[   81.270519] Trying to free free IRQ23
>[   90.485885] mantis_pci_remove: Removing -->Mantis irq: 23, latency: 32
>[   90.485887] memory: 0xefeff000, mmio: 0xf9218000
>[   90.486293] Trying to free free IRQ23
>[   90.486429] Trying to free nonexistent resource <efeff000-efefffff>
>
>
>
>
>static int __devinit mantis_pci_probe(struct pci_dev *pdev, const struct
>pci_device_id *mantis_pci_table)
>{
>	u8 revision, latency;
>	u8 data[2];
>	struct mantis_pci *mantis;
>	mantis =3D (struct mantis_pci *) kmalloc(sizeof (struct mantis_pci),
>GFP_KERNEL);

Cast is unneeded.

>	if (mantis =3D=3D NULL) {
>		dprintk(verbose, MANTIS_ERROR, 1, "Out of memory");
>		return -ENOMEM;
>	}
>
>	pdev =3D pci_get_device(PCI_VENDOR_ID_MANTIS, PCI_DEVICE_ID_MANTIS_R11,
>NULL);

Hm, this is wrong. pdev contains the struct pci_dev of the found device. If=
=20
you do it your way the first device is always used (and the found one is=20
ignored). When you have two mantis cards in your system it will happily tra=
sh=20
the reference counting. The driver needs to work if you comment out this=20
line.

>	if (pdev) {

This if is not needed either, the probe function is only called if pdev is=
=20
set.

>		dprintk(verbose, MANTIS_ERROR, 1, "Got a device");
>		mantis->mantis_addr =3D pci_resource_start(pdev, 0);
>		if (!request_mem_region(pci_resource_start(pdev, 0),
>			pci_resource_len(pdev, 0), DRIVER_NAME)) {
>			dprintk(verbose, MANTIS_ERROR, 1, "Request for memory region failed");
>			goto err0;
>		}
>		if ((mantis->mantis_mmio =3D ioremap(mantis->mantis_addr, 0x1000)) =3D=3D
>NULL) {
>			dprintk(verbose, MANTIS_ERROR, 1, "IO remap failed");
>			goto err1;
>		}
>		if (request_irq(pdev->irq, (void *) mantis_pci_irq, SA_SHIRQ |
>						SA_INTERRUPT, DRIVER_NAME, (void *) mantis) < 0) {
>			dprintk(verbose, MANTIS_ERROR, 1, "Mantis IRQ registration failed");
>			goto err2;
>		}
>		dprintk(verbose, MANTIS_DEBUG, 1, "We got an IRQ");
>		if (pci_enable_device(pdev)) {
>			dprintk(verbose, MANTIS_ERROR, 1, "Mantis PCI device enable failed");
>			goto err3;
>		}

IIRC the call to pci_enable_device() must be the first thing you do. This w=
ill=20
do the things like assigning memory regions to the device and so on.

>		dprintk(verbose, MANTIS_DEBUG, 1, "We finally enabled the device");
>		pci_set_master(pdev);
>		pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &latency);
>		pci_read_config_byte(pdev, PCI_CLASS_REVISION, &revision);
>		mantis->latency =3D latency;
>		mantis->revision =3D revision;
>		if (!latency) {
>			pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 32);
>		}
>		pci_set_drvdata(pdev, mantis);
>		dprintk(verbose, MANTIS_ERROR, 0, "Mantis Rev %d, ", mantis->revision);
>		dprintk(verbose, MANTIS_ERROR, 0, "irq: %d, latency: %d\nmemory:
>0x%04x, mmio: %p\n", pdev->irq, mantis->latency,
>			mantis->mantis_addr, mantis->mantis_mmio);
>
>		pci_dev_put(pdev);
>
>	} else {
>		dprintk(verbose, MANTIS_ERROR, 1, "No device found");
>		return -ENODEV;
>	}

return 0;

>err3:
>	free_irq(pdev->irq, pdev);
>err2:
>	if (mantis->mantis_mmio)
>		iounmap(mantis->mantis_mmio);
>err1:
>	release_mem_region(pci_resource_start(pdev, 0),
>				pci_resource_len(pdev, 0));
>err0:
>	kfree(mantis);
>
>	return 0;
>}

Returning 0 in error cases is just wrong. And you free the assignments even=
 in=20
case of success AFAICS. Try the return I introduced above and see what=20
happens.

Eike

--nextPart1421155.yCyJ8sDeVN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDSlh2XKSJPmm5/E4RApqeAJ9soxeXFcs7tiWmZ3LOeLYrUQZ2BQCgmVMd
RiaRJNUIdN8dzfphWdzcG/c=
=IABG
-----END PGP SIGNATURE-----

--nextPart1421155.yCyJ8sDeVN--
