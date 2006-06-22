Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbWFVO1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbWFVO1H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 10:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbWFVO0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 10:26:52 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:46476 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030277AbWFVO0g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 10:26:36 -0400
Date: Thu, 22 Jun 2006 07:27:10 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Jens Axboe <axboe@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Dave Miller <davem@redhat.com>
Subject: Re: Move struct file RCU handling into the slab allocator?
Message-ID: <20060622142710.GB1295@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <Pine.LNX.4.64.0606161246210.16400@schroedinger.engr.sgi.com> <20060617213704.GB5310@us.ibm.com> <Pine.LNX.4.64.0606211517160.22515@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606211517160.22515@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 03:36:10PM -0700, Christoph Lameter wrote:
> On Sat, 17 Jun 2006, Paul E. McKenney wrote:
> 
> > Careful performance testing is needed as well, the validity check does
> > appear to me to be pretty lightweight, but this stuff is a bit sensitive
> > to performance.
> 
> Jens has done some testing with another approach like this and found a 
> good increase in speed.

And I would be much more concerned if the change was in the single-threaded
fastpath in fget_light(), to be sure.  But getting a view of multi-threaded
performance of this particular patch for a variety of workloads is still
warranted.

> > Some one less than a philistine than I might argue that this should
> > go back to the original name of f_list.  ;-)
> 
> Did that in V2 of the patch.

Cool!

> > o	Not sure whether hfs_file_release()s check for zero f_count
> > 	still works, but am quite concerned.  HFS experts?
> > 
> > o	Ditto for hfsplus_file_release().  And for affs_file_release().
> 
> That is not a problem since the object has not been returned to the slab 
> yet so it cannot have been reused.

Good enough!

							Thanx, Paul

>                                    A problem could occur if one could
> now establish a new reference to the object while it has a zero count. 
> But if that would be possible then we would be already in trouble.
> 
> The RCU check is only used to guarantee that the object is not
> vanishing from under us while we increase the refcount if it was not 
> zero. Since it is zero in these cases that will never occur.
> 
> In order to generate a wrong alias situation the following needs to 
> happen:
> 
> process 1		process 2:
> 
> do table lookup
> 			free the filp structure (refcount becomes zero)
> 			modify table
> 			create a new filp structure (same address)
> 			increment counter to 1
> inc_if_nonzero
> (counter becomes two)
> 
> <now we have a wrong reference>
> 
> put_filp (reduce refcount)
> 
> Table lookup fails->fget fails.
> 
> 
