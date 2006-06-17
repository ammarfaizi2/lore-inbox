Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWFQGli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWFQGli (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 02:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWFQGli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 02:41:38 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:57048 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S932103AbWFQGli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 02:41:38 -0400
Subject: Re: [RFC][PATCH] binfmt: turn MAX_ARG_PAGES into a sysctl tunable
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060616204024.GA7097@ucw.cz>
References: <1150297122.31522.54.camel@lappy> <20060616204024.GA7097@ucw.cz>
Content-Type: text/plain
Date: Sat, 17 Jun 2006 08:41:31 +0200
Message-Id: <1150526492.28517.26.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-16 at 20:40 +0000, Pavel Machek wrote:
> Hi!
> 
> > From: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > 
> > Some folks find 128KB of env+arg space too little. Solaris provides them with
> > 1MB. Manually changing MAX_ARG_PAGES worked for them so far, however they
> > would like to run the supported vendor kernel.
> > 
> > In the interrest of not penalizing everybody with the overhead of just
> > setting it larger, provide a sysctl to change it.
> 
> I very muh like that idea.
> 
> > Compiles and boots on i386.
> > 
> > Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> ....but does is also work if you keep changing that value in the tight
> loop while trying to work with the system?
> 

Yes, I've added a bprm local copy of max_arg_pages:

> @@ -20,9 +13,10 @@ struct pt_regs;
> >  /*
> >   * This structure is used to hold the arguments that are used when loading binaries.
> >   */
> > -struct linux_binprm{
> > +struct linux_binprm {
> >         char buf[BINPRM_BUF_SIZE];
> > -       struct page *page[MAX_ARG_PAGES];
> > +       struct page **page;
> > +       int max_arg_pages;
> >         struct mm_struct *mm;
> >         unsigned long p; /* current top of mem */
> >         int sh_bang;

That is set once from the sysctl variable:

> > @@ -1153,14 +1164,20 @@ int do_execve(char * filename,
> >         if (!bprm)
> >                 goto out_ret;
> >  
> > +       bprm->max_arg_pages = max_arg_pages;
> > +       bprm->page = kzalloc(bprm->max_arg_pages*sizeof(struct page*),
> > +                       GFP_KERNEL);
> > +       if (!bprm->page)
> > +               goto out_kfree;
> > +

And is thereafter used and never again changed.

This should be enough to guard against your scenario I recon.

Peter


