Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWE2L4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWE2L4H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 07:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWE2L4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 07:56:07 -0400
Received: from ns.mipt.ru ([193.125.143.173]:53956 "EHLO mail.telecom.mipt.ru")
	by vger.kernel.org with ESMTP id S1750883AbWE2L4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 07:56:06 -0400
Message-ID: <44744AC0.3020908@sw.ru>
Date: Wed, 24 May 2006 16:00:00 +0400
From: Vasily Tarasov <vtaras@sw.ru>
Reply-To: vtaras@sw.ru
Organization: SWSoft
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: axboe@suse.de
CC: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@sw.ru>
Subject: CFQ ioprio setting patch
Content-Type: multipart/mixed;
 boundary="------------060101040403010706030607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060101040403010706030607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

If you set io-priority of process 1 using sys_ioprio_set system call by 
another process 2 (like ionice do),
then cfq_init_prio_data() function sets priority of process 2 (current) 
on queue of process 1 and clears the flag, that designates change of ioprio.
So the process  1 will work like with priority of process 2.

I propose not to call cfq_init_prio_data() on io-priority change, but 
only mark queue as queue with changed prority.
Every time when new request comes cfq-scheduler checks for this flag and 
atomaticaly changes priority of queue to new value.

Small patch is below.

--------------060101040403010706030607
Content-Type: text/plain;
 name="diff-cfq-ioprio-set-20060529"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-cfq-ioprio-set-20060529"

--- linux-2.6.16-026stab012-ioprio/block/cfq-iosched.c.orig	2006-05-29 13:46:20.000000000 +0400
+++ linux-2.6.16-026stab012-ioprio/block/cfq-iosched.c	2006-05-24 15:31:24.000000000 +0400
@@ -1325,7 +1325,6 @@ static inline void changed_ioprio(struct
 
 		spin_lock(cfqd->queue->queue_lock);
 		cfq_mark_cfqq_prio_changed(cfqq);
-		cfq_init_prio_data(cfqq);
 		spin_unlock(cfqd->queue->queue_lock);
 	}
 }

--------------060101040403010706030607--
