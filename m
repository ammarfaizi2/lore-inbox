Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272372AbTHNOfL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 10:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272385AbTHNOfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 10:35:11 -0400
Received: from oker.escape.de ([194.120.234.254]:58807 "EHLO oker.escape.de")
	by vger.kernel.org with ESMTP id S272372AbTHNOfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 10:35:06 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.22-rc, IDE: cannot unload piix module
From: Urs Thuermann <urs@isnogud.escape.de>
Date: 14 Aug 2003 16:33:04 +0200
Message-ID: <m2k79gxqan.fsf@isnogud.escape.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After loading the module piix.o for some Intel IDE chips, the usage
count is 1 even if the module isn't used, so the module cannot be
unloaded.

I think this is because of the following code in
linux/drivers/ide/pci/piix.c:

    /**
     *	piix_init_one	-	called when a PIIX is found
     *	@dev: the piix device
     *	@id: the matching pci id
     *
     *	Called when the PCI registration layer (or the IDE initialization)
     *	finds a device matching our IDE device tables.
     */
     
    static int __devinit piix_init_one(struct pci_dev *dev, const struct pci_device_id *id)
    {
            ide_pci_device_t *d = &piix_pci_info[id->driver_data];
    
            if (dev->device != d->device)
                    BUG();
            d->init_setup(dev, d);
            MOD_INC_USE_COUNT;
            return 0;
    }
    

But there is no MOD_DEC_USE_COUNT anywhere.  Is that intended?


urs
