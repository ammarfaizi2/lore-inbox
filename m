Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263034AbUCLXZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 18:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263035AbUCLXZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 18:25:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:13512 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263034AbUCLXZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 18:25:47 -0500
Date: Fri, 12 Mar 2004 15:27:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: thockin@sun.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: calling flush_scheduled_work()
Message-Id: <20040312152747.0b3f74d3.akpm@osdl.org>
In-Reply-To: <20040312205814.GY1333@sun.com>
References: <20040312205814.GY1333@sun.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin <thockin@sun.com> wrote:
>
> We've recently bumped into an issue, and I'm not sure which is the real bug.
> 
> In short we have a case where mntput() is called from the kevetd workqueue.
> When that mntput() hit an NFS mount, we got a deadlock.  It turns out that
> deep in the RPC code, someone calls flush_scheduled_work().  Deadlock.

Seems simple enough to fix the workqueue code to handle this situation.

Wanna test this for me?

---

 25-akpm/kernel/workqueue.c |    8 ++++++++
 1 files changed, 8 insertions(+)

diff -puN kernel/workqueue.c~flush_scheduled_work-deadlock-fix kernel/workqueue.c
--- 25/kernel/workqueue.c~flush_scheduled_work-deadlock-fix	Fri Mar 12 15:24:29 2004
+++ 25-akpm/kernel/workqueue.c	Fri Mar 12 15:25:46 2004
@@ -229,6 +229,14 @@ void fastcall flush_workqueue(struct wor
 			continue;
 		cwq = wq->cpu_wq + cpu;
 
+		if (cwq->thread == current) {
+			/*
+			 * Probably keventd trying to flush its own queue.
+			 * So just run it by hand rather than deadlocking
+			 */
+			run_workqueue(cwq);
+			continue;
+		}
 		spin_lock_irq(&cwq->lock);
 		sequence_needed = cwq->insert_sequence;
 

_

