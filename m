Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbTJNUr6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 16:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTJNUr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 16:47:58 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:16320 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262274AbTJNUr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 16:47:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16268.24826.62507.628677@gargle.gargle.HOWL>
Date: Tue, 14 Oct 2003 22:47:54 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Chris Lattner <sabre@nondot.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [x86] Access off the bottom of stack causes a segfault?
In-Reply-To: <Pine.LNX.4.44.0310141358420.4165-100000@nondot.org>
References: <Pine.LNX.4.56.0310141136080.2098@bigblue.dev.mdolabs.com>
	<Pine.LNX.4.44.0310141358420.4165-100000@nondot.org>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Lattner writes:
 > > > Generated code:
 > > >         .intel_syntax
 > > > ...
 > > > main:
 > > >         mov DWORD PTR [%ESP - 16004], %EBP    # Save EBP to stack
 > >                          ^^^^^^^^^^^^
 > >
 > > Yes, this is the problem (even Windows does that IIRC).
 > 
 > Ok, I realize what's going on here.  The question is, why does the linux
 > kernel consider this to be a bug?  Where (in the X86 specs) is it
 > documented that it's illegal to access off the bottom of the stack?

Signal handlers.

 > My compiler does a nice leaf function optimization where it does not even
 > bother to adjust the stack for leaf functions, which eliminates the adds
 > and subtracts entirely from these (common) functions.  This completely
 > invalidates the optimization.

The common definition of a leaf function is one that does
not need an activation record. Whether you call another
function or not is immaterial, it's the stack allocation
that counts. Your code is using an implicit activation
record, which, as you've found out, doesn't work.

If you desperately need to clobber below %esp (which is a bug
except on x86-64) then you can use sigaltstack() and SA_ONSTACK
in sigaction() to force signal handlers off your stack. Doing
this safely requires C library specific hacks. (Why? Because
not all sigaction() calls are in _your_ code, typically.)
