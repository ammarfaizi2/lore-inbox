Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130187AbQL1PEh>; Thu, 28 Dec 2000 10:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130159AbQL1PE1>; Thu, 28 Dec 2000 10:04:27 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:25584 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129692AbQL1PEL>; Thu, 28 Dec 2000 10:04:11 -0500
Date: Thu, 28 Dec 2000 12:33:01 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Dan Aloni <karrde@callisto.yi.org>, Zlatko Calusic <zlatko@iskon.hr>,
        "Marco d'Itri" <md@Linux.IT>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <Pine.LNX.4.21.0012281210480.14052-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0012281227570.14052-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2000, Rik van Riel wrote:
> On Wed, 27 Dec 2000, Linus Torvalds wrote:
> > On Wed, 27 Dec 2000, Rik van Riel wrote:
> > > 
> > > The (trivial) patch below should fix this problem.
> > 
> > It must be wrong.
> > 
> > If we have a dirty page on the LRU lists, that page _must_ have
> > a mapping.
> 
> Hmm, last I looked buffercache pages didn't have
> page->mapping set ...

OK, you're right ;)

We never set PG_dirty for buffercache pages, so a
pure buffercache page shouldn't be caught here...

I've made a small debugging patch that simply checks
for this illegal state in add_page_to_active_list and
add_page_to_inactive_dirty_list.

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/


--- include/linux/swap.h.orig	Thu Dec 28 12:29:29 2000
+++ include/linux/swap.h	Thu Dec 28 12:31:29 2000
@@ -206,7 +206,11 @@
 #define ZERO_PAGE_BUG \
 	if (page_count(page) == 0) BUG();
 
+#define DIRTY_NO_MAPPING \
+	if (PageDirty(page) && !page->mapping) BUG();
+
 #define add_page_to_active_list(page) { \
+	DIRTY_NO_MAPPING \
 	DEBUG_ADD_PAGE \
 	ZERO_PAGE_BUG \
 	SetPageActive(page); \
@@ -215,6 +219,7 @@
 }
 
 #define add_page_to_inactive_dirty_list(page) { \
+	DIRTY_NO_MAPPING \
 	DEBUG_ADD_PAGE \
 	ZERO_PAGE_BUG \
 	SetPageInactiveDirty(page); \

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
