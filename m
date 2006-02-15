Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030616AbWBODYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030616AbWBODYh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 22:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030617AbWBODYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 22:24:37 -0500
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:15233 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030616AbWBODYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 22:24:36 -0500
Date: Tue, 14 Feb 2006 22:17:57 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Trap flag handling change in 2.6.10-bk5 broke Kylix
  debugger
To: Paulo Marques <pmarques@grupopie.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Message-ID: <200602142220_MC3-1-B866-DF84@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <43F23BB4.8070703@grupopie.com>

On Tue, 14 Feb 2006 at 20:21:08 +0000, Paulo Marques wrote:

> Going even further, a 2.6.10-bk5 kernel without this single change runs 
> the debugger just fine:
> 
> > @@ -718,23 +717,21 @@
> >              */
> >             if ((regs->xcs & 3) == 0)
> >                     goto clear_TF_reenable;
> > -           if ((tsk->ptrace & (PT_DTRACE|PT_PTRACED)) == PT_DTRACE)
> > -                   goto clear_TF;
> > +
> > +           /*
> > +            * Was the TF flag set by a debugger? If so, clear it now,
> > +            * so that register information is correct.
> > +            */
> > +           if (tsk->ptrace & PT_DTRACE) {
> > +                   regs->eflags &= ~TF_MASK;
> > +                   tsk->ptrace &= ~PT_DTRACE;
> > +                   if (!tsk->ptrace & PT_DTRACE)
                            ^^^^^^^^^^^^^^^^^^^^^^^^
  Looks like this is always true because that bit was cleared one line above.
Maybe it should be testing PT_DTRACED instead?  And it's missing parens too,
so try:
                        if (!(tsk->ptrace & PT_DTRACED))


> > +                           goto clear_TF;
> > +           }
> >     }
> >  
> >     /* Ok, finally something we can handle */

-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert
