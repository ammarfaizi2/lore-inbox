Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264015AbTDWMku (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 08:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264016AbTDWMku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 08:40:50 -0400
Received: from [81.80.245.157] ([81.80.245.157]:48033 "EHLO smtp.alcove-fr")
	by vger.kernel.org with ESMTP id S264015AbTDWMkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 08:40:49 -0400
Date: Wed, 23 Apr 2003 14:53:15 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Tony Spinillo <tspinillo@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ben Collins <bcollins@debian.org>
Subject: Re: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
Message-ID: <20030423125315.GH820@hottah.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Tony Spinillo <tspinillo@yahoo.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ben Collins <bcollins@debian.org>
References: <20030423122940.51011.qmail@web14002.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423122940.51011.qmail@web14002.mail.yahoo.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 05:29:40AM -0700, Tony Spinillo wrote:

> Stelian
> 
> Similiar problem here. Machine boots fine, but when I plug my DV
> camera in I can't cat /proc/bus/ieee1394/ devices, and I get looping
> messages in dmesg. If I move the 1394 drivers from pre-7 in, all works
> fine.
> (Thanks Dan). I submitted my logs and hw info to:
> http://sourceforge.net/mailarchive/forum.php?thread_id=2009188&forum_id=5387
> 

The following patch seems to cure my problem, I'm not sure yours
is the same.

I'm not absolutely sure about the corectness of the patch, but I
believe that kernel_thread should not be called with interrupts
disabled.

I'll leave up to the ieee1394 developpers to decide if some other,
semaphore based, locking is still necessary here.

Stelian.

===== drivers/ieee1394/nodemgr.c 1.19 vs edited =====
--- 1.19/drivers/ieee1394/nodemgr.c	Thu Apr 17 19:40:56 2003
+++ edited/drivers/ieee1394/nodemgr.c	Wed Apr 23 14:32:57 2003
@@ -1417,8 +1417,6 @@
 	init_completion(&hi->exited);
         sema_init(&hi->reset_sem, 0);
 
-	spin_lock_irqsave (&host_info_lock, flags);
-
 	hi->pid = kernel_thread(nodemgr_host_thread, hi,
 				CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
 	
@@ -1426,9 +1424,10 @@
 		HPSB_ERR ("NodeMgr: failed to start NodeMgr thread for %s",
 			  host->driver->name);
 		kfree(hi);
-		spin_unlock_irqrestore (&host_info_lock, flags);
 		return;
 	}
+
+	spin_lock_irqsave (&host_info_lock, flags);
 
 	list_add_tail(&hi->list, &host_info_list);
 
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
