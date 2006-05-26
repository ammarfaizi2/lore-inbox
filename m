Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbWEZETl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbWEZETl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 00:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbWEZETl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 00:19:41 -0400
Received: from vbn.0012335.lodgenet.net ([67.96.213.158]:30622 "EHLO
	vbn.0012335.lodgenet.net") by vger.kernel.org with ESMTP
	id S1030298AbWEZETk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 00:19:40 -0400
Date: Thu, 25 May 2006 21:06:13 -0700
From: Greg KH <greg@kroah.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, lkml <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] request_firmware without a device
Message-ID: <20060526040613.GA5324@kroah.com>
References: <1148529045.32046.102.camel@sli10-desk.sh.intel.com> <20060525040134.GA29974@kroah.com> <1148552694.4734.10.camel@localhost> <1148614839.32046.143.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148614839.32046.143.camel@sli10-desk.sh.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 11:40:39AM +0800, Shaohua Li wrote:
> On Thu, 2006-05-25 at 12:24 +0200, Marcel Holtmann wrote:
> > Hi Greg,
> > 
> > > > The patch allows calling request_firmware without a 'struct device'.
> > > > It appears we just need a name here from 'struct device'. I changed it
> > > > to use a kobject as Patrick suggested.
> > > > Next patch will use the new API to request firmware (microcode) for a CPU.
> > > 
> > > But a cpu does have a struct device.  Why not just use that?
> > > 
> > > > +fw_setup_class_device_id(struct class_device *class_dev, struct kobject *kobj)
> > > >  {
> > > >  	/* XXX warning we should watch out for name collisions */
> > > > -	strlcpy(class_dev->class_id, dev->bus_id, BUS_ID_SIZE);
> > > > +	strlcpy(class_dev->class_id, kobj->k_name, BUS_ID_SIZE);
> > > 
> > > There's a function for this, kobject_name(), please never touch k_name
> > > directly.
> > > 
> > > > +EXPORT_SYMBOL(request_firmware_kobj);
> > > 
> > > Ick, if you really want to do this, just fix up all callers of
> > > request_firmware(), there aren't that many of them.
> > > 
> > > But I don't recommend it anyway.
> > 
> > I also disagree with this change at all. The callers of request_firmware
> > should not fiddle around with kobject's to make this work. All of them
> > have their struct device and they should use it.
> So why we need a 'struct device'? I didn't see any point we need it. We
> just need a 'name'.

You need a kobject, as ideally we would have a symlink back to the
"real" kobject.  So far, only "devices" need firmware, that's why it is
that way.

> > So I would propose that we fix the caller and the not request_firmware
> > code. However one option would be calling it with NULL as device
> > argument and it registers itself a dummy device for the operation.
> This doesn't work, as we need a 'name'.
> 
> do we really need to differentiate between sysdev and device anymore. I
> > recall a plan to unify all devices, but I might be wrong.
> I'd like this idea. But it means many works. In addition, a sysdev could
> have multiple drivers, and a 'device' can't to me.

Today a sysdev can have that?  Ick.  Any examples of ones that really
do?

thanks,

greg k-h
