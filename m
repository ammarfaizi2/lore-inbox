Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312581AbSCVAWg>; Thu, 21 Mar 2002 19:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312577AbSCVAU3>; Thu, 21 Mar 2002 19:20:29 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:61231 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S312575AbSCVAUN>; Thu, 21 Mar 2002 19:20:13 -0500
Date: Thu, 21 Mar 2002 19:19:38 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Douglas Gilbert <dougg@torque.net>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2 questions about SCSI initialization
Message-ID: <20020321191938.B1054@devserv.devel.redhat.com>
In-Reply-To: <20020321000553.A6704@devserv.devel.redhat.com> <3C99E6C7.34F05AE7@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Thu, 21 Mar 2002 08:57:27 -0500
> From: Douglas Gilbert <dougg@torque.net>

> > #1: Why does scsi_build_commandblocks() allocate memory with
> > GFP_ATOMIC? It's not called from an interrupt or from a swap I/O
> > path as far as I can see.
> 
> There has long been a preference in the scsi subsystem
> for using its own memory management ( scsi_malloc() )
> or the most conservative mm calls. GFP_ATOMIC may well
> be overkill in scsi_build_commandblocks(). However it
> might be wise to check that the calling context is indeed
> user_space since this can be called from all subsystems 
> that have a scsi pseudo device driver (e.g. ide-scsi, 
> usb-storage, 1394/sbp2, ...).

Thanks for the explanation. I've set out to prove that it is called
from a user context only. If that fails, I'll come up with something
else, perhaps in_interrupt() check, or an extra parameter.
 
> > #2: What does  if (GET_USE_COUNT(tpnt->module) != 0)  do in
> > scsi_unregister_device? The circomstances are truly bizzare:
> > a) the error code is NEVER used
> > b) it can be called either from module unload.
> > I would like to kill that check.
> 
> Another badly named function since it is unregistering
> in upper level driver (e.g. sd). That "if" is to check
> if there are open file descriptors (or some other
> reason **) on the driver in question. That seems to be
> a sensible check. Whether it can every happen in that
> context, I'm not sure.
> 
> ** The sg driver purposely holds its USE_COUNT > 0 even
> when all its file descriptors are closed iff there are
> outstanding commands for which the response has not
> yet arrived. [If this is not done, then a control-C on
> something like cdrecord followed by "rmmod sg" may
> cause an oops, especially during "fixating" mode.]

I think the above cannot apply, because sys_delete_module()
does this:

                spin_lock(&unload_lock);
                if (!__MOD_IN_USE(mod)) {
                        mod->flags |= MOD_DELETED;
                        spin_unlock(&unload_lock);
                        free_module(mod, 0);
                        error = 0;
                } else {
                        spin_unlock(&unload_lock);
                }

There's no way even to get near that check if the module
count is nonzero (well, minus "can_unload()", which is not 
used by sg, or anyone for that matter).

One more thing that was skipped in the header of my mail
was that the current code in scsi_register_device_module near
out_of_space flag simply DOES NOT WORK. There's an oops for
the show. It is possible to de-factor the scsi_unregister_device
into checking and non-checking version (perhaps one calling
the other), but why? So far it is proven that the check does
nothing (either it is not reached when files are open, or else
it is guaranteed to fail). This is why I suggest to remove
the check.

-- Pete
