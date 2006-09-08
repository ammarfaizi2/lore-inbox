Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751839AbWIHGx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbWIHGx2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 02:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbWIHGx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 02:53:28 -0400
Received: from cantor.suse.de ([195.135.220.2]:50653 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752205AbWIHFmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 01:42:47 -0400
Date: Thu, 7 Sep 2006 22:42:17 -0700
From: Greg KH <greg@kroah.com>
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Andrew Morton <akpm@osdl.org>,
       USB Development List <linux-usb-devel@lists.sourceforge.net>,
       Kernel Development List <linux-kernel@vger.kernel.org>,
       Bart Prescott <bart.prescott@elandigitalsystems.com>
Subject: Re: USB: ftdi-elan: client driver for ELAN Uxxx adapters
Message-ID: <20060908054217.GA10302@kroah.com>
References: <200609051619.k85GJqV24114@elandigitalsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609051619.k85GJqV24114@elandigitalsystems.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2006 at 04:12:24PM +0100, Tony Olech wrote:
> + #define FTDI_ERR(format, arg...) printk(KERN_ERR "ftdi.%d " format \
> +         " *ERROR*\n", ftdi->sequence_num, ## arg)
> + #define ELAN_ERR(format, arg...) printk(KERN_ERR "ftdi " format " *ERROR*\n", \
> +         ## arg)
> + #define FTDI_WARN(format, arg...) printk(KERN_WARNING "ftdi.%d " format \
> +         " WARNING\n", ftdi->sequence_num, ## arg)
> + #define ELAN_WARN(format, arg...) printk(KERN_WARNING "ftdi " format \
> +         " WARNING\n", ## arg)
> + #define FTDI_INFO(format, arg...) printk(KERN_INFO "ftdi.%d " format "\n", \
> +         ftdi->sequence_num, ## arg)
> + #define ELAN_INFO(format, arg...) printk(KERN_INFO "ftdi " format "\n", ## arg)

The dev_err, dev_info, and dev_warn() macros are incouraged to be used
instead of rolling your own, but this is no real big deal.


> + #include "usb_u132.h"
> + #define TD_DEVNOTRESP 5
> + /* Define these values to match your devices*/
> + #define USB_FTDI_ELAN_VENDOR_ID 0x0403
> + #define USB_FTDI_ELAN_PRODUCT_ID 0xd6ea
> + /* table of devices that work with this driver*/
> + static struct usb_device_id ftdi_elan_table[] = {
> +         {USB_DEVICE(USB_FTDI_ELAN_VENDOR_ID, USB_FTDI_ELAN_PRODUCT_ID)}, 
> +         { /* Terminating entry */ }
> + };
> + 
> + MODULE_DEVICE_TABLE(usb, ftdi_elan_table);
> + /* Get a minor range for your devices from the usb maintainer*/
> + #define USB_FTDI_ELAN_MINOR_BASE 192

How many minor numbers do you need for this driver?  Do you ever expect
to have more than one of these devices in a system?  8?  16?  256?


> + int ftdi_elan_send(void *data)
> + {
> +         dump_stack();
> +         return 0;

This seems like an odd function to export :)

> + }
> + 
> + 
> + EXPORT_SYMBOL(ftdi_elan_send);

Can this, and the other exports, be marked as EXPORT_SYMBOL_GPL()
instead?

> + void ftdi_elan_gone_away(struct platform_device *pdev)
> + {
> +         struct usb_ftdi *ftdi = platform_device_to_usb_ftdi(pdev);
> +         ftdi->gone_away += 1;
> +         ftdi_elan_put_kref(ftdi);
> + }
> + 
> + 
> + EXPORT_SYMBOL(ftdi_elan_gone_away);
> + void ftdi_release_platform_dev(struct device *dev)
> + {
> +         dev->parent = NULL;
> +         dump_stack();
> + }

This also seems like an odd function...

> + /*
> + * usb class driver info in order to get a minor number from the usb core, 
> + * and to have the device registered with devfs and the driver core
> + */

This comment is a bit out of date, as there is no more devfs anymore.

> + static struct usb_class_driver ftdi_elan_jtag_class = {
> +         .name = "ftdi-%d-jtag", 
> +         .fops = &ftdi_elan_fops, 
> +         .minor_base = USB_FTDI_ELAN_MINOR_BASE, 
> + };
> + 
> + #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

We already have this macro in the kernel.

> + #define cPCIu132rd 0x0
> + #define cPCIu132wr 0x1
> + #define cPCIiord 0x2
> + #define cPCIiowr 0x3
> + #define cPCImemrd 0x6
> + #define cPCImemwr 0x7
> + #define cPCIcfgrd 0xA
> + #define cPCIcfgwr 0xB
> + #define cPCInull 0xF
> + #define cU132cmd_status 0x0
> + #define cU132flash 0x1
> + #define cPIDsetup 0x0
> + #define cPIDout 0x1
> + #define cPIDin 0x2
> + #define cPIDinonce 0x3
> + #define cCCnoerror 0x0
> + #define cCCcrc 0x1
> + #define cCCbitstuff 0x2
> + #define cCCtoggle 0x3
> + #define cCCstall 0x4
> + #define cCCnoresp 0x5
> + #define cCCbadpid1 0x6
> + #define cCCbadpid2 0x7
> + #define cCCdataoverrun 0x8
> + #define cCCdataunderrun 0x9
> + #define cCCbuffoverrun 0xC
> + #define cCCbuffunderrun 0xD
> + #define cCCnotaccessed 0xF

What do these defines refer to?  Something in a spec somewhere?

in all, it's a lot of code, so I'll trust that it's working correctly :)

thanks,

greg k-h
