Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266819AbUFYRnC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266819AbUFYRnC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 13:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266812AbUFYRnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 13:43:02 -0400
Received: from fw-us-hou19.bmc.com ([198.207.223.240]:44790 "EHLO
	mangrove.bmc.com") by vger.kernel.org with ESMTP id S266819AbUFYRmf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 13:42:35 -0400
Message-ID: <F12B6443B4A38748AFA644D1F8EF3532147332@bos-ex-01.adprod.bmc.com>
From: "Makhlis, Lev" <Lev_Makhlis@bmc.com>
To: "'Andries Brouwer'" <aebr@win.tue.nl>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [SYSVIPC] Change shm_tot from int to size_t
Date: Fri, 25 Jun 2004 12:42:26 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andries Brouwer wrote:
> On Fri, Jun 25, 2004 at 10:41:13AM -0500, Makhlis, Lev wrote:
> 
> > I see that shm_tot (the total number of pages in shm segments) in
> > ipc/shm.c is defined as int, even though its max value 
> (shmall) is size_t.
> > 
> > Admittedly, it only matters for systems with >8TB memory, 
> but shouldn't
> > shm_tot also be size_t?  The attached patch makes it so.
> 
> > -static int shm_tot; /* total number of shared memory pages */
> > +static size_t shm_tot; /* total number of shared memory pages */
> 
> First, please avoid attachments.
> 
> Secondly, this makes shm_tot unsigned. Have you checked all places
> where it occurs in an inequality to see whether the semantics did
> change? (It looks OK.)

Yes -- it looked to me like the semantics would be more correct, since
currently, "if (shm_tot + numpages >= shm_ctlall)" will break when
shm_tot wraps around MAX_INT and becomes negative.

> 
> Thirdly, shm_tot is transmitted to userspace (via the SHM_INFO ioctl)
> as an unsigned long. If it is necessary to make it larger, then we
> must do something with this ioctl. For example, return -1 there
> in case the actual value does not fit in an unsigned long.

The SHM_INFO shmctl is actually how I found it in the first place.
But we have the same situation with many other values.  For example,
shm_ctlmax, shm_ctlall and shm_segsz can all potentially be 64-bit wide
in the kernel and are exported into potentially 32-bit userspace values.
We don't return -1 for any of those if they don't fit.  Is there a
special reason to do it in this case?
