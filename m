Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWE3Rij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWE3Rij (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 13:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWE3Rij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 13:38:39 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:10973 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932359AbWE3Rii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 13:38:38 -0400
Subject: Re: [patch 05/61] lock validator: introduce WARN_ON_ONCE(cond)
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
In-Reply-To: <20060529183321.6c1a3cba.akpm@osdl.org>
References: <20060529212109.GA2058@elte.hu> <20060529212328.GE3155@elte.hu>
	 <20060529183321.6c1a3cba.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 30 May 2006 13:38:17 -0400
Message-Id: <1149010697.8104.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-29 at 18:33 -0700, Andrew Morton wrote:
> On Mon, 29 May 2006 23:23:28 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > add WARN_ON_ONCE(cond) to print once-per-bootup messages.
> > 
> > Signed-off-by: Ingo Molnar <mingo@elte.hu>
> > Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> > ---
> >  include/asm-generic/bug.h |   13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > Index: linux/include/asm-generic/bug.h
> > ===================================================================
> > --- linux.orig/include/asm-generic/bug.h
> > +++ linux/include/asm-generic/bug.h
> > @@ -44,4 +44,17 @@
> >  # define WARN_ON_SMP(x)			do { } while (0)
> >  #endif
> >  
> > +#define WARN_ON_ONCE(condition)				\
> > +({							\
> > +	static int __warn_once = 1;			\
> > +	int __ret = 0;					\
> > +							\
> > +	if (unlikely(__warn_once && (condition))) {	\

Since __warn_once is likely to be true, and the condition is likely to
be false, wouldn't it be better to switch this around to:

  if (unlikely((condition) && __warn_once)) {

So the && will fall out before having to check a global variable.

Only after the unlikely condition would the __warn_once be false.

-- Steve

> > +		__warn_once = 0;			\
> > +		WARN_ON(1);				\
> > +		__ret = 1;				\
> > +	}						\
> > +	__ret;						\
> > +})
> > +
> >  #endif
> 
> I'll queue this for mainline inclusion.


