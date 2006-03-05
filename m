Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWCETeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWCETeh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 14:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWCETeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 14:34:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46796 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750702AbWCETeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 14:34:36 -0500
Date: Sun, 5 Mar 2006 14:34:22 -0500
From: Dave Jones <davej@redhat.com>
To: bjd <bjdouma@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 001/001] PCI: PCI quirk for Asus A8V and A8V Deluxe motherboards
Message-ID: <20060305193422.GA18593@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, bjd <bjdouma@xs4all.nl>,
	linux-kernel@vger.kernel.org
References: <20060305192709.GA3789@skyscraper.unix9.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060305192709.GA3789@skyscraper.unix9.prv>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2006 at 08:27:09PM +0100, bjd wrote:

 > +static void __init asus_hides_ac97_lpc(struct pci_dev *dev)
 > +{
 > +	u8 val;
 > +	int asus_hides_ac97 = 0;
 > +
 > +	if (likely(dev->subsystem_vendor == PCI_VENDOR_ID_ASUSTEK)) {
 > +		if (dev->device == PCI_DEVICE_ID_VIA_8237)
 > +			asus_hides_ac97 = 1;
 > +	}
 > +
 > +	if (!asus_hides_ac97)
 > +		return;

Why likely ?  It's just as unlikely to be an ASUS.
Also, why not just ..

	if (dev->subsystem_vendor != PCI_VENDOR_ID_ASUSTEK)
		return;
	if (dev->device != PCI_DEVICE_ID_VIA_8237)
		return;

and lose the asus_hides_ac97 var completely?

Is this true of every ASUS board that has an 8237 ?
Does it actually remove the enable/disable ac97 feature from the BIOS,
or just reset it to disabled ?

 > +	pci_read_config_byte(dev, 0x50, &val);
 > +	if (val & 0xc0) {
 > +		pci_write_config_byte(dev, 0x50, val & (~0xc0));
 > +		pci_read_config_byte(dev, 0x50, &val);
 > +		if (val & 0xc0)
 > +			printk(KERN_INFO "PCI: onboard AC97/MC97 devices continue to
 > play 'hide and seek'! 0x%x\n", val);

How often does this trigger ?
The message could be a little more end-user friendly too
"Failed to enable onboard AC97/MC97 devices"

		Dave

-- 
http://www.codemonkey.org.uk
