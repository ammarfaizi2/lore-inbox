Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318169AbSHZRwP>; Mon, 26 Aug 2002 13:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318170AbSHZRwP>; Mon, 26 Aug 2002 13:52:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42757 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318169AbSHZRwO>; Mon, 26 Aug 2002 13:52:14 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: MM patches against 2.5.31
Date: Mon, 26 Aug 2002 17:58:41 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <akdq8h$fqn$1@penguin.transmeta.com>
References: <3D644C70.6D100EA5@zip.com.au> <20020822112806.28099.qmail@thales.mathematik.uni-ulm.de> <3D6989F7.9ED1948A@zip.com.au>
X-Trace: palladium.transmeta.com 1030384576 26743 127.0.0.1 (26 Aug 2002 17:56:16 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 26 Aug 2002 17:56:16 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3D6989F7.9ED1948A@zip.com.au>,
Andrew Morton  <akpm@zip.com.au> wrote:
>
>What I'm inclined to do there is to change __page_cache_release()
>to not attempt to free the page at all.  Just let it sit on the
>LRU until page reclaim encounters it.  With the anon-free-via-pagevec
>patch, very, very, very few pages actually get their final release in
>__page_cache_release() - zero on uniprocessor, I expect.

If you do this, then I would personally suggest a conceptually different
approach: make the LRU list count towards the page count.  That will
_automatically_ result in what you describe - if a page is on the LRU
list, then "freeing" it will always just decrement the count, and the
_real_ free comes from walking the LRU list and considering count==1 to
be trivially freeable. 

That way you don't have to have separate functions for releasing
different kinds of pages (we've seen how nasty that was from a
maintainance standpoint already with the "put_page vs
page_cache_release" thing). 

Ehh?

		Linus

