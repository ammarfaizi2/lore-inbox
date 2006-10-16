Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161025AbWJPTvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbWJPTvy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 15:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWJPTvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 15:51:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35538 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750775AbWJPTvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 15:51:53 -0400
Date: Mon, 16 Oct 2006 12:48:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>,
       Alok Kataria <alok.kataria@calsoftinc.com>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       "Benzi Galili (Benzi@ScaleMP.com)" <benzi@scalemp.com>
Subject: Re: [patch] slab: Fix a cpu hotplug race condition while tuning
 slab cpu caches
Message-Id: <20061016124808.20123a01.akpm@osdl.org>
In-Reply-To: <20061016192615.GA3746@localhost.localdomain>
References: <20061016085439.GA6651@localhost.localdomain>
	<20061016111511.3901be27.akpm@osdl.org>
	<20061016192615.GA3746@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006 12:26:15 -0700
Ravikiran G Thirumalai <kiran@scalex86.org> wrote:

> On Mon, Oct 16, 2006 at 11:15:11AM -0700, Andrew Morton wrote:
> > On Mon, 16 Oct 2006 01:54:39 -0700
> > Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> > 
> > The problem is obvious: we have some data (the array caches) and we have a
> > data structure which is used to look up that data (cpu_online_map).  But
> > we're releasing the lock while these two things are in an inconsistent
> > state.
> > 
> > So you could have fixed this by taking cache_chain_mutex in CPU_UP_PREPARE
> > and releasing it in CPU_ONLINE and CPU_UP_CANCELED.
> 
> Hmm, yes. I suppose so. Maybe we can do away with other uses of
> lock_cpu_hotplug() in slab.c as well then!

Yes, we can.

>  Will give it a shot. Slab
> locking might look uglier than what it already is though no?

I suspect it will improve - all the calls to lock_cpu_hotplug() go away.

But it gets conceptually more complex: we're now holding cache_chain_mutex
across some or all of the _other_ callbacks which are registered on the cpu
notifier list.  And they could be anything at all, and in any order.

But as long as things are well-designed and layered and interactions are
minimised (all things we like to achieve) then we're OK.  But it's a worry.
Fortunately lockdep helps a lot here.

> > 
> > >  	list_for_each_entry(cachep, &cache_chain, next) {
> > > @@ -4087,6 +4088,7 @@ ssize_t slabinfo_write(struct file *file
> > >  		}
> > >  	}
> > >  	mutex_unlock(&cache_chain_mutex);
> > > +	unlock_cpu_hotplug();
> > >  	if (res >= 0)
> > >  		res = count;
> > >  	return res;
> > 
> > Given that this lock_cpu_hotplug() happens at a high level I guess it'll
> > avoid the usual lock_cpu_hotplug() horrors and we can live with it.  I
> > assume lockdep was enabled when you were testing this?
> 
> Not when I tested it.  I just retested with lockdep on and things seemed 
> fine on a SMP.

Great, thanks.  Please ensure that lockdep is used when testing the kernel.
 Also preempt, DEBUG_SLAB, DEBUG_SPINLOCK_SLEEP and various other things. 
I guess the list in Documentation/SubmitChecklist is the definitive one.
