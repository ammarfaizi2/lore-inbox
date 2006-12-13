Return-Path: <linux-kernel-owner+w=401wt.eu-S964897AbWLMMln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWLMMln (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 07:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWLMMln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 07:41:43 -0500
Received: from pat.uio.no ([129.240.10.15]:48071 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964897AbWLMMlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 07:41:42 -0500
Subject: Re: 2.6.18.4: flush_workqueue calls mutex_lock in interrupt
	environment
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Arjan van de Ven <arjan@infradead.org>
Cc: xb <xavier.bru@bull.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1165996947.27217.725.camel@laptopd505.fenrus.org>
References: <457FAAFD.6000300@bull.net>
	 <1165996947.27217.725.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 07:41:18 -0500
Message-Id: <1166013678.5695.26.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.231, required 12,
	autolearn=disabled, AWL 1.63, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 09:02 +0100, Arjan van de Ven wrote:
> On Wed, 2006-12-13 at 08:25 +0100, xb wrote:
> > Hi all,
> > 
> > Running some IO stress tests on a 8*ways IA64 platform, we got:
> >      BUG: warning at kernel/mutex.c:132/__mutex_lock_common()  message
> > followed by:
> >      Unable to handle kernel paging request at virtual address
> > 0000000000200200
> > oops corresponding to anon_vma_unlink() calling list_del() on a
> > poisonned list.
> > 
> > Having a look to the stack, we see that flush_workqueue() calls
> > mutex_lock() with softirqs disabled.
> 
> something is wrong here... flush_workqueue() is a sleeping function and
> is not allowed to be called in such a context!

It seems utterly insane to have aio_complete() flush a workqueue. That
function has to be called from a number of different environments,
including non-sleep tolerant environments.

For instance it means that directIO on NFS will now cause the rpciod
workqueues to call flush_workqueue(aio_wq), thus slowing down all RPC
activity.

Trond

