Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWAENrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWAENrL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 08:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWAENrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 08:47:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31188 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751254AbWAENrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 08:47:09 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1136301286.2869.2.camel@laptopd505.fenrus.org> 
References: <1136301286.2869.2.camel@laptopd505.fenrus.org>  <20060103100632.GA23154@elte.hu> <16604.1136300837@warthog.cambridge.redhat.com> 
To: Arjan van de Ven <arjan@infradead.org>
Cc: David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 00/19] mutex subsystem, -V11 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Thu, 05 Jan 2006 13:44:55 +0000
Message-ID: <20379.1136468695@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:

> > Can you arrange .text.lock.mutex+0 here to just jump directly to
> > __mutex_lock_noinline? Otherwise we have an unnecessarily extended return
> > path.
> 
> jmp is free on x86. eg zero cycles. Any trickery is more likely to cost
> because of doing unexpected things.

I'm talking about replacing:

	<caller>:		call
	mutex_lock:		 lock decl
	mutex_lock:		 js
	.text.lock.mutex:	  call
	__mutex_lock:		   ret
	.text.lock.mutex:	  jmp
	mutex_lock:		 ret
	<caller>:		...

With:

	<caller>:		call
	mutex_lock:		 lock decl
	mutex_lock:		 js
	.text.lock.mutex:	  jmp
	__mutex_lock:		   ret
	<caller>:		...

Or:

	<caller>:		call
	mutex_lock:		 lock decl
	mutex_lock:		 js
	__mutex_lock:		  ret
	<caller>:		...

This sort of thing is done by the compiler when it does tail-calling.

> > You may not want to make the JS go directly there, but you could have that
> > go to a JMP to __mutex_lock_noinline rather than having a CALL followed by
> > a JMP back to a return instruction.
> 
> unbalanced call/ret pairs are REALLY expensive on x86. The current x86
> processors all do branch prediction on the ret based on a special
> internal call stack, breaking the symmetry is thus a branch prediction
> miss, eg 40+ cycles

In what way would this be unbalanced? You end up with one fewer CALL and one
fewer RET instruction. And why would the CPU think this is any different from
a function with a conditional branch in it? Eg:

	<caller>:		call
	mutex_lock:		 lock decl
	mutex_lock:		 js
	mutex_lock:		 ret
	<caller>:		...

The only route to __mutex_lock would be through mutex_lock...

Are there docs on this feature of the x86 anywhere?

David
