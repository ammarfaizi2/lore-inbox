Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290277AbSBORJv>; Fri, 15 Feb 2002 12:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290259AbSBORJm>; Fri, 15 Feb 2002 12:09:42 -0500
Received: from host194.steeleye.com ([216.33.1.194]:45833 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S290229AbSBORJY>; Fri, 15 Feb 2002 12:09:24 -0500
Message-Id: <200202151709.g1FH9H202142@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Chris Mason <mason@suse.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] queue barrier support 
In-Reply-To: Message from Chris Mason <mason@suse.com> 
   of "Fri, 15 Feb 2002 11:28:35 EST." <3998280000.1013790514@tiny> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 15 Feb 2002 12:09:17 -0500
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mason@suse.com said:
> Ok, I'll try to narrow the barrier usage a bit, I'm waiting on the
> barrier write once it is sent, so I'm not worried about anything done
> after the ordered tag.

> write X log blocks   (simple tag) write 1 commit block (ordered tag)
> wait on all of them.

> All I care about is knowing that all of the log blocks hit the disk
> before the commit.  So, if one of the log blocks aborts, I want it to
> abort the commit too.  Is this a little easier to implement? 

Actually, I'm afraid not.  The FS has the notion of a transaction to help it 
with this.  All the SCSI driver sees is a list of IOs with some requests for 
ordered tags.  If we go into error recovery and have to abort a tag, how do we 
know which of the outstanding ordered tags is actually the commit block for 
this transaction? (Remember also that a FS sits on a partition, not a physical 
SCSI device, so even if you single thread your commits per FS, there could 
still be multiple FSs on the same physical device).

That's why I think it's safer to abandon the abort entirely.  If our first 
line of error recovery is device reset, we know we've just cleared the entire 
outstanding tag queue and we can resend all the tags in FIFO order which means 
that we still don't need a concept of "transaction" at the SCSI level (which 
is a good thing, I think), all we need to know is the order in which the tags 
came to us.

Even if some tags were committed but not acknowledged at reset time, it's 
still safe to resend them in the correct ordered sequence because of 
transaction idempotence of block writes.

James


