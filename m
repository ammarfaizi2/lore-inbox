Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbTDYJYP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 05:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263521AbTDYJYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 05:24:15 -0400
Received: from [212.50.18.217] ([212.50.18.217]:520 "EHLO gw.zaxl.net")
	by vger.kernel.org with ESMTP id S263173AbTDYJYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 05:24:14 -0400
Message-ID: <3EA90176.2080304@ssi.bg>
Date: Fri, 25 Apr 2003 12:35:50 +0300
From: Alexander Atanasov <alex@ssi.bg>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en, bg
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH] IDE Power Management try 1
References: <1051189194.13267.23.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

		Hello,

Benjamin Herrenschmidt wrote:


> The point is to pipe the power management requests through the request
> queue for proper locking. Since those requests involve several
> operations that have to be tied together with the queue beeing locked
> for further 'user' requests, they are implemented as a state machine
> with specific callbacks in the subdrivers
> 
[cut]
> 
> One thing that should probably be cleaned up is the difference between
> the suspend and the resume request. I didn't want to implement 2
> different request bits to avoid using too much of that bit-space, and
> because most of the core handling is the same. So right now, I carry in
> the special structure attached to the request, 2 fields. An int
> indicating if we are doing a suspend or a resume op, and an int that is
> the actual state machine step.

 > ===== include/linux/blkdev.h 1.100 vs edited =====
 > --- 1.100/include/linux/blkdev.h	Sun Apr 20 18:20:10 2003
 > +++ edited/include/linux/blkdev.h	Thu Apr 24 14:30:50 2003
 > @@ -116,6 +116,7 @@
 >  	__REQ_DRIVE_CMD,
 >  	__REQ_DRIVE_TASK,
 >  	__REQ_DRIVE_TASKFILE,
 > +	__REQ_POWER_MANAGEMENT,
 >  	__REQ_NR_BITS,	/* stops here */
 >  };


		What about this - add __REQ_DRIVE_INTERNAL, and carry args in 
rq->cmd[16] [0] = PM, [1] = SUSPEND/RESUME, [2]= STATE ? IDE can use it 
for power managment, error handling (do not do it from interrupt 
context, but queue it), may be more. This way it would really makes 
things a bit better with the complicated IDE locking. SCSI and probably 
other block devices can benefit from this internal requests too, so the 
bit is not wasted.


--
have fun,
alex

