Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030415AbVLNCDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbVLNCDe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 21:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030417AbVLNCDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 21:03:34 -0500
Received: from ozlabs.org ([203.10.76.45]:34747 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030415AbVLNCDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 21:03:33 -0500
Subject: Re: [RFC][PATCH] Prevent overriding of Symbols in the Kernel,
	avoiding Undefined behaviour
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Ashutosh Naik <ashutosh.naik@gmail.com>, anandhkrishnan@yahoo.co.in,
       linux-kernel@vger.kernel.org, rth@redhat.com, akpm@osdl.org,
       Greg KH <greg@kroah.com>, alan@lxorguk.ukuu.org.uk
In-Reply-To: <9a8748490512130849o73c14313l166e6dd360f32d70@mail.gmail.com>
References: <81083a450512120439h69ccf938m12301985458ea69f@mail.gmail.com>
	 <1134424878.22036.13.camel@localhost.localdomain>
	 <81083a450512130626x417d86c9w31f300555c99fdb2@mail.gmail.com>
	 <9a8748490512130849o73c14313l166e6dd360f32d70@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 13:03:35 +1100
Message-Id: <1134525816.30383.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-13 at 17:49 +0100, Jesper Juhl wrote:
> On 12/13/05, Ashutosh Naik <ashutosh.naik@gmail.com> wrote:
> > On 12/13/05, Rusty Russell <rusty@rustcorp.com.au> wrote:
> > >
> > > How about something like:
> > >
> [snip imrovement suggestion]
> >
> > Have tried that in the attached patch. However,  mod->syms[i].name
> > would be valid only after a long relocation for loop has run through.
> > While this adds a wee bit extra overhead, that overhead is only in the
> > case where the module does actually export a Duplicate Symbol.
> >
> > This its a question, whether we do the search before relocation ( A
> > little messier ) or after ( More straight forward)

Hi Ashutosh, Jasper,

	Patch looks good!  A few nits still:

> > +static int verify_export_symbols(struct module *mod)
> > +{
> > +	const char *name=0;
> 
> CodingStyle issue :
> 	const char *name = 0;

More importantly:
	const char *name = NULL; /* GCC 4.0 warns */

(I assume that's why you have the useless initialization).

> > +	spin_lock_irq(&modlist_lock);
> > +	for (i = 0; i < mod->num_syms; i++)
> > +		if (unlikely(__find_symbol(mod->syms[i].name, &owner, &crc,1))) {
> 
> CodingStyle issue :
> 	if (unlikely(__find_symbol(mod->syms[i].name, &owner, &crc, 1))) {

I would discard the unlikely() here; it's a completely wasted
micro-optimization in this context

> > +	if (ret)
> > +		printk("%s: exports duplicate symbol %s (owned by %s)\n",
> 
> I still think this should be printk(KERN_ERROR ...) and not just a
> warning, since the loading of the module will fail completely. Others
> may disagree ofcourse, but that's my oppinion.

I agree, KERN_ERR is appropriate here.

> I still worry a bit about the spinlock hold time, especially since you
> are doing two linear searches through what could potentially be a
> *lot* of symbols.. It may not be a problem (do you have any time
> measurements?), but it still seems to me that using a lock type that
> allows you to sleep + a call to schedule() would be a good thing for
> those loops.

We already do this to resolve (more) symbols, so I don't see it as a
problem.  However, I believe that lock is redundant here: we need both
locks to write the list, but either is sufficient for reading, and we
already hold the sem.

Cheers,
Rusty.
-- 
 ccontrol: http://ozlabs.org/~rusty/ccontrol

