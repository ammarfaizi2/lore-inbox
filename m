Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQL0WhU>; Wed, 27 Dec 2000 17:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129998AbQL0WhK>; Wed, 27 Dec 2000 17:37:10 -0500
Received: from inje.iskon.hr ([213.191.128.16]:41489 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S129340AbQL0Wgz>;
	Wed, 27 Dec 2000 17:36:55 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: Dan Aloni <karrde@callisto.yi.org>,
        Linus Torvalds <torvalds@transmeta.com>, "Marco d'Itri" <md@Linux.IT>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <Pine.LNX.4.21.0012271717230.14052-100000@duckman.distro.conectiva>
Reply-To: zlatko@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko@iskon.hr>
Date: 27 Dec 2000 23:04:10 +0100
In-Reply-To: Rik van Riel's message of "Wed, 27 Dec 2000 17:20:33 -0200 (BRDT)"
Message-ID: <87d7eded2d.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Peisino,Ak(B)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> On Mon, 25 Dec 2000, Dan Aloni wrote:
> > On 25 Dec 2000, Zlatko Calusic wrote:
> > 
> > > Speaking of page_launder() I just stumbled upon two oopsen today on
> > > the UP build. Maybe it could give a hint to someone, I'm not that good
> > > at Oops decoding.
> > 
> > I've decoded the Oops I got, and found that the problem is in
> > vmscan.c:line-605, where page->mapping is NULL and a_ops gets
> > resolved and dereferenced at 0x0000000c.
> 
> The code assumes that every page which has the PG_dirty
> bit set also has page->mapping set to a valid value.
> 
> The BUG() people are getting confirms that this assumption
> is not necessarily true and the VM work that's going on will
> most likely make it not be true either in some cases.
> 
> The (trivial) patch below should fix this problem.
> 
> Linus and/or Alan, could you please apply this for the next
> pre-patch ?
> 

Looking at the patch, I'm practically sure it will cure the symptoms.
But I'm still slightly worried about those pages we skip in
there. Maybe we should at least try to discover what are those pages,
and then maybe it will become obvious what we need (or not) to do with
them.

Some strategic printk()s could probably give us some clue.

Too bad I lost track of the recent changes due to catastrofic time
shortage. And that is a shame as I'm very satisfied with the current
VM code, thanks to your hard work Rik.

> regards,
> 
> Rik
> --
> Hollywood goes for world dumbination,
> 	Trailer at 11.
> 
> 		http://www.surriel.com/
> http://www.conectiva.com/	http://distro.conectiva.com.br/
> 
> 
> --- vmscan.c.orig	Wed Dec 27 16:48:24 2000
> +++ vmscan.c	Wed Dec 27 17:14:32 2000
> @@ -601,7 +601,7 @@
>  		 * Dirty swap-cache page? Write it out if
>  		 * last copy..
>  		 */
> -		if (PageDirty(page)) {
> +		if (PageDirty(page) && page->mapping) {
>  			int (*writepage)(struct page *) = page->mapping->a_ops->writepage;
>  			int result;
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-- 
Zlatko
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
