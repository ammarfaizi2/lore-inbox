Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVFCVYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVFCVYy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 17:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVFCVYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 17:24:54 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:26299 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261409AbVFCVYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 17:24:13 -0400
Date: Fri, 3 Jun 2005 14:24:11 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][1/5] RapidIO support: core
Message-ID: <20050603142411.A32392@cox.net>
References: <20050602140359.B24818@cox.net> <20050603071133.GB30292@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050603071133.GB30292@kroah.com>; from greg@kroah.com on Fri, Jun 03, 2005 at 12:11:33AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 12:11:33AM -0700, Greg KH wrote:
> On Thu, Jun 02, 2005 at 02:03:59PM -0700, Matt Porter wrote:
> > +RIO_LOP_READ(8, u8, 1)
> > +    RIO_LOP_READ(16, u16, 2)
> > +    RIO_LOP_READ(32, u32, 4)
> > +    RIO_LOP_WRITE(8, u8, 1)
> > +    RIO_LOP_WRITE(16, u16, 2)
> > +    RIO_LOP_WRITE(32, u32, 4)
> > +
> > +    EXPORT_SYMBOL(__rio_local_read_config_8);
> > +EXPORT_SYMBOL(__rio_local_read_config_16);
> > +EXPORT_SYMBOL(__rio_local_read_config_32);
> > +EXPORT_SYMBOL(__rio_local_write_config_8);
> > +EXPORT_SYMBOL(__rio_local_write_config_16);
> > +EXPORT_SYMBOL(__rio_local_write_config_32);
> 
> Odd indenting here.

Lindent got me here. I didn't doublecheck its munging on this file.
Updated that.

> And why the __rio* stuff for public functions?  You should drop the "__"
> part.

This may seem silly but I was trying to have the automagic DocBook
stuff pick up the complete set of kernel interfaces without have
to duplicate anything in the DocBook template.  Since these functions
are macro-generated I could have a comment block for each one that
the docs stuff would pick up.  So, I put rio_local_*() up in
include/linux/rio_drv.h as inline wrappers around these implementations.

Too ugly to live? Maybe there's a better way to make this work, it
would nice to have it autogenerate the docs.

<snip>

> > +EXPORT_SYMBOL(rio_mport_send_doorbell);
> 
> Just a question, should these be EXPORT_SYMBOL_GPL() as this is GPL
> code?  Just to be explicit that is.

Good point. I'm going to go through and make all RIO interfaces
EXPORT_SYMBOL_GPL(). Embedded folks need the extra encouragement
to do the right thing when writing drivers.

> > +static ssize_t
> > +rio_read_config(struct kobject *kobj, char *buf, loff_t off, size_t count)
> 
> <snip>
> 
> You might want to compare this to the recent changes in the 2.6.12-rc
> kernels in the pci sysfs config code.  There were some 64 and endian
> issues fixed up there that you might want to make sure are also done
> properly here.

I see that in the current git tree.  I think some of it applies (note
that RIO is a big-endian system, not surprising since it originates
from Motorola/Fscale), I'll look more closely and add the appropriate
fixes into the next patch.  Since Andrew took these into -mm I will
just post patches against -mm.

> > +static struct bin_attribute rio_config_attr = {
> > +	.attr = {
> > +		 .name = "config",
> > +		 .mode = S_IRUGO | S_IWUSR,
> > +		 .owner = THIS_MODULE,
> > +		 },
> > +	.size = 0x200000,
> > +	.read = rio_read_config,
> > +	.write = rio_write_config,
> > +};
> 
> Wow, that's a huge config space (just a comment, not an issue...)

Heh, yes.  The "maintenance packets" that are used to access config
space on RIO devices have a 21-bit offset field.  I guess the
spec guys didn't want to run out of config space too quickly. :)

-Matt
