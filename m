Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQL0Tx6>; Wed, 27 Dec 2000 14:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129683AbQL0Txh>; Wed, 27 Dec 2000 14:53:37 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:27889 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129561AbQL0TxT>; Wed, 27 Dec 2000 14:53:19 -0500
Date: Wed, 27 Dec 2000 17:20:33 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Dan Aloni <karrde@callisto.yi.org>
cc: Zlatko Calusic <zlatko@iskon.hr>, Linus Torvalds <torvalds@transmeta.com>,
        "Marco d'Itri" <md@Linux.IT>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <Pine.LNX.4.21.0012250416530.29006-100000@callisto.yi.org>
Message-ID: <Pine.LNX.4.21.0012271717230.14052-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Dec 2000, Dan Aloni wrote:
> On 25 Dec 2000, Zlatko Calusic wrote:
> 
> > Speaking of page_launder() I just stumbled upon two oopsen today on
> > the UP build. Maybe it could give a hint to someone, I'm not that good
> > at Oops decoding.
> 
> I've decoded the Oops I got, and found that the problem is in
> vmscan.c:line-605, where page->mapping is NULL and a_ops gets
> resolved and dereferenced at 0x0000000c.

The code assumes that every page which has the PG_dirty
bit set also has page->mapping set to a valid value.

The BUG() people are getting confirms that this assumption
is not necessarily true and the VM work that's going on will
most likely make it not be true either in some cases.

The (trivial) patch below should fix this problem.

Linus and/or Alan, could you please apply this for the next
pre-patch ?

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/


--- vmscan.c.orig	Wed Dec 27 16:48:24 2000
+++ vmscan.c	Wed Dec 27 17:14:32 2000
@@ -601,7 +601,7 @@
 		 * Dirty swap-cache page? Write it out if
 		 * last copy..
 		 */
-		if (PageDirty(page)) {
+		if (PageDirty(page) && page->mapping) {
 			int (*writepage)(struct page *) = page->mapping->a_ops->writepage;
 			int result;
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
