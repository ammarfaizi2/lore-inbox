Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292912AbSCDVLA>; Mon, 4 Mar 2002 16:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292908AbSCDVKl>; Mon, 4 Mar 2002 16:10:41 -0500
Received: from dsl-213-023-043-195.arcor-ip.net ([213.23.43.195]:14232 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S292911AbSCDVKe>;
	Mon, 4 Mar 2002 16:10:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Date: Mon, 4 Mar 2002 22:06:19 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Chris Mason <mason@suse.com>,
        James Bottomley <James.Bottomley@steeleye.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <phillips@bonn-fries.net> <E16hyRG-0000fO-00@starship.berlin> <20020304195723.J1444@redhat.com>
In-Reply-To: <20020304195723.J1444@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16hzf1-0000fz-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 4, 2002 08:57 pm, Stephen C. Tweedie wrote:
> Hi,
> 
> On Mon, Mar 04, 2002 at 08:48:02PM +0100, Daniel Phillips wrote:
> > On March 4, 2002 07:05 pm, Stephen C. Tweedie wrote:
> > > Also, as soon as we have journals on external devices, this whole
> > > thing changes entirely.  We still have to enforce the commit ordering
> > > in the journal, but we also still need the ordering between that
> > > commit and any subsequent writeback, and that obviousy can no longer
> > > be achieved via ordered tags if the two writes are happening on
> > > different devices.
> > 
> > But the bio layer can manage it, by sending a write barrier down all
> > relevant queues.  We can send a zero length write barrier command, yes?
> 
> Sort of --- there are various flush commands we can use.  However, bio
> can't just submit the barriers, it needs to synchronise them, and that
> means doing a global wait over all the devices until they have all
> acked their barrier op.  That's expensive: you may be as well off just
> using the current fs-internal synchronous commands at that point.

With ordered tags, at least we get the benefit of not having to wait on all 
the commands before the write barrier.

It's annoying to have to let the all the command queues empty, but it's hard 
to see what can be done about that, the synchronization *has* to be global.  
In this case, all we can do is to be sure to respond quickly to the command 
completion interrupt.  So the unavoidable cost is one request's worth of bus 
transfer (is there an advantage in trying to make it a small request?) and 
the latency of the interrupt.  100 uSec?

In the meantime, if I am right about being able to have multiple queues per 
disk, reads can continue.  It's not so bad.

The only way I can imagine of improving this is if there's a way to queue 
some commands on the understanding they're not to be carried out until the 
word is given.  My scsi-fu is not great enough to know if there's a way to do 
this.  Even if we could, it's probably not worth the effort, because all the 
drives will have to wait for the slowest/most loaded anyway.

That's life.

-- 
Daniel
