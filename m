Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbUCJSXZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 13:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262751AbUCJSXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 13:23:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9110 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262757AbUCJSWd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 13:22:33 -0500
Message-ID: <404F5CDB.50900@pobox.com>
Date: Wed, 10 Mar 2004 13:22:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
CC: axboe@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: per device queues for cciss 2.6.0
References: <D4CFB69C345C394284E4B78B876C1CF105BC1EBB@cceexc23.americas.cpqcorp.net>
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF105BC1EBB@cceexc23.americas.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miller, Mike (OS Dev) wrote:
> Yes, the controller has a single command buffer. It can hold 1024 outstanding commands.

Ok, great.  Well then the carmel.c I sent you should be a good model -- 
carmel.c has per-device queues, and there are no starvation issues.  The 
code is contained within only a few LOC, in carm_push_q(), carm_pop_q(), 
and carm_round_robin().

As an aside, you should probably make the call to cciss_round_robin() 
conditional on the hardware's command buffer being at least 1/2 empty. 
(or pick whatever low water mark you like)

The command buffer size, 1024, is quite nice.  Given the same model as 
carmel.c, I predict that blk_{start,stop}_queue will be called quite 
infrequently -- that translates to _high_ performance on the cciss hardware.

Note the blk_{start,stop}_queue() were only recently fixed (grab latest 
2.6.4-rc), so that may have introduced noise into whatever testing and 
design you've done.

Now, per-queue locking, rather than per-HBA locking, definitely 
introduces some additional complexity.  I've got a good idea how to do 
that, which involves the each queue's request function kicking a common 
tasklet that queues commands to hardware.  But there's a lot of deadlock 
potentional if it's not done right, since you still need a common lock 
for the HBA when submitting and completing hardware commands.  So I 
would be interested to see some evidence of actual SMP contention on the 
per-HBA lock...

Regards,

	Jeff



