Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbTEDSYb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 14:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbTEDSYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 14:24:31 -0400
Received: from verein.lst.de ([212.34.181.86]:58127 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S261339AbTEDSY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 14:24:29 -0400
Date: Sun, 4 May 2003 20:36:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove useless MOD_{INC,DEC}_USE_COUNT from sunrpc
Message-ID: <20030504203655.A11574@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <20030504191447.C10659@lst.de> <16053.20430.903508.188812@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16053.20430.903508.188812@charged.uio.no>; from trond.myklebust@fys.uio.no on Sun, May 04, 2003 at 07:37:18PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 04, 2003 at 07:37:18PM +0200, Trond Myklebust wrote:
> There's another case which you appear to be ignoring: rpciod_down() is
> interruptible and does not have to wait on the rpciod() thread to
> complete.

What do you thing about something like the following to wait on the
thread in module_exit()?


--- 1.10/include/linux/sunrpc/sched.h	Sun Jan 12 16:40:13 2003
+++ edited/include/linux/sunrpc/sched.h	Sun May  4 19:08:09 2003
@@ -188,6 +188,7 @@
 int		rpciod_up(void);
 void		rpciod_down(void);
 void		rpciod_wake_up(void);
+void		wait_on_rpciod(void);
 #ifdef RPC_DEBUG
 void		rpc_show_tasks(void);
 #endif
--- 1.24/net/sunrpc/sched.c	Thu Mar 27 12:42:11 2003
+++ edited/net/sunrpc/sched.c	Sun May  4 19:07:42 2003
@@ -1097,6 +1092,12 @@
 	spin_unlock_irqrestore(&current->sighand->siglock, flags);
 out:
 	up(&rpciod_sema);
+}
+
+void
+wait_on_rpciod(void)
+{
+	wait_event_interruptible(rpciod_killer, !rpciod_pid);
 }
 
 #ifdef RPC_DEBUG
