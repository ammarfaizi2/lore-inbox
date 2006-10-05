Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWJENRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWJENRf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 09:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWJENRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 09:17:35 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:12769 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751461AbWJENRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 09:17:34 -0400
Date: Thu, 5 Oct 2006 15:16:23 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ashok Raj <ashok.raj@intel.com>, Nathan Lynch <nathanl@austin.ibm.com>
Subject: Re: [PATCH] drivers/base: error handling fixes
Message-ID: <20061005131623.GC6920@osiris.boeblingen.de.ibm.com>
References: <20061004130554.GA25974@havoc.gtf.org> <20061004172434.1a2ddb71@gondolin.boeblingen.de.ibm.com> <20061005081705.GA6920@osiris.boeblingen.de.ibm.com> <4524E983.6010208@garzik.org> <20061005124848.GB6920@osiris.boeblingen.de.ibm.com> <45250161.4060002@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45250161.4060002@garzik.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>If someone wants to provide a better fix, let's see the patch...
> >If sysfs_remove_group() would also work for non-created (-existent) groups
> >then the patch below would work. Unfortunately that is not the case. So one
> >would have to remember if sysfs_create_group() was done and succeeded before
> >calling sysfs_remove_group()...
> >There must be an easier way.
> >diff --git a/drivers/base/topology.c b/drivers/base/topology.c
> >index 3ef9d51..d0056c3 100644
> >--- a/drivers/base/topology.c
> >+++ b/drivers/base/topology.c
> 
> ACK

Ah, you probably got me wrong. The patch doesn't work, because of the
sysfs_remove_group() stuff. That's why there is no Signed-off-by:...

What _could_ happen with this patch applied: some code fails on
CPU_UP_PREPARE and then all notifiers get called with CPU_UP_CANCELLED.

That would cause the call of topology_remove_dev(sys_dev) and therefore
sysfs_remove_group(&sys_dev->kobj, &topology_attr_group) which will crash,
because sysfs_create_group() wasn't even called.
To fix this one has to remember if sysfs_create_group() succeeded or was
even called. That would be a per-cpu array. Now, I think it's just
overkill to introduce a per-cpu array for error-checking.

IMHO it would make sense to change sysfs_remove_group() so it will survive
if being asked to remove groups that don't exist.
