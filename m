Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbTEDUry (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 16:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbTEDUrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 16:47:53 -0400
Received: from verein.lst.de ([212.34.181.86]:39696 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S261704AbTEDUrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 16:47:48 -0400
Date: Sun, 4 May 2003 23:00:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@redhat.com>
Cc: trond.myklebust@fys.uio.no, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove useless MOD_{INC,DEC}_USE_COUNT from sunrpc
Message-ID: <20030504230010.A12753@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	"David S. Miller" <davem@redhat.com>, trond.myklebust@fys.uio.no,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <20030504191447.C10659@lst.de> <16053.20430.903508.188812@charged.uio.no> <20030504203655.A11574@lst.de> <16053.24599.277205.64363@charged.uio.no> <20030504205306.A11647@lst.de> <16053.25445.434038.90945@charged.uio.no> <1052075166.27465.12.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1052075166.27465.12.camel@rth.ninka.net>; from davem@redhat.com on Sun, May 04, 2003 at 12:06:06PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 04, 2003 at 12:06:06PM -0700, David S. Miller wrote:
> Well, what if this hangs?  Unless the user specifies
> "--wait" to 2.5.x's rmmod, the user absolutely does not
> expect this behavior.
> 
> Rather, so that the "--wait" is respected, something one level
> up ought to be doing try_module_get().

Oh well, what about something like the following?


--- 1.25/net/sunrpc/sched.c	Thu May  1 12:52:23 2003
+++ edited/net/sunrpc/sched.c	Sun May  4 21:25:21 2003
@@ -952,6 +952,14 @@
 	wait_queue_head_t *assassin = (wait_queue_head_t*) ptr;
 	int		rounds = 0;
 
+	/*
+	 * We are locked into memory by beeing used by another module,
+	 * but the refcount might be 0 neverless so we can't use
+	 * __module_get().
+	 */
+	if (!try_module_get(THIS_MODULE))
+		return -EBUSY;
+
 	lock_kernel();
 	/*
 	 * Let our maker know we're running ...
@@ -994,6 +1002,7 @@
 
 	dprintk("RPC: rpciod exiting\n");
 	unlock_kernel();
+	module_put(THIS_MODULE);
 	return 0;
 }
 
@@ -1042,6 +1051,11 @@
 	if (error < 0) {
 		printk(KERN_WARNING "rpciod_up: create thread failed, error=%d\n", error);
 		rpciod_users--;
+		goto out;
+	}
+	if (!rpciod_pid) {
+		rpciod_users--;
+		error = -EBUSY;
 		goto out;
 	}
 	down(&rpciod_running);
