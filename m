Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270513AbRHHPfo>; Wed, 8 Aug 2001 11:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270514AbRHHPfg>; Wed, 8 Aug 2001 11:35:36 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:24068 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S270513AbRHHPfR>; Wed, 8 Aug 2001 11:35:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Dieter.Nuetzel@hamburg.de (Dieter =?iso-8859-1?q?N=FCtzel?=)
Subject: Re: 2.4.7-ac4 disk thrashing
Date: Wed, 8 Aug 2001 17:41:14 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org (Linux Kernel List),
        reiserfs-list@namesys.com (ReiserFS List),
        mason@suse.com (Chris Mason), NikitaDanilov@Yahoo.COM (Nikita Danilov),
        phillips@bonn-fries.net (Daniel Phillips), tmv5@home.com (Tom Vier)
In-Reply-To: <E15UR2B-00051d-00@the-village.bc.nu>
In-Reply-To: <E15UR2B-00051d-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01080817411402.00351@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 August 2001 12:57, Alan Cox wrote:
> > Could it be that the ReiserFS cleanups in ac4 do harm?
> > http://marc.theaimsgroup.com/?l=3Dreiserfs&m=3D99683332027428&w=3D2
>
> I suspect the use once patch is the more relevant one.

Two things to check:

  - Linus found a bug in balance_dirty_state yesterday.  Is the
    fix applied?

  - The original use-once patch tends to leave a referenced pages
    on the inactive_dirty queue longer, not in itself a problem,
    but can expose other problems.  The previously posted patch
    below fixes that, is it applied?

To apply (with use-once already applied):

  cd /usr/src/your.2.4.7.source.tree
  patch -p0 <this.patch

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
 
