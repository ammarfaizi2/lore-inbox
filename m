Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbTIXRoc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 13:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbTIXRoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 13:44:32 -0400
Received: from hera.kernel.org ([63.209.29.2]:12712 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261489AbTIXRob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 13:44:31 -0400
To: linux-kernel@vger.kernel.org
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Can we kill f inb_p, outb_p and other random I/O on port 0x80, in 2.6?
Date: Wed, 24 Sep 2003 10:43:39 -0700
Organization: OSDL
Message-ID: <bksl4b$d6b$1@build.pdx.osdl.net>
References: <20030922153651.16497.qmail@science.horizon.com> <m1brtck6wq.fsf@ebiederm.dsl.xmission.com> <20030922215432.GE29869@mail.jlokier.co.uk> <bkq44o$f47$1@gatekeeper.tmr.com>
Reply-To: torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: build.pdx.osdl.net 1064425419 13515 172.20.1.2 (24 Sep 2003 17:43:39 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 24 Sep 2003 17:43:39 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bill davidsen wrote:
>
> Isn't one of the benefits of a rethink not to use any i/o bus cycles?

I wouldn't worry about the bloat as much as I do about synchronization.

Doing an IO to an ISA device not just causes a delay, but tends to actually
force the PCI forwarding buffers to flush. 

Of course, IOIO shouldn't be buffered anyway, and if we wanted to flush
stuff we'd actually be better with a read, so..

But what we _could_ do is to make "inb_p()" be more like this

        #define inb_p(port) ({ unsigned char val; \
                asm volatile("call __inb_p" \
                        :"=a" (val) \
                        :"d" ((unsigned short)(port))); \
                val; })

where we call to an out-of-line function with a magic calling convention (so
that it doesn't flush the register state like a normal call would).

That would likely shrink the code, and it would mean that we could more
easily play with what we do in the delay case (including deciding the code
at boot-time).

Anybody want to try that?

                Linus
