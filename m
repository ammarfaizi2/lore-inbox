Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266872AbUFYV47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266872AbUFYV47 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 17:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266871AbUFYV47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 17:56:59 -0400
Received: from fw-us-hou19.bmc.com ([198.207.223.240]:41865 "EHLO
	mangrove.bmc.com") by vger.kernel.org with ESMTP id S266872AbUFYV4o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 17:56:44 -0400
Message-ID: <F12B6443B4A38748AFA644D1F8EF3532147333@bos-ex-01.adprod.bmc.com>
From: "Makhlis, Lev" <Lev_Makhlis@bmc.com>
To: "'Andries Brouwer'" <aebr@win.tue.nl>,
       "Makhlis, Lev" <Lev_Makhlis@bmc.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [SYSVIPC] Change shm_tot from int to size_t
Date: Fri, 25 Jun 2004 16:56:32 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> On Fri, Jun 25, 2004 at 12:42:26PM -0500, Makhlis, Lev wrote:
> 
> > > Thirdly, shm_tot is transmitted to userspace (via the 
> SHM_INFO ioctl)
> > > as an unsigned long. If it is necessary to make it larger, then we
> > > must do something with this ioctl. For example, return -1 there
> > > in case the actual value does not fit in an unsigned long.
> > 
> > The SHM_INFO shmctl is actually how I found it in the first place.
> > But we have the same situation with many other values.  For example,
> > shm_ctlmax, shm_ctlall and shm_segsz can all potentially be 
> 64-bit wide
> > in the kernel and are exported into potentially 32-bit 
> userspace values.
> > We don't return -1 for any of those if they don't fit.  Is there a
> > special reason to do it in this case?
> 
> There is a good reason to do it always.
> If one truncates, then the result is always unreliable.
> If one replaces a too large value by -1, then any other value 
> is reliable.
> 

I've looked around and couldn't find anything that returns -1 as a value
(as opposed to returning an error) when the value won't fit in 32 bits.
Here's what I've found (assuming a 32-bit app in all cases):
* sys_statfs, which fails with EOVERFLOW if any of the values won't fit
* sys_sysinfo, which scales the values down up to a PAGE_SIZE factor,
and silently truncates them if they are still too large
* BLKGETSIZE ioctl, which fails with EFBIG if the kernel itself is 32-bit,
but silently truncates if the kernel is 64-bit
* BLKGETSIZE64 ioctl, which always silently truncates
* HDIO_GETGEO ioctl (.start is ulong), which always silently truncates
I'm sure there are some other examples...

What do you think about following the example of sys_statfs in sys_shmctl?
