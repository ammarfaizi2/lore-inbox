Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161829AbWLBAM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161829AbWLBAM7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 19:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161966AbWLBAM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 19:12:58 -0500
Received: from wx-out-0506.google.com ([66.249.82.237]:1814 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161829AbWLBAM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 19:12:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YjAX1MES5uXZyFhRSVvAWFF9pmlj85NjgbWqIQOseOj7nkaGClgXHEw3BAV52oc6OBDWseUacHo5zF6gi91qnjgu+IhXadXzxKqQLYJbU5A+5K5KCrwsSHbupQlmOyoin9HeCXW3fmgn9nl9HWgBn92DppDp7leHqzhXEJ3sKv4=
Message-ID: <571a92f0612011612w13409d7u792b5afc20cc3e98@mail.gmail.com>
Date: Fri, 1 Dec 2006 17:12:56 -0700
From: "David Lopez" <dave.l.lopez@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: [PATCH] USB: add driver for LabJack USB DAQ devices
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20061201211801.GA448@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <571a92f0612011237p35e00be5w832fafb3f824b97a@mail.gmail.com>
	 <20061201211801.GA448@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/06, Greg KH <greg@kroah.com> wrote:
> On Fri, Dec 01, 2006 at 01:37:22PM -0700, David Lopez wrote:
> > From: David Lopez <dave.l.lopez@gmail.com>
>

> The patch seems linewrapped, which doesn't make it easy to apply :(
>
> Can you resend this?

Sorry about that.  Is it ok to send the patch as an attachment?  It
seems like gmail likes to linewrap plain text.  Also, when I resend
the patch after a little fixing should I send it as a reply.


> > +#define BULK_IN_TIMEOUT                      1000    /* default bulk in
> > read timeout */
>
> What units is this timeout in?

It is in milliseconds.  I'll add that to the comment when I resend the patch.


> > +static void ljusb_write_bulk_callback(struct urb *urb)
> > +{
> > +     struct usb_ljusb *dev;
> > +
> > +     dev = (struct usb_ljusb *)urb->context;
> > +
> > +     /* sync/async unlink faults aren't errors */
> > +     if (urb->status &&
> > +         !(urb->status == -ENOENT ||
> > +           urb->status == -ECONNRESET ||
> > +           urb->status == -ESHUTDOWN)) {
> > +             dbg("%s - nonzero write bulk status received: %d",
> > +                 __FUNCTION__, urb->status);
> > +     }
>
> A switch statement might work a bit better here.  It will let you handle
> the different values you might get in a saner way.

This was taken from USB skeleton driver, and nothing more needs to be
added or changed for error handling, that I could think of now
anyways.


> > +/**
> > + *   ljusb_ioctl
> > + */
> > +static int ljusb_ioctl (struct inode *inode, struct file *file,
> > unsigned int cmd, unsigned long arg)
>
> New ioctls are pretty much frowned apon to add.  Do you _really_ need
> these?
>
> Can you use sysfs instead?
>
> > +     /* driver specific commands */
> > +     switch (cmd) {
> > +             /* Sets the timeout for usb_bulk_msg reads transfers in ms
> > from an integer
> > +              * argument.  If the timeout is set to zero, reads will wait
> > forever */
> > +             case IOCTL_LJ_SET_BULK_IN_TIMEOUT:
> > +                     data = (void __user *) arg;
> > +                     if (data == NULL)
> > +                             break;
> > +
> > +                     if (copy_from_user(&timeout, data, sizeof(int))) {
> > +                             retval = -EFAULT;
> > +                             break;
> > +                     }
> > +
> > +                     if(timeout < 0)
> > +                             retval = -EINVAL;
> > +                     else
> > +                             dev->bulk_in_timeout = timeout;
> > +
> > +                     break;
>
> Is this really needed to be modified?

No this really isn't needed.  I'll take it out.


> > +             /* Gets the Product ID for the device */
> > +             case IOCTL_LJ_GET_PRODUCT_ID:
> > +                     retval = put_user(dev->udev->descriptor.idProduct,
> > +                                             (unsigned int __user *)arg);
> > +                     break;
>
> You can get this from sysfs or usbfs today.  Don't duplicate it please.

I didn't look at sysfs or usbfs.  I just needed a way to determine the
device from a device node in /dev from user space, and it seemed easy
to use ioctl.


>
> > +             /* Sets the bulk in endpoint for the next read from an
> > integer argument.
> > +              * There are two bulk endpoints, which are endpoints 0 and 1
> > when
> > +              * setting the integer argument. */
> > +             case IOCTL_LJ_SET_BULK_IN_ENDPOINT:
> > +                     data = (void __user *) arg;
> > +                     if (data == NULL)
> > +                             break;
> > +
> > +                     if (copy_from_user(&ep, data, sizeof(int))) {
> > +                             retval = -EFAULT;
> > +                             break;
> > +                     }
> > +
> > +                     if(ep > N_BULK_IN_ENDPOINTS || ep < 0)
> > +                             retval = -EINVAL;
> > +                     else
> > +                             dev->next_bulk_in_endpoint = ep;
> > +                     break;
>
> Why is this needed?

The devices have a stream mode which can only be read from the second
bulk in endpoint.  All other communications are done from the first
bulk in and bulk out endpoints, and I needed some way to indicate that
the the next read should be from second bulk in endpoint keeping in
mind that first bulk in endpoint can still be used.  Is there a better
way to do this?


Thanks,
David
