Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289018AbSBSAGZ>; Mon, 18 Feb 2002 19:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289036AbSBSAGM>; Mon, 18 Feb 2002 19:06:12 -0500
Received: from unused ([66.187.233.200]:27223 "EHLO devserv.devel.redhat.com")
	by vger.kernel.org with ESMTP id <S289018AbSBSAEL>;
	Mon, 18 Feb 2002 19:04:11 -0500
Date: Mon, 18 Feb 2002 19:04:07 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Peter Wong <wpeter@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Encountered a Null Pointer Problem on the SCSI Layer
Message-ID: <20020218190407.A16616@devserv.devel.redhat.com>
In-Reply-To: <OFC7A42817.7DD2C3FB-ON85256B64.00725D00@raleigh.ibm.com> <200202182301.AAA23425@webserver.ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200202182301.AAA23425@webserver.ithnet.com>; from skraw@ithnet.com on Tue, Feb 19, 2002 at 12:01:39AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Tue, 19 Feb 2002 00:01:39 +0100
> From: Stephan von Krawczynski <skraw@ithnet.com>

> Are you 100% sure, that there is no case where                        
> dpnt==NULL? Because if there is such a possibility, your patch will   
> blow up.                                                              

If there is such a possibility, everything will blow up.

Please bear with me while I am ranting at your expense, but
your example is very educational.

It seems to me that many people consider that putting a check
for NULL in front of every pointer dereference is an answer
to everything, including a missing understanding of the code.
It actually is not the case, IMHO. In well written code,
checks for NULL are not introduced to prevent oopses locally.
Instead, they implement a functionality, according to the
master plan. To distinguish these two conditions, mentally
consider a replacement of the check with something more descriptive.
When my eye sees a code that does this:

	if (p->foo == NULL)
		return -EINVAL;

my mind sees either this:

	/*
	 * Our brains are too small to wrap arouund this module,
	 * and we saw an oops somewhere. Let's plug it with
	 * a check and pray that nobody will notice.
	 */
	if (p->foo == NULL)
		return -EINVAL;

or this:

	if (device_is_attached(dpnt))
		return -EINVAL;		/* XXX TODO: -ENODEV, not -EINVAL */

The code may be conductive to such interpretation by the mind,
or it may be not. In latter case we do what is called "a cleanup".

Often, the interpretation can only be done by looking at the
code as a whole, but this particular patch is nearly obvious
by itself:

> >       dpnt = &rscsi_disks[target];                                  
> > -     if (!dpnt)                                                    
> > +     if (!dpnt->device)                                            
> >             return NULL;      /* No such device */                  
> >       return &dpnt->device->request_queue;                          

The dpnt may be null ONLY if we do I/O to the first partition
of a first disk. Is anything special about that case?
I think not. Also, look at the comment. Obviously, the if() was
meant for something other than a corner case of partition zero.
It seems probable that the data layout was modified
but the check was forgotten.

-- Pete
