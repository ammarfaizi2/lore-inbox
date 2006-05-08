Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWEHQG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWEHQG5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 12:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWEHQG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 12:06:56 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:53477 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932416AbWEHQG4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 12:06:56 -0400
Subject: Re: [PATCH] fs: fcntl_setlease defies lease_init assumptions
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Daniel Hokka Zakrisson <daniel@hozac.com>, linux-kernel@vger.kernel.org,
       "=?ISO-8859-1?Q?Bj=F6rn?= Steinbrink" <B.Steinbrink@gmx.de>,
       greg@kroah.com, matthew@wil.cx, Christoph Lameter <clameter@sgi.com>,
       manfred@colorfullife.com, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.64.0605080807430.3718@g5.osdl.org>
References: <445E80DD.9090507@hozac.com>
	 <Pine.LNX.4.64.0605072030280.3718@g5.osdl.org>
	 <84144f020605080131r58ce2a93w6c7ba784a266bbeb@mail.gmail.com>
	 <84144f020605080134q7e16f37fl385359c634ece8ca@mail.gmail.com>
	 <Pine.LNX.4.64.0605080807430.3718@g5.osdl.org>
Date: Mon, 08 May 2006 19:06:51 +0300
Message-Id: <1147104412.22096.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-08 at 08:12 -0700, Linus Torvalds wrote:
> Yeah, but CONFIG_DEBUG_SLAB is _really_ expensive. 
> 
> We do have a lot of very basic debug checks (unconditionally) in the 
> kernel to verify various "must be true" kinds of things. It might slow 
> things down a bit, but in general, I think anything that helps catch 
> problems early tends to pay itself back very quickly. So I'm more than 
> happy with a simple BUG_ON() in even a hot path, if it just ends up being 
> compiled into a "test and branch to unlikely" and doesn't need any costly 
> locking etc around it.

I was under the impression that virt_to_page() is expensive, even more
so on NUMA.  Do we really want this check included unconditionally in
slab free hot path?

				Pekka

   text    data     bss     dec     hex filename
   9279     664      80   10023    2727 mm/slab.o (vanilla uma)
   9327     664      80   10071    2757 mm/slab.o (debug uma)
  13464    2596      24   16084    3ed4 mm/slab.o (vanilla numa)
  13492    2596      24   16112    3ef0 mm/slab.o (debug numa)

diff --git a/mm/slab.c b/mm/slab.c
index c32af7e..8ace45b 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3077,6 +3077,8 @@ static inline void __cache_free(struct k
 	check_irq_off();
 	objp = cache_free_debugcheck(cachep, objp, __builtin_return_address(0));
 
+	BUG_ON(!PageSlab(virt_to_page(objp)));
+
 	/* Make sure we are not freeing a object from another
 	 * node to the array cache on this cpu.
 	 */


