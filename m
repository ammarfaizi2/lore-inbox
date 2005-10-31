Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbVJaGza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbVJaGza (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 01:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVJaGza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 01:55:30 -0500
Received: from ozlabs.org ([203.10.76.45]:39096 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751358AbVJaGz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 01:55:29 -0500
Date: Mon, 31 Oct 2005 17:55:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Roman Zippel <zippel@linux-m68k.org>, kbuild-devel@lists.sourceforge.net,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix Kconfig performance bug
Message-ID: <20051031065521.GE6622@localhost.localdomain>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	kbuild-devel@lists.sourceforge.net, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
References: <20051020032342.GA11273@localhost.localdomain> <Pine.LNX.4.61.0510210132210.1386@scrub.home> <20051021014955.GA12976@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051021014955.GA12976@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2005 at 11:49:55AM +1000, David Gibson wrote:
> On Fri, Oct 21, 2005 at 02:46:30AM +0200, Roman Zippel wrote:
> > Hi,
> > 
> > On Thu, 20 Oct 2005, David Gibson wrote:
> > 
> > > When doing its recursive dependency check, scripts/kconfig/conf uses
> > > the flag SYMBOL_CHECK_DONE to avoid rechecking a symbol it has already
> > > checked.  However, that flag is only set at the top level, so if a
> > > symbol is first encountered as a dependency of another symbol it will
> > > be rechecked every time it is encountered until it's encountered at
> > > the top level.
> > 
> > You're correct, the check does too much.
> > 
> > > Index: working-2.6/scripts/kconfig/symbol.c
> > > ===================================================================
> > > --- working-2.6.orig/scripts/kconfig/symbol.c	2005-10-20 12:40:45.000000000 +1000
> > > +++ working-2.6/scripts/kconfig/symbol.c	2005-10-20 12:41:43.000000000 +1000
> > > @@ -758,6 +758,8 @@
> > >  out:
> > >  	if (sym2)
> > >  		printf(" %s", sym->name);
> > > +	else
> > > +		sym->flags |= SYMBOL_CHECK_DONE;
> > >  	sym->flags &= ~SYMBOL_CHECK;
> > >  	return sym2;
> > >  }
> > 
> > Actually this way it becomes redundant with SYMBOL_CHECKED, could you 
> > merge these two flags? The above check would be also probably better:
> 
> Ok, done.  There is now only SYMBOL_CHECKED (seemed a clearer name to
> me), but it's semantics are like those of SYMBOL_CHECK_DONE were.
> 
> > 	if (sym2) {
> > 		printf(" %s", sym->name);
> > 		if (sym2 == sym) {
> > 			printf("\n");
> > 			sym2 = NULL;
> > 		}
> > 	}
> > 
> > So that this check will stop when it hits the start symbol and continue 
> > looking for more dependency problems, which is I think I intended with the 
> > original code.
> 
> Erm.. ok.  I don't entirely understand the intent of this is, but
> applied anyway.
> 
> > > Index: working-2.6/scripts/kconfig/zconf.y
> > > ===================================================================
> > > --- working-2.6.orig/scripts/kconfig/zconf.y	2005-10-20 12:40:45.000000000 +1000
> > > +++ working-2.6/scripts/kconfig/zconf.y	2005-10-20 12:41:43.000000000 +1000
> > > @@ -495,10 +495,9 @@
> > >  		exit(1);
> > >  	menu_finalize(&rootmenu);
> > >  	for_all_symbols(i, sym) {
> > > +/* 		fprintf(stderr, "Checking %s...\n", sym->name); */
> > 
> > One "quilt refresh" missing? :-)
> 
> Oops.  Something like that.
> 
> Oh.. one caveat, the diffs I have here to zconf.tab.c_shipped are
> direct edits to match zconf.y - I didn't regenerate the file with
> bison.  I've done that to getting a whole lot of irrelevant changes in
> the patch because I'm using a different version of bison to that used
> for the existing zconf.tab.[ch]_shipped
> 
> Anyway, revised version below:

Now that 2.6.14 is out, do you intend to pass this patch on to Linus?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
