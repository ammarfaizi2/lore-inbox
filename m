Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261322AbSKKUyj>; Mon, 11 Nov 2002 15:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261321AbSKKUyj>; Mon, 11 Nov 2002 15:54:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62993 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261330AbSKKUyh>; Mon, 11 Nov 2002 15:54:37 -0500
Date: Mon, 11 Nov 2002 13:01:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Doug Ledford <dledford@redhat.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
       <geert@linux-m68k.org>, <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NCR53C9x ESP: C99 designated initializers
In-Reply-To: <20021111203537.GC11636@redhat.com>
Message-ID: <Pine.LNX.4.44.0211111249250.1498-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Nov 2002, Doug Ledford wrote:
> 
> Yes, this part sucks.  There needs to be an easy library function that
> takes a scsi command pointer, sets up a wait queue, adds the wait queue
> struct pointer to the scsi command, sleeps with a timeout, wakes up when
> command completes via scsi_done() or timeout fires, returns value based
> upon how wake up happened. 

I think you got it wrong.

The timer should be started when the command is started, not when it is 
queued.

Just adding the command to the request queue and doing a wait-queue'd
"schedule_timeout()" is bad, because a previous (and unrelated command) 
may be taking a long time, and may be delaying the new command which works 
perfectly fine and returns immediately.

Example: somebody does a "close tray and read". Where it should be 
perfectly possible to give the read command a short timeout, even if the 
close tray takes a few seconds. 

And btw, this has nothing to do with SCSI per se, so adding the thing to
the scsi command struct is bad, evil, and the reason for why the SCSI
mid-layers will eventually have to go away (ie they do exactly this kind
of thing, and _encourage_ people to do them).

We've got almost all of the infrastructure to do this on a request level 
now, including the timeout value (but nothing that sets the timeouts for 
regular IO).

We don't have the starting of the timer thing there, and that's at least
partly because I really think the timer should be started and set up by
the driver itself - and that's because only the driver can know if it can
actually remove the request and how to do it.

If the request ends up being pending and holding up other requests
(because the driver doesn't know how to physically abort it), we MUST NOT
return it as being "aborted due to timeout", because higher layers cannot
de-allocate the request anyway (imagine the thing later on waking up and
scribbling on memory that has now been free'd because the command "timed
out").

But yes, we want the infrastructure for doing this easily some day. As it 
is, that's 2.7.x material by now.

			Linus

