Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266748AbUIITsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266748AbUIITsU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 15:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbUIITpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:45:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17368 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266748AbUIITit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:38:49 -0400
Message-ID: <4140B13A.3010104@pobox.com>
Date: Thu, 09 Sep 2004 15:38:34 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, akpm@osdl.org,
       bjorn.helgaas@hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] missing pci_disable_device()
References: <413D0E4E.1000200@jp.fujitsu.com> <1094550581.9150.8.camel@localhost.localdomain> <413E7925.1010801@jp.fujitsu.com> <1094647195.11723.5.camel@localhost.localdomain> <413FF05B.8090505@jp.fujitsu.com> <20040909062009.GD10428@kroah.com> <41403075.1010103@jp.fujitsu.com> <20040909173349.GA14633@kroah.com>
In-Reply-To: <20040909173349.GA14633@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, the kexec folks have a bit of a point (but not IMO a strong one).

Overall to be friendly with firmware and multi-driver situations we 
should try and _restore_ the state of the PCI device prior to 
pci_enable_device(), when pci_disable_device() is called.

Some situations -- namely BIOS/ACPI/SMM and kexec -- really do care 
about the state of the hardware at shutdown time.  Other situations are 
purely Linux problems, like what Jens ran into a month or more ago:
* IDE driver loads, including on legacy addresses
* modprobe ata_piix
* 	pci_enable_device() on a running device
*	notice, according to pci_request_regions, that regions are busy
*	pci_disable_device()
*	IDE suddenly stops working because we disabled IO/MEM


However, with regards to bus-mastering bit specifically, it is 
considered a Real Good Idea on a lot of the hardware I mess with to 
disable busmastering when you shut down the hardware.

	Jeff



