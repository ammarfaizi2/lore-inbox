Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261764AbSJMXHb>; Sun, 13 Oct 2002 19:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261769AbSJMXHb>; Sun, 13 Oct 2002 19:07:31 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:5907 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261764AbSJMXHa>;
	Sun, 13 Oct 2002 19:07:30 -0400
Date: Sun, 13 Oct 2002 16:08:40 -0700
From: Greg KH <greg@kroah.com>
To: Mark Peloquin <peloquin@us.ibm.com>
Cc: Kevin M Corry <corryk@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: evms ioctl question
Message-ID: <20021013230839.GA25230@kroah.com>
References: <OF25AABB03.802F967E-ON85256C4F.007776C0@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF25AABB03.802F967E-ON85256C4F.007776C0@pok.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2002 at 06:09:54PM -0500, Mark Peloquin wrote:
> 
> On 10/11/2002 at 03:49 PM, Greg KH wrote:
> 
> > > However, Al pointed out that it would be better style to turn these
> > > into extra plugin APIs, so we added a bunch of functions to the
> > > evms_plugin_fops table, and converted all of the plugins to implement
> > > these instead of handling them in the ioctl code.
> > >
> > > Thus, most of the defines listed above are no longer used. I had
> > > actually thought these defines were removed from evms_ioctl.h, but
> > > apparently I was mistaken.
> 
> > Ok, I'll wait for your next round of patches to verify this, thanks for
> > the explaination.  You still have a ioctl() and direct_ioctl() function
> > in that structure that you should probably remove if it's no longer
> > needed.
> 
> All plugins ioctls used for layer to layer communication
> have been converted to plugin methods, as Al Viro
> suggested, except one. That one is used only for s390
> arch and will be conditionally marked as such.

Why can't the s390 code also be converted?  If it was, do you mean that
the ioctl() and direct_ioctl() callbacks can be removed?

> > > > Does evms "plugins" make ioctl calls to the evms core?  Please tell me
> > > > I'm mistaken :)
> > >
> > > This was never the case. Plugins make calls into the core using the
> > > common-services API, which is defined in services.c.
> 
> > Um, then what's the following function for:
> > +/**
> > + * evms_cs_kernel_ioctl - performs a userspace ioctl from within the kernel
> > + * @node:      the storage object that is the target of this ioctl
> > + * @cmd: the ioctl command
> > + * @arg: the ioctl argument(s)
> > + *
> > + * Performs a userspace ioctl from within the kernel
> > + **/
> 
> There are a few cases where drivers, such as the s390,
> have private ioctls to perform various functions like
> formatting/partitioning devices, obtaining specifics
> about existing partitions, etc.

Why is s390 special?  Shouldn't it use the same interface the rest of
the block devices use?

> This routine just encapsulated the common steps for
> performing this type of operation.
> 
> > > > And is there any documentation you can point me to on what the evms
> > > > "plugin" interface consists of?
> > >
> > > Every plugin must implement a set of functions, which are specified in
> > > evms_plugin_fops structure (defined in evms.h). The most significant of
> > > these are the methods for volume discovery, volume delete, handling I/O,
> > > and handling ioctls (along the with new ones I mentioned above).
> 
> > New ioctls?
> 
> No, new plugin methods.
> 
> > > You have both a ioctl() and direct_ioctl() callback in that structure
> 
> ioctl() is a standard block device operation so it
> supported in our plugin operations. It targets
> either the EVMS block device, or it targets a volume.
> The direct_ioctl() provides communication from
> userspace plugin to corresponding kernel space
> plugin operations. It allows the LVM plugin to
> target a "volume group" or a physical volume (PV).
> It allows MD to target a specific element of drive
> array. Its designed to allow plugins to target
> abstract items other than just a volume or the EVMS
> block device driver.

So some upper layer code determines which kind of ioctl this is, and
sends the data to direct_ioctl() or ioctl()?  I can understand trying to
handle the "generic block device ioctls" but being forced to parse them
yourself seems like a loosing job.

Again, I really recommend getting rid of any new ioctls, and use either
driverfs or your own fs.

> > > Are they not needed now (as I mentioned above)?
> 
> I would need to learn about current level of
> support in driverfs to determine if it would
> be suitable to support our needs. I was under
> the impression that driverfs described the
> physical world. How are logical entities
> described/placed in the current driverfs
> topology?

In the end, everything is a "logical" representation :)
Driverfs exports the in-kernel representation of the device tree, so
that would fit perfectly with your logical representation.  As this is
the main reason for having driverfs, I'm very reluctant to see new
chunks of code added to the kernel that tries to implement this in their
own "custom" way.  In this case, you are doing this through ioctls, and
your /proc interface.  Both of these should be converted.

If you have any implementation questions about the driver model, and
driverfs, please feel free to ask.

thanks,

greg k-h
