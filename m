Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271730AbTHMJzQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 05:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271733AbTHMJzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 05:55:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:52190 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271730AbTHMJzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 05:55:12 -0400
Date: Wed, 13 Aug 2003 02:55:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: thunder7@xs4all.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3-mm1: scheduling while atomic (ext3?)
Message-Id: <20030813025542.32429718.akpm@osdl.org>
In-Reply-To: <20030813091958.GA30746@gates.of.nowhere>
References: <20030813045638.GA9713@middle.of.nowhere>
	<20030813014746.412660ae.akpm@osdl.org>
	<20030813091958.GA30746@gates.of.nowhere>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurriaan on adsl-gate <thunder7@xs4all.nl> wrote:
>
> > Exactly what sort of CPU are you using?
>  > -
>  AMD Athlon XP2400+ on a VIA KT400 chipset, single CPU-system.

OK, thanks.  The word is that Athlons will, very occasionally,
take a fault when prefetching from an unmapped address.

 include/linux/list.h |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff -puN include/linux/list.h~hlist_for_each-fix include/linux/list.h
--- 25/include/linux/list.h~hlist_for_each-fix	2003-08-13 02:29:32.000000000 -0700
+++ 25-akpm/include/linux/list.h	2003-08-13 02:37:33.000000000 -0700
@@ -504,11 +504,15 @@ static __inline__ void hlist_add_after(s
 
 #define hlist_entry(ptr, type, member) container_of(ptr,type,member)
 
-/* Cannot easily do prefetch unfortunately */
-#define hlist_for_each(pos, head) \
-	for (pos = (head)->first; pos && ({ prefetch(pos->next); 1; }); \
-	     pos = pos->next) 
+#define hlist_for_each(pos, head)					\
+	for (	pos = (head)->first;					\
+		likely(pos) && ({					\
+				if (likely(pos->next))			\
+					prefetch(pos->next);		\
+				1; });					\
+		pos = pos->next)
 
+/* Cannot easily do prefetch unfortunately */
 #define hlist_for_each_safe(pos, n, head) \
 	for (pos = (head)->first; n = pos ? pos->next : 0, pos; \
 	     pos = n)

_

