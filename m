Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269146AbRHFXQO>; Mon, 6 Aug 2001 19:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269148AbRHFXPy>; Mon, 6 Aug 2001 19:15:54 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:51474 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269146AbRHFXPs>; Mon, 6 Aug 2001 19:15:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: BERECZ Szabolcs <szabi@inf.elte.hu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: kswapd eats the cpu without swap
Date: Tue, 7 Aug 2001 01:21:33 +0200
X-Mailer: KMail [version 1.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.A41.4.31.0108070044550.37910-100000@pandora.inf.elte.hu>
In-Reply-To: <Pine.A41.4.31.0108070044550.37910-100000@pandora.inf.elte.hu>
MIME-Version: 1.0
Message-Id: <01080701213301.02122@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 August 2001 00:48, BERECZ Szabolcs wrote:
> On Fri, 3 Aug 2001, Marcelo Tosatti wrote:
> > Does the problem happen only with the used-once patch ?
> >
> > If it also happens without the used-once patch, can you reproduce
> > the problem with 2.4.6 ?
>
> The problem happened about 4 times, with the used-once patch,
> but I don't know exactly what triggered it.
>
> now I use 2.4.7-ac5, and I have not seen the problem, yet.
>
> I will try with the used-once patch, if it appears again.

Please note the additional patch, to be applied after the used-once 
patch for 2.4.7 and 2.4.7-ac*, or directly to 2.4.8-pre*.  This was 
posted on lkml and linux-mm on Aug 5 under the subject:

    [PATCH] Unlazy activate

which adds the additional behaviour of moving used-twice pages to the 
active list.

Here it is again:

--- ../2.4.7.clean/mm/filemap.c	Sat Aug  4 14:27:16 2001
+++ ./mm/filemap.c	Sat Aug  4 23:41:00 2001
@@ -979,9 +979,13 @@
 
 static inline void check_used_once (struct page *page)
 {
-	if (!page->age) {
-		page->age = PAGE_AGE_START;
-		ClearPageReferenced(page);
+	if (!PageActive(page)) {
+		if (page->age)
+			activate_page(page);
+		else {
+			page->age = PAGE_AGE_START;
+			ClearPageReferenced(page);
+		}
 	}
 }
 
