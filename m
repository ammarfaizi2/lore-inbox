Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265362AbSJaSrR>; Thu, 31 Oct 2002 13:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265363AbSJaSrR>; Thu, 31 Oct 2002 13:47:17 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:39558 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265362AbSJaSrO>; Thu, 31 Oct 2002 13:47:14 -0500
Subject: RE: [PATCH] fixes for building kernel 2.5.45 using Intel compiler
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
In-Reply-To: <F2DBA543B89AD51184B600508B68D4000EFF43C9@fmsmsx103.fm.intel.com>
References: <F2DBA543B89AD51184B600508B68D4000EFF43C9@fmsmsx103.fm.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 31 Oct 2002 19:13:37 +0000
Message-Id: <1036091617.8852.108.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-31 at 16:37, Nakajima, Jun wrote:
> > Why is this needed ?
> 
> Becaues the compiler optimization removes the following code without it.
> 	regs->eflags = (regs->eflags & 0xffffcfff) | (level << 12);
> 
> The compiler provides access to the argument 'unused' in the stack
> (asmlinkage, 
> i.e. __attribute__ ((regparm(0))), but it thinks modifying the stack 
> more than that is not effective anyway. So it elimites the code under
> optimizations. 

The compiler at function entry cannot know anything about the scope of 
objects above the return address. It could equally be a valid pointer to
data above the stack with a global context created by a thread library.

I'm curious if the optimisation is actually legal


> > > -	IGNLABEL "HmacRxUc",
> > > -	IGNLABEL "HmacRxDiscard",
> > > -	IGNLABEL "HmacRxAccepted",
> > > +	IGNLABEL /* "HmacTxMc", */
> > > +	IGNLABEL /* "HmacTxBc", */
> > 
> > You seem to be removing fields from the struct - have you 
> > tested this ?
> > 
> No, it's not removing fields from there. The original definition of IGNLABLE
> is 
> 	#define IGNLABEL 0&(int)
> And
> 	IGNLABEL "HmacRxUc",
> simpile ends up 0, (in gcc). But this is just causing (a lot of) warnings,
> so I take this out.

You removed the comma in the patch above its gone from IGNLABEL foo, to
IGNLABEL foo. I don't see where your comma is coming back from.
Otherwise I've no problem (although maybe IGNLABEL("HmacRxAccepted")
would be neater since it conveniently lets people put them back.

Alan

