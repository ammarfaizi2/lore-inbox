Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275042AbRJBOWF>; Tue, 2 Oct 2001 10:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274617AbRJBOVp>; Tue, 2 Oct 2001 10:21:45 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:6660 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S274243AbRJBOVl>; Tue, 2 Oct 2001 10:21:41 -0400
Date: Tue, 2 Oct 2001 10:22:10 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: printk while interrupts are disabled
Message-ID: <20011002102210.B1630@mueller.datastacks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3BB9A6F4.6BDDAA81@berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BB9A6F4.6BDDAA81@berlin.de>; from n.roos@berlin.de on Tue, Oct 02, 2001 at 01:37:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

++ 02/10/01 13:37 +0200 - Norbert Roos:
> Hello!
> 
> Simple question: Do printk()s get printed while interrupts are disabled
> (after cli)?

They get stuffed into a buffer to be printed later. It is possible to
overflow that buffer, and lose some of your printk messages.

from krenel/printk.c:
/*
 * This is printk.  It can be called from any context.  We want it to
 * work.
 * 
 * We try to grab the console_sem.  If we succeed, it's easy - we log
 * the output and
 * call the console drivers.  If we fail to get the semaphore we place
 * the output
 * into the log buffer and return.  The current holder of the
 * console_sem will
 * notice the new output in release_console_sem() and will send it to
 * the
 * consoles before releasing the semaphore.
 *
 * One effect of this deferred printing is that code which calls
 * printk() and
 * then changes console_loglevel may break. This is because
 * console_loglevel
 * is inspected when the actual printing occurs.
 */
...
        /* This stops the holder of console_sem just where we want him
 * */
        spin_lock_irqsave(&logbuf_lock, flags);



-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$
