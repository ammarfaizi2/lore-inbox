Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422777AbWBNUEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422777AbWBNUEY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 15:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422779AbWBNUEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 15:04:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16073 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422777AbWBNUEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 15:04:23 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060214195130.GA21442@lst.de> 
References: <20060214195130.GA21442@lst.de>  <20060214175240.GC19080@lst.de> <6199.1139941212@warthog.cambridge.redhat.com> 
To: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rxrpc: use kthread_ API 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 14 Feb 2006 20:04:04 +0000
Message-ID: <8623.1139947444@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> > > +	krxiod_thread = kthread_run(rxrpc_krxiod, NULL, "krxiod");
> > > +	if (IS_ERR(krxiod_thread))
> > > +		return PTR_ERR(krxiod_thread);
> > > +	return 0;
> > 
> > Don't assign an error to (rxrpc_)krxiod_thread.
> 
> Well, kthread_run can returns errors.  If you want to avoid that for
> some reasons we'd need a local varibale

So what? There's an implicit local variable anyway. The compiler doesn't pass
the address of rxrpc_krxiod_thread to kthread_run() so that the latter can
fill it in; the result is returned in a register. Sticking a local variable in
the source would just attach a label to that register. Moving the assignment
to the global variable to after the error checking if-statement would then
mean the store instruction is emitted after the branch rather than before it.

> , which would be rather silly.

No. It'd probably be faster in the error case (no write to the memory).

> Note that there's nothing it could pollute, once one of these fails
> rxrpc_initialise goes to the error path, unwinds and returns a failure,
> so the rxrpc module never goes live.

At the moment, there's nothing it can pollute, you mean. Although you're
probably correct, it costs very little to program defensively in this case,
and in fact it's probably cheaper in execution time, even if it's a little
more expensive in terms of source code and work for you.

David
