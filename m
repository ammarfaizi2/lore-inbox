Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbTEUSqQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 14:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbTEUSqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 14:46:16 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:11946 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262290AbTEUSqK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 14:46:10 -0400
Date: Wed, 21 May 2003 20:34:35 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>, Oliver Neukum <oliver@neukum.org>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: request_firmware() hotplug interface, third round and a halve
Message-ID: <20030521183434.GA12677@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <20030517221921.GA28077@ranty.ddts.net> <20030521072318.GA12973@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030521072318.GA12973@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 12:23:18AM -0700, Greg KH wrote:
> Oops, forgot to respond to this, sorry...
> 
> On Sun, May 18, 2003 at 12:19:22AM +0200, Manuel Estrada Sainz wrote:
[snip]
> >  - There is a timeout, changeable from userspace. Feedback on a
> >    reasonable default value appreciated.
> 
> Is this really needed?  Especially as you now have:

 There is currently no way to know if hotplug couldn't be called at all
 or if it failed because it didn't have firmware load support.

 If that happens, we would be waiting for ever. And I'd rather make that
 a countable number of seconds :)

 I'll make '0' mean no timeout at all.

> >  - Extended 'loading' semantics:
> >  	echo 1 > loading:
> > 		start a new load, and flush any data from a previous
> > 		partial load.
> > 	echo 0 > loading:
> > 		finish load.
> > 	echo -1 > loading:
> > 		cancel load and give an error to the driver.
> 
> Looks good.
> 
> I'd recommend sending the sysfs patches to Pat Mochel.  He's the one to
> take those.

 Done.
 
> Some minor comments about the code:
> 
> > diff --exclude=CVS -urN linux-2.5.orig/drivers/base/Makefile linux-2.5.mine/drivers/base/Makefile
> > --- linux-2.5.orig/drivers/base/Makefile	2003-05-17 20:44:03.000000000 +0200
> > +++ linux-2.5.mine/drivers/base/Makefile	2003-05-17 23:17:21.000000000 +0200
> > @@ -3,4 +3,6 @@
> >  obj-y			:= core.o sys.o interface.o power.o bus.o \
> >  			   driver.o class.o platform.o \
> >  			   cpu.o firmware.o init.o
> > +obj-m			:= firmware_class.o firmware_sample_driver.o \
> > +			   firmware_sample_firmware_class.o
> 
> Why make the firmware_class.o always a module?  Shouldn't it only be
> included in the core, if a driver that uses it is selected?

 That was the quickest way to get modules to play with :-)

 I am not sure on how to implement "if a driver that uses it is
 selected" and not sure on where to add the Kconfig entries to make it
 available to out-of-kernel modules.

 If the approach in the attached patches is still not right, please
 complain.
 
 Maybe kbuild could allow forcing one option from another, a companion
 for 'depends', lets call it 'hard_depends'

	 depends FOO
		If FOO is not there the entry won't even be shown in the
		menu.
	 hard_depends FOO 
		FOO gets set to satisfy the dependency.

 When trying to deselect an item that is hard_depended upon, the system
 could complain and tell you which options should be deselected or even
 offer to do it automatically.

 This would also simplify the selection of crc32 and
 compression/decompression code. And allow removal of all those comments
 like "Video4Linux support is needed for USB Multimedia device support".

> > +static inline struct class_device *to_class_dev(struct kobject *obj)
> > +{
> > +	return container_of(obj,struct class_device,kobj);
> > +}
> > +static inline
> > +struct class_device_attribute *to_class_dev_attr(struct attribute *_attr)
> > +{
> > +	return container_of(_attr,struct class_device_attribute,attr);
> > +}
> 
> Move these two to drivers/base/base.h as they shouldn't be defined in
> two different files.

 OK, I also removed equivalent macros from class.c
 
> > +int sysfs_create_bin_file(struct kobject * kobj, struct bin_attribute * attr);
> > +int sysfs_remove_bin_file(struct kobject * kobj, struct bin_attribute * attr);
> 
> If you need these, add them to include/linux/sysfs.h.
> 
> > +struct firmware_priv {
> > +	char fw_id[FIRMWARE_NAME_MAX];
> > +	struct completion completion;
> > +	struct bin_attribute attr_data;
> > +	struct firmware *fw;
> > +	s32 loading:2;
> > +	u32 abort:1;
> 
> Why s32 and u32?  Why not just ints for both of them?

 Since they are bit fields, I wanted to have more control over them and a
 single bit bit-field should be unsigned, but I guess that David is
 right, it is not worth it. Both are full int's now.
 
> > +struct class firmware_class = {
> > +        .name           = "firmware",
> > +	.hotplug        = firmware_class_hotplug,
> > +};
> 
> Oops, forgot tabs there...
> 
> > +	switch(fw_priv->loading){
> 
> Please add a space before the '{'.
> 
> > +	case 0:
> > +		if(prev_loading==1)
> 
> And a space after the if.  You do this in lots of places.

 Fixed, and just in case, I put it through Lindent which BTW is a little
 evil :-) so I hand removed the evilness I could not take.

> Other than those very minor things, this looks quite good.

 Great.

 Patches:
	firmware-class.diff:
		The code itself against bk-cvs.

	class-casts.diff:
		to_class_dev/to_class_dev_attr changes against bk-cvs.

	sysfs-bin-header.diff
	sysfs-bin-lost-dget.diff
	sysfs-bin-flexible-size.diff:
		Just for completeness, since the above will not work
		without them, but I already send them to Pat Mochel in a
		separate mail.

 	incremental.diff:
		Incremental patch for easier reading, although there are
		lots of formating changes.

 Thanks

 	Manuel
-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
