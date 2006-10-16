Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422850AbWJPTYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422850AbWJPTYJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 15:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422854AbWJPTYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 15:24:09 -0400
Received: from server99.tchmachines.com ([72.9.230.178]:3800 "EHLO
	server99.tchmachines.com") by vger.kernel.org with ESMTP
	id S1422850AbWJPTYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 15:24:08 -0400
Date: Mon, 16 Oct 2006 12:26:15 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>,
       Alok Kataria <alok.kataria@calsoftinc.com>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       "Benzi Galili (Benzi@ScaleMP.com)" <benzi@scalemp.com>
Subject: Re: [patch] slab: Fix a cpu hotplug race condition while tuning slab cpu caches
Message-ID: <20061016192615.GA3746@localhost.localdomain>
References: <20061016085439.GA6651@localhost.localdomain> <20061016111511.3901be27.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061016111511.3901be27.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 11:15:11AM -0700, Andrew Morton wrote:
> On Mon, 16 Oct 2006 01:54:39 -0700
> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> 
> The problem is obvious: we have some data (the array caches) and we have a
> data structure which is used to look up that data (cpu_online_map).  But
> we're releasing the lock while these two things are in an inconsistent
> state.
> 
> So you could have fixed this by taking cache_chain_mutex in CPU_UP_PREPARE
> and releasing it in CPU_ONLINE and CPU_UP_CANCELED.

Hmm, yes. I suppose so. Maybe we can do away with other uses of
lock_cpu_hotplug() in slab.c as well then!  Will give it a shot. Slab
locking might look uglier than what it already is though no?

> 
> >  	list_for_each_entry(cachep, &cache_chain, next) {
> > @@ -4087,6 +4088,7 @@ ssize_t slabinfo_write(struct file *file
> >  		}
> >  	}
> >  	mutex_unlock(&cache_chain_mutex);
> > +	unlock_cpu_hotplug();
> >  	if (res >= 0)
> >  		res = count;
> >  	return res;
> 
> Given that this lock_cpu_hotplug() happens at a high level I guess it'll
> avoid the usual lock_cpu_hotplug() horrors and we can live with it.  I
> assume lockdep was enabled when you were testing this?

Not when I tested it.  I just retested with lockdep on and things seemed 
fine on a SMP.

Thanks,
Kiran
