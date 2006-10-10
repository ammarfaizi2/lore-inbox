Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbWJJEtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWJJEtl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 00:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbWJJEtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 00:49:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37297 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964944AbWJJEtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 00:49:40 -0400
Date: Mon, 9 Oct 2006 21:49:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Why is device_create_file __must_check?
Message-Id: <20061009214936.a2788702.akpm@osdl.org>
In-Reply-To: <17707.8801.395100.35054@cargo.ozlabs.ibm.com>
References: <17707.8801.395100.35054@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 14:32:33 +1000
Paul Mackerras <paulus@samba.org> wrote:

> I am seeing a bunch of warnings about not checking the return value
> from device_create_file() for code like this (from
> arch/powerpc/kernel/pci_64.c):
> 
> static ssize_t pci_show_devspec(struct device *dev,
> 		struct device_attribute *attr, char *buf)
> {
> 	struct pci_dev *pdev;
> 	struct device_node *np;
> 
> 	pdev = to_pci_dev (dev);
> 	np = pci_device_to_OF_node(pdev);
> 	if (np == NULL || np->full_name == NULL)
> 		return 0;
> 	return sprintf(buf, "%s", np->full_name);
> }
> static DEVICE_ATTR(devspec, S_IRUGO, pci_show_devspec, NULL);
> 
> void pcibios_add_platform_entries(struct pci_dev *pdev)
> {
> 	device_create_file(&pdev->dev, &dev_attr_devspec);
> }
> 
> What bad thing could happen if device_create_file fails, other than
> that the "devspec" file doesn't appear in sysfs?

There are no super-strong reasons here, but if device_create_file() fails
then the required control files aren't there and the subsystem isn't
working as intended.  If it's in a module then we should fail the modprobe. 
If it's a bootup thing then best we can do is to panic.  Or at least log
the event.

The most common cause of this is a programming error: we tried to create
the same entry twice.   We want to know about that.

>  I don't see how the
> error could lead to any null pointer dereference later on or anything
> like that.  If some bad thing could happen, how do I avert that?  If
> nothing bad will happen, why does device_create_file have __must_check
> on it?

Because it can fail.  We need to take _some_ action if the setup failed - at
least report it so the user (and the kernel developers) know that something
is going wrong.

