Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261642AbSJMTeW>; Sun, 13 Oct 2002 15:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261643AbSJMTeV>; Sun, 13 Oct 2002 15:34:21 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:54792
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261642AbSJMTeU>; Sun, 13 Oct 2002 15:34:20 -0400
Subject: Re: in_atomic() & spin_lock / spin_unlock in different functions
From: Robert Love <rml@tech9.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20021013203838.A122@elf.ucw.cz>
References: <20021013203838.A122@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Oct 2002 15:40:09 -0400
Message-Id: <1034538009.753.4507.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-13 at 14:38, Pavel Machek wrote:

> I'm doing spin_lock_irqsave() then in another function
> spin_unlock_irqrestore. Is that okay? If no, can it cause "scheduling
> in atomic"?

It is not OK if the function is run by a different process.  Then one
process will have a preempt_count one larger than it should and one
would have a preempt_count one smaller.

The task with the one smaller preempt_count will probably cause a crash
when it preemptively reschedules erroneously.

In other words, you have:

	Process A		Process B
	preempt_count++
				preempt_count--

When both of those routines need to be done by the same process.

Also, you cannot use spin_lock_irqsave() in different functions at all
on sparc as it contains stack information.

	Robert Love

