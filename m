Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbTEZUcc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 16:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbTEZUcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 16:32:32 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11021 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262222AbTEZUca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 16:32:30 -0400
Date: Mon, 26 May 2003 13:45:25 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
In-Reply-To: <1053981380.1768.203.camel@mulgrave>
Message-ID: <Pine.LNX.4.44.0305261339340.13489-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 26 May 2003, James Bottomley wrote:
> 
> > I'd hate for SATA to pick up these kinds of mistakes from the SCSI layer.
> 
> The elevator is based on linear head movements.

Historically, yes.

But we've been moving more and more towards a latency-based elevator, or
at least one that takes latency into account. Which is exactly why you'd
like to leave unfinished requests on the queue, because otherwise your
queue doesn't really show what is really going on.

In particular, while the higher layers don't actually _do_ this yet, from 
a latency standpoint the right thing to do when some request seems to get 
starved is to refuse to feed more tagged requeusts to the device until the 
starved request has finished. 

As I mentioned, Andrew actually had some really bad latency numbers to
prove that this is a real issue. SCSI with more than 4 tags or so results 
in potentially _major_ starvation, because the disks themselves are not 
even trying to avoid it.

Also, even aside from the starvation issue with unfair disks, just from a
"linear head movement" standpoint, you really want to sort the queue
according to what is going on _now_ in the disk. If the disk eats the
requests immediately (but doesn't execute them immediately), the sorting
has nothing to go on, and you get tons of back-and-forth movements.

Basically, if you're trying to do an elevator, you need to know what the 
outstanding commands are. Think it through on paper, and you'll see what I 
mean.

			Linus

