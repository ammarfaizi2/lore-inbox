Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVBXGpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVBXGpf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 01:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVBXGpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 01:45:35 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:1582 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261867AbVBXGpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 01:45:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Iz4rdG8HmgVDZaGdJhMKfS/uhfefWSyhoL+63++WnkNqDc7pdbppOXA0AVegAXf7SkjfHtvoZO286CwxGnWoQl5VD8l+F9fLf5ckKjhfwo9IKpoUh9OOF7KKTwzg6nsi13fwB0jzvhwpjLl1ddK/grDgwr+z38oXbMdlbZOMRek=
Message-ID: <9e473391050223224532239c9d@mail.gmail.com>
Date: Thu, 24 Feb 2005 01:45:24 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Adam Belay <abelay@novell.com>
Subject: Re: [RFC] PCI bridge driver rewrite
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       Jesse Barnes <jbarnes@sgi.com>
In-Reply-To: <1109226122.28403.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1109226122.28403.44.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2005 01:22:01 -0500, Adam Belay <abelay@novell.com> wrote:
> For the past couple weeks I have been reorganizing the PCI subsystem to
> better utilize the driver model.  Specifically, the bus detection code
> is now using a standard PCI driver.  It turns out to be a major

What about VGA routing? Most PCI buses do it with the normal VGA bit
but big hardware supports multiple legacy IO spaces via the bridge
chips.

Are you going to make sysfs entries for the bridges? If so I'd like a
VGA attribute that directly reads the VGA bit from the hardware and
display it instead of using the shadow copy.

/* sysfs show for VGA routing bridge */
static ssize_t vga_bridge_show(struct device *dev, char *buf)
{
	struct pci_dev *pdev = to_pci_dev(dev);
	u16 l;

	/* don't trust the shadow PCI_BRIDGE_CTL_VGA in pdev */
	/* user space (X) may change hardware without telling the kernel */
	pci_read_config_word(pdev, PCI_BRIDGE_CONTROL, &l);
	return sprintf(buf, "%d\n", (l & PCI_BRIDGE_CTL_VGA) != 0);
}

I also use these functions to control VGA routing, maybe they should
be part of bridge support.

static void bridge_yes(struct pci_dev *pdev)
{
	struct pci_dev *bridge;
	struct pci_bus *bus;
	
	/* Make sure the bridges route to us */
	bus = pdev->bus;
	while (bus) {
		bridge = bus->self;
		if (bridge) {
			bus->bridge_ctl |= PCI_BRIDGE_CTL_VGA;
			pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bus->bridge_ctl);
		}
		bus = bus->parent;
	}
}

static void bridge_no(struct pci_dev *pdev)
{
	struct pci_dev *bridge;
	struct pci_bus *bus;
	
	/* Make sure the bridges don't route to us */
	bus = pdev->bus;
	while (bus) {
		bridge = bus->self;
		if (bridge) {
			bus->bridge_ctl &= ~PCI_BRIDGE_CTL_VGA;
			pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bus->bridge_ctl);
		}
		bus = bus->parent;
	}
}

Jesse can comment on the specific support needed for multiple legacy IO spaces.

-- 
Jon Smirl
jonsmirl@gmail.com
