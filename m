Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129526AbRBGUne>; Wed, 7 Feb 2001 15:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129945AbRBGUnZ>; Wed, 7 Feb 2001 15:43:25 -0500
Received: from [62.172.234.2] ([62.172.234.2]:18331 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129526AbRBGUnP>; Wed, 7 Feb 2001 15:43:15 -0500
Date: Wed, 7 Feb 2001 20:42:51 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        David Howells <dhowells@cambridge.redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] micro-opt DEBUG_ADD_PAGE
In-Reply-To: <Pine.LNX.4.10.10102071016050.4623-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0102071948260.5423-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Feb 2001, Linus Torvalds wrote:
> 
> I'd rather not do these kinds of things that the compiler should be able
> to trivially do for us.
> 
> (gcc sometimes _does_ do these things. I've seen it. Why doesn't it do it
> here? Did you check the code? Have you asked the gcc lists?)

The "(1<<PG_bitshift)" part of it is done, sure; but I've rechecked
activate_page_nolock() compiled -O2 -march=i686 with egcs-2.91.66 (RH7.0
kgcc), gcc-2.96-69 (RH7.0 gcc+fixes), gcc-2.97 (gcc-snapshot-20010207-1).

None of those optimizes this: I believe the semantics of "||" (don't
try next test if first succeeds) forbid the optimization "|" gives?

2.91 and 2.96 give three movs (two unnecessary), three tests,
three jumps (first two not usually taken):

 232:	8b 43 18             	mov    0x18(%ebx),%eax
 235:	a8 40                	test   $0x40,%al
 237:	75 0f                	jne    248 <activate_page_nolock+0x4c>
 239:	8b 43 18             	mov    0x18(%ebx),%eax
 23c:	a8 80                	test   $0x80,%al
 23e:	75 08                	jne    248 <activate_page_nolock+0x4c>
 240:	8b 43 18             	mov    0x18(%ebx),%eax
 243:	f6 c4 08             	test   $0x8,%ah
 246:	74 19                	je     261 <activate_page_nolock+0x65>

2.97 is jumpier: mov and je mov test jne mov test jne jmp.
That looks worse to me: David, earlier on you advertized
	http://www.codesourcery.com/gcc-snapshots/
Is this something worth your pursuing with the gcc guys?

Hugh

--- linux-2.4.2-pre1/include/linux/swap.h	Wed Feb  7 15:21:13 2001
+++ linux/include/linux/swap.h	Wed Feb  7 17:21:25 2001
@@ -200,8 +200,8 @@
  * with the pagemap_lru_lock held!
  */
 #define DEBUG_ADD_PAGE \
-	if (PageActive(page) || PageInactiveDirty(page) || \
-					PageInactiveClean(page)) BUG();
+	if ((page)->flags & ((1<<PG_active)|(1<<PG_inactive_dirty)| \
+					(1<<PG_inactive_clean))) BUG();
 
 #define ZERO_PAGE_BUG \
 	if (page_count(page) == 0) BUG();

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
