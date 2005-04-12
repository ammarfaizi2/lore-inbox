Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVDLAcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVDLAcl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 20:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVDLAcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 20:32:41 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:35753 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261984AbVDLAcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 20:32:31 -0400
Date: Tue, 12 Apr 2005 10:26:03 +1000
From: Nathan Scott <nathans@sgi.com>
To: Pavel Machek <pavel@suse.cz>
Cc: "Barry K. Nathan" <barryn@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, hare@suse.de, linux-xfs@oss.sgi.com
Subject: Re: [xfs-masters] swsusp vs. xfs [was Re: 2.6.12-rc2-mm1]
Message-ID: <20050412002603.GA1178@frodo>
References: <20050407030614.GA7583@ip68-4-98-123.oc.oc.cox.net> <20050408103327.GD1392@elf.ucw.cz> <20050410211808.GA12118@ip68-4-98-123.oc.oc.cox.net> <20050410212747.GB26316@elf.ucw.cz> <20050410225708.GB12118@ip68-4-98-123.oc.oc.cox.net> <20050410230053.GD12794@elf.ucw.cz> <20050411043124.GA24626@ip68-4-98-123.oc.oc.cox.net> <20050411105759.GB1373@elf.ucw.cz> <20050411231213.GD702@frodo> <20050411235110.GA2472@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411235110.GA2472@elf.ucw.cz>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 01:51:10AM +0200, Pavel Machek wrote:
> I should take some sleep now, so I can't test the patch, but I don't
> think it will help. If someone has PF_FREEZE set, he should be in
> refrigerator.

OK, so if that doesn't help, here's an alternate approach - this
lets xfsbufd track when its entering the refrigerator(), so that
other callers know that attempts to wake it are futile.

cheers.

-- 
Nathan


--- fs/xfs/linux-2.6/xfs_buf.c.orig	2005-04-12 09:00:26.375351560 +1000
+++ fs/xfs/linux-2.6/xfs_buf.c	2005-04-12 10:14:27.468202824 +1000
@@ -1746,13 +1746,15 @@ STATIC DECLARE_COMPLETION(pagebuf_daemon
 STATIC struct task_struct *pagebuf_daemon_task;
 STATIC int pagebuf_daemon_active;
 STATIC int force_flush;
-
+STATIC int force_sleep;
 
 STATIC int
 pagebuf_daemon_wakeup(
 	int			priority,
 	unsigned int		mask)
 {
+	if (force_sleep)
+		return 0;
 	force_flush = 1;
 	barrier();
 	wake_up_process(pagebuf_daemon_task);
@@ -1778,7 +1780,12 @@ pagebuf_daemon(
 
 	INIT_LIST_HEAD(&tmp);
 	do {
-		try_to_freeze(PF_FREEZE);
+		if (unlikely(current->flags & PF_FREEZE)) {
+			force_sleep = 1;
+			refrigerator(PF_FREEZE);
+		} else {
+			force_sleep = 0;
+		}
 
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout((xfs_buf_timer_centisecs * HZ) / 100);
