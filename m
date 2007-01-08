Return-Path: <linux-kernel-owner+w=401wt.eu-S1422716AbXAHTzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422716AbXAHTzn (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 14:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422718AbXAHTzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 14:55:41 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:20048 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422713AbXAHTz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 14:55:26 -0500
To: linux-kernel@vger.kernel.org
Subject: pci_driver resume() callback return value
From: Dmitriy Monakhov <dmonakhov@sw.ru>
Date: Mon, 08 Jan 2007 22:55:40 +0300
Message-ID: <87wt3xcmyr.fsf@sw.ru>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While investigating pci driver model i've found strange thing.
struct pci_driver has resume() callback and it declarated like follows
int  (*resume) (struct pci_dev *dev);/* Device woken up */
Documentation states about it:
from Documentation/pci-error-recovery.txt
STEP 5: Resume Operations
-------------------------
The platform will call the resume() callback on all affected device
drivers if all drivers on the segment have returned
PCI_ERS_RESULT_RECOVERED from one of the 3 previous callbacks.
The goal of this callback is to tell the driver to restart activity,
that everything is back and running.
This callback does not return a result code.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.......
But most of pci devices may return correct error code if error happens
during resume(), for example e1000 implement it as follows:
static int e1000_resume(struct pci_dev *pdev)
{
	struct net_device *netdev = pci_get_drvdata(pdev);
	struct e1000_adapter *adapter = netdev_priv(netdev);
	uint32_t err;
        .....
	if ((err = pci_enable_device(pdev))) {
           printk(KERN_ERR "e1000: Cannot enable PCI device from suspend\n");
           return err;
	}
.....
Even generic pci routines may return nonzero err code and upper(but_type) level
routunes properly handles it:
from drivers/pci/pci-driver.c:321
static int pci_device_resume(struct device * dev)
{
	int error;
	struct pci_dev * pci_dev = to_pci_dev(dev);
	struct pci_driver * drv = pci_dev->driver;

	if (drv && drv->resume)
		error = drv->resume(pci_dev);
	else
		error = pci_default_resume(pci_dev);
	return error;
}

Now question. Should we,or should we not return error code from resume callback?
Where a two possible ways:
a) Comment in document section is out of date and we have to properly handle 
   and return error code if something goes wrong.
b) Comment in document section is correct and and dont have to worry about any 
error, and return code  from resume() callback.
As i understand (a) is correct answer.

