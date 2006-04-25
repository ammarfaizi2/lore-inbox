Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751544AbWDYP5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbWDYP5i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 11:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWDYP5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 11:57:38 -0400
Received: from pat.uio.no ([129.240.10.6]:32932 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751401AbWDYP5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 11:57:37 -0400
Subject: Re: question about nfs_execute_read: why do we need to do
	lock_kernel?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: Peter Staubach <staubach@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4ae3c140604250831v5a2f8714h7ab0beccba466da4@mail.gmail.com>
References: <4ae3c140604242157k26f39f71qcf6eed811f1e2d8@mail.gmail.com>
	 <1145941743.8164.6.camel@lade.trondhjem.org>
	 <4ae3c140604250708w438545c1lfa66233fdaa63cc@mail.gmail.com>
	 <444E3433.1040703@redhat.com>
	 <4ae3c140604250831v5a2f8714h7ab0beccba466da4@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 25 Apr 2006 11:57:21 -0400
Message-Id: <1145980641.8193.97.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.165, required 12,
	autolearn=disabled, AWL 1.65, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-25 at 11:31 -0400, Xin Zhao wrote:
> Thanks for your guys' reply!
> 
> Peter, can you point me somewhere I can check the semantics of BKL? In
> the past, I remembered BKL does block the kernel. So I am quite
> confused now.

That would have been true >10 years ago, when Alan introduced it.
Nowadays, the BKL is just another type of lock, albeit with very unique
properties. The two main ones being:
        - it can be taken recursively.
        - you can call schedule() while holding it.
                Note however, that upon yielding, the process
                automatically gives up the lock, then retakes it when it
                is rescheduled

> Also, I still don't understand why we use lock_kernel instead of some
> finer granularity lock. Trond's answer gave me a feeling that this is
> simply because the code is not carefully optimized.  :)

Sigh... Removing the BKL is not a trivial thing to do. You have make
absolutely sure that you understand the thread data dependencies that
are protected by that lock. That is why we do it gradually.

Cheers,
  Trond

