Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbVITLkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbVITLkM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 07:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbVITLkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 07:40:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36369 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964978AbVITLkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 07:40:10 -0400
Date: Tue, 20 Sep 2005 12:40:03 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: p = kmalloc(sizeof(*p), )
Message-ID: <20050920114003.GA31025@flint.arm.linux.org.uk>
Mail-Followup-To: Pekka Enberg <penberg@cs.helsinki.fi>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@ftp.linux.org.uk>,
	Andrew Morton <akpm@osdl.org>
References: <20050918100627.GA16007@flint.arm.linux.org.uk> <84144f0205092004187f86840c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f0205092004187f86840c@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 02:18:42PM +0300, Pekka Enberg wrote:
> On 9/18/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > 1. The above implies that the common case is that we are changing the
> >    names of structures more frequently than we change the contents of
> >    structures.  Reality is that we change the contents of structures
> >    more often than the names of those structures.
> > 
> >    Why is this relevant?  If you change the contents of structures,
> >    they need checking for initialisation.  How do you find all the
> >    locations that need initialisation checked?  Via grep.  The problem
> >    is that:
> > 
> >         p = kmalloc(sizeof(*p), ...)
> > 
> >    is not grep-friendly, and can not be used to identify potential
> >    initialisation sites.  However:
> > 
> >         p = kmalloc(sizeof(struct foo), ...)
> > 
> >    is grep-friendly, and will lead you to inspect each place where
> >    such a structure is allocated for correct initialisation.
> 
> I would disagree on this one. You can still grep all the places where
> the local variable is declared in. Furthermore, structs are not always
> initialized where they're kmalloc'd so you need to manually inspect
> anyway.

Think about it some more.  You've added a new member to struct foo.
You want to fix up all the places which allocate struct foo to
initialise this new member.  Grepping for 'struct foo' returns 100
files.  Grepping for kmalloc in those 100 files returns 100 files.

Do you open all 100 in an editor and manually try and locate the five
kmalloc instances of this structure, and end up missing some.

Or do you do the sane thing and use kmalloc(sizeof(struct foo), ...)
and grep for "kmalloc[[:space:]]*(sizeof[[:space:]]*(struct foo)"
which returns only the five files and fix those up with knowledge
that you've found all the instances?

> On 9/18/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > 2. in the rare case that you're changing the name of a structure, you're
> >    grepping the source for all instances for struct old_name, or doing
> >    a search and replace for struct old_name.  You will find all instances
> >    of struct old_name by this method and the bug alluded to will not
> >    happen.
> 
> Perhaps it has poor wording but I was more thinking about a case where
> you shuffle code around and forget that you changed a struct to
> something else (not necessarily removing the old one).

Such shuffling around should be done in easy to review stages so that
bugs can be found, and not a mega patch.  This inherently means that
for a structure name change, you don't end up with a new structure
named the same as an old structure.  And if you compile-test the
stages, you find out if you missed the problem.

That's the only real sane way of doing such changes to ensure
correctness.  Anything less and the patch should not be accepted.

> On 9/18/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > So the assertion above that kmalloc(sizeof(*p) is somehow superiour is
> > rather flawed, and as such should not be in the Coding Style document.
> 
> I think it is better because:
> 
>   - It is easier to get right.
>   - It is easier to audit with a script.
>   - It is shorter.
> 
> I am not saying you can use sizeof(*p) everywhere but it is the common
> case and as such the preferred form.

Your solution is better if the only thing you're concerned about is
"are we allocating enough memory for this fixed size structure".
It completely breaks if you are also concerned about "are we doing
correct initialisation" or "are we allocating enough memory for this
variable sized structure" both of which are far more important
questions.

*especially* when you consider that kmalloc is redzoned and therefore
will catch the kinds of bugs you're suggesting.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
