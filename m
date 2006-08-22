Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWHVJfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWHVJfd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 05:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWHVJfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 05:35:33 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:64713 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751382AbWHVJfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 05:35:33 -0400
Date: Tue, 22 Aug 2006 18:38:20 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ebiederm@xmission.com,
       pj@sgi.com, saito.tadashi@soft.fujitsu.com
Subject: Re: [RFC][PATCH] ps command race fix take2 [4/4] proc_pid_readdir
Message-Id: <20060822183820.b62d44bd.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060822174302.e97f23d1.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060822174302.e97f23d1.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry, this rcu_read_lock() should be inserted.

-Kame

 fs/proc/base.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-2.6.18-rc4/fs/proc/base.c
===================================================================
--- linux-2.6.18-rc4.orig/fs/proc/base.c
+++ linux-2.6.18-rc4/fs/proc/base.c
@@ -2240,12 +2240,14 @@ retry:
 	 * insertion of token should be done just before not-stale task.
 	 */
 	if (task) {
+		rcu_read_lock();
 		pos = first_alive_task(task);
 		if (pos != task) { /* task is not alive */
 			if (pos)
 				get_task_struct(pos);
 			put_task_struct(task);
 		}
+		rcu_read_unlock();
 		if (pos) { /* remember here for next access */
 			/* token->token turns to be 1 */
 			insert_list_token_rcu(token, &pos->tasks);

