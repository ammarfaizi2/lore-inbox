Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161448AbWJKVK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161448AbWJKVK7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161443AbWJKVKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:10:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:5797 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161450AbWJKVKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:10:34 -0400
Date: Wed, 11 Oct 2006 14:09:20 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Vasily Tarasov <vtaras@openvz.org>,
       Jens Axboe <jens.axboe@oracle.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 67/67] block layer: elv_iosched_show should get elv_list_lock
Message-ID: <20061011210920.GP16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="block-layer-elv_iosched_show-should-get-elv_list_lock.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Vasily Tarasov <vtaras@openvz.org>

elv_iosched_show function iterates other elv_list,
hence elv_list_lock should be got.

Also the question is: in elv_iosched_show, elv_iosched_store
q->elevator->elevator_type construction is used without locking q->queue_lock.
Is it expected?..

Signed-off-by: Vasily Tarasov <vtaras@openvz.org>
Cc: Jens Axboe <jens.axboe@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 block/elevator.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.18.orig/block/elevator.c
+++ linux-2.6.18/block/elevator.c
@@ -892,7 +892,7 @@ ssize_t elv_iosched_show(request_queue_t
 	struct list_head *entry;
 	int len = 0;
 
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irq(&elv_list_lock);
 	list_for_each(entry, &elv_list) {
 		struct elevator_type *__e;
 
@@ -902,7 +902,7 @@ ssize_t elv_iosched_show(request_queue_t
 		else
 			len += sprintf(name+len, "%s ", __e->elevator_name);
 	}
-	spin_unlock_irq(q->queue_lock);
+	spin_unlock_irq(&elv_list_lock);
 
 	len += sprintf(len+name, "\n");
 	return len;

--
