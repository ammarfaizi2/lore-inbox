Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbWGYJLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWGYJLp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 05:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWGYJLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 05:11:45 -0400
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:6030 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751505AbWGYJLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 05:11:44 -0400
Date: Tue, 25 Jul 2006 05:06:07 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH for 2.6.18rc2] [1/7] i386/x86-64: Don't randomize
  stack top when...
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>
Message-ID: <200607250508_MC3-1-C604-C1C9@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1153815124.8932.15.camel@laptopd505.fenrus.org>

On Tue, 25 Jul 2006 10:12:04 +0200, Arjan van de Ven wrote:
> > >  unsigned long arch_align_stack(unsigned long sp)
> > >  {
> > > -     if (randomize_va_space)
> > > +     if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
> > >               sp -= get_random_int() % 8192;
> > >       return sp & ~0xf;
> > >  }
> > 
> > I think this needs to be done always, at least on P4.  It really isn't
> > 'randomization' at the same high level as the rest -- more like a small
> > adjustment.  And the offset should be a multiple of 128 and < 7K (not
> > 8K.) Something like this:
> 
> the 8K was what Intel proposed for 2.4 quite a while ago and has been in
> use in linux for years and years... Can you explain why you are saying
> 7Kb? throwing away that 1Kb of cache associativity is unfortunate and
> shouldn't be done unless there's a good reason, so I'm quite interested
> in finding out your reason ;)

Well that's what the Intel IA-32 optimization manual says:

        To establish a suitable stack offset for two instances of the same
        application running on two logical processors in the same physical
        processor package, the stack pointer can be adjusted in the entry
        function of the application using the technique shown in Example 7-5.

        Example 7-5 Adding a Pseudo-random Offset to the Stack Pointer
        in the Entry Function

        void main()
        {
        char * pPrivate = NULL;
        long myOffset = GetMod7Krandom128X()
        // A pseudo-random number that is a multiple
        // of 128 and less than 7K.
        // Use runtime library routine to reposition.
        _alloca(myOffset); // The stack pointer.
        }

        IA-32 Intel Architecture Optimization Reference Manual, Ch. 7
        June 2005
-- 
Chuck

