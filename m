Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293233AbSCEO7h>; Tue, 5 Mar 2002 09:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293243AbSCEO71>; Tue, 5 Mar 2002 09:59:27 -0500
Received: from pc-80-195-34-57-ed.blueyonder.co.uk ([80.195.34.57]:5761 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S293233AbSCEO7K>; Tue, 5 Mar 2002 09:59:10 -0500
Date: Tue, 5 Mar 2002 14:58:29 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Chris Mason <mason@suse.com>,
        James Bottomley <James.Bottomley@steeleye.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Message-ID: <20020305145829.A2120@redhat.com>
In-Reply-To: <phillips@bonn-fries.net> <E16hyRG-0000fO-00@starship.berlin> <20020304195723.J1444@redhat.com> <E16hzf1-0000fz-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16hzf1-0000fz-00@starship.berlin>; from phillips@bonn-fries.net on Mon, Mar 04, 2002 at 10:06:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 04, 2002 at 10:06:19PM +0100, Daniel Phillips wrote:
> On March 4, 2002 08:57 pm, Stephen C. Tweedie wrote:
> > On Mon, Mar 04, 2002 at 08:48:02PM +0100, Daniel Phillips wrote:
> > > On March 4, 2002 07:05 pm, Stephen C. Tweedie wrote:
> > > > Also, as soon as we have journals on external devices, this whole
> > > > thing changes entirely. 

> > > We can send a zero length write barrier command, yes?
> > 
> > Sort of --- there are various flush commands we can use.  However, bio
> > can't just submit the barriers, it needs to synchronise them, and that
> > means doing a global wait over all the devices until they have all
> > acked their barrier op.  That's expensive: you may be as well off just
> > using the current fs-internal synchronous commands at that point.
> 
> With ordered tags, at least we get the benefit of not having to wait on all 
> the commands before the write barrier.
> 
> It's annoying to have to let the all the command queues empty, but it's hard 
> to see what can be done about that, the synchronization *has* to be global.  
> In this case, all we can do is to be sure to respond quickly to the command 
> completion interrupt.  So the unavoidable cost is one request's worth of bus 
> transfer (is there an advantage in trying to make it a small request?) and 
> the latency of the interrupt.  100 uSec?

It probably doesn't really matter.  For performance, we want to stream
both the journal writes and the primary disk writeback as much as
possible, but a bit of latency in the synchronisation between the two
ought to be largely irrelevant.

Much more significant than the external-journal case is probably the
stripe case, either with raid5, striped LVM or raid-1+0.  In that
case, even sequential IO to the notionally-sequential journal may have
to be split over multiple disks, and at that point the pipeline stall
in the middle of IO that was supposed to be sequential will really
hurt.

Cheers,
 Stephen
