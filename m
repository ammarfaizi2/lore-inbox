Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWGDHcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWGDHcb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 03:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWGDHcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 03:32:31 -0400
Received: from igw1.zrnko.cz ([81.31.45.160]:35542 "EHLO anubis.fi.muni.cz")
	by vger.kernel.org with ESMTP id S1751107AbWGDHca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 03:32:30 -0400
Date: Tue, 4 Jul 2006 09:32:47 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux kernel 2.6.17-git14 and PCI suspend/resume
Message-ID: <20060704073247.GA2790@mail.muni.cz>
References: <20060703231121.GB2752@mail.muni.cz> <20060703232109.GA18605@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060703232109.GA18605@suse.de>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 04:21:09PM -0700, Greg KH wrote:
> When suspending, pci_save_state() would have saved off those values (all
> 1s) which is what it is restoring.  That function gets called if there
> is no driver specific suspend function to call.  On suspend, is there
> any driver loaded for the device?

No driver is loaded.

> And what type of PCI device is this?

It does for these devices:
01:01.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev b3)
01:01.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 08)
01:01.2 Class 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (rev
17)
01:01.3 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host Adapter
(rev 08)
01:01.4 System peripheral: Ricoh Co Ltd xD-Picture Card Controller (rev 03)


> Any chance you can test -mm and see if that helps with suspend/resume?
> Linus's new suspend framework is in there, and that's the way forward
> for these kinds of issues.

I found out, that pci_save_state() reads 0xffffffff value using
pci_read_config_dword for these devices. Actually, I modified pci_save_state
like this:
int
pci_save_state(struct pci_dev *dev)
{
        int i;
        /* XXX: 100% dword access ok here? */
        printk(KERN_ERR "PM: Saving config space on device %s.\n",
                        pci_name(dev));
        mdelay(500);
        for (i = 0; i < 16; i++) {
                pci_read_config_dword(dev, i * 4,&dev->saved_config_space[i]);
                if(strcmp(pci_name(dev), "0000:01:01.4") == 0)
                        printk(KERN_ERR "PM: Saved value: %x.\n", dev->saved_config_space[i]);
        }
        if ((i = pci_save_msi_state(dev)) != 0)
                return i;
        if ((i = pci_save_msix_state(dev)) != 0)
                return i;
        return 0;
}

With this result in log:
kernel: PM: Saving config space on device 0000:01:01.4.
kernel: PM: Saved value: ffffffff.
last message repeated 15 times

So, looks like not enabled/mapped device returns 1s. 
(For none of mentioned devices is loaded driver, so they are all disabled).

So for now, I disabled to restore state of value 0xffffffff and things go OK.

-- 
Luká¹ Hejtmánek
