Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267575AbTAQQPj>; Fri, 17 Jan 2003 11:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267581AbTAQQPj>; Fri, 17 Jan 2003 11:15:39 -0500
Received: from air-2.osdl.org ([65.172.181.6]:29675 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267575AbTAQQPg>;
	Fri, 17 Jan 2003 11:15:36 -0500
Subject: Re: lots of calls to __write/read_lock_failed
From: Stephen Hemminger <shemminger@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andreas Schwab <schwab@suse.de>
In-Reply-To: <20030117161701.GI17986@dualathlon.random>
References: <3E263285.2000204@us.ibm.com>
	 <20030116044600.GN919@holomorphy.com> <20030116065940.GA4801@in.ibm.com>
	 <20030117161701.GI17986@dualathlon.random>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1042820659.3505.5.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 17 Jan 2003 08:24:19 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your analysis looks right, also, look at the ordering of the updates of
pre/post.  They should match the vsyscall version on x86.

On Fri, 2003-01-17 at 08:17, Andrea Arcangeli wrote:
> Hello,
> 
> On Thu, Jan 16, 2003 at 12:29:41PM +0530, Dipankar Sarma wrote:
> > On Thu, Jan 16, 2003 at 04:47:30AM +0000, William Lee Irwin III wrote:
> > > On Wed, Jan 15, 2003 at 08:18:13PM -0800, Dave Hansen wrote:
> > > >  file_table:_raw_read_lock() 3300000
> > > >  Call Trace:
> > > >   [<c0152469>] fget+0x9d/0xa0
> > > >   [<c0152b27>] sys_fsync+0x21/0xbe
> > > >   [<c0151b53>] sys_writev+0x47/0x56
> > > >   [<c010931f>] syscall_call+0x7/0xb
> > > 
> > > read_lock(&file->files_lock);
> > 
> > You mean read_lock(&files->file_lock); :)
> > 
> > Dave, does your webserver benchmark clone() tasks with CLONE_FILES ? Unless
> > the fd table is shared, can't see why there would be contention on this.
> > If it is indeed necessary to share fd table, then there is a somewhat
> > unmaintained lockfree fget() patch (files_struct_rcu) that you might want
> > to try.
> > 
> > > 
> > > On Wed, Jan 15, 2003 at 08:18:13PM -0800, Dave Hansen wrote:
> > > > time:_raw_write_lock() 1350000
> > > > Call Trace:
> > > >  [<c010f321>] timer_interrupt+0x99/0x9c
> > > >  [<c010b150>] handle_IRQ_event+0x38/0x5c
> > > 
> > > read_lock_irqsave(&xtime_lock, flags)
> > > or
> > > write_lock_irq(&xtime_lock);
> > 
> > ISTR a patch from Stephen Hemminger at OSDL that used Andrea's
> > sequence number trick based rwlock (frlock) to implement do_gettimeofday.
> 
> I'm merging a version of Stephen's patch right now (the starvation of
> the read locks that we rely when we don't clear irqs in read_locks that
> can run from irqs too seems to hurt too much on some hardware/workload
> combination to a point that it even lose ticks with the irq stuck, and
> the frlock is the most efficient and scalable possible locking design
> for gettimeofday and it will solve the starvation too, very good patch
> Stephen).
> 
> While merging it I found a problem, not sure if it helps for your crash
> but while checking it I found a quite fatal bug here:
> 
> +static inline unsigned fr_read_begin(frlock_t *rw)
> +{
> +       rmb();
> +       return rw->post_sequence;
> +
> +}
> 
> the rmb() must be placed after (not before) reading the post_sequence.
> The above bug could trigger on x86 too because it should even allow the
> compiler to reorder stuff and the x86 can read speculative even if the
> compiler doesn't reorder. This at the very least can explain screwed
> timing results with such patch applied.
> 
> Andrea
-- 
Stephen Hemminger <shemminger@osdl.org>
Open Source Devlopment Lab

