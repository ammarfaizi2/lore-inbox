Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292939AbSBVRgx>; Fri, 22 Feb 2002 12:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292938AbSBVRgd>; Fri, 22 Feb 2002 12:36:33 -0500
Received: from host194.steeleye.com ([216.33.1.194]:14865 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S292939AbSBVRg0>; Fri, 22 Feb 2002 12:36:26 -0500
Message-Id: <200202221736.g1MHaMc04473@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Stephen C. Tweedie" <sct@redhat.com>, Chris Mason <mason@suse.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3) 
In-Reply-To: Message from "Stephen C. Tweedie" <sct@redhat.com> 
   of "Fri, 22 Feb 2002 16:13:07 GMT." <20020222161307.H2424@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 22 Feb 2002 12:36:22 -0500
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sct@redhat.com said:
> There is a get-out for ext3 --- we can submit new journal IOs without
> waiting for the commit IO to complete, but hold back on writeback IOs.
> That still has the desired advantage of allowing us to stream to the
> journal, but only requires that the commit block be ordered with
> respect to older, not newer, IOs.  That gives us most of the benefits
> of tagged queuing without any problems in your scenario. 

Actually, I intended the tagged queueing discussion to be discouraging.  The 
amount of work that would have to be done to implement it is huge, touching, 
as it does, every low level driver's interrupt routine.  For the drivers that 
require scripting changes to the chip engine, it's even worse: only someone 
with specialised knowledge can actually make the changes.

It's feasible, but I think we'd have to demonstrate some quite significant 
performance or other improvements before changes on this scale would fly.

Neither of you commented on the original suggestion.  What I was wondering is 
if we could benchmark (or preferably improve on) it:

James.Bottomley@SteelEye.com said:
> The easy way out of the problem, I think, is to impose the barrier as
> an  effective queue plug in the SCSI mid-layer, so that after the
> mid-layer  recevies the barrier, it plugs the device queue from below,
> drains the drive  tag queue, sends the barrier and unplugs the device
> queue on barrier I/O  completion. 

If you need strict barrier ordering, then the queue is double plugged since 
the barrier has to be sent down and waited for on its own.  If you allow the 
discussed permiability, the queue is only single plugged since the barrier can 
be sent down along with the subsequent writes.

I can take a look at implementing this in the SCSI mid-layer and you could see 
what the benchmark figures look like with it in place.  If it really is the 
performance pig it looks like, then we could go back to the linux-scsi list 
with the tag change suggestions.

James


