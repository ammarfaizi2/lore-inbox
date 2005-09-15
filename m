Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965146AbVIOGmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbVIOGmv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 02:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbVIOGmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 02:42:51 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:41682 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S932527AbVIOGmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 02:42:50 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Manu Abraham <manu@linuxtv.org>
Subject: Re: PCI driver
Date: Thu, 15 Sep 2005 08:43:27 +0200
User-Agent: KMail/1.8.2
References: <4327EE94.2040405@kromtek.com> <43287712.3040503@gmail.com> <4328A3C8.6010501@linuxtv.org>
In-Reply-To: <4328A3C8.6010501@linuxtv.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2584951.WXeBkvUJnh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509150843.33849@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2584951.WXeBkvUJnh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Manu Abraham wrote:
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

Because pci_enable_device() works like most other kernel (and also libc)=20
functions: it returns 0 if everything went fine.


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

You should introduce a table of PCI devices here that your driver feels=20
responsible for. Then put this into a struct pci_driver which you pass to=20
pci_module_init. Take a look on a random other PCI driver,=20
drivers/net/8139too.c, drivers/scsi/aic7xxx/aic7xxx_osm_pci.c, whatever.

>static int __devinit mantis_pci_probe(struct pci_dev *pdev, const struct
>pci_device_id *mantis_pci_table)
>{
>	u8 revision, latency;
>	u8 data[2];
>	struct mantis_pci *mantis;
>	mantis =3D (struct mantis_pci *) kmalloc(sizeof (struct mantis_pci),
>GFP_KERNEL);
>	if (mantis =3D=3D NULL) {
>		dprintk(verbose, MANTIS_ERROR, 1, "Out of memory");
>		return -ENOMEM;
>	}
>
>	pdev =3D pci_get_device(PCI_VENDOR_ID_MANTIS, PCI_DEVICE_ID_MANTIS_R11,
>NULL);

This is not needed anymore then. Your probe function will get called with f=
or=20
any pci dev your driver can handle.

>	if (pdev) {
>		dprintk(verbose, MANTIS_ERROR, 1, "Got a device");
>		mantis->mantis_addr =3D pci_resource_start(pdev, 0);
>		if (!request_mem_region(pci_resource_start(pdev, 0),
>			pci_resource_len(pdev, 0), DRIVER_NAME)) {
>			dprintk(verbose, MANTIS_ERROR, 1, "Request for memory region failed");

Line length is maximum 80 characters. See Documentation/CodingStyle

>			goto err0;
>		}
>		if ((mantis->mantis_mmio =3D ioremap(mantis->mantis_addr, 0x1000)) =3D=
=3D NULL) {
>			dprintk(verbose, MANTIS_ERROR, 1, "IO remap failed");
>			goto err1;
>		}
>		if (request_irq(pdev->irq, (void *) mantis_pci_irq, SA_SHIRQ |
>						SA_INTERRUPT, DRIVER_NAME, (void *) mantis) < 0) {

You don't need to cast a pointer to void* or vice versa.

>			dprintk(verbose, MANTIS_ERROR, 1, "Mantis IRQ registration failed");
>			goto err2;
>		}
>		dprintk(verbose, MANTIS_DEBUG, 1, "We got an IRQ");
>		if (pci_enable_device(pdev)) {
>			dprintk(verbose, MANTIS_ERROR, 1, "Mantis PCI device enable failed");
>			goto err3;
>		}
>		dprintk(verbose, MANTIS_DEBUG, 1, "We finally enabled the device");
>		pci_set_master(pdev);
>		pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &latency);
>		pci_read_config_byte(pdev, PCI_CLASS_REVISION, &revision);
>		mantis->latency =3D latency;
>		mantis->revision =3D revision;
>		if (!latency) {
>			pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 32);
>		}

The value in mantis->latency and the one in the card's address space now di=
ffer.

>		pci_set_drvdata(pdev, mantis);
>		dprintk(verbose, MANTIS_ERROR, 0, "Mantis Rev %d, ", mantis->revision);
>		dprintk(verbose, MANTIS_ERROR, 0, "irq: %d, latency: %d\nmemory:
>0x%04x, mmio: %p\n", pdev->irq, mantis->latency,
>			mantis->mantis_addr, mantis->mantis_mmio);
>
>		pci_dev_put(pdev);

No, DON'T DO THAT! This will drop the a reference count from the struct=20
pci_dev, which means it can get freed while your driver still wants to work=
=20
with it.

>	} else {
>		dprintk(verbose, MANTIS_ERROR, 1, "No device found");
>		return -ENODEV;
>	}
>
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
>
>
>static void __devexit mantis_pci_remove(struct pci_dev *pdev)
>{
>	struct mantis_pci *mantis =3D pci_get_drvdata(pdev);
>	if (mantis =3D=3D NULL) {
>		dprintk(verbose, MANTIS_ERROR, 1, "Aeio, MAntis NULL ptr");

a) this should really never happen. If it happens, it's a kernel bug.
b) if you catch this error while debugging, you should return here so you do
   not dereference this NULL pointer.

>	}
>	dprintk(verbose, MANTIS_ERROR, 1, "Removing -->Mantis irq: %d, latency:
>%d\nmemory: 0x%04x, mmio: 0x%p", pdev->irq, mantis->latency,
>			mantis->mantis_addr, mantis->mantis_mmio);
>
>	free_irq(pdev->irq, pdev);
>
>	release_mem_region(pci_resource_start(pdev, 0),
>		pci_resource_len(pdev, 0));
>	pci_disable_device(pdev);
>	pci_set_drvdata(pdev, NULL);
>	kfree(mantis);
>}

Eike

--nextPart2584951.WXeBkvUJnh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDKRgVXKSJPmm5/E4RAnb/AJ9pEaJDJKB30OjQI2RBkfJIfBLsBACfaLZl
1UT/f1YmcAkbe3dulnBYNU0=
=9k+m
-----END PGP SIGNATURE-----

--nextPart2584951.WXeBkvUJnh--
