Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265244AbTLKUOn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 15:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbTLKUOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 15:14:43 -0500
Received: from hell.org.pl ([212.244.218.42]:42245 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S265244AbTLKUOk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 15:14:40 -0500
Date: Thu, 11 Dec 2003 21:14:44 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Announce: Software Suspend 2.0rc3 for 2.4 and 2.6.
Message-ID: <20031211201444.GA18122@hell.org.pl>
Mail-Followup-To: Nigel Cunningham <ncunningham@clear.net.nz>,
	swsusp-devel <swsusp-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1071030171.3344.29.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <1071030171.3344.29.camel@laptop-linux>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline

Thus wrote Nigel Cunningham:
> This is to announce 2.0-rc3, now being uploaded to swsusp.sf.net.

Hi,
I've just tested it on 2.4.23 as well -- no problems found, although the
XFS option patch needs updating -- probably as much as the 2.6 XFS code
(though the latter seems to suspend... I'll get to it later today).
Attached is the patch to bring the XFS code for 2.4 up to date (note: this
is not the whole xfs-option, it should be applied on top of the latter; I
can prepare a complete xfs-option if you care).

Oh, BTW: the slowdown I mentioned for 2.6 seems to hit this version also,
but in a different manner: I/O is fine, but the resuming kernel spends some
time on displaying "Freezing processes" -- what was unnoticeable under rc2
is somewhat awkward with rc3.

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename="swsusp-2.0-2.4-xfs.patch"

--- fs/xfs/pagebuf/page_buf.c~	2003-10-25 15:34:51.000000000 +0200
+++ fs/xfs/pagebuf/page_buf.c	2003-10-25 15:59:49.000000000 +0200
@@ -1645,11 +1645,11 @@
 	current->flags |= PF_MEMALLOC;
 
 	SWSUSP_THREAD_FLAGS_RESET;
-	SWSUSP_ACTIVITY_START;
+	SWSUSP_ACTIVITY_START(PF_SYNCTHREAD);
 
 	INIT_LIST_HEAD(&tmp);
 	do {
-		SWSUSP_ACTIVITY_PAUSING;
+		SWSUSP_ACTIVITY_SYNCTHREAD_PAUSING;
 
 		if (pbd_active == 1) {
 			mod_timer(&pb_daemon_timer,
@@ -1661,7 +1661,7 @@
 			del_timer_sync(&pb_daemon_timer);
 		}
 
-		SWSUSP_ACTIVITY_RESTARTING;
+		SWSUSP_ACTIVITY_RESTARTING(PF_SYNCTHREAD);
 		spin_lock(&pbd_delwrite_lock);
 
 		count = 0;
@@ -2096,7 +2096,7 @@
 
 		if (TQ_ACTIVE(pagebuf_iodone_tq[cpu]))
 			__set_task_state(current, TASK_RUNNING);
-		SWSUSP_ACTIVITY_PAUSING;
+		SWSUSP_ACTIVITY_SYNCTHREAD_PAUSING;
 		schedule();
 		SWSUSP_ACTIVITY_RESTARTING(PF_SYNCTHREAD);
 		remove_wait_queue(&pagebuf_iodone_wait[cpu], &wait);
--- fs/xfs/linux/xfs_super.c~	2003-10-25 15:34:51.000000000 +0200
+++ fs/xfs/linux/xfs_super.c	2003-10-25 16:00:47.000000000 +0200
@@ -444,13 +444,13 @@
 	wake_up(&vfsp->vfs_wait_sync_task);
 
 	SWSUSP_THREAD_FLAGS_RESET;
-	SWSUSP_ACTIVITY_START;
+	SWSUSP_ACTIVITY_START(PF_SYNCTHREAD);
 
 	for (;;) {
-		SWSUSP_ACTIVITY_PAUSING;
+		SWSUSP_ACTIVITY_SYNCTHREAD_PAUSING;
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(xfs_syncd_interval);
-		SWSUSP_ACTIVITY_RESTARTING;
+		SWSUSP_ACTIVITY_RESTARTING(PF_SYNCTHREAD);
 		if (vfsp->vfs_flag & VFS_UMOUNT)
 			break;
 		if (vfsp->vfs_flag & VFS_RDONLY)

--SLDf9lqlvOQaIe6s--
