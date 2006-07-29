Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752001AbWG2Bey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbWG2Bey (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 21:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbWG2Bey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 21:34:54 -0400
Received: from kanga.kvack.org ([66.96.29.28]:45750 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751992AbWG2Bex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 21:34:53 -0400
Date: Fri, 28 Jul 2006 21:34:46 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC][PATCH] Fix lock inversion aio_kick_handler()
Message-ID: <20060729013446.GA3387@kvack.org>
References: <20060729001032.GA7885@tetsuo.zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060729001032.GA7885@tetsuo.zabbo.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 05:10:32PM -0700, Zach Brown wrote:
> Fix lock inversion aio_kick_handler()

Doh.  Unfortunately, this patch isn't entirely correct as it could race with 
__put_ioctx() which sets ioctx->mm = NULL.  Something like the following 
should do the trick:

	struct mm_struct *mm;
...
> - 	unuse_mm(ctx->mm);
+	mm = ctx->mm;
>  	spin_unlock_irq(&ctx->ctx_lock);
+ 	unuse_mm(mm);
>  	set_fs(oldfs);
>  	/*
...


		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
