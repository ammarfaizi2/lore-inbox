Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbVKAVtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbVKAVtn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 16:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVKAVtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 16:49:43 -0500
Received: from hqemgate03.nvidia.com ([216.228.112.143]:33286 "EHLO
	HQEMGATE03.nvidia.com") by vger.kernel.org with ESMTP
	id S1751273AbVKAVtm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 16:49:42 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: MSI/MSIX issues and bugs
Date: Tue, 1 Nov 2005 13:49:42 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B00BA5D810@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: MSI/MSIX issues and bugs
Thread-Index: AcXfLip65ClEGZKtRvuGf8irLgUqew==
From: "Ayaz Abdulla" <AAbdulla@nvidia.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Nov 2005 21:49:42.0492 (UTC) FILETIME=[2A8731C0:01C5DF2E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am working on MSI/MSIX support described in PCI 3.0 specification and
found some bugs in the linux kernel code.

1) If a device does not expose PCI Express capability, the MSI code
should still disable INTx for the device since you are switching to a
different interrupt model - in functions enable_msi_mode() and
disable_msi_mode().

2) If a device supports MSI mask mode (PCI_MSI_FLAGS_MASKBIT), the
expression to set the flag is wrong:

    ie. entry->msi_attrib.maskbit = is_mask_bit_support(control);

    This will return 0x100 but maskbit field is only 1 bit. It should be
the following:

    entry->msi_attrib.maskbit = (is_mask_bit_support(control) ? 1 : 0);

3) Same bug when using is_64bit_address() macro followed by
msi_mask_bits_reg() macro:

    #define msi_mask_bits_reg(base, is64bit) \
     ( (is64bit == 1) ? base+PCI_MSI_MASK_BIT : base+PCI_MSI_MASK_BIT-4)

    is_64bit_address() will return 0x80, which is passed as is64bit
parameter. It should be the following:

    #define msi_mask_bits_reg(base, is64bit) \
     ( (is64bit != 0) ? base+PCI_MSI_MASK_BIT : base+PCI_MSI_MASK_BIT-4)

4) If a device supports both MSI and MSIX, you can not switch between
them on subsequent driver loads. In either case, when the
pci_disable_msi(x) functions are called, the vector is not free'd. If
you reload the driver in the other mode it will complain that you are
already in the previous mode. This might have been intended design not
to free the vector or msi_desc entry, but it should be allowed to switch
between the different modes without a reboot.

5) The PCI_MSIX_XXX defines in msi.h should be within
include/linux/pci.h alongside the other PCI config space defines.


Regards,
Ayaz
