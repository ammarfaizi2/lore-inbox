Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbULHFlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbULHFlR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 00:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbULHFlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 00:41:17 -0500
Received: from gw.goop.org ([64.81.55.164]:55176 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S262029AbULHFlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 00:41:13 -0500
Subject: Re: 32-bit syscalls from 64-bit process on x86-64?
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041204144002.GA15404@vana.vc.cvut.cz>
References: <1102004520.8707.10.camel@localhost>
	 <20041203061520.GG31767@wotan.suse.de>
	 <1102115789.8707.122.camel@localhost>
	 <20041204144002.GA15404@vana.vc.cvut.cz>
Content-Type: text/plain
Date: Tue, 07 Dec 2004 18:30:56 -0800
Message-Id: <1102473057.11405.51.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-0.mozer.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-12-04 at 15:40 +0100, Petr Vandrovec wrote:
> Seems to work for me.  See second example below.  If it won't work, you
> can always use reverse procedure to one I used in syscall.c - only
> problem is that you'll have to allocate some memory below 4GB to
> hold code & stack during 32bit syscall.

I've been playing with this.

If I have a 64-bit process, and I switch to the 32-bit segment with ljmp
it works fine - until I get a signal.  The kernel doesn't reload cs with
the 64-bit segment before calling the handler, which causes an obvious
mess.  I've been experimenting with setting the handler to this little
trampoline:

handler32:
.code32
	ljmp *1f
.code64
1:	.long handler	/* x86-64 handler */
	.word 0x33	/* USER_CS */

but this always gets a SIGSEGV on the ljmp.  I don't know why - there
are lots of reasons for getting a GPF, and there doesn't seem to be a
way to distinguish them.

(Hm, if I change this to the "ljmp $0x33, $handler" form, it gets to
handler, but then crashes because rsp has been truncated to 32-bits.
Hmm2, OK, so if I set up a 32-bit stack and a signal stack, it all works
OK.)

Any ideas?  Is this a kernel bug: should it always make sure that CS has
the right value before starting a signal handler?  I notice that the
ia32 kernel reloads cs before starting a signal handler.

	J

