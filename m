Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWI2JSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWI2JSr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 05:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWI2JSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 05:18:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13731 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750810AbWI2JSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 05:18:45 -0400
Date: Fri, 29 Sep 2006 02:18:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
       Hugh Dickens <hugh@veritas.com>,
       Michael Ellerman <michael@ellerman.id.au>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH RFC 1/4] Generic BUG handling.
Message-Id: <20060929021833.147a17bd.akpm@osdl.org>
In-Reply-To: <20060929091319.GB41098@muc.de>
References: <20060928225444.439520197@goop.org>
	<20060928225452.229936605@goop.org>
	<20060929085745.GA41098@muc.de>
	<20060929021019.19058b98.akpm@osdl.org>
	<20060929091319.GB41098@muc.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Sep 2006 11:13:19 +0200
Andi Kleen <ak@muc.de> wrote:

> On Fri, Sep 29, 2006 at 02:10:19AM -0700, Andrew Morton wrote:
> > On 29 Sep 2006 10:57:45 +0200
> > Andi Kleen <ak@muc.de> wrote:
> > 
> > > > Some architectures (powerpc) implement WARN using the same mechanism;
> > > > if the illegal instruction was the result of a WARN, then report_bug()
> > > > returns 1; otherwise it returns 0.
> > > 
> > > In theory we could do that on x86 too (and skipping the instruction), 
> > > the only problem 
> > > is that the only guaranteed to fault opcode is ud2 :/. Ok maybe we could
> > > reserve some int XXX vector.
> > > 
> > > % gid WARN_ON | grep -v arch | wc -l
> > > 299
> > 
> > powerpc sets a bit in the __LINE__ number to indicate that it was a
> > WARN_ON.  That'll work on all architectures.
> 
> We still would need an architecture dependent way to skip the opcode
> though (just returning would raise it again). On x86
> 
> regs->eip += 2     (rip on x86-64) 
> 
> should be enough 
> 

We have all that now.  Do:

	if (report_bug(regs->eip) == BUG_TRAP_TYPE_WARN)
		regs>eip += 2;

(The powerpc is_warning_bug() implementation needs to be hoisted into
generic code)

