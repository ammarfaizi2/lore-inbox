Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263267AbSJaQcx>; Thu, 31 Oct 2002 11:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263218AbSJaQb7>; Thu, 31 Oct 2002 11:31:59 -0500
Received: from fmr05.intel.com ([134.134.136.6]:10741 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S263215AbSJaQbc>; Thu, 31 Oct 2002 11:31:32 -0500
Message-ID: <F2DBA543B89AD51184B600508B68D4000EFF43C9@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: RE: [PATCH] fixes for building kernel 2.5.45 using Intel compiler
Date: Thu, 31 Oct 2002 08:37:48 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> 
> On Thu, 2002-10-31 at 03:17, Nakajima, Jun wrote:
> >  asmlinkage int sys_iopl(unsigned long unused)
> >  {
> > -	struct pt_regs * regs = (struct pt_regs *) &unused;
> > +	volatile struct pt_regs * regs = (struct pt_regs *) &unused;
> 
> Why is this needed ?

Becaues the compiler optimization removes the following code without it.
	regs->eflags = (regs->eflags & 0xffffcfff) | (level << 12);

The compiler provides access to the argument 'unused' in the stack
(asmlinkage, 
i.e. __attribute__ ((regparm(0))), but it thinks modifying the stack 
more than that is not effective anyway. So it elimites the code under
optimizations. 

> 
> 
> > -	IGNLABEL "HmacRxUc",
> > -	IGNLABEL "HmacRxDiscard",
> > -	IGNLABEL "HmacRxAccepted",
> > +	IGNLABEL /* "HmacTxMc", */
> > +	IGNLABEL /* "HmacTxBc", */
> 
> You seem to be removing fields from the struct - have you 
> tested this ?
> 
No, it's not removing fields from there. The original definition of IGNLABLE
is 
	#define IGNLABEL 0&(int)
And
	IGNLABEL "HmacRxUc",
simpile ends up 0, (in gcc). But this is just causing (a lot of) warnings,
so I take this out.

Jun



