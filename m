Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261297AbSI0UCV>; Fri, 27 Sep 2002 16:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261399AbSI0UCV>; Fri, 27 Sep 2002 16:02:21 -0400
Received: from pD9E239ED.dip.t-dialin.net ([217.226.57.237]:42114 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S261297AbSI0UCT>; Fri, 27 Sep 2002 16:02:19 -0400
Date: Fri, 27 Sep 2002 14:08:17 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Zach Brown <zab@zabbo.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Single linked lists for Linux, overly complicated
 v2
In-Reply-To: <20020926205727.T13817@bitchcake.off.net>
Message-ID: <Pine.LNX.4.44.0209271359250.7827-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for copying me. That one almost got lost!

On Thu, 26 Sep 2002, Zach Brown wrote:
> #define TSLIST_DECLARE(type, name) 		\
> 	type *name = NULL

OK, but I'd rather use typeof() which enhances possibilities. (Imagine 
code which wouldn't know the type of something arbitrary passed.)

> #define TSLIST_MEMBER_INIT(member) 		\
> 	NULL

I'd prefer { .next = NULL; }

> #define INIT_TSLIST_MEMBER(member) 		\
> 	do {					\
> 		(member)->_slist_next = NULL;	\
> 	} while (0)

I'd still prefer calling the field ->next.

> #define tslist_on_list(_head,_elem) 		\
> 	( (_elem)->_slist_next != NULL || _head == _elem )

That doesn't give me whether the elem is on _that_ list.

> #define tslist_add(_head, _elem) 			\
> 	do {  						\
> 		BUG_ON(tslist_on_list(_head, _elem));	\
> 		(_elem)->_slist_next = (_head);		\
> 		(_head) = (_elem);			\
> 	} while(0)

That's adding to front. One should be aware of that. The other add is

#define slist_add(_new_in, _head_in)            \
do {                                            \
        typeof(_head_in) _head = (_head_in),    \
                    _new = (_new_in);           \
        _new->next = _head->next;               \
        _head->next = _new;                     \
} while (0)

> #define tslist_pop(_head)					\
> 	({							\
> 	 	typeof(_head) _ret = _head;			\
> 		if ( _head ) {					\
> 			_ret = _head;				\
> 			_head = _head->_slist_next;		\
> 			_ret->_slist_next = NULL;		\
> 		}						\
> 		_ret;						\
> 	})

Okay with me, except for the below reason.

> #define __tslist_walk_del(_start, _elem)			\
> 	do {							\
> 		typeof(_start) _pos, _prev = _start;		\
> 		for (; _prev && (_pos = _prev->_slist_next) ;	\
> 			_prev = _pos ) {			\
> 			if ( _pos != _elem )			\
> 				continue;			\
> 			_prev->_slist_next = (_elem)->_slist_next;\
> 			(_elem)->_slist_next = NULL;		\
> 			break;					\
> 		}						\
> 	} while (0)

This looks overly complicated. Why not something like while, but this 
weird for construct?

> #define tslist_del(_head, _elem) 					\
> 	do {  								\
> 		if ( _head == _elem ) {					\
> 			_head = (_elem)->_slist_next;			\
> 			(_elem)->_slist_next = NULL;			\
> 		} else {						\
> 			__tslist_walk_del(_head, _elem);		\
> 		}							\
> 	} while (0)

OK with me, I'll apply it to my version. Coming soon.

> #define tslist_for_each(_pos, _head)				\
> 	for ( _pos = _head ; _pos ; _pos = _pos->_slist_next )

That lacks the prefetch feature at all.

The issue overall is that you still evaluate the arguments more than once. 
That's what Nikita mentioned: you might end up somewhere outlandish.

Wait -- I'll do that.

			Thunder
-- 
assert(typeof((fool)->next) == typeof(fool));	/* wrong */

