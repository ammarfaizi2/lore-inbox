Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWACPIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWACPIa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 10:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWACPI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 10:08:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28329 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751437AbWACPI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 10:08:29 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060103100632.GA23154@elte.hu> 
References: <20060103100632.GA23154@elte.hu> 
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Al Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 00/19] mutex subsystem, -V11 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 03 Jan 2006 15:07:17 +0000
Message-ID: <16604.1136300837@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:

> this is version -V11 of the generic mutex subsystem, against v2.6.15.

When compiling for x86 with no mutex debugging, I see:

	(gdb) disas mutex_lock
	Dump of assembler code for function mutex_lock:
	0xc02950d0 <mutex_lock+0>:      lock decl (%eax)
	0xc02950d3 <mutex_lock+3>:      js     0xc02950ef <.text.lock.mutex>
	0xc02950d5 <mutex_lock+5>:      ret    
	End of assembler dump.
	(gdb) disas 0xc02950ef
	Dump of assembler code for function .text.lock.mutex:
	0xc02950ef <.text.lock.mutex+0>:        call   0xc0294ffb <__mutex_lock_noinline>
	0xc02950f4 <.text.lock.mutex+5>:        jmp    0xc02950d5 <mutex_lock+5>
	0xc02950f6 <.text.lock.mutex+7>:        call   0xc029509f <__mutex_unlock_noinline>
	0xc02950fb <.text.lock.mutex+12>:       jmp    0xc02950db <mutex_unlock+5>
	End of assembler dump.

Can you arrange .text.lock.mutex+0 here to just jump directly to
__mutex_lock_noinline? Otherwise we have an unnecessarily extended return
path.

You may not want to make the JS go directly there, but you could have that go
to a JMP to __mutex_lock_noinline rather than having a CALL followed by a JMP
back to a return instruction.


Admittedly, this may not be possible, as you're mixing up C and ASM, but it
would speed things up a little.

David
