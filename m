Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267361AbTBFX7a>; Thu, 6 Feb 2003 18:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267582AbTBFX7a>; Thu, 6 Feb 2003 18:59:30 -0500
Received: from dp.samba.org ([66.70.73.150]:52899 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267361AbTBFX72>;
	Thu, 6 Feb 2003 18:59:28 -0500
Date: Fri, 7 Feb 2003 11:07:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: jt@hpl.hp.com
Cc: Jouni Malinen <jkmaline@cc.hut.fi>, joshk@triplehelix.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5 kernel + hostap_cs + X11 = scheduling while atomic
Message-ID: <20030207000733.GD4905@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	jt@hpl.hp.com, Jouni Malinen <jkmaline@cc.hut.fi>,
	joshk@triplehelix.org, linux-kernel@vger.kernel.org
References: <20030205073637.GA10725@saltbox.argot.org> <20030206052849.GA1540@jm.kir.nu> <20030206172759.GC17785@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030206172759.GC17785@bougret.hpl.hp.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2003 at 09:27:59AM -0800, Jean Tourrilhes wrote:
> On Wed, Feb 05, 2003 at 09:28:49PM -0800, Jouni Malinen wrote:
> > On Tue, Feb 04, 2003 at 11:36:37PM -0800, Joshua Kwan wrote:
> > 
> > > However, a combination of running said kernel, hostap_cs, and X11 produces
> > > this nasty infinite string of errors:
> > > 
> > > bad: scheduling while atomic!
> > > Call Trace:
> > 
> > >  [<d2948a30>] hfa384x_get_rid+0x36/0x2d6b7606 [hostap_cs]
> > 
> > That will sleep, so it better not be called while in interrupt context
> > or apparently also, while atomic with preemptive kernels(?).
> > 
> > >  [<d29388b5>] hostap_get_wireless_stats+0xa6/0x2d6c77f1 [hostap]
> > 
> > That's the dev->get_wireless_stats handler. I have assumed that it is
> > allowed to sleep there, but apparently that is not the case with Linux
> > 2.5.x (at least with CONFIG_PREEMPT). I added a workaround for this into
> > Host AP CVS, but you will not get signal quality statistics in that
> > case. I'll do a proper fix if that function is indeed not allowed to
> > sleep (e.g., by collecting the statistics before and just copying the
> > values here).
> > 
> > Jean, do you have a comment on this? This happens, e.g., when executing
> > 'cat /proc/net/wireless':
> > 
> > >  [<c0168f45>] seq_printf+0x45/0x56
> > >  [<c02bd9b6>] wireless_seq_show+0xd6/0xf7
> > >  [<c0141dd5>] do_mmap_pgoff+0x40e/0x6dc
> > >  [<c0168a56>] seq_read+0x1c9/0x2ee
> > >  [<c014d20f>] vfs_read+0xbc/0x127
> > >  [<c014d496>] sys_read+0x3e/0x55
> > >  [<c01093cb>] syscall_call+0x7/0xb
> 
> 	I had an argument with David a few month ago on the subject
> (you can ask him how it ended). I believe that it's not a good
> practice to "schedule" in any of the ioctl, and that seem to also
> apply to get_wireless_stats. On the other hand, you can perfectly take
> a spinlock, disable irq and do your job.

Yes, this is because most of the device ioctl() calls are made with
one or more spinlocks held by the network layer.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
