Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbVJSDd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVJSDd2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 23:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbVJSDd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 23:33:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35773 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751495AbVJSDd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 23:33:27 -0400
Date: Tue, 18 Oct 2005 20:33:20 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Christopher Li <usb-devel@chrisli.org>
Cc: greg@kroah.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: usb: Patch for USBDEVFS_IOCTL from 32-bit programs
Message-Id: <20051018203320.179f4c4c.zaitcev@redhat.com>
In-Reply-To: <20051018150533.GB21786@64m.dyndns.org>
References: <20051017181554.77d0d45d.zaitcev@redhat.com>
	<20051018171333.GA29504@kroah.com>
	<20051018150533.GB21786@64m.dyndns.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2005 11:05:33 -0400, Christopher Li <usb-devel@chrisli.org> wrote:
> On Tue, Oct 18, 2005 at 10:13:33AM -0700, Greg KH wrote:

> I am a little nervous no check have been done to what ioctl it is
> passing. Most of the case you don't need to convert the buffer, but
> what if there is some ioctl need to do something special.

You do not have to be nervous, because USB ioctls are not unstructured.
These ioctls do not receive __user pointers, unsigned longs, or things
freely interpreted. They are defined to receive one buffer, and they
are not expected to perform any copy_from_user/copy_to_user.

The struct file_operations has ioctl which looks like this:
        int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
The unsigned long here is often a pointer to user buffer.

However, in USB case, struct usb_driver has ioctl like this:
        int (*ioctl) (struct usb_interface *intf, unsigned int code, void *buf);
The *buf is not passed from user mode. It's an honest to goodness
kmalloc'ed buffer.

> On the safe side, I am expecting a big switch to list all the ioctl
> we known can safely pass, can grow the list when needed.

>From the above it should be obvious why such checking is entirely
unnecessary for the case of USB.

To be sure, one can write a driver which looks _inside_ the passed
*buf, and interpret the contents as a bunch of user pointers, in a
misguided attempt to create a DIY s/g capability, for instance.
If such a thing happens, we'd only have to identify the programmers
and impale them on a pole, then feed their intestines to crows.
That ought to take care of the problem without any checking lists.

-- Pete
