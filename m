Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317855AbSGPOao>; Tue, 16 Jul 2002 10:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317856AbSGPOan>; Tue, 16 Jul 2002 10:30:43 -0400
Received: from adsl-64-109-89-110.dsl.chcgil.ameritech.net ([64.109.89.110]:15694
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S317855AbSGPOal>; Tue, 16 Jul 2002 10:30:41 -0400
Message-Id: <200207160933.g6G9XKL02184@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Joerg Schilling <schilling@fokus.gmd.de>
cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5 
In-Reply-To: Message from Joerg Schilling <schilling@fokus.gmd.de> 
   of "Tue, 16 Jul 2002 13:28:19 +0200." <200207161128.g6GBSJPE021316@burner.fokus.gmd.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Jul 2002 04:33:20 -0500
From: James Bottomley <James.Bottomley@SteelEye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

schilling@fokus.gmd.de said:
> Why should the character interface be connected to the block layer?
> This would contradict UNIX rules. 

Well, first and foremost Linux isn't UNIX, especially where block and 
character devices are concerned.  But secondly, the block layer provides 
command queueing.  If any device (SCSI, IDE or more exotic) can't accept a 
character command (like QUEUE_FULL in SCSI), it goes back to the block layer 
queue to await reissue.  It's really exactly a block request without the block 
position.

This is actually almost the way linux operates now:  all the character tap for 
a SCSI tape device does is take the read or write and convert it into an 
appropriate SCSI command, which now has a block extent attached.  Since we 
have all the machinery for handling block command queuing in the block layer, 
it makes no sense to duplicate it for the character layer.

> Why should the error handlers interface with the block layer? This is
> not true for UNIX and it would not help. However, it would be nice to
> have a way to make the blocklayer find out that e.g.  only the last
> sector  of a multi sector read ahead instruction  did fail. 

Error handling is more than local.  Some errors, you are correct, can only be 
handled at the SCSI layer.  However, a large class of drivers (Think 
multi-path or software raid) want the ability to direct how SCSI handles 
errors themselves.  It is unacceptable to have SCSI all on its own retry a 
medium error command x times, taking minutes before the upper layers become 
aware anything went wrong.

The solution is to have a stacking error handler where the error handler for 
upper devices would be notified of a problem and asked for direction as soon 
as it occurs.

> With my proposal, anything that speaks SCSI is used via SCSI commands
> and a  generic SCSI driver like scg.c could access the SCSI transport
> aware drives of any type. An important (communication baesed) feature
> of my SCSI glue layer  would be to make it possible to insert SCSI
> commands from scg.c without making  sd.c believe that something
> strange and unexpected happened to one of it's drives. 

But the new scheme allows that.  The block queues accept translated requests 
(that's really what sg does).

> It would help, if somebody would correct the current SCSI addressng
> scheme used  in Linux. Linux currently uses something called BUS/
> channel/target/lun. This does not reflect reality.

No UNIX scheme reflects reality, so I suppose we're all equal

> Why do you believe that you need to have something that is not a
> bumber? 

Look at a solaris fibre driver for instance.  On the fabric, most of them 
think of targets in terms of WWN/PORT (because that's what the fibre LIP 
uses).  They then have an internal database to translate what they use 
(WWN/PORT, soft loop ID, etc.) into a target number for the user to see.  
Next, because the fibre topology is mutable, they have to have a way of 
mapping the WWN/PORT to the device across reboots, hence persistent binding.  
Ultimately you get a huge chunk of code whose sole job is to preserve the 
fiction that targets are numbers.

Not pretending the target is a number avoids all the above glue and complexity.

> Let me add my modified artwork: 

But you're still too SCSI transport specific.  The ongoing goal is to make the 
physical transport protocol an adjunct to the Linux internal transport (the 
struct request) so that we can treat all block/character devices on an equal 
footing.

Your diagram picks one preferred transport and forces everything else to 
conform.  It's rather like quantum field theory:  I want to treat the 
underlying physics in a gauge invariant fashion (i.e. transport independent), 
exposing only the essential features of the problem.  You want to pick a 
preferred gauge (the SCSI transport).  There are always cases where the 
preferred gauge makes everything much simpler, but it's simply not worth it 
for the many more cases where it makes the problem much more complex.

James


