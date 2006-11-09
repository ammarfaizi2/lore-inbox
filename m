Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966064AbWKIWmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966064AbWKIWmS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 17:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966066AbWKIWmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 17:42:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46506 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966064AbWKIWmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 17:42:17 -0500
To: Zach Brown <zach.brown@oracle.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC][PATCH] Fix lock inversion aio_kick_handler()
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
References: <20060729001032.GA7885@tetsuo.zabbo.net>
	<20060729013446.GA3387@kvack.org> <44CAC1AF.6010505@oracle.com>
From: Jeff Moyer <jmoyer@redhat.com>
Date: Thu, 09 Nov 2006 17:41:47 -0500
Message-ID: <x49velokztg.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> On Fri, 28 Jul 2006 19:02:23 -0700, Zach Brown <zach.brown@oracle.com> said:

Zach> Benjamin LaHaise wrote:
Zach> > On Fri, Jul 28, 2006 at 05:10:32PM -0700, Zach Brown wrote:
Zach> >> Fix lock inversion aio_kick_handler()
Zach> > 
Zach> > Doh.  Unfortunately, this patch isn't entirely correct as it
Zach> could race with > __put_ioctx() which sets ioctx->mm = NULL.

Zach> Aha, yeah, that's what I was missing.  Thanks.

Zach> > Something like the following should do the trick:

Zach> Cool, I'll respin and send it out.

Did you ever resend this patch, Zach?  It doesn't appear to be in
current kernels.  I'm still running into the lockdep warnings.

-Jeff

--- linux-2.6.19-rc5-mm1/fs/aio.c.orig	2006-11-09 17:28:43.000000000 -0500
+++ linux-2.6.19-rc5-mm1/fs/aio.c	2006-11-09 17:29:29.000000000 -0500
@@ -864,13 +864,15 @@ static void aio_kick_handler(void *data)
 	struct kioctx *ctx = data;
 	mm_segment_t oldfs = get_fs();
 	int requeue;
+	struct mm_struct *mm;
 
 	set_fs(USER_DS);
 	use_mm(ctx->mm);
 	spin_lock_irq(&ctx->ctx_lock);
 	requeue =__aio_run_iocbs(ctx);
- 	unuse_mm(ctx->mm);
+	mm = ctx->mm;
 	spin_unlock_irq(&ctx->ctx_lock);
+ 	unuse_mm(mm);
 	set_fs(oldfs);
 	/*
 	 * we're in a worker thread already, don't use queue_delayed_work,
