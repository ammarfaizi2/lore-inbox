Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWESUbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWESUbE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 16:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWESUbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 16:31:04 -0400
Received: from ns.suse.de ([195.135.220.2]:9150 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964822AbWESUbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 16:31:01 -0400
Date: Fri, 19 May 2006 13:28:47 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Patrick Mansfield <patmans@us.ibm.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: dev_printk output
Message-ID: <20060519202847.GB8865@kroah.com>
References: <20060511150015.GJ12272@parisc-linux.org> <20060512170854.GA11215@us.ibm.com> <20060513050059.GR12272@parisc-linux.org> <20060518183652.GM1604@parisc-linux.org> <20060518200957.GA29200@us.ibm.com> <20060519201142.GB2826@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060519201142.GB2826@parisc-linux.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2006 at 02:11:42PM -0600, Matthew Wilcox wrote:
> On Thu, May 18, 2006 at 01:09:57PM -0700, Patrick Mansfield wrote:
> > Funky how loading sd after sg changes the output ... and using the driver
> > name as a prefix sometimes messes this up for scsi.
> > 
> > i.e. scan without sd_mod or sg loaded (and distro I'm using loads sg
> > before sd_mod via udev rules):
> > 
> >  0:0:0:0: Attached scsi generic sg0 type 0
> >  0:0:0:1: Attached scsi generic sg1 type 0
> > 
> > Then remove/add those devices, and sg lines become:
> > 
> > sd 1:0:0:0: Attached scsi generic sg0 type 0
> > sd 1:0:0:1: Attached scsi generic sg1 type 0
> 
> I find that a bit confusing too.  Obviously, we should distinguish
> different kinds of bus_id from each other somehow -- but isn't the
> obvious thing to use the bus name?  That must already be unique as sysfs
> relies on it.  ie this patch:
> 
> (seems that dev->bus isn't always set; I got a null ptr dereference when
> booting without that check).

Yes, not all devices are on a bus, so this will not work.  And we want
to know the driver that controls the device too.  So how about adding
the bus if it's not null?

Something like (untested):
	printk(level "%s %s %s: " format , (dev)->bus ? (dev)->bus->name : "", (dev)->driver ? (dev)->driver->name : "", (dev)->bus_id , ## arg)

thanks,

greg k-h
