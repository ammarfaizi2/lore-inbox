Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbVHYK3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbVHYK3t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 06:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVHYK3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 06:29:49 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:49342 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964915AbVHYK3s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 06:29:48 -0400
Subject: Re: [Hdaps-devel] Re: HDAPS, Need to park the head for real
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Escombe <lists@dresco.co.uk>
Cc: Jens Axboe <axboe@suse.de>,
       Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>,
       linux-ide@vger.kernel.org
In-Reply-To: <430CEA54.7060803@dresco.co.uk>
References: <1124205914.4855.14.camel@localhost.localdomain>
	 <20050816200708.GE3425@suse.de>  <430CEA54.7060803@dresco.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 25 Aug 2005 11:57:47 +0100
Message-Id: <1124967468.21456.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You need the kernel side timeout. Consider this case

One page of memory holds the parking code
A second page is swapped to disk and holds the resume code

You park the disk
You wakeup
You got to page in the resume code

So you really do want the kernel helping to avoid a deadlock

@@ -1661,6 +1671,9 @@
                where = ELEVATOR_INSERT_FRONT;
                rq->flags |= REQ_PREEMPT;
        }
+       if (action == ide_next)
+               where = ELEVATOR_INSERT_FRONT;
+
        __elv_add_request(drive->queue, rq, where, 0);
        ide_do_request(hwgroup, IDE_NO_IRQ);
        spin_unlock_irqrestore(&ide_lock, flags);

Also puzzles me- why is this needed ?


