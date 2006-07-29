Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWG2Xp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWG2Xp7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 19:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWG2Xp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 19:45:59 -0400
Received: from mail1.cenara.com ([193.111.152.3]:33163 "EHLO
	kingpin.cenara.com") by vger.kernel.org with ESMTP id S1750785AbWG2Xp7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 19:45:59 -0400
From: Magnus =?iso-8859-1?q?Vigerl=F6f?= <wigge@bigfoot.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] input: Wacom tablet driver for simple X hotplugging
Date: Sun, 30 Jul 2006 01:45:44 +0200
User-Agent: KMail/1.9.1
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       "Ping Cheng" <pingc@wacom.com>
References: <20060721211341.5366.93270.sendpatchset@pipe> <20060725120645.b4dc98ab.akpm@osdl.org>
In-Reply-To: <20060725120645.b4dc98ab.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607300145.45158.wigge@bigfoot.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comments. They are appreciated even though the module never 
will be submitted to the kernel.

On Tuesday 25 July 2006 21:06, Andrew Morton wrote:
[...]
> > Note, the patch is included for idea visualization and not by any
> > means something I consider ready to be submitted. I know I have a few
> > issues that I must sort out first, however it does work in its current
> > state.
>
> The patch adds rather a lot of trailing whitespace.  I trim that off when
> applying; others do not.

Hmm... These I can't see.. For me trailing WS can be two things; WS between 
the last real character and newline and empty lines at the end of the file. I 
hate these two cases of trailing WS myself and I can't see any of them in the 
patch, so what is it I'm missing here? (Ok, I see one space at the beginning 
of one line, but that's not 'a lot' so it can't be that.)

> > +#include <asm/semaphore.h
>
> Semaphores are deprecated.  Unless you actually _need_ the sempahore's
> counting feature, please use mutexes.
>
> > +static int exclusivegrab = 0;
> > +static int debugconnect = 0;
> > +static short openfailcount = 0;
>
> Avoid the initialisation-to-zero.  The C runtime will zero these anyway,
> and the explicit initialisation will move these variables into the data
> section and hence into the on-disk vmlinux inage.
>
> > +#ifdef OPENFAILCOUNT
> > +module_param(openfailcount, short, 0644);
> > +MODULE_PARM_DESC(openfailcount, "Number of upcoming open that will fail"
> > +		 " with -ENODEV.");
> > +#endif
>
> What is this??

I should have put a note on this. It is something that enables me to force X 
to fail to open and to read from the device. That way it will be possible to 
reload the module without restarting X. Useful while developing and would 
have been removed if I ever would have released it to the kernel.

> > +static int str_to_user(const char *str, unsigned int maxlen,
> > +		       void __user *p)
> > +{
> > +	int len;
> > +
> > +	if (!str)
> > +		return -ENOENT;
> > +
> > +	len = strlen(str) + 1;
> > +	if (len > maxlen)
> > +		len = maxlen;
> > +
> > +	return copy_to_user(p, str, len) ? -EFAULT : len;
> > +}
>
> If (len > maxlen) this will send userspace a non-null-terminated string.
>
> > +/* ###################################################################
> > */ +/*                  Module File Methods                              
> >  */ +/*
> > ################################################################### */
> > +static int wp_open(struct inode *inodp, struct file *filp)
> > +{
> > +	struct wp_filenode *list;
> > +
> > +	if (openfailcount > 0) {
> > +		openfailcount--;
> > +		return -ENODEV;
> > +	}
> > +
> > +	if (!(list = kzalloc(sizeof(*list), GFP_KERNEL)))
> > +		return -ENOMEM;
> > +
> > +	filp->private_data = list;
> > +	list->tabletid = wp_proxyhndl.tabletid;
> > +
> > +	down(&wp_sema);
> > +	list_add_tail(&list->node, &wp_users);
> > +	if (wp_currenthndl != &wp_proxyhndl) {
> > +		if (!(wp_currenthndl->flags & WP_FLAG_OPEN)) {
> > +			if (!input_open_device(&wp_currenthndl->handle))
> > +				wp_currenthndl->flags |= WP_FLAG_OPEN;
> > +			else
> > +				printk(KERN_WARNING WP_MODNAME
> > +				       ": Failed to open '%s'\n",
> > +				       wp_currenthndl->devdesc);
> > +		}
> > +	}
> > +	up(&wp_sema);
> > +	return 0;
> > +}
>
> If input_open_device() fails then the whole open() should fail.  That way
> there will be no close(), flush() or release().

Yes, that would be the correct behavior. It could however result in some 
inconsistent behavior. As applications that open the device before attaching 
the tablet succeeds, and applications that opens it after the tablet is 
attached will fail (if input_open_device fails as well).

Maybe only opening the device when connecting it or if it is the first one 
that opens it would be the best way to handle it?

> > +		if(copy_to_user(ip, &wp_proxydev.id, sizeof(struct input_id)))
>
> We put a space between the `if' and the `(' (review the entire patch for
> this).
>
> > +	/* the id as all must close/reopen again anyway. */
> > +	else if (!list_empty(&wp_users)) {
> > +		if (!input_open_device(&devh->handle)) {
> > +			devh->flags |= WP_FLAG_OPEN;
> > +			if (wp_devgrabcount > 0) {
> > +				if (!input_grab_device(&devh->handle))
> > +					devh->flags |= WP_FLAG_GRAB;
> > +				else
> > +					printk(KERN_WARNING WP_MODNAME
> > +					       ": Failed to grab '%s'\n",
> > +					       dev->name);
> > +			}
> > +		}
> > +		else
> > +			printk(KERN_WARNING WP_MODNAME
> > +			       ": Failed to open '%s'\n", dev->name);
> > +	}
> > +}
>
> Again, just emitting a printk seems insufficient here.

The above code is called when a new tablet is added/removed so it's not 
possible to return something 'nice'. It might not even be the newly attached 
tablet that it fails to open. So in this case is it really possible to do 
anything else than a printk?

Thanks
 Magnus
