Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319107AbSHTPZZ>; Tue, 20 Aug 2002 11:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319159AbSHTPZY>; Tue, 20 Aug 2002 11:25:24 -0400
Received: from dsl-213-023-021-044.arcor-ip.net ([213.23.21.44]:42376 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319107AbSHTPZX>;
	Tue, 20 Aug 2002 11:25:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Thunder from the hill <thunder@lightweight.ods.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Generic list push/pop
Date: Tue, 20 Aug 2002 17:30:28 +0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208200701580.3234-100000@hawkeye.luckynet.adm>
In-Reply-To: <Pine.LNX.4.44.0208200701580.3234-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17hAxg-00011z-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 August 2002 15:08, Thunder from the hill wrote:
> ...Anyway, this work had already been done by 
> Thomas 'Dent' Mirlacher. We might want to work on that.
>
> [...]
>
> +#define slist_add_front(_new, _head)   \
> +do {                                   \
> +       _new->next = _head;             \
> +       _head = _new->next;             \
> +} while (0)

The second line is equivalent to _head = _head.

> +#define slist_add(_new, _head)         \
> +do {                                   \
> +       _new->next = _head->next;       \
> +       _head->next = _new;             \
> +} while (0)

I don't see the point of this.  Why doesn't the caller just push_list onto
head->next?

Anyway, since I went to the trouble of writing versions of push/pop_list
that at least avoid multiple argument evaluation, here they are in all their
glorious ugliness:

#define push_list(list, node) do { \
	typeof(list) *_LIST_ = &(list), _NODE_ = (node); \
	_NODE_->next = *_LIST_; \
	*_LIST_ = _NODE_; } while (0)

#define pop_list(list) ({ \
	typeof(list) *_LIST_ = &(list), _NODE_ = *_LIST_; \
	*_LIST_ = (*_LIST_)->next; \
	_NODE_; })

It's unecessary to obfuscate the macro parameter names.  On the other hand, 
if somebody passes in an expression that happens to contain one of the 
obfuscated local variable names, bad things will happen.  On the third hand, 
if somebody does that they probably need bad things to happen to them.

This problem arises only because of C's idiotic policy of entering the new 
local symbol before parsing the initializer, and there is nothing you can do 
about it[1] except to avoid using obfuscated variable names in normal code, 
and check carefully for nested obfuscated variables every time you write a 
macro.

The other problems with these constructions are:

  - How do we know gcc will successfully optimize these things to the
    same code you'd get if you simply wrote the two required assignments
    out in full?  The local variables should disappear early in constant 
    expression evaluation, but do they always?

  - We assume the link field is named 'next'.

  - They are ugly (but I don't care.  If you need to feast your eyes on
    ugly, look at any pgtable.h)

As promised, I moved them to my scraps.c and just wrote the code out in full.

[1] If we uniformly adopt the convention of encoding the name of the macro 
into any locals declared in macros, plus a convention to indicate the end of 
name, I suppose we could gaurantee uniqueness.  Or we can just keep muddling 
along as usual (more likely).

-- 
Daniel
