Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262513AbVD3FNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbVD3FNZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 01:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbVD3FNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 01:13:25 -0400
Received: from ozlabs.org ([203.10.76.45]:397 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262510AbVD3FNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 01:13:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17011.5098.292582.129522@cargo.ozlabs.ibm.com>
Date: Sat, 30 Apr 2005 15:13:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Benjamin LaHaise <bcrl@kvack.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] unify semaphore implementations
In-Reply-To: <17010.58144.95239.716600@cargo.ozlabs.ibm.com>
References: <20050428182926.GC16545@kvack.org>
	<17009.33633.378204.859486@cargo.ozlabs.ibm.com>
	<20050429141437.GA24617@kvack.org>
	<1114789320.10086.81.camel@lade.trondhjem.org>
	<17010.58144.95239.716600@cargo.ozlabs.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

> The only fast path that needs atomic_dec_if_positive is down_trylock.
> You can use atomic_dec for down_trylock instead; the only downside to
> that is that if somebody was holding the semaphore but nobody was
> waiting, the holder will take the slow path when it does the up.

Better still, on machines without ll/sc we can do down_trylock as:

	return atomic_read(&sem->count) <= 0
		|| atomic_add_negative(-1, &sem->count);

Then we will only take the slow path unnecessarily on up() if another
cpu decrements the count between the test and the atomic_add_negative,
which should be very rare.  Doing the test will also avoid doing the
atomic op if the semaphore is already held.

Paul.
