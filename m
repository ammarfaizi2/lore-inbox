Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262569AbTDAOm7>; Tue, 1 Apr 2003 09:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262570AbTDAOm7>; Tue, 1 Apr 2003 09:42:59 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:8150 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id <S262569AbTDAOm5>; Tue, 1 Apr 2003 09:42:57 -0500
Date: Wed, 2 Apr 2003 00:54:34 +1000
From: CaT <cat@zip.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: Xavier Bestel <xavier.bestel@free.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
Message-ID: <20030401145434.GF459@zip.com.au>
References: <20030401142317.GC459@zip.com.au> <Pine.LNX.4.44.0304011536350.1375-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304011536350.1375-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 03:43:09PM +0100, Hugh Dickins wrote:
> There's plenty of room in unsigned long long size, yes, but si.totalram
> is only an unsigned long, so the arithmetic as you have it starts out
> overflowing an unsigned long.

Ahh yes.

> I don't know yet what it should say: RH2.96-110 is getting confused
> by the do_div(size, 100) I have there (to respect Xavier's point),
> and this is definitely _not_ worth adding a compiler dependency for.

Would a cast be bad? ie:

--- linux/mm/shmem.c.old	Sun Mar 30 00:51:39 2003
+++ linux/mm/shmem.c	Sun Mar 30 03:23:47 2003
@@ -1630,6 +1630,12 @@
 		if (!strcmp(this_char,"size")) {
 			unsigned long long size;
 			size = memparse(value,&rest);
+			if (*rest == '%') {
+				struct sysinfo si;
+				si_meminfo(&si);
+				size = ((unsigned long long)si.totalram << PAGE_CACHE_SHIFT) / 100 * size;
+				rest++;
+			}
 			if (*rest)
 				goto bad_val;
 			*blocks = size >> PAGE_CACHE_SHIFT;
-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to
kill my dad."
        - George W. Bush Jr, Leader of the United States Regime
          September 26, 2002 (from a political fundraiser in Houston, Texas)
