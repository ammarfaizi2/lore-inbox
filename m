Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262565AbVDABWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbVDABWh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 20:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVDABWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 20:22:36 -0500
Received: from pat.uio.no ([129.240.130.16]:41149 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262555AbVDABWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 20:22:31 -0500
Subject: Re: [RFC] Add support for semaphore-like structure with support
	for asynchronous I/O
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20050331161350.0dc7d376.akpm@osdl.org>
References: <1112219491.10771.18.camel@lade.trondhjem.org>
	 <20050330143409.04f48431.akpm@osdl.org>
	 <1112224663.18019.39.camel@lade.trondhjem.org>
	 <1112309586.27458.19.camel@lade.trondhjem.org>
	 <20050331161350.0dc7d376.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 20:22:17 -0500
Message-Id: <1112318537.11284.10.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.41, required 12,
	autolearn=disabled, AWL 1.54, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 31.03.2005 Klokka 16:13 (-0800) skreiv Andrew Morton:
> Trond Myklebust <trondmy@trondhjem.org> wrote:
> >
> >  on den 30.03.2005 Klokka 18:17 (-0500) skreiv Trond Myklebust:
> >  > > Or have I misunderstood the intent?  Some /* comments */ would be appropriate..
> >  > 
> >  > Will do.
> > 
> >  OK. Plenty of comments added that will hopefully clarify what is going
> >  on and how to use the API. Also some cleanups of the code.
> 
> Ah, so that's what it does ;)
> 
> I guess once we have a caller in-tree we could merge this.  I wonder if
> there's other existing code which should be converted to iosems.

I can put it into the NFS client stream which feeds into the -mm kernel.
That will enable me to queue up the NFSv4 patches that depend on it
too...

> You chose to not use the aio kernel threads?

I thought I'd do that in a separate patch since the aio workqueue is
currently statically defined in aio.c.

> Does iosem_lock_and_schedule_function() need locking?  It nonatomically
> alters *lk_state.

iosem_lock_and_schedule_function() will always be called with the
iosem->wait.lock held, since it is a waitqueue notification function.

In practice it is called by iosem_unlock(). The call to wake_up_locked()
will trigger a call to __wake_up_common() which again tries the
notification function of each waiter on the queue until it finds one
that succeeds.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

