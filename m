Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262892AbTHUVcp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 17:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTHUVcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 17:32:45 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:22961 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262892AbTHUVcn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 17:32:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16197.14968.235907.128727@gargle.gargle.HOWL>
Date: Thu, 21 Aug 2003 23:32:40 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: jim.houston@comcast.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Pentium Pro - sysenter - doublefault
In-Reply-To: <1061498486.3072.308.camel@new.localdomain>
References: <1061498486.3072.308.camel@new.localdomain>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Houston writes:
 > Hi Everyone,
 > 
 > I upgraded my Pentium Pro system to Redhat 9, installed a
 > linux-2.6.0-test3 kernel, and it fails with a double-fault when
 > init starts.
 > 
 > The code which decides if it is o.k. to use sysenter is broken for
 > some Pentium Pro cpus ,in particular, this bit of code from
 > arch/i386/kernel/cpu/intel.c:
 > 
 > 	/* SEP CPUID bug: Pentium Pro reports SEP but doesn't have it */
 > 	if ( c->x86 == 6 && c->x86_model < 3 && c->x86_mask < 3 )
 > 		clear_bit(X86_FEATURE_SEP, c->x86_capability);
 > 
 > On my cpu model=1 and mask=9, it doesn't clear 86_FEATURE_SEP.
 > This results in a double-fault when init starts.  The double-fault
 > happens on the sysexit.  The new double-fault handler caught this
 > nicely, and I was able to debug this with kgdb.
 > 
 > The logic above is exactly what Intel says to do in "IA-32 Intel®
 > Architecture Software Developer's Manual, Volume 2: Instruction Set
 > Reference" on page 3-767.  It also says that sysenter was added to the
 > Pentium II.

I double-checked AP-485 (24161823.pdf, the "real" reference to CPUID),
and it says (section 3.4) that SEP is unsupported when the signature
as a whole is less that 0x633. This means all PPros, and PII Model 3s
with steppings less than 3.

The problem is that the kernel check you quoted above is buggy: the
c->x86_model < 3 && c->x86_mask < 3 part fails for late-stepping PPros
since c->x86_mask >= 3 for them. The test should be rewritten as:

        if (c->x86 == 6 && (c->x86_model < 3 ||
                            (c->x86_model == 3 && c->x86_mask < 3)))
                clear_bit(X86_FEATURE_SEP, c->x86_capability);

/Mikael
