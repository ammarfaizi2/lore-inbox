Return-Path: <linux-kernel-owner+w=401wt.eu-S964807AbWLOB6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWLOB6q (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 20:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWLOB6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 20:58:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:38437 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964807AbWLOB6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 20:58:45 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,171,1165219200"; 
   d="scan'208"; a="174721531:sNHT20977264"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>, <linux-aio@kvack.org>,
       "'xb'" <xavier.bru@bull.net>, <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.18.4: flush_workqueue calls mutex_lock in interrupt environment
Date: Thu, 14 Dec 2006 17:58:43 -0800
Message-ID: <000001c71fec$8d5ca370$d034030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Accf5339jWiQtQIlRdqjjNxFhLpISAABDM8A
In-Reply-To: <20061214172010.a3810c9d.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Thursday, December 14, 2006 5:20 PM
> it's hard to disagree.
> 
> Begin forwarded message:
> > On Wed, 2006-12-13 at 08:25 +0100, xb wrote:
> > > Hi all,
> > > 
> > > Running some IO stress tests on a 8*ways IA64 platform, we got:
> > >      BUG: warning at kernel/mutex.c:132/__mutex_lock_common()  message
> > > followed by:
> > >      Unable to handle kernel paging request at virtual address
> > > 0000000000200200
> > > oops corresponding to anon_vma_unlink() calling list_del() on a
> > > poisonned list.
> > > 
> > > Having a look to the stack, we see that flush_workqueue() calls
> > > mutex_lock() with softirqs disabled.
> > 
> > something is wrong here... flush_workqueue() is a sleeping function and
> > is not allowed to be called in such a context!
> 
> It seems utterly insane to have aio_complete() flush a workqueue. That
> function has to be called from a number of different environments,
> including non-sleep tolerant environments.
> 
> For instance it means that directIO on NFS will now cause the rpciod
> workqueues to call flush_workqueue(aio_wq), thus slowing down all RPC
> activity.

The bug appears to be somewhere else, somehow the ref count on ioctx is
all messed up.

In aio_complete, __put_ioctx() should not be invoked because ref count
on ioctx is supposedly more than 2, aio_complete decrement it once and
should return without invoking the free function.

The real freeing ioctx should be coming from exit_aio() or io_destroy(),
in which case both wait until no further pending AIO request via
wait_for_all_aios().

- Ken
