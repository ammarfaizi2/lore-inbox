Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266896AbUIRO5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266896AbUIRO5R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 10:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267164AbUIRO5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 10:57:17 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8467 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266896AbUIRO5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 10:57:04 -0400
Date: Sat, 18 Sep 2004 15:56:59 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: bus_type->dev_attrs not properly thought out
Message-ID: <20040918155659.B17085@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I thought I'd look into converting the MMC sysfs code to use the new
bus_type->dev_attrs pointer.  However, it doesn't appear that enough
thought has been put into how this should work.

1. include/linux/device.h, macro for creating device attributes:

#define DEVICE_ATTR(_name,_mode,_show,_store) \
struct device_attribute dev_attr_##_name = __ATTR(_name,_mode,_show,_store)

2. include/linux/device.h, bus_type definition:

struct bus_type {
...
        struct device_attribute * dev_attrs;
...
};

3. device_add_attrs(), the code which adds the attributes to a device:

        if (bus->dev_attrs) {
                for (i = 0; attr_name(bus->dev_attrs[i]); i++) {
                        error = device_create_file(dev,&bus->dev_attrs[i]);
                        if (error)
                                goto Err;
                }
        }

The crux of the problem:
 - As can be seen from (3) and (2), we expect dev_attrs to point to an
   array of at least two struct device_attributes.  This is incompatible
   with (1).

Example of the problem:

 - MMC code can do this:

#define MMC_ATTR(name, fmt, args...)                                    \
static ssize_t mmc_dev_show_##name (struct device *dev, char *buf)      \
{                                                                       \
        struct mmc_card *card = dev_to_mmc_card(dev);                   \
        return sprintf(buf, fmt, args);                                 \
}                                                                       \
static DEVICE_ATTR(name, S_IRUGO, mmc_dev_show_##name, NULL)

MMC_ATTR(cid, "%08x %08x %08x %08x\n",
        card->raw_cid[0], card->raw_cid[1],
        card->raw_cid[2], card->raw_cid[3]);
MMC_ATTR(csd, "%08x %08x %08x %08x\n",
        card->raw_csd[0], card->raw_csd[1],
        card->raw_csd[2], card->raw_csd[3]);
MMC_ATTR(date, "%02d/%04d\n", card->cid.month, card->cid.year);
MMC_ATTR(fwrev, "0x%x\n", card->cid.fwrev);
MMC_ATTR(hwrev, "0x%x\n", card->cid.hwrev);
MMC_ATTR(manfid, "0x%06x\n", card->cid.manfid);
MMC_ATTR(name, "%s\n", card->cid.prod_name);
MMC_ATTR(oemid, "0x%02x\n", card->cid.oemid);
MMC_ATTR(serial, "0x%08x\n", card->cid.serial);

static struct device_attribute *mmc_dev_attributes[] = {
        &dev_attr_cid,
        &dev_attr_csd,
        &dev_attr_date,
        &dev_attr_fwrev,
        &dev_attr_hwrev,
        &dev_attr_manfid,
        &dev_attr_name,
        &dev_attr_oemid,
        &dev_attr_serial,
};

and handle the array of mmc_dev_attributes itself.  However, converting
this to a suitable form to allow it to be poked into bus_type->dev_attrs
makes this:

#define MMC_ATTR(name, fmt, args...)                                    \
static ssize_t mmc_dev_show_##name (struct device *dev, char *buf)      \
{                                                                       \
        struct mmc_card *card = dev_to_mmc_card(dev);                   \
        return sprintf(buf, fmt, args);                                 \
}

MMC_ATTR(cid, "%08x %08x %08x %08x\n",
        card->raw_cid[0], card->raw_cid[1],
        card->raw_cid[2], card->raw_cid[3]);
MMC_ATTR(csd, "%08x %08x %08x %08x\n",
        card->raw_csd[0], card->raw_csd[1],
        card->raw_csd[2], card->raw_csd[3]);
MMC_ATTR(date, "%02d/%04d\n", card->cid.month, card->cid.year);
MMC_ATTR(fwrev, "0x%x\n", card->cid.fwrev);
MMC_ATTR(hwrev, "0x%x\n", card->cid.hwrev);
MMC_ATTR(manfid, "0x%06x\n", card->cid.manfid);
MMC_ATTR(name, "%s\n", card->cid.prod_name);
MMC_ATTR(oemid, "0x%02x\n", card->cid.oemid);
MMC_ATTR(serial, "0x%08x\n", card->cid.serial);

static struct device_attributes mmc_dev_attrs[] = {
	{
		{
			.name = "cid",
			.owner = THIS_MODULE,
			.mode = S_IRUGO,
		},
		.show = mmc_dev_show_cid,
	}, {
		{
			.name = "csd",
			.owner = THIS_MODULE,
			.mode = S_IRUGO,
		},
		.show = mmc_dev_show_csd,
	}, {
		{
			.name = "date",
			.owner = THIS_MODULE,
			.mode = S_IRUGO,
		},
		.show = mmc_dev_show_date,
	}, ... etc ...
};

Hardly elegant, hardly clean, and hardly foolproof from silly C'n'P
errors.

Can we please convert the attribute stuff to something a little saner
so the existing macros can still be used?

I don't think anyone uses this yet, so now would be an opportune
moment to fix this.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
