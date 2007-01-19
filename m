Return-Path: <linux-kernel-owner+w=401wt.eu-S932855AbXASCat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932855AbXASCat (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 21:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932856AbXASCat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 21:30:49 -0500
Received: from mga05.intel.com ([192.55.52.89]:45107 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932855AbXASCas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 21:30:48 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,207,1167638400"; 
   d="scan'208"; a="189808360:sNHT18078991"
Subject: Re: Questions on PCI express AER support in HBA driver
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Allexio Ju <allexio.ju@gmail.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linas@austin.ibm.com,
       yanmin.zhang@intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <a02278b00701181246y51c04491k9d6d0be3c6c693a2@mail.gmail.com>
References: <a02278b00701181146o2384d62ah8445ec3bb846a8da@mail.gmail.com>
	 <a02278b00701181246y51c04491k9d6d0be3c6c693a2@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Fri, 19 Jan 2007 10:30:49 +0800
Message-Id: <1169173849.15989.273.camel@ymzhang>
Mime-Version: 1.0
X-Mailer: Evolution 2.9.2 (2.9.2-2.fc7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-18 at 12:46 -0800, Allexio Ju wrote:
> > What are the expected changes on SCSI LLD driver in regards to PCIE
> > AER supporting? I understood that the driver need to call following
> > APIs during probing to enable AER support for the device,
> > ---
> > if (pci_find_aer_capability(dev)) {
> >    pci_enable_pcie_error_reporting(dev);
> > }
This is just to enable the error reporting of the device. One of the important
parts of AER is error recovery.

When an AER error happens, device will send an error message to root port. Then,
root port will notify kernel by interrupt. Kernel will print out error message,
and do error recovery to recover the related devices. Such recovery need device
drivers to provide a couple of callbacks. Documentation/pci-error-recovery.txt
has the detailed callback definitions and the recovery steps.


> > ---
> > What else does SCSI LLD driver need to changed?
Usually, 3 callbacks are enough while error_detected is must.
        int (*error_detected)(struct pci_dev *dev, enum pci_channel_state);
        int (*slot_reset)(struct pci_dev *dev);
        void (*resume)(struct pci_dev *dev);

You could refer to the patches of e1000 drivers written by Linas, or just read
the source codes of the 3 callbacks of e1000 drivers in the latest kernel.

Yanmin

