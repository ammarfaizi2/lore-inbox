Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263237AbUCNBGA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 20:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263239AbUCNBGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 20:06:00 -0500
Received: from oliv.bezeqint.net ([192.115.104.12]:491 "EHLO oliv.bezeqint.net")
	by vger.kernel.org with ESMTP id S263237AbUCNBF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 20:05:57 -0500
Date: Sun, 14 Mar 2004 03:05:09 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
Message-ID: <20040314010508.GL5960@luna.mooo.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <20040311141703.GE3053@luna.mooo.com> <1079198671.4446.3.camel@laptop.fenrus.com> <4053624D.6080806@BitWagon.com> <20040313193852.GC12292@devserv.devel.redhat.com> <20040313221418.GF5960@luna.mooo.com> <1079217159.4915.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079217159.4915.0.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 11:32:39PM +0100, Arjan van de Ven wrote:
> On Sat, 2004-03-13 at 23:14, Micha Feigin wrote:
> > On Sat, Mar 13, 2004 at 08:38:52PM +0100, Arjan van de Ven wrote:
> > > On Sat, Mar 13, 2004 at 11:34:37AM -0800, John Reiser wrote:
> > > > Arjan van de Ven wrote:
> > > > >On Thu, 2004-03-11 at 15:17, Micha Feigin wrote:
> > > > >
> > > > >>Is it possible to find out what the kernel's notion of HZ is from user
> > > > >>space?
> > > > >>It seem to change from system to system and between 2.4 (100 on i386)
> > > > >>to 2.6 (1000 on i386).
> > > > >
> > > > >
> > > > >if you can see 1000 from userspace that is a bad kernel bug; can you say
> > > > >where you find something in units of 1000 ?
> > > > 
> > > > create_elf_tables() in fs/binfmt_elf.c tells every ELF execve():
> > > >         NEW_AUX_ENT(AT_CLKTCK, CLOCKS_PER_SEC);
> > > > which can be found by crawling through the stack above the pointer
> > > > to the last environment variable.
> > > 
> > > Ugh that should say 100 on x86....
> > > but..
> > > param.h:# define USER_HZ        100             /* .. some user interfaces are in "ticks" */
> > > param.h:# define CLOCKS_PER_SEC (USER_HZ)       /* like times() */
> > > .....
> > > that looks like 100 to me.
> > > 
> > 
> > When dealing with bdflush and a few other interfaces the values need to
> > be in jiffies which requires knowledge of the kernels notion of HZ not
> > userspace.
> 
> Wrong. Any such interface is supposed to convert automatically. Any
> interface you can find that doesn't should be reported as a serious bug!
> 

Like I said, look at bdflush in 2.4 (this was fixed with the changed 2.6
interface) and xfs proc interface in both 2.4 and 2.6.
In light of your post then there is a serious bug.

For example for bdflush age_buffer field (true for the other used fields
also), no conversion:
	bh->b_flushtime = jiffies + bdf_prm.b_un.age_buffer;

For xfs flush interval:
if (pbd_active == 1) {
			mod_timer(&pb_daemon_timer,
				  jiffies + pb_params.flush_interval.val);
			interruptible_sleep_on(&pbd_waitq);
		}

xfs should be converted to centisecs, bdflush should also be converted
to centisecs, or the interface from 2.6 should somehow be ported to
exist in parallel to the 2.4 one.

I don't mind making a patch, which approach should be used?
