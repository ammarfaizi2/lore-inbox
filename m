Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263302AbTCNIIU>; Fri, 14 Mar 2003 03:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263303AbTCNIIU>; Fri, 14 Mar 2003 03:08:20 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:10763 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263302AbTCNIIS>; Fri, 14 Mar 2003 03:08:18 -0500
Date: Fri, 14 Mar 2003 08:19:04 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [PATCH] i2c driver changes for 2.5.64
Message-ID: <20030314081904.A11701@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	sensors@stimpy.netroedge.com
References: <20030314005027.GA1923@kroah.com> <10476033153504@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <10476033153504@kroah.com>; from greg@kroah.com on Thu, Mar 13, 2003 at 04:55:00PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13, 2003 at 04:55:00PM -0800, Greg KH wrote:
> +/* Detect whether a ALI15X3 can be found, and initialize it, where necessary.
> +   Note the differences between kernels with the old PCI BIOS interface and
> +   newer kernels with the real PCI interface. In compat.h some things are
> +   defined to make the transition easier. */

This comment seems a bit outdated..

> +int ali15x3_setup(void)

Should be static like everything in this file (and merged into
ali15x3_probe anyway).

> +{
> +	u16 a;
> +	unsigned char temp;
> +
> +	struct pci_dev *ALI15X3_dev;
> +
> +	/* First check whether we can access PCI at all */
> +	if (pci_present() == 0) {
> +		printk("i2c-ali15x3.o: Error: No PCI-bus found!\n");
> +		return -ENODEV;
> +	}

You're calling this from pci_driver->probe, so you will never get
here without PCI hardware.

> +	/* Look for the ALI15X3, M7101 device */
> +	ALI15X3_dev = NULL;
> +	ALI15X3_dev = pci_find_device(PCI_VENDOR_ID_AL,
> +				      PCI_DEVICE_ID_AL_M7101, ALI15X3_dev);
> +	if (ALI15X3_dev == NULL) {
> +		printk("i2c-ali15x3.o: Error: Can't detect ali15x3!\n");
> +		return -ENODEV;
> +	}

Calling pci_find_device in ->probe looks buggy to me.  What are you
trying to do?

> +/* Is SMB Host controller enabled? */
> +	pci_read_config_byte(ALI15X3_dev, SMBHSTCFG, &temp);
> +	if ((temp & 1) == 0) {

What about proper indentation for the comments?

> +/* Internally used pause function */
> +void ali15x3_do_pause(unsigned int amount)
> +{
> +	current->state = TASK_INTERRUPTIBLE;
> +	schedule_timeout(amount);
> +}

I think this should be moved to linux/kernel.h as delay() - I've seen
it duplicated in so much code (including XFS)

> +#ifdef DEBUG
> +	printk
> +	    ("i2c-ali15x3.o: Transaction (pre): STS=%02x, CNT=%02x, CMD=%02x, ADD=%02x, DAT0=%02x, "
> +	     "DAT1=%02x\n", inb_p(SMBHSTSTS), inb_p(SMBHSTCNT),
> +	     inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
> +	     inb_p(SMBHSTDAT1));
> +#endif

use pr_debug() here.

> +static struct pci_device_id ali15x3_ids[] __devinitdata = {
> +	{ 0, }
> +};

Umm?

