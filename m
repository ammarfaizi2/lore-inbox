Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbWJJEck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWJJEck (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 00:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbWJJEck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 00:32:40 -0400
Received: from ozlabs.org ([203.10.76.45]:37022 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964960AbWJJEck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 00:32:40 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17707.8801.395100.35054@cargo.ozlabs.ibm.com>
Date: Tue, 10 Oct 2006 14:32:33 +1000
From: Paul Mackerras <paulus@samba.org>
To: greg@kroah.com
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Why is device_create_file __must_check?
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing a bunch of warnings about not checking the return value
from device_create_file() for code like this (from
arch/powerpc/kernel/pci_64.c):

static ssize_t pci_show_devspec(struct device *dev,
		struct device_attribute *attr, char *buf)
{
	struct pci_dev *pdev;
	struct device_node *np;

	pdev = to_pci_dev (dev);
	np = pci_device_to_OF_node(pdev);
	if (np == NULL || np->full_name == NULL)
		return 0;
	return sprintf(buf, "%s", np->full_name);
}
static DEVICE_ATTR(devspec, S_IRUGO, pci_show_devspec, NULL);

void pcibios_add_platform_entries(struct pci_dev *pdev)
{
	device_create_file(&pdev->dev, &dev_attr_devspec);
}

What bad thing could happen if device_create_file fails, other than
that the "devspec" file doesn't appear in sysfs?  I don't see how the
error could lead to any null pointer dereference later on or anything
like that.  If some bad thing could happen, how do I avert that?  If
nothing bad will happen, why does device_create_file have __must_check
on it?

Paul.
