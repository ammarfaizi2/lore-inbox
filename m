Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268156AbTBYWMz>; Tue, 25 Feb 2003 17:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268255AbTBYWMz>; Tue, 25 Feb 2003 17:12:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8719 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268156AbTBYWMy>; Tue, 25 Feb 2003 17:12:54 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Horrible L2 cache effects from kernel compile
Date: Tue, 25 Feb 2003 22:18:09 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b3gq31$2h8$1@penguin.transmeta.com>
References: <3E5BB7EE.5090301@colorfullife.com>
X-Trace: palladium.transmeta.com 1046211762 7552 127.0.0.1 (25 Feb 2003 22:22:42 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 25 Feb 2003 22:22:42 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3E5BB7EE.5090301@colorfullife.com>,
Manfred Spraul  <manfred@colorfullife.com> wrote:
>
>Are you sure that this will help?

It might, under some loads.

However, I don't think it's a long-term solution, since the hashing will
mean that for any reasonably spread out load you _will_ always walk all
dentries.

So the long-term solution is to either use a local lookup (which we
ended up doing for the page cache) _or_ to limit the number of dentries
themselves some way.  The latter sounds like a bad idea.

>Btw, has anyone tried to replaced the global dcache with something 
>local, perhaps a tree instead of d_child, and then lookup in d_child_tree?

I'd love to see somebody try.  The main worry is the overhead required
per directory dentry and keeping it scalable.  The dentry tree _will_ be
quickly populated and one common case is a few huge directories, yet at
the same time for most dentries there won't be any children at all or
very few of them). 

Right now the "child" list is just a simple linked list, and changing
that to something more complex might make it possible to get rid of the
hash entirely. But increasing the size of individual dentries is a bad
idea, so it would have to be something fairly smart.

			Linus
