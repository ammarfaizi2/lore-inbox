Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261407AbSI0UeE>; Fri, 27 Sep 2002 16:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261440AbSI0UeE>; Fri, 27 Sep 2002 16:34:04 -0400
Received: from bitchcake.off.net ([216.138.242.5]:2723 "EHLO mail.off.net")
	by vger.kernel.org with ESMTP id <S261407AbSI0UeC>;
	Fri, 27 Sep 2002 16:34:02 -0400
Date: Fri, 27 Sep 2002 16:39:22 -0400
From: Zach Brown <zab@zabbo.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Single linked lists for Linux, overly complicated v2
Message-ID: <20020927163922.A13817@bitchcake.off.net>
References: <20020926205727.T13817@bitchcake.off.net> <Pine.LNX.4.44.0209271359250.7827-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209271359250.7827-100000@hawkeye.luckynet.adm>; from thunder@lightweight.ods.org on Fri, Sep 27, 2002 at 02:08:17PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > #define TSLIST_MEMBER_INIT(member) 		\
> > 	NULL
> 
> I'd prefer { .next = NULL; }

that only works if you have a proper struct for the list members, not
magical pointers that are embedded in their definition.  (also, its
pretty unacceptable that if I have a singly linked list of buffer_heads
that I need to have an entire dummy buffer_head struct allocated to be
the head.  this incongruity is what creates the special casing of the
head as a type *point on its own, while the list members are type *
pointer members in type structs).  

the explicit struct is much cleaner (as wli's post shows) and the member
approach allows hand-wavey macrosy type safety while only allowing a
particular struct to be on one list.

> I'd still prefer calling the field ->next.

arguments could be made about layering violations: that the member
name should really scream out that its going to be magically used by
macros deep in include/ somewhere.

> > #define tslist_on_list(_head,_elem) 		\
> > 	( (_elem)->_slist_next != NULL || _head == _elem )
> 
> That doesn't give me whether the elem is on _that_ list.

no, it doesn't.  it isn't meant to.

> That's adding to front. One should be aware of that. The other add is
> 
> #define slist_add(_new_in, _head_in)            \
> do {                                            \
>         typeof(_head_in) _head = (_head_in),    \
>                     _new = (_new_in);           \
>         _new->next = _head->next;               \
>         _head->next = _new;                     \
> } while (0)

which is a degenerate case of slist_add_pos(), which is more
complication than this trivial implementation needs.  have you looked at other
single linked list implementations?  like glib's?  do you really think
we need that in the kernel?

> > #define __tslist_walk_del(_start, _elem)			\
> > 	do {							\
> > 		typeof(_start) _pos, _prev = _start;		\
> > 		for (; _prev && (_pos = _prev->_slist_next) ;	\
> > 			_prev = _pos ) {			\
> > 			if ( _pos != _elem )			\
> > 				continue;			\
> > 			_prev->_slist_next = (_elem)->_slist_next;\
> > 			(_elem)->_slist_next = NULL;		\
> > 			break;					\
> > 		}						\
> > 	} while (0)
> 
> This looks overly complicated. Why not something like while, but this 
> weird for construct?

	while (A) {
		...
		B;
	}

	for ( ; A ; B ) {
	}

some people prefer to have the loop terminating invariant explicitly
expressed in the for() construct so that it isn't overlooked.  perhaps you
don't.

> That lacks the prefetch feature at all.
> 
> The issue overall is that you still evaluate the arguments more than once. 
> That's what Nikita mentioned: you might end up somewhere outlandish.

yes, both of these are mechanical refinements that don't change the API
at all.  they can wait until people have actually expressed interest in
this thing being in the kernel.  has anyone expressed real interest?

but really, as I realized the single membership limitation of this api,
it became clear to me that its too limited.  if you want to persue this,
move to the very simple struct list proposal that wli did.    

- z
