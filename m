Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265051AbSJaAiJ>; Wed, 30 Oct 2002 19:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265052AbSJaAiJ>; Wed, 30 Oct 2002 19:38:09 -0500
Received: from host194.steeleye.com ([66.206.164.34]:58633 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S265051AbSJaAiG>; Wed, 30 Oct 2002 19:38:06 -0500
Message-Id: <200210310044.g9V0iRs03324@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.5 current bk fix setting scsi queue depths 
In-Reply-To: Message from Patrick Mansfield <patmans@us.ibm.com> 
   of "Wed, 30 Oct 2002 10:05:34 PST." <20021030100534.A12400@eng2.beaverton.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 30 Oct 2002 19:44:27 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, the problem is that in scsi_register_host() if there are no upper
> level drivers - the standard case if building no modules - we call
> scsi_release_commandblocks even though we are NOT getting rid of the
> scsi_device. So, with current code, new_queue_depth and
> current_queue_depth are zero.

But slave_attach isn't called here (even though it should be for attached 
devices).  I assume it's getting added by the scan between register_host & 
register_device.

> When we register upper level drivers in scsi_register_device(), we
> call scsi_build_commandblocks (again), and get a queue depth of 1,
> since we've cleared new_queue_depth. 

OK, we have a slight mess up here.  Perhaps the rule for slave_attach should 
be that we only call it if we actually have an upper level device attached (if 
we haven't, there's little point asking the HBA to allocate space for queueing 
for a device we're not currently using).  Then, we should do slave_attach when 
something actually decides to attach to the device.

if we follow this approach, slave_attach wouldn't be called until 
register_device in your problem scenario, and then everything would work as 
expected.

> Removing the scsi_release_commandblocks() in scsi_register_host()
> would also fix the problem, and in most cases, would not waste any
> space. In the worst case AFAICT it would waste one scsi_cmnd (about
> 300 or so bytes?). 

Well, if there's no device attached, there's no need for a queue.  This would 
waste 1 SCSI command per unattached device (and SCSI commands are DMA'able 
memory which is precious on some systems).  Right now, that's OK for small 
systems.  When we move to a lazy attachment model because we have an array 
with 65535 LUNs and we're only interested in one of them, it won't be.

> I see no good reason to zero new_queue_depth in scsi_release_commandblo
> cks, as new_queue_depth is the desired queue depth, and should remain
> so until scsi_adjust_queue_depth is called. Setting new_queue_depth to
> zero means we have to call slave_attach again to set it right, and
> depending on what else an adapter slave_attach does could be very
> wrong. 

Well, to my way of thinking, build and release commandblocks are like 
constructor and destructor for the device queue.  On general design 
principles, I don't like the idea of queue specific information persisting 
past its destruction.

James


