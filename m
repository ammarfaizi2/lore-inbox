Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267439AbUHTOXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267439AbUHTOXJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 10:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268105AbUHTOXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 10:23:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9395 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268098AbUHTOVo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 10:21:44 -0400
Date: Fri, 20 Aug 2004 15:21:43 +0100
From: Matthew Wilcox <willy@debian.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@osdl.org>,
       martins@au.ibm.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: VPD in sysfs
Message-ID: <20040820142143.GB14144@parcelfarce.linux.theplanet.co.uk>
References: <20040814182932.GT12936@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040814182932.GT12936@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2004 at 07:29:32PM +0100, Matthew Wilcox wrote:
> Thoughts?  Since there's at least four and probably more ways of getting
> at VPD, we either need to fill in some VPD structs at initialisation or
> have some kind of vpd_ops that a driver can fill in so the core can get
> at the data.

I've tried the first option -- creating a large block of sysfs entries for
all the VPD entries that are present.  However, I've come upon a problem
with sysfs that prevents me from doing so.

Basically, the problem is that sysfs doesn't pass the attribute that's
being invoked to the attribute ->show method.  So I can't determine
which one is being read.  This isn't a problem for any other sysfs attribute
because they're all static, but for dynamically created attributes, it's
not possible to work this way.

What I wanted to have was:

/sys/devices/pci0000:00/0000:00:00.0/vpd/
/sys/devices/pci0000:00/0000:00:00.0/vpd/PN (contents "6181682A")
/sys/devices/pci0000:00/0000:00:00.0/vpd/EC (contents "4950262536")
/sys/devices/pci0000:00/0000:00:00.0/vpd/SN (contents "00000194")
/sys/devices/pci0000:00/0000:00:00.0/vpd/FN (contents "135722")
/sys/devices/pci0000:00/0000:00:00.0/vpd/MN (contents "1037")
...

(note, this example is taken from table 6-8 in PCI 2.1)

So I have code that iterates over each element in a block of raw VPD,
extracts each name and value and creates sysfs entries for them ... but
I can't write the show method.  Here's the VPD file (compiles, haven't
hooked any code up to it yet):


/*
 * drivers/base/vpd.c
 *
 * Expose Vital Product Data through sysfs
 *
 * Copyright (c) Matthew Wilcox 2004
 */

#include <linux/device.h>

/* This should really be in a common file shared with drivers/pnp/isapnp */

enum isapnp_tag {
	ISA_TAG_COMPAT = 0x03,
	ISA_TAG_VEND_S = 0x0e,
	ISA_TAG_END = 0x0f,
	ISA_TAG_IDSTR = 0x82,
	ISA_TAG_VEND_L = 0x84,
	ISA_TAG_VPD = 0x90,
};

static inline int vpd_get_len(char *data, int *idx, enum isapnp_tag *tag)
{
	int i, x, len;

	i = *idx;
	x = data[i++];

	if (x & 0x80) {
		len = data[i] | (data[i + 1] << 8);
		i += 2;
	} else {
		len = x & 7;
		x >>= 3;
	}

	*idx = i;
	*tag = x;
	return len;
}

static int vpd_count_items(char *data)
{
	int i = 0;
	int count = 0;

	for (;;) {
		int j;
		enum isapnp_tag tag;
		int len = vpd_get_len(data, &i, &tag);
		if (tag == ISA_TAG_END)
			break;
		if (tag != ISA_TAG_VPD)
			continue;
		j = i;
		while (j < i + len) {
			count++;
			j += 2;
			j += data[j] + 1;
		}
	}
	return count;
}

static ssize_t vpd_show(struct device *dev, char *buf)
{
	return 0;
}

static struct attribute * vpd_create_attr(unsigned char *data)
{
	struct device_attribute *attr;
	char *buf;
	unsigned int len = data[2];

	attr = kmalloc(sizeof(*attr) + 4 + len, GFP_KERNEL);
	if (!attr)
		return NULL;
	buf = (char *)(attr + 1);

	buf[0] = data[0];
	buf[1] = data[1];
	buf[2] = '\0';
	memcpy(buf, data + 3, len);

	attr->attr.name = buf;
	attr->attr.mode = 0644;
	attr->show = vpd_show;
	attr->store = NULL;

	return &attr->attr;
}

static int vpd_create_attrs(struct attribute **attrs, int count, unsigned char *data)
{
	int i = 0;
	int k = 0;

	for (;;) {
		int j;
		enum isapnp_tag tag;
		int len = vpd_get_len(data, &i, &tag);
		if (tag == ISA_TAG_END)
			break;
		if (tag != ISA_TAG_VPD)
			continue;
		j = i;
		while (j < i + len) {
			attrs[k] = vpd_create_attr(data + j);
			if (!attrs[k])
				return -ENOMEM;
			k++;
			j += 2;
			j += data[j] + 1;
		}
	}

	BUG_ON(k != count);
	attrs[count] = NULL;
	return 0;
}

/**
 * device_add_vpd - Add VPD files to a device
 * @dev: The device that this VPD pertains to
 * @vpd: A memory region containing VPD data
 */
int device_add_vpd(struct device *dev, unsigned char *data)
{
	int err, i;
	int count = vpd_count_items(data);
	if (count < 1)
		return count;

	dev->vpd = kmalloc(sizeof(*dev->vpd) + (count + 1) * sizeof(void *),
			GFP_KERNEL);
	if (!dev->vpd)
		return -ENOMEM;
	memset(dev->vpd, 0, sizeof(*dev->vpd) + (count + 1) * sizeof(void *));

	dev->vpd->name = "vpd";
	dev->vpd->attrs = (struct attribute **)(dev->vpd + 1);

	err = vpd_create_attrs(dev->vpd->attrs, count, data);
	if (err)
		goto fail;

	err = sysfs_create_group(&dev->kobj, dev->vpd);
	if (err)
		goto fail;

	return 0;

 fail:
	for (i = 0; i < count; i++) {
		kfree(dev->vpd->attrs[i]);
	}
	kfree(dev->vpd);
	return err;
}

void device_remove_vpd(struct device *dev)
{
	int i = 0;
	sysfs_remove_group(&dev->kobj, dev->vpd);
	while (dev->vpd->attrs[i] != NULL) {
		kfree(dev->vpd->attrs[i]);
		i++;
	}
	kfree(dev->vpd->attrs);
	kfree(dev->vpd);
	dev->vpd = NULL;
}

EXPORT_SYMBOL(device_add_vpd);
EXPORT_SYMBOL(device_remove_vpd);

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
