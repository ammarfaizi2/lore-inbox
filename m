Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318361AbSHZWIF>; Mon, 26 Aug 2002 18:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318365AbSHZWIE>; Mon, 26 Aug 2002 18:08:04 -0400
Received: from tomts25.bellnexxia.net ([209.226.175.188]:57538 "EHLO
	tomts25-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S318361AbSHZWIE>; Mon, 26 Aug 2002 18:08:04 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: MM patches against 2.5.31
Date: Mon, 26 Aug 2002 18:09:45 -0400
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@zip.com.au>,
       Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       Daniel Phillips <phillips@arcor.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208261809.45568.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to have been missed: 

Linus Torvalds wrote:

> In article <3D6989F7.9ED1948A@zip.com.au>,
> Andrew Morton  <akpm@zip.com.au> wrote:
>>
>>What I'm inclined to do there is to change __page_cache_release()
>>to not attempt to free the page at all.  Just let it sit on the
>>LRU until page reclaim encounters it.  With the anon-free-via-pagevec
>>patch, very, very, very few pages actually get their final release in
>>__page_cache_release() - zero on uniprocessor, I expect.
> 
> If you do this, then I would personally suggest a conceptually different
> approach: make the LRU list count towards the page count.  That will
> _automatically_ result in what you describe - if a page is on the LRU
> list, then "freeing" it will always just decrement the count, and the
> _real_ free comes from walking the LRU list and considering count==1 to
> be trivially freeable.
> 
> That way you don't have to have separate functions for releasing
> different kinds of pages (we've seen how nasty that was from a
> maintainance standpoint already with the "put_page vs
> page_cache_release" thing).
> 
> Ehh? 

If every structure locks before removing its reference (ie before testing and/or
removing a lru reference we take zone->lru_lock, for slabs take cachep->spinlock
etc)  Its a bit of an audit task to make sure the various locks are taken (and
documented) though.

By leting the actual free be lazy as Linus suggests things should simplify nicely.

comments,
Ed Tomlinson
