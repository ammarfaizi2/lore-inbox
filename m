Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261588AbSI0AwN>; Thu, 26 Sep 2002 20:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261589AbSI0AwN>; Thu, 26 Sep 2002 20:52:13 -0400
Received: from bitchcake.off.net ([216.138.242.5]:26016 "EHLO mail.off.net")
	by vger.kernel.org with ESMTP id <S261588AbSI0AwM>;
	Thu, 26 Sep 2002 20:52:12 -0400
Date: Thu, 26 Sep 2002 20:57:27 -0400
From: Zach Brown <zab@zabbo.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Single linked lists for Linux, overly complicated v2
Message-ID: <20020926205727.T13817@bitchcake.off.net>
References: <Pine.LNX.4.44L.0209261628490.1837-100000@duckman.distro.conectiva> <Pine.LNX.4.44.0209261337290.7827-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209261337290.7827-100000@hawkeye.luckynet.adm>; from thunder@lightweight.ods.org on Thu, Sep 26, 2002 at 01:43:41PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My problem is just: where to put the old _entry? Anyway, since we're 
> talking about list entry deletion, we could copy it nowhere and just 
> overwrite it with _entry->next...

honestly, I think if you're contemplating this kind of thing, you've
gone too far with the design.  it should be dirt friggin simple', like
what wli posted a while ago with struct list.  if you need more, you
really should just use list_head and be done with it.  (restartable list
walking?  why did you stop walking in the first place?  oh, you didn't
mean restartable, you meant able to start walking at an arbitrary
position?  back to list_head.. )

Here's something I'd consider using if it were in the kernel.  if others
agree, I can finalize and submit it.

( yeah, a lot of it is stinky, like the requirement that users magically
have the right member in their structs.  I have no deep love for the
interface.  at least this passes basic usage tests..)

#define TSLIST_DECLARE(type, name) 		\
	type *name = NULL

#define TSLIST_MEMBER_INIT(member) 		\
	NULL

#define INIT_TSLIST_MEMBER(member) 		\
	do {					\
		(member)->_slist_next = NULL;	\
	} while (0)

#define tslist_on_list(_head,_elem) 		\
	( (_elem)->_slist_next != NULL || _head == _elem )

#define tslist_push tslist_add

#define tslist_add(_head, _elem) 			\
	do {  						\
		BUG_ON(tslist_on_list(_head, _elem));	\
		(_elem)->_slist_next = (_head);		\
		(_head) = (_elem);			\
	} while(0)

#define tslist_pop(_head)					\
	({							\
	 	typeof(_head) _ret = _head;			\
		if ( _head ) {					\
			_ret = _head;				\
			_head = _head->_slist_next;		\
			_ret->_slist_next = NULL;		\
		}						\
		_ret;						\
	})

#define __tslist_walk_del(_start, _elem)			\
	do {							\
		typeof(_start) _pos, _prev = _start;		\
		for (; _prev && (_pos = _prev->_slist_next) ;	\
			_prev = _pos ) {			\
			if ( _pos != _elem )			\
				continue;			\
			_prev->_slist_next = (_elem)->_slist_next;\
			(_elem)->_slist_next = NULL;		\
			break;					\
		}						\
	} while (0)
		

#define tslist_del(_head, _elem) 					\
	do {  								\
		if ( _head == _elem ) {					\
			_head = (_elem)->_slist_next;			\
			(_elem)->_slist_next = NULL;			\
		} else {						\
			__tslist_walk_del(_head, _elem);		\
		}							\
	} while (0)

#define tslist_for_each(_pos, _head)				\
	for ( _pos = _head ; _pos ; _pos = _pos->_slist_next )
