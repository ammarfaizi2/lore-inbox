Return-Path: <linux-kernel-owner+w=401wt.eu-S1751998AbWLNXmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbWLNXmu (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 18:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbWLNXmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 18:42:50 -0500
Received: from nz-out-0506.google.com ([64.233.162.234]:37728 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbWLNXms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 18:42:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BOxvYnlmSeywSWzwoRSLTZodZQIghW2p8JNpnJrFfOqOCaQrxJrARhymWIXjhfgVJYFNsr9nIefNxgmSrtRJhaNbGB+I47CRXWrplGexqjU6VjlWMS3tqX6vqAsovhFlWOgcAVYt8lpHRGS+78r7j5WbjH1aHliqteDrn3IofaY=
Message-ID: <b0943d9e0612141542s558d3768h57a7bb9b5440a246@mail.gmail.com>
Date: Thu, 14 Dec 2006 23:42:47 +0000
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Tejun Heo" <htejun@gmail.com>
Subject: Re: [PATCH] ata_piix: use piix_host_stop() in ich_pata_ops
Cc: "Jeff Garzik" <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <b0943d9e0612130241k3363a2c9kd464d33122e6147f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b0943d9e0612091454j6df1fb0ej2fa006c3fa33abae@mail.gmail.com>
	 <20061211132625.GA18947@htj.dyndns.org>
	 <b0943d9e0612130241k3363a2c9kd464d33122e6147f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 11/12/06, Tejun Heo <htejun@gmail.com> wrote:
> > piix_init_one() allocates host private data which should be freed by
> > piix_host_stop().  ich_pata_ops wasn't converted to piix_host_stop()
> > while merging, leaking 4 bytes on driver detach.  Fix it.
>
> I tried your patch last night but the leak is still reported. I need
> to investigate further and put some printk's in the piix_host_stop
> function to check whether the freeing really takes place.

The piix_host_stop() isn't actually called on my machine, so this is
not the cause of the leak.

What causes the leak seem to be the error returned by
ata_pci_init_one() called from piix_init_one(). These are the related
kernel messages:

ata_piix 0000:00:1f.1: version 2.00ac7
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 16 (level, low) -> IRQ 18
PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:1f.1
ata_piix: probe of 0000:00:1f.1 failed with error -16

I think the call to ata_pci_init_one() should be followed by some
clean-up in case it fails. There is also another return without
clean-up in piix_init_one() after the call to piix_disable_ahci(). I
don't have time to try this now.

-- 
Catalin
