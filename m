Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263294AbTCNIRo>; Fri, 14 Mar 2003 03:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263296AbTCNIRo>; Fri, 14 Mar 2003 03:17:44 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:14603 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263294AbTCNIRl>; Fri, 14 Mar 2003 03:17:41 -0500
Date: Fri, 14 Mar 2003 08:28:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [PATCH] i2c driver changes for 2.5.64
Message-ID: <20030314082827.C11701@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	sensors@stimpy.netroedge.com
References: <1047603318248@kroah.com> <10476033191486@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <10476033191486@kroah.com>; from greg@kroah.com on Thu, Mar 13, 2003 at 04:55:00PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13, 2003 at 04:55:00PM -0800, Greg KH wrote:
> +#include <linux/i2c.h>
> +#include <asm/io.h>
> +
> +MODULE_LICENSE("GPL");

This should be at the bottom of the file with the other MODULE_* stuff

> +#ifdef I2C_FUNC_SMBUS_BLOCK_DATA_PEC
> +#define HAVE_PEC
> +#endif

Needs more explanation.

> +
> +#ifndef PCI_DEVICE_ID_INTEL_82801CA_SMBUS
> +#define PCI_DEVICE_ID_INTEL_82801CA_SMBUS	0x2483
> +#endif
> +
> +#ifndef PCI_DEVICE_ID_INTEL_82801DB_SMBUS
> +#define PCI_DEVICE_ID_INTEL_82801DB_SMBUS	0x24C3
> +#endif

Should go to pci_ids.h

> +
> +static int supported[] = {PCI_DEVICE_ID_INTEL_82801AA_3,
> +                          PCI_DEVICE_ID_INTEL_82801AB_3,
> +                          PCI_DEVICE_ID_INTEL_82801BA_2,
> +			  PCI_DEVICE_ID_INTEL_82801CA_SMBUS,
> +			  PCI_DEVICE_ID_INTEL_82801DB_SMBUS,
> +                          0 };

Shouldn't be required with new-style pci probing.

> +static int force_addr = 0;
> +MODULE_PARM(force_addr, "i");
> +MODULE_PARM_DESC(force_addr,
> +		 "Forcibly enable the I801 at the given address. "
> +		 "EXTREMELY DANGEROUS!");

What about using Rusty's new module parameter stuff?

> +static unsigned short i801_smba = 0;
> +static struct pci_dev *I801_dev = NULL;
> +static int isich4 = 0;

This is in .bss..

> +/* Detect whether a I801 can be found, and initialize it, where necessary.
> +   Note the differences between kernels with the old PCI BIOS interface and
> +   newer kernels with the real PCI interface. In compat.h some things are
> +   defined to make the transition easier. */
> +int i801_setup(void)

Merge with caller, comment is b0rked.

> +{
> +	int error_return = 0;
> +	int *num = supported;
> +	unsigned char temp;
> +
> +	/* First check whether we can access PCI at all */
> +	if (pci_present() == 0) {
> +		printk(KERN_WARNING "i2c-i801.o: Error: No PCI-bus found!\n");
> +		error_return = -ENODEV;
> +		goto END;
> +	}

END is a bad name for a label.  

> +	/* Look for each chip */
> +	/* Note: we keep on searching until we have found 'function 3' */
> +	I801_dev = NULL;
> +	do {
> +		if((I801_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
> +					      *num, I801_dev))) {
> +			if(PCI_FUNC(I801_dev->devfn) != 3)
> +				continue;
> +			break;
> +		}
> +		num++;
> +	} while (*num != 0);

You already changed it to new-style pci probing in the next patch, didn't
you?

> +	if (check_region(i801_smba, (isich4 ? 16 : 8))) {

no way!

> +int i801_transaction(void)

static..

> +	int temp;
> +	int result = 0;
> +	int timeout = 0;
> +
> +#ifdef DEBUG
> +	printk
> +	    (KERN_DEBUG "i2c-i801.o: Transaction (pre): CNT=%02x, CMD=%02x, ADD=%02x, DAT0=%02x, "
> +	     "DAT1=%02x\n", inb_p(SMBHSTCNT), inb_p(SMBHSTCMD),
> +	     inb_p(SMBHSTADD), inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1));
> +#endif

pr_debug

> +		temp = inb_p(SMBHSTSTS);
> +                if (i == 1) {
> +                    /* Erronenous conditions before transaction: 
> +                     * Byte_Done, Failed, Bus_Err, Dev_Err, Intr, Host_Busy */
> +                    errmask=0x9f; 
> +                } else {
> +                    /* Erronenous conditions during transaction: 
> +                     * Failed, Bus_Err, Dev_Err, Intr */
> +                    errmask=0x1e; 
> +                }

Indentation look b0rked.

