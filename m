Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752369AbWJ0R5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369AbWJ0R5W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 13:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752370AbWJ0R5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 13:57:22 -0400
Received: from host-233-54.several.ru ([213.234.233.54]:35220 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1752367AbWJ0R5V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 13:57:21 -0400
Date: Fri, 27 Oct 2006 21:56:52 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       Jay Lan <jlan@sgi.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 7/6] fill_tgid: cleanup delays accounting
Message-ID: <20061027175652.GA461@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fill_tgid() should skip not only an already exited group leader. If the
task has ->exit_state != 0 it already did exit_notify(), so it also did
fill_tgid_exit()->delayacct_add_tsk(->signal->stats) and we should skip
it to avoid a double accounting.

This patch doesn't close the race completely, but it cleanups the code.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- STATS/kernel/taskstats.c~7_estate	2006-10-27 03:03:40.000000000 +0400
+++ STATS/kernel/taskstats.c	2006-10-27 21:34:26.000000000 +0400
@@ -235,7 +235,7 @@ static int fill_tgid(pid_t tgid, struct 
 
 	tsk = first;
 	do {
-		if (tsk->exit_state == EXIT_ZOMBIE && thread_group_leader(tsk))
+		if (tsk->exit_state)
 			continue;
 		/*
 		 * Accounting subsystem can call its functions here to

