Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVAYB5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVAYB5r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 20:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVAYB5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 20:57:41 -0500
Received: from fire.osdl.org ([65.172.181.4]:5827 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261708AbVAYB5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 20:57:19 -0500
Subject: Re: [PATCH] BUG in io_destroy (fs/aio.c:1248)
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <20050124165856.02ac0c50.akpm@osdl.org>
References: <41F04D73.20800@us.ibm.com> <20050124085805.GA4462@in.ibm.com>
	 <20050124155613.3a741825.akpm@osdl.org>
	 <1106613801.11633.2.camel@localhost.localdomain>
	 <20050124165856.02ac0c50.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1106618202.9346.26.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 24 Jan 2005 17:56:42 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-24 at 16:58, Andrew Morton wrote:
> "Darrick J. Wong" <djwong@us.ibm.com> wrote:
> >
> > Andrew Morton wrote:
> > 
> > > So...  Will someone be sending a new patch?
> > 
> > Here's a cheesy patch that simply marks the ioctx as dead before
> > destroying it.
> 
> super-cheesy, given that `ctx' is an unsigned long.
> 
> > +		spin_lock_irq(&ctx->ctx_lock);
> > +		ctx->dead = 1;
> > +		spin_unlock_irq(&ctx->ctx_lock);
> > +
> 
> Even with this fixed up, the locking looks very odd.
> 
> Needs more work, please.  Or we just run with the original patch which I
> assume was tested.  It's a rare error path and performance won't matter.

The use of 'dead' looks very strange.  It is set to 1 in
aio_cancel_all() while holding spin_lock_irq(&ctx->ctx_lock);
but it is set to 1 in io_destroy() holding
write_lock(&mm->ioctx_list_lock);

The io_destroy() comment says
"Protects against races with itself via ->dead."

I assume the race the comment is talking about is
multiple threads calling io_destroy() on the same
ctx.  io_destroy() in only called from sys_io_destroy() or
from sys_io_setup() in the failure case that is trying
to be fixed.

aio_cancel_all() is only called from exit_aio() when the
mm is going away.  So this path is using 'dead' for something
else since the mm cannot go away twice (and there cannot be
an io_destroy() in progress or the mm would not be going away).

The overloading of 'dead' is ugly and confusing.

The use of spin_lock_irq(&ctx->ctx_lock) in sys_io_setup()
does not do any good AFAICT.

Daniel





