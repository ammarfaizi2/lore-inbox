Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWACPOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWACPOx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 10:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWACPOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 10:14:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60139 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932397AbWACPOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 10:14:52 -0500
Subject: Re: [patch 00/19] mutex subsystem, -V11
From: Arjan van de Ven <arjan@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Al Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <16604.1136300837@warthog.cambridge.redhat.com>
References: <20060103100632.GA23154@elte.hu>
	 <16604.1136300837@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 16:14:45 +0100
Message-Id: <1136301286.2869.2.camel@laptopd505.fenrus.org>
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

On Tue, 2006-01-03 at 15:07 +0000, David Howells wrote:
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > this is version -V11 of the generic mutex subsystem, against v2.6.15.
> 
> When compiling for x86 with no mutex debugging, I see:
> 
> 	(gdb) disas mutex_lock
> 	Dump of assembler code for function mutex_lock:
> 	0xc02950d0 <mutex_lock+0>:      lock decl (%eax)
> 	0xc02950d3 <mutex_lock+3>:      js     0xc02950ef <.text.lock.mutex>
> 	0xc02950d5 <mutex_lock+5>:      ret    
> 	End of assembler dump.
> 	(gdb) disas 0xc02950ef
> 	Dump of assembler code for function .text.lock.mutex:
> 	0xc02950ef <.text.lock.mutex+0>:        call   0xc0294ffb <__mutex_lock_noinline>
> 	0xc02950f4 <.text.lock.mutex+5>:        jmp    0xc02950d5 <mutex_lock+5>
> 	0xc02950f6 <.text.lock.mutex+7>:        call   0xc029509f <__mutex_unlock_noinline>
> 	0xc02950fb <.text.lock.mutex+12>:       jmp    0xc02950db <mutex_unlock+5>
> 	End of assembler dump.
> 
> Can you arrange .text.lock.mutex+0 here to just jump directly to
> __mutex_lock_noinline? Otherwise we have an unnecessarily extended return
> path.

jmp is free on x86. eg zero cycles. Any trickery is more likely to cost
because of doing unexpected things.

> 
> You may not want to make the JS go directly there, but you could have that go
> to a JMP to __mutex_lock_noinline rather than having a CALL followed by a JMP
> back to a return instruction.

unbalanced call/ret pairs are REALLY expensive on x86. The current x86
processors all do branch prediction on the ret based on a special
internal call stack, breaking the symmetry is thus a branch prediction
miss, eg 40+ cycles


