Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbUL3TTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbUL3TTe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 14:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbUL3TTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 14:19:34 -0500
Received: from av1-2-sn1.fre.skanova.net ([81.228.11.108]:40871 "EHLO
	av1-2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261699AbUL3TTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 14:19:31 -0500
To: Mateusz.Blaszczyk@nask.pl
Cc: axboe@suse.de, linux-kernel@vger.kernel.org,
       Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: [pktcdvd] Badness in fork.c:91 then Oops
References: <Pine.GSO.4.58.0412301854420.2875@boromir>
From: Peter Osterlund <petero2@telia.com>
Date: 30 Dec 2004 20:19:19 +0100
In-Reply-To: <Pine.GSO.4.58.0412301854420.2875@boromir>
Message-ID: <m3acrvh9vs.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mateusz.Blaszczyk@nask.pl writes:

> PKTCDVD seems to create some badness in kernel/fork, line 91:
> 
> I loaded pktcdvd manaully end everything was fine
> 
> Dec 30 08:32:46 localhost kernel: pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
> 
> Then I tried to map cd drive using udftools' pktsetup (v.1.0.3b):
> 
> Dec 30 08:33:27 localhost kernel: cdrom: This disc doesn't have any tracks I recognize!
> Dec 30 08:33:27 localhost kernel: Badness in __put_task_struct at kernel/fork.c:91
...
> Dec 30 08:05:52 localhost kernel: Software Suspend Core.
> Dec 30 08:05:52 localhost kernel: Software Suspend text mode support loaded.
> Dec 30 08:05:52 localhost kernel: Software Suspend LZF Compression Driver registered.
> Dec 30 08:05:52 localhost kernel: Software Suspend Swap Writer registered.

It's actually the swsusp 2 patches that don't handle the pktcdvd
driver correctly. The kthread_run() function was changed, but the
pktcdvd driver wasn't updated accordingly. I think this patch will fix
the problem.

--- linux/drivers/block/pktcdvd.c.old	2004-12-30 20:11:54.400478672 +0100
+++ linux/drivers/block/pktcdvd.c	2004-12-30 20:12:09.617165384 +0100
@@ -2364,7 +2364,7 @@
 	pkt_init_queue(pd);
 
 	atomic_set(&pd->cdrw.pending_bios, 0);
-	pd->cdrw.thread = kthread_run(kcdrwd, pd, "%s", pd->name);
+	pd->cdrw.thread = kthread_run(kcdrwd, pd, PF_SYNCTHREAD, "%s", pd->name);
 	if (IS_ERR(pd->cdrw.thread)) {
 		printk("pktcdvd: can't start kernel thread\n");
 		ret = -ENOMEM;

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
