Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWAYALn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWAYALn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 19:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWAYALn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 19:11:43 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:201 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750863AbWAYALm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 19:11:42 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm] swsusp: userland interface (rev 2)
Date: Wed, 25 Jan 2006 00:35:38 +0100
User-Agent: KMail/1.9
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
References: <200601240929.37676.rjw@sisk.pl> <20060124131312.0545262d.akpm@osdl.org>
In-Reply-To: <20060124131312.0545262d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601250035.39383.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 24 January 2006 22:13, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > Hi,
> > 
> > This patch introduces a user space interface for swsusp.
> 
> How will we know if/when this feature is ready for mainline?  What criteria
> can we use to judge that?

I think when we are able to demonstrate that it allows us to do more than
the current built-in swsusp in terms of performance, security etc.  Of course
we'll need some userland utilities for this purpose.

> Will you be developing and long-term maintaining the userspace tools?

Yes.

> Is it your expectation/hope that distros will migrate onto using them?  etc.

I think they'll find the interface useful.  I've been using it for a couple of
weeks now and it really allowed me to do some tricks that are just impossible
with the current implementation.

> > +
> > +static int snapshot_open(struct inode *inode, struct file *filp)
> > +{
> > +	struct snapshot_data *data;
> > +
> > +	if (!atomic_dec_and_test(&device_available)) {
> > +		atomic_inc(&device_available);
> 
> You may find that atomic_add_unless(..., -1, ...) is neater here, and
> closes the tiny race.

Well, actually I've taken this stuff verbatim from LDD3.

> > +		return -EBUSY;
> > +	}
> > +
> > +	if ((filp->f_flags & O_ACCMODE) == O_RDWR)
> > +		return -ENOSYS;
> > +
> > +	nonseekable_open(inode, filp);
> > +	data = &snapshot_state;
> > +	filp->private_data = data;
> > +	memset(&data->handle, 0, sizeof(struct snapshot_handle));
> 
> <goes off hunting elsewhere for the defn of data->handle.  grr>
> 
> > +static ssize_t snapshot_read(struct file *filp, char __user *buf,
> > +                             size_t count, loff_t *offp)
> > +{
> > +	struct snapshot_data *data;
> > +	ssize_t res;
> > +
> > +	data = filp->private_data;
> > +	res = snapshot_read_next(&data->handle, count);
> > +	if (res > 0) {
> > +		if (copy_to_user(buf, data_of(data->handle), res))
> > +			res = -EFAULT;
> > +		else
> > +			*offp = data->handle.offset;
> > +	}
> > +	return res;
> > +}
> 
> It's more conventional for a read() to return less-than-was-asked-for when
> it hits a fault.  Doesn't matter though - lots of drivers do it this way.

I thought about it, but this would increase the complexity of
snapshot_read_next() by two orders of magnitude, and this function is also
called by the built-in code which doesn't use the read-less-than-one-page-at-a-time
functionality anyway, so I decided against it.

> > +static ssize_t snapshot_write(struct file *filp, const char __user *buf,
> > +                              size_t count, loff_t *offp)
> > +{
> > +	struct snapshot_data *data;
> > +	ssize_t res;
> > +
> > +	data = filp->private_data;
> > +	res = snapshot_write_next(&data->handle, count);
> > +	if (res > 0) {
> > +		if (copy_from_user(data_of(data->handle), buf, res))
> > +			res = -EFAULT;
> > +		else
> > +			*offp = data->handle.offset;
> > +	}
> > +	return res;
> > +}
> 
> Ditto.
> 
> > +static int snapshot_ioctl(struct inode *inode, struct file *filp,
> > +                          unsigned int cmd, unsigned long arg)
> > +{
> >
> > ...
> >
> > +	case SNAPSHOT_ATOMIC_RESTORE:
> > +		if (data->mode != O_WRONLY || !data->frozen ||
> > +		    !snapshot_image_loaded(&data->handle)) {
> > +			error = -EPERM;
> > +			break;
> > +		}
> > +		down(&pm_sem);
> > +		pm_prepare_console();
> > +		error = device_suspend(PMSG_FREEZE);
> > +		if (!error) {
> > +			mb();
> > +			error = swsusp_resume();
> > +			device_resume();
> > +		}
> 
> whee, what does the mystery barrier do?  It'd be nice to comment this
> (please always comment open-coded barriers).

Pavel should know. ;-)
 
> > +	case SNAPSHOT_GET_SWAP_PAGE:
> > +		if (!access_ok(VERIFY_WRITE, (unsigned long __user *)arg, _IOC_SIZE(cmd))) {
> > +			error = -EINVAL;
> > +			break;
> > +		}
> 
> Why do we need an access_ok() here?

Because we use __put_user() down the road?

The problem is if the address is wrong we should not try to call
alloc_swap_page() at all.  If we did, we wouldn't be able to return the result
and we would leak a swap page.

> Should it return -EFAULT?

Yes, it should.

I'll post a small fix on top of this patch if you don't mind.

