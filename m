Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317369AbSGOJSf>; Mon, 15 Jul 2002 05:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317396AbSGOJSe>; Mon, 15 Jul 2002 05:18:34 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:59641 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317369AbSGOJSe>; Mon, 15 Jul 2002 05:18:34 -0400
Date: Mon, 15 Jul 2002 14:55:21 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Matthew Wilcox <willy@debian.org>,
       Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] BH removal text
Message-ID: <20020715145521.C15298@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20020701050555.F29045@parcelfarce.linux.theplanet.co.uk> <20020714010506.GW23693@holomorphy.com> <20020714102219.A9412@in.ibm.com> <20020714101730.GZ23693@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020714101730.GZ23693@holomorphy.com>; from wli@holomorphy.com on Sun, Jul 14, 2002 at 03:17:30AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 03:17:30AM -0700, William Lee Irwin III wrote:
> On Sun, Jul 14, 2002 at 10:22:19AM +0530, Dipankar Sarma wrote:
> > Even if you replace timemr_bh() with a tasklet, you still need
> > to take the global_bh_lock to ensure that timers don't race with
> > single-threaded BH processing in drivers. I wrote this patch [included]
> > to get rid of timer_bh in Ingo's smptimers, but it acquires
> > global_bh_lock as well as net_bh_lock, the latter to ensure
> > that some older protocol code that expected serialization of
> > NET_BH and timers work correctly (see deliver_to_old_ones()).
> > They need to be cleaned up too.
> 
> This is great stuff. I'll definitely try it out in an hour or two. I'd
> be interested in helping with the cleanup of the things assuming the BH
> things still exist but might need a wee bit of hand-holding to get
> through it. I'll go around flagging people down who might be able to
> help me with it as I go.

I did a quick and dirty search on packet_type.data == NULL protocols.
Here is a list -

802/psnap.c
appletalk/ddp.c
ax25/af_ax25.c
core/ext8022.c
econet/af_econet.c
irda/irsyms.c
x25/af_x25.c

These need to be made safe for a non-BH based timer. I guess
the current code assumes serialization between timer and
BH context code due to the use of now-defunct NET_BH.

> 
> I actually suspect tty-related things are a likely culprit as
> significant use of the serial console occurs.

It should also be possible to make minimal non-smptimers 
bhless_timer patch - just in case smptimers isn't going in
any time soon. It will run a timer tasklet off of do_timer().
The tasklet handler still has to grab global_bh_lock and
the likes to keep the tty and other drivers that expect
serialization BH and timers or use __global_cli, happy.
Will such a patch be useful ?

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
