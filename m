Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265010AbSJPOf2>; Wed, 16 Oct 2002 10:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265009AbSJPOfZ>; Wed, 16 Oct 2002 10:35:25 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:30950 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S265008AbSJPOfY> convert rfc822-to-8bit; Wed, 16 Oct 2002 10:35:24 -0400
Date: Wed, 16 Oct 2002 15:42:12 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@zet.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at swap.c:62 [2.4.19 vanilla]
In-Reply-To: <20021016150131.F26786@stine.vestdata.no>
Message-ID: <Pine.LNX.4.44.0210161539130.1306-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002, Thomas Langås wrote:
> kernel BUG at swap.c:62! 

Andrew Morton foresaw that race, and fixed it in 2.4.20-pre3:

--- 2.4.19/mm/swap.c	Wed Nov  7 06:44:20 2001
+++ 2.4.20-pre11/mm/swap.c	Wed Oct 16 11:18:44 2002
@@ -57,9 +57,10 @@
  */
 void lru_cache_add(struct page * page)
 {
-	if (!TestSetPageLRU(page)) {
+	if (!PageLRU(page)) {
 		spin_lock(&pagemap_lru_lock);
-		add_page_to_inactive_list(page);
+		if (!TestSetPageLRU(page))
+			add_page_to_inactive_list(page);
 		spin_unlock(&pagemap_lru_lock);
 	}
 }

