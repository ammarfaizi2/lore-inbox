Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262313AbSI1Tnj>; Sat, 28 Sep 2002 15:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262315AbSI1Tnj>; Sat, 28 Sep 2002 15:43:39 -0400
Received: from bitchcake.off.net ([216.138.242.5]:57765 "EHLO mail.off.net")
	by vger.kernel.org with ESMTP id <S262313AbSI1Tnh>;
	Sat, 28 Sep 2002 15:43:37 -0400
Date: Sat, 28 Sep 2002 15:49:00 -0400
From: Zach Brown <zab@zabbo.net>
To: Lightweight Patch Manager <patch@luckynet.dynu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Single linked headed lists for Linux, v3
Message-ID: <20020928154900.B13817@bitchcake.off.net>
References: <20020928093335.E7A794@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020928093335.E7A794@hawkeye.luckynet.adm>; from patch@luckynet.dynu.com on Sat, Sep 28, 2002 at 09:33:35AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is mind-bogglingly clear that you haven't really used these at all.
I still think, because of the magical struct member pollution and the
limitation of structs being on a single list, that these #define-based
slists are fundamentally flawed.  This is the last email I'll send, I
think.  

> +#define SLIST_HEAD(type,name)			\
> +	typeof(type) name = SLIST_HEAD_INIT(name)

ok, problem #1.  I have to instantiate a full copy of the structs that
make up the list to have a head of the list?  say I'm walking a bunch of
tasks and want to have a temporary slist of tasks that I'm going to
later walk and destroy.  I'd like to have a list header on the stack in
that function, but now I can't, because a full task_struct is enormous.
the same goes for many data structures.  This, alone, is enough to
torpedo these lists ever being used.

> +#define SLIST_HEAD_INIT(name)			\
> +	{ .next = NULL; }

ok, right, problem 2.  to make these work, you need a magical .next
member and you get only one.  want to have structs on two lists?  tough.
is that 'next' member in a struct being used by slist macros or did the
author, not knowing about them, open code their own as is _very_ common
in C?  who knows!

go look through the kernel and find structs that have more than one
struct list_head.  realize that with your lists you couldn't do that.
ponder.

and, really, the reason I posted this.  an empty list has a NULL next
pointer as the head.

> +#define slist_add_front(_new_in, _head_in)	\
> +do {						\
> +	typeof(_head_in) _head = _head_in,	\
> +		    _new = _new_in;		\
> +	_new->next = _head;			\

ok, now a new item in the list has ->next null from the head.

> +#define slist_del_quick(_entry_in,_buf_in)		\
> +do {							\
> +	typeof(_entry_in) _entry = (_entry_in),		\
> +			  _buf = (_buf_in), _free;	\
> +	_free = _entry->next;				\
> +	memcpy(_buf, _entry, sizeof(_entry));		\
> +	memcpy(_entry, _free, sizeof(_entry));		\
> +	memcpy(_buf, _free, sizeof(_entry));		\
> +	slist_del_single(_entry);			\
> +} while (0)
> +

wow.

1) we just blindly memcpy()ed from NULL if entry was the last in the
	list.

2) I can only assume that you meant to be memcpy()ing the structs
around.  _entry_in is a pointer.  _buf and _free are pointers.  you're
copying the first pointer-sized chunk of structs around as you delete
entries, corrupting them.

3) you set entry->next to null, but the previous node to entry still
thinks it is the next node.  you just truncated the list, losing all the
later members.

4) if the entire structs really were copied, you just destroyed entry.
maybe you meant to copy buf into free in that last memcpy.

I just don't know what else to say.  just get rid of this concept, no
matter what it was you were really trying to do.  (a node swap concept?
a list seperating concept?  oy.)

> +#define slist_del(_entry_in,_head_in)			\
> +do {							\
> +	typeof(_entry_in) _entry = (_entry_in),		\
> +			  _head  = (_head_in);		\
> +	if (_head == _entry) {				\
> +		_head = _entry->next;			\

wait, we initialized head with .next = NULL, now we're setting it
straight?  one of these is wrong.  also, you're not changing the head,
you're changing the head pointer you allocated on the stack.  you seem
to have really meant _head->next;

> +#define slist_del_init(_entry_in)			\
> +({							\
> +	typeof(_entry_in) _entry = (_entry_in), _head =	\
> +	    kmalloc(sizeof(_entry), GFP_KERNEL), _free;	\
> +	if (_head) {					\
> +	    memcpy(_head, (_entry), sizeof(_entry));	\
> +	    _free = (_entry);				\
> +	    (_entry) = (_entry)->next;			\
> +	    kfree(_free);				\
> +	    _head->next = _head;			\
> +	    _head;					\
> +	} else						\
> +	    NULL;					\
> +})

wow, part 2.

look, thunder, I think we're all for experimentation.  go to town, learn
how lists work.  take it to kernelnewbies or kernel-janitors, I'm sure
someone will be glad to help out.  

but please don't bother sending them to l-k until you've put them
through even the most basic tests and have tried to convert open-coded
single lists in the kernel to them.  

-- 
 zach
