Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbUCXHpT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 02:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbUCXHpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 02:45:19 -0500
Received: from palrel12.hp.com ([156.153.255.237]:46544 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263060AbUCXHpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 02:45:12 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16481.15493.591464.867776@napali.hpl.hp.com>
Date: Tue, 23 Mar 2004 23:45:09 -0800
To: Jakub Jelinek <jakub@redhat.com>
Cc: davidm@hpl.hp.com, Ulrich Drepper <drepper@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Non-Exec stack patches
In-Reply-To: <20040324072840.GK31589@devserv.devel.redhat.com>
References: <20040323231256.GP4677@tpkurt.garloff.de>
	<20040323154937.1f0dc500.akpm@osdl.org>
	<20040324002149.GT4677@tpkurt.garloff.de>
	<16480.55450.730214.175997@napali.hpl.hp.com>
	<4060E24C.9000507@redhat.com>
	<16480.59229.808025.231875@napali.hpl.hp.com>
	<20040324070020.GI31589@devserv.devel.redhat.com>
	<16481.13780.673796.20976@napali.hpl.hp.com>
	<20040324072840.GK31589@devserv.devel.redhat.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 24 Mar 2004 02:28:40 -0500, Jakub Jelinek <jakub@redhat.com> said:

  Jakub> On Tue, Mar 23, 2004 at 11:16:36PM -0800, David Mosberger
  Jakub> wrote:

  >> I'm not following you on the "get ld.so handling free" part.  How
  >> is that handling free?

  Jakub> What I meant is that it is already written and tested.

OK.  The ELF flags bit is even more free, then... ;-)

  >> Actually, that's something that worries me.  Somebody just needs
  >> to succeed in loading any shared object with the right
  >> PT_GNU_STACK header and then the entire program will be exposed
  >> to the risk of a writable stack.  On ia64, I just don't see any
  >> need to ever implicitly turn on execute-permission on the stack,
  >> so why allow this extra backdoor?

  Jakub> What kind of backdoor is it?  If you dlopen untrusted shared
  Jakub> libraries into your program you have far bigger problem than
  Jakub> executable stack (you can execute any code it wants in its
  Jakub> constructors).

Sure.  Theoretically, none of this matters at all (thanks to
mprotect()), so we're justs talking about raising the barrier.  With
PT_GNU_STACK, it's sufficient to tweak one bit in any dependent
library, whereas with the ELF flag bit, you need to tweak one bit in
the main executable.  Not a huge difference, I'll submit, but from an
admin perspective, I find it a lot easier to check the main program to
see if it has the "executable stack/data" bit set rather than all
dependent libraries.  Additionally, we could easily choose to drop
support for the ELF flag bit altogether.  The only program that I know
of that ever needed executable data was XFree86 and that was only due
to an oversight---and that has long been fixed.

  Jakub> If there is a shared library which needs executable stack for
  Jakub> its use (on !IA64 !PPC64 this is e.g. any library which takes
  Jakub> address of a nested function and passes it to some other
  Jakub> function and/or stores it into some variable which cannot be
  Jakub> optimized out, on IA64 or PPC64 this is of course much rarer,

For sufficiently small values of "much rarer", I agree. ;-)

  Jakub> but it is still possible some language interpreter or
  Jakub> something builds code on the fly on the stack).

That's why there is mprotect().

	--david
