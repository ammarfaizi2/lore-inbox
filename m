Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbTEZQnw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 12:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbTEZQnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 12:43:52 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4616 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261788AbTEZQnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 12:43:51 -0400
Date: Mon, 26 May 2003 09:56:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] add ata scsi driver
In-Reply-To: <3ED1ADA0.9080500@pobox.com>
Message-ID: <Pine.LNX.4.44.0305260947430.11328-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 May 2003, Jeff Garzik wrote:
> >>I think with SATA + drivers/ide, you reach a point of diminishing 
> >>returns versus amount of time spent on mid-layer coding.
> > 
> > I think that's a valid approach, and just have a special driver for SATA. 
> > That's not the part I worry about. 
> 
> You're still at a point of diminishing returns for a native driver too.

No, because for a block-queue native driver there would be one huge 
advantage: making sure the native queueing is brought up to be a fully 
used interface.

Originally, native queueing was all there was, and all drivers interfaced 
directly to it. The IDE and SCSI layers ended up being used largely
because they allowed drivers to use a global naming scheme, not because 
they were "better". In fact, in many ways they were a lot worse than the 
native queues, but then they had some other infrastructure that did help.

My bet is that most of that infrastructure today is just not worth it.

> Userland support is nonexistent, and users would have start using yet 
> another set of tools to deal with their disks, instead of the existing 
> [scsi] ones.

That's not true. The command set is already exported, so that even things 
like packet commands can be sent (that's how you write CD-RW under 2.5.x, 
and it's the _generic_ layer that does all the command queueing). 

That, btw, i show you should do the ATA transport thing. Even SCSI devices 
can get the commands fed that way. It's neither ATA nor SCSI, it's a 
"packet interface for the generic queue".

The only remaining piece of the puzzle (from a user land perspective) ends 
up being the mapping from major/minor -> queue. That used to be a _huge_
issue, and the main reason you couldn't write a SCSI driver outside the 
SCSI layer, for example (but look at DAC960 - it decided to do so 
_anyway_, even if it meant being ostracised and put on a separate major).

But that should be much less of an issue now, since our queue mapping is a 
lot more flexible these days.

> Device model, power management, hotplugging are all handled or 
> in-the-works for scsi, and they are exactly what SATA needs.

Clue-in-time: if hotplugging doesn't work on a native level, it won't work 
on a SCSI level either. So that _cannot_ be a real issue.

Device model stuff and power management all comes from other areas, and 
have little to do with SCSI.

		Linus

