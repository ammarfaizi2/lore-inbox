Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbSKTIXF>; Wed, 20 Nov 2002 03:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265886AbSKTIXF>; Wed, 20 Nov 2002 03:23:05 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:29970 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265667AbSKTIXD>;
	Wed, 20 Nov 2002 03:23:03 -0500
Date: Wed, 20 Nov 2002 00:23:30 -0800
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, perex@suse.cz
Subject: Re: [PATCH] Module alias and table support
Message-ID: <20021120082330.GD22408@kroah.com>
References: <20021114002129.477B72C236@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021114002129.477B72C236@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 12:19:51PM +1100, Rusty Russell wrote:
> Hi guys,
> 
> 	Below is a preliminary patch which implements module aliases
> and reimplements support for MODULE_DEVICE_TABLE on top of it.  Tested
> on drivers/usb/net/pegasus.c, seems to work.  The reason for doing
> this is so that userspace tools are shielded from ever needing to know
> the layout of the xxx_id structures.

Nice, I like that.

> 	The idea that modules can contain a ".modalias" section of
> strings which are aliases for the module.  Every module goes through a
> "finishing" stage (scripts/modfinish) which looks for __module_table*
> symbols and uses scripts/table2alias.c to add aliases such as
> "usb:v0506p4601dl*dh*dc*dsc*dp*ic*isc*ip*" which hotplug can use to
> probe for matching modules.

How are you going to be able to handle hex values in that string?  Or
are you just going to rely on the fact that no valid hex value can be a
identifier?  You might want to add a ':' or something between fields to
make it easier to parse, unless you've already written a bash and C
parser that I can use :)

Hm, there goes my wonderful % decrease in size claims of diethotplug if
we shink the original size of the module_table files...

> +
> +#define USB_DEVICE_ID_MATCH_VENDOR              0x0001
> +#define USB_DEVICE_ID_MATCH_PRODUCT             0x0002
> +#define USB_DEVICE_ID_MATCH_DEV_LO              0x0004
> +#define USB_DEVICE_ID_MATCH_DEV_HI              0x0008
> +#define USB_DEVICE_ID_MATCH_DEV_CLASS           0x0010
> +#define USB_DEVICE_ID_MATCH_DEV_SUBCLASS        0x0020
> +#define USB_DEVICE_ID_MATCH_DEV_PROTOCOL        0x0040
> +#define USB_DEVICE_ID_MATCH_INT_CLASS           0x0080
> +#define USB_DEVICE_ID_MATCH_INT_SUBCLASS        0x0100
> +#define USB_DEVICE_ID_MATCH_INT_PROTOCOL        0x0200
> +
> +struct usb_device_id {

We're already including other kernel header files, why not include usb.h
too?  That way we don't have to remember to update the structures in two
places.

> +        /* which fields to match against? */
> +        uint16_t        match_flags;
> +
> +        /* Used for product specific matches; range is inclusive */
> +        uint16_t        idVendor;
> +        uint16_t        idProduct;
> +        uint16_t        bcdDevice_lo;
> +        uint16_t        bcdDevice_hi;
> +
> +        /* Used for device class matches */
> +        uint8_t         bDeviceClass;
> +        uint8_t         bDeviceSubClass;
> +        uint8_t         bDeviceProtocol;
> +
> +        /* Used for interface class matches */
> +        uint8_t         bInterfaceClass;
> +        uint8_t         bInterfaceSubClass;
> +        uint8_t         bInterfaceProtocol;
> +
> +        /* not matched against */
> +        kernel_long     driver_info;

Or is it because of "kernel_long"?  I'm pretty sure this field is only
used within the kernel, and userspace does not care at all about it.

> +/* Looks like "usb:vNpNdlNdhNdcNdscNdpNicNiscNipN" */
> +static int do_usb_table(void)
> +{
> +        struct usb_device_id id;
> +        int r;
> +        char alias[200];
> +
> +        while ((r = xread(STDIN_FILENO, &id, sizeof(id))) == sizeof(id)) {
> +                TO_NATIVE(id.match_flags);
> +                TO_NATIVE(id.idVendor);
> +                TO_NATIVE(id.idProduct);
> +                TO_NATIVE(id.bcdDevice_lo);
> +                TO_NATIVE(id.bcdDevice_hi);
> +
> +                strcpy(alias, "usb:");
> +                ADD(alias, "v", id.match_flags&USB_DEVICE_ID_MATCH_VENDOR,
> +                    id.idVendor);

Why are you doing this "preprocessing" of the flags and the different
fields?  If you do this, you mess with the logic of the current
/sbin/hotplug tools a lot, as they expect to have to do this.

Granted, it's much nicer to do this only once, at this moment in time,
but it is a change that we need to be aware of.

Also realize that if you do this, you can't generate the existing
modules.*map files from the exported values.


> +struct pci_device_id {
> +        unsigned int vendor, device;   /* Vendor and device ID or PCI_ANY_ID */
> +        unsigned int subvendor, subdevice; /* Subsystem ID's or PCI_ANY_ID */
> +        unsigned int class, class_mask; /* (class,subclass,prog-if) triplet */
> +        kernel_long driver_data;        /* Data private to the driver */
> +};

You should specify a proper size of vendor, device, and other fields of
size "int" like you did above for USB.  Also, driver_data isn't used by
userspace, so don't worry about keeping the size properly.

Or just include <linux/pci.h> and don't worry about it :)

> +/* Looks like: pci:vNdNsvNsdNcN. */
> +static int do_pci_table(void)
> +{
> +        struct pci_device_id id;
> +        int r;
> +        char alias[200];
> +
> +        while ((r = xread(STDIN_FILENO, &id, sizeof(id))) == sizeof(id)) {
> +                TO_NATIVE(id.vendor);
> +                TO_NATIVE(id.device);
> +                TO_NATIVE(id.subvendor);
> +                TO_NATIVE(id.subdevice);
> +                TO_NATIVE(id.class);
> +                TO_NATIVE(id.class_mask);
> +
> +                strcpy(alias, "pci:");
> +                ADD(alias, "v", id.vendor != PCI_ANY_ID, id.vendor);

Again, same "preprocessing" comment as made above for USB.

In summary, I like the idea, and removing userspace knowledge of kernel
structures is very nice.  Just a few tweaks are needed.

thanks,

greg k-h
