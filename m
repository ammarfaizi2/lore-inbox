Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261319AbSI0HjN>; Fri, 27 Sep 2002 03:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261438AbSI0HjN>; Fri, 27 Sep 2002 03:39:13 -0400
Received: from mx1.elte.hu ([157.181.1.137]:53988 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261319AbSI0HjM>;
	Fri, 27 Sep 2002 03:39:12 -0400
Date: Fri, 27 Sep 2002 09:53:40 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@digeo.com>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 'sticky pages' support in the VM, futex-2.5.38-C5
In-Reply-To: <Pine.LNX.4.33.0209261530150.1345-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209270939330.3174-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Sep 2002, Linus Torvalds wrote:

> Well, we have two situations:
>  - the page is shared. In which case we don't need to put it on any 
>    pinning list, since the very sharedness of the page means that we won't
>    be COW'ing it in this address space.
>  - the page is private. In which case we can (and should) pre-COW it and 
>    make it anonymous at futex time.
> 
> So yeah, it should be doable.

well, 4 fields: ->mapping, ->list.next, ->list.prev, ->index and ->private
is *alot* of space to do something smart in struct page itself.

(hm, dont we have named anonymous mappings? (ie. mmap()-ing of a file via
MAP_PRIVATE?) And if a futex is put there it can be COW-ed, right, while
it's also in the pagecache?)

assuming those 4 fields are available, it should be easy for the futex
code to detect such mappings - the ->mapping field should be a good test,
if it's NULL then it's a COW-able page, if it's non-NULL then not.

then eg. the ->private field could be used as a simple PG_sticky counter.

or, to implement real lazy COW, the ->private field could be used as an
'owner MM' pointer, and if the COW handler sees current->mm == owner_mm,
then the ->list has a queue of pending page_change_struct's, which would
trigger a rehashing of the futexes. Then PG_sticky is cleared.

this would work fine as long as the pin_page code guarantees to never put
a hash on an already COW-ed page. (which can be guaranteed by using the
'writable' flag to get_user_pages())

no additional hashes. Is there any danger in going into this direction?

	Ingo

