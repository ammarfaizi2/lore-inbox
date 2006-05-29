Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWE2D51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWE2D51 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 23:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWE2D51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 23:57:27 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:36993 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1751155AbWE2D50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 23:57:26 -0400
Date: Sun, 28 May 2006 21:57:25 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Greg KH <greg@kroah.com>
Cc: Patrick Mansfield <patmans@us.ibm.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: dev_printk output
Message-ID: <20060529035725.GC23405@parisc-linux.org>
References: <20060511150015.GJ12272@parisc-linux.org> <20060512170854.GA11215@us.ibm.com> <20060513050059.GR12272@parisc-linux.org> <20060518183652.GM1604@parisc-linux.org> <20060518200957.GA29200@us.ibm.com> <20060519201142.GB2826@parisc-linux.org> <20060519202847.GB8865@kroah.com> <20060520045544.GD2826@parisc-linux.org> <20060520212135.GB24672@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060520212135.GB24672@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2006 at 02:21:35PM -0700, Greg KH wrote:
> On Fri, May 19, 2006 at 10:55:44PM -0600, Matthew Wilcox wrote:
> > On Fri, May 19, 2006 at 01:28:47PM -0700, Greg KH wrote:
> > > On Fri, May 19, 2006 at 02:11:42PM -0600, Matthew Wilcox wrote:
> > > > On Thu, May 18, 2006 at 01:09:57PM -0700, Patrick Mansfield wrote:
> > > > > Funky how loading sd after sg changes the output ... and using the driver
> > > > > name as a prefix sometimes messes this up for scsi.
> > > > > 
> > > > >  0:0:0:0: Attached scsi generic sg0 type 0
> > > > > sd 1:0:0:0: Attached scsi generic sg0 type 0
> > > 
> > > Something like (untested):
> > > 	printk(level "%s %s %s: " format , (dev)->bus ? (dev)->bus->name : "", (dev)->driver ? (dev)->driver->name : "", (dev)->bus_id , ## arg)
> > 
> > Then we still get the inconsistency of device names changing as drivers
> > are loaded.
> 
> The bus id doesn't change, just the "hint" as to who is controling it at
> that point in time.  Which is something that is needed/wanted by a lot
> of people.

Sure, but it's also unwanted by others ;-)  There's no reason we have to
have a 'one size fits all' solution.  Let's add a dev_bus_printk() (or
maybe just bus_printk()?) that does
	printk(level "%s %s: " format , (dev)->bus ? (dev)->bus->name : "", \
		(dev)->bus_id , ## arg)

or we could rename the current dev_printk() implementation to drv_printk()
and have dev_printk() do the above.  or we could do something like:

#define DEV_DRV(dev)	(dev)->driver ? (dev)->driver->name : ""
#define DEV_BUS(dev)	(dev)->bus ? (dev)->bus->name : ""
#define dev_printk(level, dev, format, arg...)  \
	printk(level "%s %s: " format, DEV_BUS(dev), (dev)->bus_id , ## arg)
#define drv_printk(level, dev, format, arg...)  \
	printk(level "%s %s %s: " format, DEV_DRV(dev), DEV_BUS(dev), \
		(dev)->bus_id , ## arg)

Obviously, we could argue about the exact naming until the cows come home, 
so let me say that I don't really care.  I just want something that
looks like "scsi 0:0:0:0" rather than "sd 0:0:0:0" or " 0:0:0:0",
depending on whether sd has been loaded or not.

If you're still reluctant, think about it this way.  There are bits of
the kernel which need to tell the user about a device that may, or may
not have a driver attached.  The scsi midlayer is one, and I'm sure
there are others.
