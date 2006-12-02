Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161383AbWLBHsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161383AbWLBHsj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 02:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162069AbWLBHsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 02:48:39 -0500
Received: from ns1.suse.de ([195.135.220.2]:38112 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161383AbWLBHsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 02:48:38 -0500
Date: Fri, 1 Dec 2006 23:48:26 -0800
From: Greg KH <greg@kroah.com>
To: David Lopez <dave.l.lopez@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] USB: add driver for LabJack USB DAQ devices
Message-ID: <20061202074825.GA15982@kroah.com>
References: <571a92f0612011237p35e00be5w832fafb3f824b97a@mail.gmail.com> <20061201211801.GA448@kroah.com> <571a92f0612011612w13409d7u792b5afc20cc3e98@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <571a92f0612011612w13409d7u792b5afc20cc3e98@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 05:12:56PM -0700, David Lopez wrote:
> On 12/1/06, Greg KH <greg@kroah.com> wrote:
> >On Fri, Dec 01, 2006 at 01:37:22PM -0700, David Lopez wrote:
> >> From: David Lopez <dave.l.lopez@gmail.com>
> >
> 
> >The patch seems linewrapped, which doesn't make it easy to apply :(
> >
> >Can you resend this?
> 
> Sorry about that.  Is it ok to send the patch as an attachment?  It
> seems like gmail likes to linewrap plain text.  Also, when I resend
> the patch after a little fixing should I send it as a reply.

A plain text attachment should work.

> >> +             /* Gets the Product ID for the device */
> >> +             case IOCTL_LJ_GET_PRODUCT_ID:
> >> +                     retval = put_user(dev->udev->descriptor.idProduct,
> >> +                                             (unsigned int __user 
> >*)arg);
> >> +                     break;
> >
> >You can get this from sysfs or usbfs today.  Don't duplicate it please.
> 
> I didn't look at sysfs or usbfs.  I just needed a way to determine the
> device from a device node in /dev from user space, and it seemed easy
> to use ioctl.

Ok, but as there are other ways to get this information, can you take it
out please?

> >> +             /* Sets the bulk in endpoint for the next read from an
> >> integer argument.
> >> +              * There are two bulk endpoints, which are endpoints 0 and 
> >1
> >> when
> >> +              * setting the integer argument. */
> >> +             case IOCTL_LJ_SET_BULK_IN_ENDPOINT:
> >> +                     data = (void __user *) arg;
> >> +                     if (data == NULL)
> >> +                             break;
> >> +
> >> +                     if (copy_from_user(&ep, data, sizeof(int))) {
> >> +                             retval = -EFAULT;
> >> +                             break;
> >> +                     }
> >> +
> >> +                     if(ep > N_BULK_IN_ENDPOINTS || ep < 0)
> >> +                             retval = -EINVAL;
> >> +                     else
> >> +                             dev->next_bulk_in_endpoint = ep;
> >> +                     break;
> >
> >Why is this needed?
> 
> The devices have a stream mode which can only be read from the second
> bulk in endpoint.  All other communications are done from the first
> bulk in and bulk out endpoints, and I needed some way to indicate that
> the the next read should be from second bulk in endpoint keeping in
> mind that first bulk in endpoint can still be used.  Is there a better
> way to do this?

Can you just create a new device node for the second endpoint?  That way
your userspace tools don't have to toggle anything, and it might make
things for users simpler.  Just use the second device node to read from
the endpoint used for streaming.  Writing on it might not need to do
anything (or you could tie the write into the single out endpoint,
that's up to you.)

Would that work?

thanks,

greg k-h
