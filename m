Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbVL0MGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbVL0MGE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 07:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVL0MGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 07:06:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:25323 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932296AbVL0MGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 07:06:02 -0500
Subject: Re: [patch 1/3] mutex subsystem: trylock
From: Arjan van de Ven <arjan@infradead.org>
To: Nicolas Pitre <nico@cam.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0512261411530.1496@localhost.localdomain>
References: <20051223161649.GA26830@elte.hu>
	 <Pine.LNX.4.64.0512261411530.1496@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 27 Dec 2005 13:05:58 +0100
Message-Id: <1135685158.2926.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-26 at 14:25 -0500, Nicolas Pitre wrote:
> Index: linux-2.6/include/asm-arm/mutex.h
> ===================================================================
> --- linux-2.6.orig/include/asm-arm/mutex.h
> +++ linux-2.6/include/asm-arm/mutex.h
> @@ -98,5 +98,31 @@ do {									\
>   */
>  #define __mutex_slowpath_needs_to_unlock()	1
>  
> +/*
> + * For __mutex_trylock we use another construct which could be described
> + * as an "incomplete atomic decrement" or a "single value cmpxchg" since
> + * it has two modes of failure:
> + *
> + * 1) if the exclusive store fails we fail, and
> + *
> + * 2) if the decremented value is not zero we don't even attempt the store.


btw I really think that 1) is wrong. trylock should do everything it can
to get the semaphore short of sleeping. Just because some cacheline got
written to (which might even be shared!) in the middle of the atomic op
is not a good enough reason to fail the trylock imho. Going into the
slowpath.. fine. But here it's a quality of implementation issue; you
COULD get the semaphore without sleeping (at least probably, you'd have
to retry to know for sure) but because something wrote to the same
cacheline as the lock... no. that's just not good enough.. sorry.


