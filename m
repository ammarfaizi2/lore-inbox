Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbVGLA7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVGLA7j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 20:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVGLA63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 20:58:29 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:2212 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261804AbVGLA4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 20:56:48 -0400
Date: Mon, 11 Jul 2005 17:56:33 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, mochel@digitalimplant.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Use device_for_each_child() to unregister devices in scsi_remove_target().
Message-ID: <20050712005633.GA453@us.ibm.com>
References: <11193083662356@kroah.com> <11193083663269@kroah.com> <20050706003850.GA11542@us.ibm.com> <20050712002011.GA9331@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050712002011.GA9331@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 05:20:12PM -0700, Greg KH wrote:
> On Tue, Jul 05, 2005 at 05:38:50PM -0700, Patrick Mansfield wrote:
> > Hi Greg / Patrick -
> > 
> > I'm getting an oops with current (pulled today) 2.6 git, the
> > device_for_each_child() does not seem to be deletion safe.
> > 
> > We hold the klist in place via the n_ref, but the kobj (in the struct
> > device for the struct scsi_target) containing it is freed when the
> > kref->refcount goes to zero.
> 
> But we grab a reference to that object right before we call
> device_for_each_child(), right?  Or am I missing something here?

No, we get another reference on the passed in dev argument (in this
failing case, it is for an FC's rport), not its children (scsi_target)
that we want to iterate over.

If all children (scsi_targets) are removed, then the put in
scsi_remove_target() would (or could) set the rport refcount to zero and
it would be deleted. But the scsi_target would already be gone.

Cases that are not affected are passed a scsi_target:
scsi_is_target_device(dev) is true and we won't even call
device_for_each_child().

Adding another get/put in __remove_child() does *not* help either, as it
is the code within device_for_each_child() that needs another get/put of
the kref instead of a get/put on the klist (well its n_ref); and if you do
that, I don't see how the locking can be done correctly.

I thought we had some semaphores in scsi to protect calls to
scsi_remove_target(), but I only see those for scsi_device scan/removal
(the shost->scan_mutex).

It looks like scsi should not allow removal and additions to happen at the
same time on any scsi_target (and adding up/down on shost->scan_mutex
won't fix this problem).

-- Patrick Mansfield
