Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266964AbUBGQat (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 11:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266967AbUBGQat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 11:30:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:54977 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266964AbUBGQar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 11:30:47 -0500
Date: Sat, 7 Feb 2004 08:32:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.6.2-mm1: destroy_workqueue
Message-Id: <20040207083254.2440175b.akpm@osdl.org>
In-Reply-To: <pan.2004.02.07.11.49.04.872088@smurf.noris.de>
References: <pan.2004.02.07.11.49.04.872088@smurf.noris.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Urlichs <smurf@smurf.noris.de> wrote:
>
> I had a crash when unmounting a reiserfs at shutdown time.
> 
> Apparently, destroy_workqueue() inlines list_del(), which checks for
> 
> 148             BUG_ON(entry->prev->next != entry);
> 
> This is a problem when entry->prev is NULL.  :-/
> 
> Call trace, copied off the screen by hand:
> destroy_workqueue+0x30
> do_journal_release+0x4e
> journal_mark_dirty+0x18c
> journal_release+0x10
> reiserfs_put_super+0x24
> 

yup, thanks.

--- 25/kernel/workqueue.c~cpuhotplug-03-core-workqueue-fix	Fri Feb  6 14:36:04 2004
+++ 25-akpm/kernel/workqueue.c	Fri Feb  6 14:36:41 2004
@@ -335,7 +335,7 @@ void destroy_workqueue(struct workqueue_
 		if (cpu_online(cpu))
 			cleanup_workqueue_thread(wq, cpu);
 	}
-	list_del(&wq->list);
+	del_workqueue(wq);
 	unlock_cpu_hotplug();
 	kfree(wq);
 }

_

