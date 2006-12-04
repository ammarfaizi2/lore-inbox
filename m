Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936260AbWLDMYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936260AbWLDMYA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 07:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936257AbWLDMYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 07:24:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52357 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936250AbWLDMX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 07:23:59 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061204114851.GA25859@elte.hu> 
References: <20061204114851.GA25859@elte.hu>  <20061201172149.GC3078@ftp.linux.org.uk> <1165064370.24604.36.camel@localhost.localdomain> <20061202140521.GJ3078@ftp.linux.org.uk> <1165070713.24604.50.camel@localhost.localdomain> <20061202160252.GQ14076@parisc-linux.org> <1165082803.24604.54.camel@localhost.localdomain> <20061202181957.GK3078@ftp.linux.org.uk> 
To: Ingo Molnar <mingo@elte.hu>
Cc: Al Viro <viro@ftp.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] timers, pointers to functions and type safety 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 04 Dec 2006 12:22:44 +0000
Message-ID: <28665.1165234964@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:

> the question is: which is more important, the type safety of a 
> container_of() [or type cast], which if we get it wrong produces a 
> /very/ trivial crash that is trivial to fix - or embedded timers data 
> structure size all around the kernel? I believe the latter is more 
> important.

Indeed yes.

Using container_of() and ditching the data value, you generally have to have
one extra instruction per timer handler, if that, but you are able to discard
one instruction or more from __run_timers() and struct timer_list discards a
word.

You will almost certainly have far more timer_list structs in the kernel than
timer handler functions, therefore it's a space win, and possibly also a time
win (if the reduction of __run_timers() is greater than the increase in the
timer handler).

And that extra instruction in the timer handler is usually going to be an
addition or subtraction of a small immediate value - which may be zero (in
which case the insn is dropped) or which may be folded directly into memory
access instruction offsets.

David
