Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbVIOJsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbVIOJsO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 05:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVIOJsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 05:48:14 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:7898 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S932385AbVIOJsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 05:48:14 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Manu Abraham <manu@linuxtv.org>
Subject: Re: PCI driver
Date: Thu, 15 Sep 2005 11:48:51 +0200
User-Agent: KMail/1.8.2
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org
References: <4327EE94.2040405@kromtek.com> <200509151018.20322@bilbo.math.uni-mannheim.de> <4329362A.1030201@linuxtv.org>
In-Reply-To: <4329362A.1030201@linuxtv.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2584976.HShbx0PSjj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509151148.57779@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2584976.HShbx0PSjj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Manu Abraham wrote:
>Rolf Eike Beer wrote:
>>That is true, but you should not call pci_get_device() in this function at
>>all.
>
>I reworked the whole thing over  .. but i am feeling that something's a
>bit wrong somewhere ..
>
>The log i get on a load - unload ..
>
>[  102.261264] mantis_pci_probe: Got a device
>[  102.262852] mantis_pci_probe: We got an IRQ
>[  102.264392] mantis_pci_probe: We finally enabled the device
>[  102.266020] Mantis Rev 1, irq: 23, latency: 32
>[  102.266118]          memory: 0xefeff000, mmio: f9218000
>[  102.269162] Trying to free free IRQ23
>[  110.297341] mantis_pci_remove: Removing -->Mantis irq: 23,
>latency: 32
>[  110.297344]  memory: 0xefeff000, mmio: 0xf9218000
>[  110.301326] Trying to free free IRQ23
>[  110.303445] Trying to free nonexistent resource <efeff000-efefffff>
>
>
>#include <asm/io.h>
>#include <asm/pgtable.h>
>#include <asm/page.h>
>#include <linux/interrupt.h>
>#include <linux/kmod.h>
>#include <linux/vmalloc.h>
>#include <linux/init.h>
>#include <linux/sched.h>
>#include <linux/device.h>
>#include "mantis_common.h"
>#include "mantis_dma.h"
>#include "mantis_i2c.h"
>#include "mantis_eeprom.h"
>
>#define DRIVER_NAME                "Mantis"
>
>static struct pci_device_id mantis_pci_table[] =3D {
>    { PCI_DEVICE(PCI_VENDOR_ID_MANTIS, PCI_DEVICE_ID_MANTIS_R11) },
>    { 0 },
>};
>
>MODULE_DEVICE_TABLE(pci, mantis_pci_table);
>
>static irqreturn_t mantis_pci_irq(int irq, void *dev_id, struct pt_regs
>*regs)
>{
>    struct mantis_pci *mantis;
>
>    dprintk(verbose, MANTIS_DEBUG, 1, "Mantis PCI IRQ");
>    mantis =3D (struct mantis_pci *) dev_id;
>    if (mantis =3D=3D NULL)
>        dprintk(verbose, MANTIS_DEBUG, 1, "Aeio, mantis ISR");
>
>    /*    Events
>     *    (1) PCMCIA insert
>     *    (2) PCMCIA extract
>     *    (3) I2C complete
>     */
>
>    return IRQ_HANDLED;
>}

You must check here if this interrupt was really from your device. If not, =
you=20
must return IRQ_NONE. You have requested your interrupt as a shared one so=
=20
this may happen at any time.

>static int mantis_i2c_setup(struct mantis_pci *mantis)
>{
>    u32 config =3D 0;

You don't need to set this here, you will overwrite it anyway before lookin=
g=20
at it.

>//    mmwrite(0x80, MANTIS_DMA_CTL); // MCU i2c read
>    config =3D mmread(MANTIS_DMA_CTL);
>    dprintk(verbose, MANTIS_DEBUG, 1, "Mantis Ctl reg=3D0x%04x", config);
>
>    return 0;
>}

>static int __devinit mantis_pci_probe(struct pci_dev *pdev,
>                const struct pci_device_id *mantis_pci_table)
>{
>    u8 revision, latency;
>//    u8 data[2];
>    struct mantis_pci *mantis;

Please insert a blank line here, this improves readability.

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

I would prefer to use more descriptive names for the labels, like err_memre=
g,=20
err_iomem, err_irq or something like that.

Also you will get wrong assignements here. You must call pci_enable_device(=
)=20
_first_, it will set up the BARs of that device. Also I think=20
pci_request_regions() might be a better way to get this assignements.

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
>    if (pci_enable_device(pdev)) {
>        dprintk(verbose, MANTIS_ERROR, 1, "Mantis PCI enable failed");
>        goto err3;
>    }
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
>err3:
>    free_irq(pdev->irq, pdev);
>err2:
>    if (mantis->mantis_mmio)
>        iounmap(mantis->mantis_mmio);
>err1:
>    release_mem_region(pci_resource_start(pdev, 0),
>                pci_resource_len(pdev, 0));
>err0:
>    kfree(mantis);
>
>    return 0;
>}
>
>static void __devexit mantis_pci_remove(struct pci_dev *pdev)
>{
>    struct mantis_pci *mantis =3D pci_get_drvdata(pdev);
>    if (mantis =3D=3D NULL) {
>        dprintk(verbose, MANTIS_ERROR, 1, "Aeio, MAntis NULL ptr");
>        return;
>    }
>    dprintk(verbose, MANTIS_ERROR, 1, "Removing -->Mantis irq: %d, \
>        latency: %d\n memory: 0x%04x, mmio: 0x%p",
>        pdev->irq, mantis->latency, mantis->mantis_addr,
>        mantis->mantis_mmio);
>
>    free_irq(pdev->irq, pdev);
>
>    release_mem_region(pci_resource_start(pdev, 0),
>        pci_resource_len(pdev, 0));

pci_release_regions(pdev);

>    pci_set_drvdata(pdev, NULL);
>    pci_disable_device(pdev);
>    kfree(mantis);
>}

HTH

Eike

--nextPart2584976.HShbx0PSjj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDKUOJXKSJPmm5/E4RAsqHAJwMH2IyrbD6i72OOtEqrs2f5a3n9QCeJpKl
y5M5AL31JAqjTGxvcnYB8y0=
=cfNT
-----END PGP SIGNATURE-----

--nextPart2584976.HShbx0PSjj--
