Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162485AbWLBTv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162485AbWLBTv0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 14:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759479AbWLBTv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 14:51:26 -0500
Received: from wx-out-0506.google.com ([66.249.82.226]:54455 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1758537AbWLBTvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 14:51:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MH917Rj2oDdNzIiJGwShJquiCWnFN2ia1q90JqKyD+oZsWqloIlhDsqcv8NL9449Ps6+5Svs+vpdTVvO5KDGz/9fmTqKSeiBASZsZ8iC/276mnuJT7qpXa/99277ClcDkQlYc95kqYoBvXpfppGuGv7Ql71F/yjJzhocVgB4uOA=
Message-ID: <571a92f0612021151r25849c81md2f44e29532c5c73@mail.gmail.com>
Date: Sat, 2 Dec 2006 12:51:23 -0700
From: "David Lopez" <dave.l.lopez@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: [PATCH] USB: add driver for LabJack USB DAQ devices
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20061202074825.GA15982@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <571a92f0612011237p35e00be5w832fafb3f824b97a@mail.gmail.com>
	 <20061201211801.GA448@kroah.com>
	 <571a92f0612011612w13409d7u792b5afc20cc3e98@mail.gmail.com>
	 <20061202074825.GA15982@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/06, Greg KH <greg@kroah.com> wrote:
> On Fri, Dec 01, 2006 at 05:12:56PM -0700, David Lopez wrote:
> > On 12/1/06, Greg KH <greg@kroah.com> wrote:
> > >On Fri, Dec 01, 2006 at 01:37:22PM -0700, David Lopez wrote:
> > >> From: David Lopez <dave.l.lopez@gmail.com>
> > >
> > >> +             /* Gets the Product ID for the device */
> > >> +             case IOCTL_LJ_GET_PRODUCT_ID:
> > >> +                     retval = put_user(dev->udev->descriptor.idProduct,
> > >> +                                             (unsigned int __user
> > >*)arg);
> > >> +                     break;
> > >
> > >You can get this from sysfs or usbfs today.  Don't duplicate it please.
> >
> > I didn't look at sysfs or usbfs.  I just needed a way to determine the
> > device from a device node in /dev from user space, and it seemed easy
> > to use ioctl.
>
> Ok, but as there are other ways to get this information, can you take it
> out please?

I'll take it out.


> > >> +             /* Sets the bulk in endpoint for the next read from an
> > >> integer argument.
> > >> +              * There are two bulk endpoints, which are endpoints 0 and
> > >1
> > >> when
> > >> +              * setting the integer argument. */
> > >> +             case IOCTL_LJ_SET_BULK_IN_ENDPOINT:
> > >> +                     data = (void __user *) arg;
> > >> +                     if (data == NULL)
> > >> +                             break;
> > >> +
> > >> +                     if (copy_from_user(&ep, data, sizeof(int))) {
> > >> +                             retval = -EFAULT;
> > >> +                             break;
> > >> +                     }
> > >> +
> > >> +                     if(ep > N_BULK_IN_ENDPOINTS || ep < 0)
> > >> +                             retval = -EINVAL;
> > >> +                     else
> > >> +                             dev->next_bulk_in_endpoint = ep;
> > >> +                     break;
> > >
> > >Why is this needed?
> >
> > The devices have a stream mode which can only be read from the second
> > bulk in endpoint.  All other communications are done from the first
> > bulk in and bulk out endpoints, and I needed some way to indicate that
> > the the next read should be from second bulk in endpoint keeping in
> > mind that first bulk in endpoint can still be used.  Is there a better
> > way to do this?
>
> Can you just create a new device node for the second endpoint?  That way
> your userspace tools don't have to toggle anything, and it might make
> things for users simpler.  Just use the second device node to read from
> the endpoint used for streaming.  Writing on it might not need to do
> anything (or you could tie the write into the single out endpoint,
> that's up to you.)
>
> Would that work?

To do this do I call usb_register_dev twice with different endpoint
info in the usb_ljusb struct that I pass in the probe function?
This could work, though it is preferred that the second node's
numbering is +1 of the first.  So for example, the first node for the
first set of endpoints would be ljusb0 and second endpoint would be
ljusb1.  Though now that I think about it a global mutex should help
with that.

Someone pointed out to me that there is the possibility of using the
libusb library as opposed to having a kernel driver, which would be
preferable.  I will need to test this library to see if it what I am
looking for and is stable enough, and if all goes well I might not
need to submit this kernel driver.


Thanks,
David
