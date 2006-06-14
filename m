Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbWFNFYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWFNFYJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 01:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWFNFYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 01:24:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43619 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964885AbWFNFYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 01:24:06 -0400
Date: Wed, 14 Jun 2006 07:24:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Vasily Tarasov <vtaras@sw.ru>
Cc: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@sw.ru>
Subject: Re: CFQ ioprio setting patch
Message-ID: <20060614052441.GH4420@suse.de>
References: <44744AC0.3020908@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44744AC0.3020908@sw.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24 2006, Vasily Tarasov wrote:
> If you set io-priority of process 1 using sys_ioprio_set system call by 
> another process 2 (like ionice do),
> then cfq_init_prio_data() function sets priority of process 2 (current) 
> on queue of process 1 and clears the flag, that designates change of ioprio.
> So the process  1 will work like with priority of process 2.
> 
> I propose not to call cfq_init_prio_data() on io-priority change, but 
> only mark queue as queue with changed prority.
> Every time when new request comes cfq-scheduler checks for this flag and 
> atomaticaly changes priority of queue to new value.

Your analysis looks correct. However the patch is not -stable material,
I've queued it for inclusion post 2.6.17, thanks. Newer version below
for 2.6.17-rc6. If you have the time, please test that 2.6.17-rc6 has
the same bug and that this patch (which is just a port of yours) does
fix it.

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 56bec4e..e636b0f 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -1400,10 +1400,9 @@ static inline void changed_ioprio(struct
 			}
 		}
 		cfqq = cic->cfqq[SYNC];
-		if (cfqq) {
+		if (cfqq)
 			cfq_mark_cfqq_prio_changed(cfqq);
-			cfq_init_prio_data(cfqq);
-		}
+
 		spin_unlock(cfqd->queue->queue_lock);
 	}
 }

-- 
Jens Axboe

