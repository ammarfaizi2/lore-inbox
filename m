Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129070AbQJ0NwE>; Fri, 27 Oct 2000 09:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129095AbQJ0Nvy>; Fri, 27 Oct 2000 09:51:54 -0400
Received: from [64.64.109.142] ([64.64.109.142]:32018 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S129070AbQJ0Nvl>; Fri, 27 Oct 2000 09:51:41 -0400
Message-ID: <39F98806.721BBBC4@didntduck.org>
Date: Fri, 27 Oct 2000 09:49:58 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PROPOSED PATCH] ATM refcount + firestream
In-Reply-To: <Pine.LNX.4.21.0010270945510.13233-200000@panoramix.bitwizard.nl> <39F96BE1.B9C97C20@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Patrick van de Lageweg wrote:
> >
> > Hi all,
> >
> > Here is the second try for the atm refcount problem. I've made made
> > several enhancement over the previos patch. Can you take a look at it if
> > I've missed anything? (This time it also includes the driver for the
> > firestream card. That's why the patch is so large. It's gziped and
> > uuencoded).

[snip]

> The other thing you need to watch out for is atmdev_ops.ioctl().
> Can this be called when the device is not open?
>
> In other words, can atmdev_ops.ioctl() be called prior to
> atmdev_ops.open()?  In more other words, can ioctl() be
> called after close()?
> 
> If so then the above patch is not sufficient - it only increments
> the module use count on the open() path.
> 
> If this is the case then you're fairly severely screwed.  This is
> because the atm_dev handling has the same design flaw as the
> netdevice handling: the logical place to inc/dec the module
> refcount is within atm_dev_[de]register().  But this doesn't
> work because you can never _get_ to the deregister point
> through sys_delete_module() to drop the refcount.

The fact of the matter is that we seriously abuse ioctl() to provide an
interface to configuring network devices.  You are supposed to have a
valid file descriptor to do an ioctl, but in the network config cases,
that fd doesn't have anything to do with the network device (look at the
special cases in net/*/af_*.c).  Thus our strategy of managing the
module refcount on open/close gets sidestepped.

Currently, the network devices have two states: registered, and open. 
Only in the open case is the module referenced.  What should be done is
add a third state in the middle, configured, which also holds a
reference.  Then the userspace configuration tools can explicitly
unconfigure the device in order to release the reference and unload the
module.

In the mean time, we could wrap refcount inc/dec around the calls to
dev->set_config() and dev->do_ioctl() in dev_ifsioc().  This fixes the
potential oops but still perpetuates the abuse of ioctl though.  I would
rather see a new syscall or a misc character device added to provide the
configuration interface.

--
					Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
