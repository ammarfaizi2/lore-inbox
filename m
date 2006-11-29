Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967459AbWK2QMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967459AbWK2QMK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 11:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967462AbWK2QMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 11:12:10 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46061 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S967459AbWK2QMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 11:12:07 -0500
Date: Wed, 29 Nov 2006 08:11:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       linux-mm@kvack.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Slab: Remove kmem_cache_t
In-Reply-To: <456D26D2.7000806@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0611290749550.3395@woody.osdl.org>
References: <Pine.LNX.4.64.0611281847030.12440@schroedinger.engr.sgi.com>
 <456D0757.6050903@yahoo.com.au> <Pine.LNX.4.64.0611281923460.12646@schroedinger.engr.sgi.com>
 <456D0FC4.4050704@yahoo.com.au> <20061128200619.67080e11.akpm@osdl.org>
 <Pine.LNX.4.64.0611282027431.3395@woody.osdl.org> <456D26D2.7000806@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Nov 2006, Nick Piggin wrote:
> 
> You are saying that they should only be used to create new "primitive"
> types (ie. that you can use in arithmetic / logical ops) that can
> change depending on the config.

Well, it doesn't have to be something that is "arithmetic".

For an example of a primitive type that isn't arithmetic, the page table 
entries are (pgt_t/pud_t/pmd_t/pte_t) are excellent - they don't do any 
arithmetic or logical ops, but they do change depending on config, and no, 
they aren't always opaque structures.

(Actually, these days they mostly are, but on many architectures it's much 
slower to pass even a small struct around than it is to pass an integer 
around - due simply to calling conventions - so for truly opaque things, 
the typedef has the advantage that it _can_ be an opaque integer type, and 
nobody will notice).

> That's fair enough. I'm sure you've also said in the past that they can
> be used (IIRC you even encouraged it) when the type is opaque in the
> context it is being used.

I'm sure I've been inconsistent, but in general, typedefs are bad. I think 
you'll notice that I almost never use them myself. I much prefer passing 
an opaque structure around, _unless_ I know the structure is so small that 
it makes sense to do the above optimization (ie allow the case where the 
opaque thing actually ends up being an integer).

Opaque integer types are generally useless in C, because they lose all the 
type information _way_ too easily. There are no warnings for mis-use, 
unless you use a sparse "bitwise" type and actually run sparse on the 
thing. So even when there are performance reasons to use opaque integer 
types (and on x86, the page table things were one such thing), usign a 
struct is often preferable just for type-checking.

And as mentioned, there _are_ exceptions. Some types just get _sooo_ 
complex that it's inconvenient to type them out, even if they are 
perfectly regular types, and don't depend on any config option. The 
"filldir_t" typedef in fs.h is such an example - it's not really opaque, 
_nor_ is it a config option, but it sure as hell would be inconvenient for 
all low-level filesystems to do

	int my_readdir(struct file *filp, void *dirent,
		int (*filldir)(void *, const char *, int, loff_t,
		u64, unsigned))
	{
		...
	}

because let's face it, having to write out that "filldir" type just made 
me use two lines (and potential for totally unnecessary tupos) because the 
thing was so complex. So at that point, using a typedef is just common 
sense, and we can do

	int my_readdir(struct file *filp, void *dirent, filldir_t filldir)
	{
		...
	}

instead.

But it's really quite hard to make that kind of complex type in C. It's 
almost always a function pointer that takes complex arguments.

[ That said, I generally won't _complain_ if people use typedefs, but on 
  the other hand, some people definitely are too eager to do it, and I'll 
  happily remove them if people send me a patch. For example, we used to 
  have "task_t" for "struct task_struct", and that was just _unnecessary_, 
  and made it just harder to pick out what it was. Sometimes long names 
  and the explicit "struct" is a _good_ thing. ]

One final thing: for _small_ structures, typedefs are much better than for 
large ones. Why? Because of stack usage. I want people to really _think_ 
about local variable sizes, and that's one thing that a typedef sometimes 
causes - especially if it's opaque, so that users don't have any "handle" 
on whether it is big or small, it's really nasty to use them for automatic 
storage on the stack, because you may simply blow your stack usage on a 
single (or a couple) of structures.

Making things be "struct something_or_other" makes at least _me_ think 
more about it than if it's "file_t". Maybe it's just me, but I immediately 
think "complex structure" when I see "struct", but "file_t" to me mentally 
says "single word".

			Linus
