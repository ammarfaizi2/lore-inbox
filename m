Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132572AbRC1Vie>; Wed, 28 Mar 2001 16:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132582AbRC1ViH>; Wed, 28 Mar 2001 16:38:07 -0500
Received: from [195.63.194.11] ([195.63.194.11]:47115 "EHLO mail.stock-world.de") by vger.kernel.org with ESMTP id <S132572AbRC1Vgv>; Wed, 28 Mar 2001 16:36:51 -0500
Message-ID: <3AC25657.6CC01DFB@evision-ventures.com>
Date: Wed, 28 Mar 2001 23:23:35 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andre Hedrick <andre@linux-ide.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@transmeta.com>, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
References: <Pine.LNX.4.31.0103271545500.25282-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 27 Mar 2001, Andre Hedrick wrote:
> >
> > Am I hearing you state you want dynamic device points and dynamic majors?
> 
> Yes and no.
> 
> We need static structures for user space - from a user perspective it
> makes a ton more sense to say "I want to see all disks" than it does to
> know that you have to do /dev/hd*, /dev/sd* plus all the extra magic
> combinations that can happen (USB etc).
> 
> So in a sense what I'm arguing for is for _stricter_ device numbers to the
> outside world.
> 
> But internally, it would be reasonably easy to make a mapping from those
> user-visible numbers to a much looser version.
> 
> One example of this is going to happen very early in 2.5.x: the whole
> "partitioning" stuff is going to go away from the driver, and into the
> ll_rw_block layer as just another disk re-mapping thing. We already do
> those kinds of re-mappings for LVM reasons anyway, and partitioning is not
> something a disk driver should know about, really.
> 
> And that kind of partitioning mapping automatically means that we'd need
> to remap minor numbers, and do it on a per-major basis (because the
> partitioning mapping right now is not actually the same between SCSI and
> IDE: IDE uses six bits of partitioning, while SCSI uses just four bits).
> And once you do that, you might as well start "remapping" major numbers
> too.
> 
> So let's say that you have two separate SCSI controllers - they would both
> show up on major #8, and different minor numbers. Right now, for example,
> controller 1 might have one disk, with minors 0-15 (for the whole disk and
> 15 partitions), and controller 2 might have two disks using minors 16-47.
> 
> As it stands now, the SCSI layer needs to do the remapping, and because
> the SCSI layer does the remapping, nothing but SCSI layer devices can use
> major #8.
> 
> But once you start doing partition mapping in ll_rw_block.c, you might as
> well get rid of the notion that "SCSI is major 8". You could easily have
> many different drivers, with many different queues, and remap them all to
> have major 8 (and different minors) so that it looks simple for a user
> that just wants to see SCSI disks.
> 
> Which is not to say that the same disk might not show up somewhere else
> too, if anybody wants it to. The _driver_ should just know "unit x on
> queue y", and then the driver might do whatever it wants (it might be, for
> example, that the driver actually wants to show multiple controllers as
> one queue, if the driver really wants to for some reason). And it should
> be possible to have two drivers that really have no idea at ALL about each
> other to just share the same major numbers.

Then please please please demangle other cases as well!
IDE is the one which is badging my head most. SCSI as well...

Granted I wouldn't mind a rebot with new /dev/* once!
