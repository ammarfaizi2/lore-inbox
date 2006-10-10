Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbWJJFFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWJJFFi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 01:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbWJJFFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 01:05:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:9698 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964978AbWJJFFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 01:05:37 -0400
Date: Mon, 9 Oct 2006 22:04:53 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: Why is device_create_file __must_check?
Message-ID: <20061010050453.GA5479@kroah.com>
References: <17707.8801.395100.35054@cargo.ozlabs.ibm.com> <20061009214936.a2788702.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009214936.a2788702.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 09:49:36PM -0700, Andrew Morton wrote:
> On Tue, 10 Oct 2006 14:32:33 +1000
> Paul Mackerras <paulus@samba.org> wrote:
> 
> > I am seeing a bunch of warnings about not checking the return value
> > from device_create_file() for code like this (from
> > arch/powerpc/kernel/pci_64.c):
> > 
> > static ssize_t pci_show_devspec(struct device *dev,
> > 		struct device_attribute *attr, char *buf)
> > {
> > 	struct pci_dev *pdev;
> > 	struct device_node *np;
> > 
> > 	pdev = to_pci_dev (dev);
> > 	np = pci_device_to_OF_node(pdev);
> > 	if (np == NULL || np->full_name == NULL)
> > 		return 0;
> > 	return sprintf(buf, "%s", np->full_name);
> > }
> > static DEVICE_ATTR(devspec, S_IRUGO, pci_show_devspec, NULL);
> > 
> > void pcibios_add_platform_entries(struct pci_dev *pdev)
> > {
> > 	device_create_file(&pdev->dev, &dev_attr_devspec);
> > }
> > 
> > What bad thing could happen if device_create_file fails, other than
> > that the "devspec" file doesn't appear in sysfs?
> 
> There are no super-strong reasons here, but if device_create_file() fails
> then the required control files aren't there and the subsystem isn't
> working as intended.  If it's in a module then we should fail the modprobe. 
> If it's a bootup thing then best we can do is to panic.  Or at least log
> the event.
> 
> The most common cause of this is a programming error: we tried to create
> the same entry twice.   We want to know about that.

Exactly, that's the most common cause here (different programmers trying
to create the same file in the same place.)  That needs to error out so
that it is caught properly.

thanks,

greg k-h
