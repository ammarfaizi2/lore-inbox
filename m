Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271307AbRHTPk3>; Mon, 20 Aug 2001 11:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271297AbRHTPkU>; Mon, 20 Aug 2001 11:40:20 -0400
Received: from www.wen-online.de ([212.223.88.39]:54276 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S271283AbRHTPkI>;
	Mon, 20 Aug 2001 11:40:08 -0400
Date: Mon, 20 Aug 2001 17:40:04 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8/2.4.9 VM problems
In-Reply-To: <20010819205452Z16128-32383+429@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33.0108201726330.580-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Aug 2001, Daniel Phillips wrote:

> On August 17, 2001 03:10 pm, Frank Dekervel wrote:
> > Hello,
> >
> > since i upgraded to kernel 2.4.8/2.4.9, i noticed everything became noticably
> > slower, and the number of swapins/swapouts increased significantly. When i
> > run 'vmstat 1' i see there is a lot of swap activity constantly when i am
> > reading my mail in kmail. After a fresh bootup in the evening, i can get
> > everything I normally need swapped out by running updatedb or ht://dig. When
> > i do that, my music stops playing for several seconds, and it takes about 3
> > seconds before my applications repaint when i switch back to X after an
> > updatedb run.
> > the last time that happent (and the last time i had problems with VM at all)
> > was in 2.4.0-testXX so i think something is wrong ...
> > is it possible new used_once does not work for me (and drop_behind used to
> > work fine) ?
> >
> > My system configuration : athlon 750, 384 meg ram, 128 meg swap, XFree4.1 and
> > kde2.2.
>
> Could you please try this patch against 2.4.9 (patch -p0):

Hi Daniel,

I've been having some troubles which also seem to be use_once related.
(bonnie rewrite test induces large inactive shortage, and some nasty
IO seizures during write intelligently test. [grab window/wave it and
watch it not move for couple seconds])

I'll give your patch a shot.  In the meantime, below is what I did
to it here.  I might have busted use_once all to pieces ;-) but it
cured my problem, so I'll show it anyway.

	-Mike


--- mm/filemap.c.org	Mon Aug 20 17:25:20 2001
+++ mm/filemap.c	Mon Aug 20 17:25:50 2001
@@ -980,7 +980,7 @@
 static inline void check_used_once (struct page *page)
 {
 	if (!PageActive(page)) {
-		if (page->age)
+		if (page->age > PAGE_AGE_START)
 			activate_page(page);
 		else {
 			page->age = PAGE_AGE_START;

