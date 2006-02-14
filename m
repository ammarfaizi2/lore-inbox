Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422755AbWBNSUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422755AbWBNSUd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422753AbWBNSUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:20:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21955 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422752AbWBNSUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:20:30 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060214175240.GC19080@lst.de> 
References: <20060214175240.GC19080@lst.de> 
To: Christoph Hellwig <hch@lst.de>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rxrpc: use kthread_ API 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 14 Feb 2006 18:20:12 +0000
Message-ID: <6199.1139941212@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> Use the kthread_ API instead of opencoding lots of hairy code for kernel
> thread creation and teardown.

I take it daemonize() does not now need to be called because the new process
derives from keventd.

You've also broken things... The waitqueue is there for a specific reason:
namely so that I can have multiple threads.

Actually, RxRPC and AFS should be made to use rpciod, except that Trond hasn't
got around to documenting it yet.

> +static struct task_struct *krxiod_thread;

That should be rxrpc_krxiod_thread.

> +	krxiod_thread = kthread_run(rxrpc_krxiod, NULL, "krxiod");
> +	if (IS_ERR(krxiod_thread))
> +		return PTR_ERR(krxiod_thread);
> +	return 0;

Don't assign an error to (rxrpc_)krxiod_thread.

> +static struct task_struct *krxsecd_thread;

Ditto on name.

> +	krxsecd_thread = kthread_run(rxrpc_krxsecd, NULL, "krxsecd");
> +	if (IS_ERR(krxsecd_thread))
> +		return PTR_ERR(krxsecd_thread);
> +	return 0;

Ditto on assignment of error.

> +static struct task_struct *krxtimod_thread;

Ditto on name (I'd got this one wrong too).

> +	krxtimod_thread = kthread_run(krxtimod, NULL, "krxtimod");
> +	if (IS_ERR(krxtimod_thread))
> +		return PTR_ERR(krxtimod_thread);
> +	return 0;

Ditto on assignment of error.

David
