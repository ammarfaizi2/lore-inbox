Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbUASR4X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 12:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbUASR4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 12:56:23 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:24016 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S261190AbUASR4P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 12:56:15 -0500
Message-ID: <400C1C19.4090502@pacbell.net>
Date: Mon, 19 Jan 2004 10:04:09 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Martin F Krafft <krafft@ailab.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: failing to force-claim USB interface
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am trying to make use of the usbfs USBDEVFS_DISCONNECT ioctl, and
> I am failing.

Appended, see a snippet of code which worked reliably way back on
the original 2.4 patch.  Maybe you tripped on the precondition?
Or maybe this is just broken so far in 2.6.

A fair amount of usbfs code is at least slightly broken in 2.6;
some usbcore driver model changes are still needed in the area
of this particular ioctl.  (Which got mangled more than most
during its evolution.)  Was this with a 2.6.1 kernel?

I'm thinking this kind of thing ought to be generically doable
with sysfs, maybe with symlink/unlink syscalls between device
and driver nodes.

- Dave


     if (ioctl (fd, USBDEVFS_CLAIMINTERFACE, &ifno) < 0) {
#ifdef  USBDEVFS_DISCONNECT
         int                             saved_errno = errno;
         struct usbdevfs_ioctl           command;
         int                             retval;

         /*
          * maybe we need to boot a kernel driver off before we
          * can bind to this.  a "polite" unbind might be nice;
          * for now we expect apps to adopt a reasonble policy,
          * checking if it's claimed already (when it matters).
          */
         if (saved_errno != EBUSY)
             return -errno;
         command.ifno = ifno;
         command.ioctl_code = USBDEVFS_DISCONNECT;
         command.data = 0;
         retval = ioctl (fd, USBDEVFS_IOCTL, &command);
         if (retval < 0)
             return -saved_errno;

         if (ioctl (fd, USBDEVFS_CLAIMINTERFACE, &ifno) < 0)
             return -errno;
#else
         return -errno;
#endif
     }
     return 0;



