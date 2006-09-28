Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWI1Ukp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWI1Ukp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 16:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWI1Ukp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 16:40:45 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:39652 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1750764AbWI1Uko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 16:40:44 -0400
Date: Thu, 28 Sep 2006 14:40:43 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] async scsi scanning, version 12
Message-ID: <20060928204043.GH5017@parisc-linux.org>
References: <20060928182438.GC5017@parisc-linux.org> <20060928133246.14e79ace.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928133246.14e79ace.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 01:32:46PM -0700, Andrew Morton wrote:
> > +obj-$(CONFIG_SCSI)		+= scsi_wait_scan.o
> > +
> >  scsi_mod-y			+= scsi.o hosts.o scsi_ioctl.o constants.o \
> >  				   scsicam.o scsi_error.o scsi_lib.o \
> >  				   scsi_scan.o scsi_sysfs.o \
> 
> I think that's supposed to go into scsi_mod-y, at line 146.

Nope.  If CONFIG_SCSI is a module, we want this module around so people
can insmod it in order to ensure that scsi discovery is complete.  If
CONFIG_SCSI is built-in, we want this built-in too.

> > +static char scsi_scan_type[6] = "sync";
> 
> That wasted a byte.

If you specify "async" then the buffer needs to be 6 bytes long.

> >  
> > +static spinlock_t async_scan_lock = SPIN_LOCK_UNLOCKED;
> 
> DEFINE_SPINLOCK()

OK.

> > +int scsi_complete_async_scans(void)
> > +{
> > +	struct async_scan_data *data;
> > +
> > +	do {
> > +		if (list_empty(&scanning_hosts))
> > +			return 0;
> > +		data = kmalloc(sizeof(*data), GFP_KERNEL);
> > +		if (!data)
> > +			msleep(1);
> > +	} while (!data);
> 
> ick.  Immortal allocation loops are poor form.  If there's really no
> alternative, please use __GFP_NOFAIL, so people can easily grep for your
> sins.

It's not immortal.  The scanning threads will eventually terminate, and
so will this loop.

> > +	data->shost = NULL;
> > +	init_completion(&data->prev_finished);
> > +
> > +	spin_lock(&async_scan_lock);
> > +	if (list_empty(&scanning_hosts))
> > +		goto done;
> > +	list_add_tail(&data->list, &scanning_hosts);
> > +	spin_unlock(&async_scan_lock);
> 
> "If the list is not empty, stick something on it".
> 
> What an unusual thing to do.  I'm sure it makes sense, but some comments
> explaining what's going on would be nice.

OK.

> > +#ifdef MODULE
> > +/* Only exported for the benefit of scsi_wait_scan */
> > +EXPORT_SYMBOL_GPL(scsi_complete_async_scans);
> > +#endif
> 
> Is that actually needed?  AFACIT this .o file will just get linked against
> the one which contains scsi_wait_scan() anyway.

See above.
