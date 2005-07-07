Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVGGVta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVGGVta (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 17:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVGGVry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:47:54 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:34607 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261283AbVGGVpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:45:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VidGkCBIBPdy1ETfDgY2jIMgaFNeK1glTGxNBEuUub9JPy2M2OSJoopg1XcyRnQcxXPB2kXks/3jhH9U3HXW+LiljRRoCOZmKdNS6O8w4+QHaJcdztVBSH9fROCSMKQFpm4Bsw1BGW8F+dupDtsBh/r1XpK0KOvzOOjUQBIJDn4=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Victor <andrew@sanpeople.com>
Subject: Re: [RFC] Atmel-supplied hardware headers for AT91RM9200 SoC processor
Date: Fri, 8 Jul 2005 01:52:03 +0400
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
References: <1120730318.16806.75.camel@fuzzie.sanpeople.com>
In-Reply-To: <1120730318.16806.75.camel@fuzzie.sanpeople.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507080152.03976.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 July 2005 13:58, Andrew Victor wrote:
> If the AT91RM9200+Linux community had to convert all the headers, bugs
> may be introduced in the conversion process and we would have to assume
> any maintenance responsibility.  What we have now may be slightly ugly,
> but it is atleast known to be correct.
> I've appended two of their headers as an example - the System
> peripherals (timer, interrupt controller, etc) and Ethernet.

> Comments?

Care to get rid of cool *_UART_MAP macros?

For those who didn't bother to download the patch, the snippet is:

	#define FOO_UART_MAP                { 4, 1, -1, -1, -1 }
		...
	int serial[AT91C_NR_UART] = FOO_UART_MAP;
			[yes, each one is used in exactly one place]

Obviously, AT91C_NR_UART should be AT91C_NR_UARTS, because it is "the number
of UART_s_". And "serial" can be renamed to uart_map or something.

You also constantly cast ioremap() return values to unsigned long and cast
them back to "void __iomem *" back on iounmap()

> +static struct resource *_s1dfb_resource[] = {
> +       /* order *IS* significant */
> +       {       /* video mem */

Then rewrite it as

	static struct ... = {
		[0] = {
			.name = ...
			...
		},
		[1] = {
			.name = ...
			...
		},
	}

And check for non-NULL data in at91_add_device_usbh() is useless:
	at91_add_device_usbh(&carmeva_usbh_data);
	at91_add_device_usbh(&csb337_usbh_data);
	at91_add_device_usbh(&csb637_usbh_data);
	at91_add_device_usbh(&dk_usbh_data);
	at91_add_device_usbh(&ek_usbh_data);

Same for add_device_eth(), _udc(), _cf(). In at91_add_device_mmc() you got it
right.

> +static struct file_operations spidev_fops = {
> +       owner:          THIS_MODULE,

Use C99 initializers. Everywhere.

> +static int __init at91_spidev_init(void)
> +{
> +#ifdef CONFIG_DEVFS_FS

It will be removed soon.

at91_wdt_ioctl() isn't __user annotated. Let alone it is ioctl.

> +#define BYTE_SWAP4(x) \
> +  (((x & 0xFF000000) >> 24) | \
> +   ((x & 0x00FF0000) >> 8) | \
> +   ((x & 0x0000FF00) << 8)  | \
> +   ((x & 0x000000FF) << 24))

It's already somewhere in include/linux/byteorder/

> unsigned* dmabuf = host->buffer;

Space before star, please. Also everywhere.

> +       char* command = kmalloc(2, GFP_KERNEL);

Anyone remembers 1 kmallocated byte?

> --- linux-2.6.13-rc2.orig/include/asm-arm/arch-at91rm9200/AT91RM9200_EMAC.h
> +++ linux-2.6.13-rc2/include/asm-arm/arch-at91rm9200/AT91RM9200_EMAC.h

> +typedef struct _AT91S_EMAC {

> +} AT91S_EMAC, *AT91PS_EMAC;

Potentially even worse than "PAT91S_EMAC", "AT91S_EMACP" combined. Putting P
_there_...
