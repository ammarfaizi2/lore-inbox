Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbVIOMIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVIOMIG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 08:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVIOMIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 08:08:06 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:21974 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751124AbVIOMIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 08:08:05 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Manu Abraham <manu@linuxtv.org>
Subject: Re: PCI driver
Date: Thu, 15 Sep 2005 14:08:44 +0200
User-Agent: KMail/1.8.2
Cc: Ralph Metzler <rjkm@metzlerbros.de>, Jiri Slaby <jirislaby@gmail.com>,
       linux-kernel@vger.kernel.org
References: <4327EE94.2040405@kromtek.com> <17193.19739.213773.593444@localhost.localdomain> <43295E41.8010808@linuxtv.org>
In-Reply-To: <43295E41.8010808@linuxtv.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5808799.ILMZFFOFpk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509151408.50539@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5808799.ILMZFFOFpk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Donnerstag, 15. September 2005 13:42 schrieb Manu Abraham:
>Ralph Metzler wrote:
>>Hi Manu,
>>
>>Manu Abraham writes:
>> > [  102.261264] mantis_pci_probe: Got a device
>> > [  102.262852] mantis_pci_probe: We got an IRQ
>> > [  102.264392] mantis_pci_probe: We finally enabled the device
>> > [  102.266020] Mantis Rev 1, irq: 23, latency: 32
>> > [  102.266118]          memory: 0xefeff000, mmio: f9218000
>> > [  102.269162] Trying to free free IRQ23
>> > [  110.297341] mantis_pci_remove: Removing -->Mantis irq: 23,
>> > latency: 32
>> > [  110.297344]  memory: 0xefeff000, mmio: 0xf9218000
>> > [  110.301326] Trying to free free IRQ23
>> > [  110.303445] Trying to free nonexistent resource <efeff000-efefffff>
>>
>>I think you should call pci_enable_device() before request_irq, etc.
>>AFAIK, the pci_enable_device() can change resources like IRQ.
>>
>>
>>That's probably what causes these errors. Just print out the irq
>>number before and after pci_enable_device() to check if that's the
>>problem.
>
>Hmm.. not much of a change i can say ..

>[  631.211320] mantis_pci_probe: <1:>IRQ=3D23
>[  631.211495] mantis_pci_probe: <2:>IRQ=3D23
>[  631.211664] mantis_pci_probe: Got a device
>[  631.211850] mantis_pci_probe: We got an IRQ
>[  631.212013] mantis_pci_probe: We finally enabled the device
>[  631.212236] Mantis Rev 1, irq: 23, latency: 32
>[  631.212322]          memory: 0xefeff000, mmio: f9218000
>[  639.259136] mantis_pci_remove: Removing -->Mantis irq: 23,
>latency: 32
>[  639.259138]  memory: 0xefeff000, mmio: 0xf9218000
>[  639.259504] Trying to free free IRQ23
>[  639.259673] Trying to free nonexistent resource <efeff000-efefffff>

Oh yes, of course. Now I see what's wrong. See changes below.

>static int __devinit mantis_pci_probe(struct pci_dev *pdev,
>                const struct pci_device_id *mantis_pci_table)
>{
>    u8 revision, latency;
>//    u8 data[2];
>    struct mantis_pci *mantis;
>
>    dprintk(verbose, MANTIS_ERROR, 1, "<1:>IRQ=3D%d", pdev->irq);
>    if (pci_enable_device(pdev)) {
>        dprintk(verbose, MANTIS_ERROR, 1, "Mantis PCI enable failed");
>        goto err;
>    }
>    dprintk(verbose, MANTIS_ERROR, 1, "<2:>IRQ=3D%d", pdev->irq);
>
>    mantis =3D (struct mantis_pci *)
>                kmalloc(sizeof (struct mantis_pci), GFP_KERNEL);
>    if (mantis =3D=3D NULL) {
>        dprintk(verbose, MANTIS_ERROR, 1, "Out of memory");
>        return -ENOMEM;
>    }
>    dprintk(verbose, MANTIS_ERROR, 1, "Got a device");
>    mantis->mantis_addr =3D pci_resource_start(pdev, 0);
>    if (!request_mem_region(pci_resource_start(pdev, 0),
>        pci_resource_len(pdev, 0), DRIVER_NAME)) {
>        dprintk(verbose, MANTIS_ERROR, 1, "Request mem region failed");
>        goto err0;
>    }
>    if ((mantis->mantis_mmio =3D
>                ioremap(mantis->mantis_addr, 0x1000)) =3D=3D NULL) {
>        dprintk(verbose, MANTIS_ERROR, 1, "IO remap failed");
>        goto err1;
>    }
>    if (request_irq(pdev->irq, mantis_pci_irq, SA_SHIRQ |
>                SA_INTERRUPT, DRIVER_NAME, mantis) < 0) {
>        dprintk(verbose, MANTIS_ERROR, 1, "Mantis IRQ reg failed");
>        goto err2;
>    }
>    dprintk(verbose, MANTIS_DEBUG, 1, "We got an IRQ");
>    dprintk(verbose, MANTIS_DEBUG, 1, "We finally enabled the device");
>    pci_set_master(pdev);
>    pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &latency);
>    pci_read_config_byte(pdev, PCI_CLASS_REVISION, &revision);
>    mantis->latency =3D latency;
>    mantis->revision =3D revision;
>    if (!latency) {
>        pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 32);
>    }
>    pci_set_drvdata(pdev, mantis);
>    dprintk(verbose, MANTIS_ERROR, 0, "Mantis Rev %d, ", mantis->revision);
>    dprintk(verbose, MANTIS_ERROR, 0, "irq: %d, latency: %d\n \
>        memory: 0x%04x, mmio: %p\n", pdev->irq, mantis->latency,    \
>        mantis->mantis_addr, mantis->mantis_mmio);

return 0;

>err2:
>    if (mantis->mantis_mmio)
>        iounmap(mantis->mantis_mmio);
>err1:
>    release_mem_region(pci_resource_start(pdev, 0),
>                pci_resource_len(pdev, 0));
>err0:
>    kfree(mantis);
>err:

return -ENODEV.
>    return 0;
>}

You release the regions directly after you've claimed them. Freeing them ag=
ain=20
in release function is impossible because you don't own them any longer.

Eike

--nextPart5808799.ILMZFFOFpk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDKWRSXKSJPmm5/E4RAoXrAJoDw7M3xRb9ZriRYdwCzSpDjmKvjwCfWEM8
31j6xJXndJC/vVBgXtX1Cvc=
=dpah
-----END PGP SIGNATURE-----

--nextPart5808799.ILMZFFOFpk--
