Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261376AbSKKVRw>; Mon, 11 Nov 2002 16:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261381AbSKKVRw>; Mon, 11 Nov 2002 16:17:52 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:27963 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261376AbSKKVRu>; Mon, 11 Nov 2002 16:17:50 -0500
Date: Mon, 11 Nov 2002 16:24:39 -0500
From: Doug Ledford <dledford@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
       geert@linux-m68k.org, hch@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NCR53C9x ESP: C99 designated initializers
Message-ID: <20021111212439.GD11636@redhat.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"David S. Miller" <davem@redhat.com>, geert@linux-m68k.org,
	hch@infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021111203537.GC11636@redhat.com> <Pine.LNX.4.44.0211111249250.1498-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211111249250.1498-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2002 at 01:01:00PM -0800, Linus Torvalds wrote:
> 
> On Mon, 11 Nov 2002, Doug Ledford wrote:
> > 
> > Yes, this part sucks.  There needs to be an easy library function that
> > takes a scsi command pointer, sets up a wait queue, adds the wait queue
> > struct pointer to the scsi command, sleeps with a timeout, wakes up when
> > command completes via scsi_done() or timeout fires, returns value based
> > upon how wake up happened. 
> 
> I think you got it wrong.
> 
> The timer should be started when the command is started, not when it is 
> queued.

It is.  I don't have it wrong :-P

> Just adding the command to the request queue and doing a wait-queue'd
> "schedule_timeout()" is bad,

And I would *never* suggest such a thing.

> because a previous (and unrelated command) 
> may be taking a long time, and may be delaying the new command which works 
> perfectly fine and returns immediately.

Keep in mind that this is in eh context (from the original post).  I'm not 
talking about the queue path or normal case, only error recovery.  For 
example, in an abort handler, your driver can abort commands that haven't 
made it to the drive yet immediately and return success.  If the command 
has already made it to the drive but hasn't been completed yet, then you 
need to tell the drive to abort the command, not just do it.  So, 
currently, what I have to do in aic7xxx_abort() is actually requeue the 
command to my card (this is OK, the card firmware does the right thing in 
regards to finding an already active command on the incoming queue) but 
this time with the abort message in the command message buffer.  The card 
starts device selection, the device responds, we send the IDENTIFY and 
(possibly) TAG messages, followed by either ABORT or ABORT_TAG, device 
then drops the bus to signify receipt of ABORT message.  Fairly clean 
process.  The process can fail.  If there is another command that is stuck 
and holding the whole bus hostage, then our card won't be able to initiate 
selection to the device.  So, the only thing we can do is take a wait and 
see attitude about whether or not the card can actually start the command 
to the device and tell it to abort.  In my driver now, I just drop the 
lock and call scsi_sleep(HZ/4); (only need a very short timeout, if the 
bus isn't hung then this completes fast, if it is hung, waiting doesn't 
help), then check to see if my interrupt handler has completed the 
command.  Other drivers should wait significantly longer depending on 
hardware.  So, for me, the difference between scsi_sleep(HZ/4); or 
something like scsi_sleep_until_done_with_timeout(cmd, HZ/4); is no big 
deal, but I could see it making a lot of sense for other drivers (iSCSI, 
other emulated drivers with fabrics, etc. come to mind).  So, this becomes 
a hook for "wake me up when this command makes it through to the normal 
completion code".

[ snipped rest of Linus' comments since I think they are pretty orthogonal 
to the point I was making in the first place ]


-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
