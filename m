Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292403AbSCDO6U>; Mon, 4 Mar 2002 09:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292407AbSCDO6L>; Mon, 4 Mar 2002 09:58:11 -0500
Received: from host194.steeleye.com ([216.33.1.194]:18699 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S292402AbSCDO6D>; Mon, 4 Mar 2002 09:58:03 -0500
Message-Id: <200203041457.g24EvvU01682@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Chris Mason <mason@suse.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3) 
In-Reply-To: Message from Chris Mason <mason@suse.com> 
   of "Sun, 03 Mar 2002 22:34:07 EST." <757370000.1015212846@tiny> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 04 Mar 2002 08:57:57 -0600
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mason@suse.com said:
> 1) The drivers would need to be changed to properly keep tag ordering
> in place on resets, and error conditions. 

And actually theres also a problem with  normal operations that disrupt flow 
control like QUEUE FULL returns and contingent allegiance conditions.

Basically, neither the SCSI mid-layer nor the low level drivers were designed 
to keep absolute command ordering.  They take the chaotic I/O approach:  you 
give me a bunch of commands and I tell you when they complete.

> 2) ordered tags force ordering of all writes the drive is processing.
> For some workloads, it will be forced to order stuff the journal code
> doesn't care about at all, perhaps leading to lower performance than
> the simple wait_on_buffer() we're using now.

> 2a) Are the filesystems asking for something impossible?  Can drives
> really write block N and N+1, making sure to commit N to media before
> N+1 (including an abort on N+1 if N fails), but still keeping up a
> nice seek free stream of writes? 

These are the "big" issues.  There's not much point doing all the work to 
implement ordered tags, if the end result is going to be no gain in 
performance.

> 4) If some scsi drives come with writeback on by default, do they also
> turn it on under high load like IDE drives do? 

Finally, an easy one...the answer's "no".  The cache control bits are the only 
way to alter caching behaviour (nothing stops a WCE=1 operating as write 
through if the drive wants to, but a WCE=0 cannot operate write back).

James


