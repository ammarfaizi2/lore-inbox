Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267117AbTAUQnH>; Tue, 21 Jan 2003 11:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267120AbTAUQnH>; Tue, 21 Jan 2003 11:43:07 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:13062 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267117AbTAUQnF>; Tue, 21 Jan 2003 11:43:05 -0500
Date: Tue, 21 Jan 2003 11:48:56 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
cc: "Adam J. Richter" <adam@yggdrasil.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Patch?: linux-2.5.59/sound/soundcore.c referenced non-existant errno variable 
In-Reply-To: <200301201527.h0KFRgil001575@eeyore.valparaiso.cl>
Message-ID: <Pine.LNX.3.96.1030121111236.30858A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2003, Horst von Brand wrote:

[ the war between effeciency and maintainability continues ]

> "Adam J. Richter" <adam@yggdrasil.com> said:
> > 	To my knowledge, a goto in this case is not necessary for
> > avoiding code duplication.  If there are a small number of failable
> > steps that may need to be unwound, you could adopt the style of my patch
> > (which shortened the code slightly):
> > 
> >        if (step1() == ok) {
> > 		if (step2() == ok) {
> > 			if (strep3() == ok)
> > 				return OK;
> > 			undo_step2();
> > 		}
> > 		undo_step1();
> > 	}
> > 	return failure;
> 
> The "undo_stepX()"'s pollute the CPU's cache, and (even much worse) the
> gentle reader's.

Given the probably effect of the steps on the cache, I think the
readability argument is a better one, particularly if you have more than a
few steps. There is an effect, but it's relatively small. But use of goto
need not be unreadable.

  if (step1() != ok) goto errex0;
  if (step2() != ok) goto errex1;
  if (step3() == ok) {
    if (step4() == ok) return OK;
    undo_step3();
  }
  undo_step2();
errex1:
  undo_step1();
errex0:
  /* in case there is something other than just return, jump here */
  return FAIL;

Less indenting, and the undo's falling through look visually like a switch
without the overhead.

I have not looked at the code this generates, it's a comment on human
readability rather than an actual implementation, and I'm sure someone
will argue that the first failure should just be a return if there's
nothing else which needs to be done. On the other hand the return inline
would be more bytes, so someone else can argue against. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

