Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266203AbSKLEJX>; Mon, 11 Nov 2002 23:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266210AbSKLEJX>; Mon, 11 Nov 2002 23:09:23 -0500
Received: from fmr01.intel.com ([192.55.52.18]:11226 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S266203AbSKLEJV>;
	Mon, 11 Nov 2002 23:09:21 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CAC920@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Jamie Lokier'" <lk@tantalophile.demon.co.uk>,
       Rusty Russell <rusty@rustcorp.com.au>
Cc: "'mingo@redhat.com'" <mingo@redhat.com>,
       "'Mark Mielke'" <mark@mark.mielke.cc>, linux-kernel@vger.kernel.org
Subject: RE: Users locking memory using futexes
Date: Mon, 11 Nov 2002 20:16:08 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Perez-Gonzalez, Inaky wrote:
> > [...] each time you lock a futex you are pinning the containing page
> > into physical memory, that would cause that if you have, for
> > example, 4000 futexes locked in 4000 different pages, there is going
> > to be 4 MB of memory locked in [...]
> 
> Ouch!  It looks to me like userspace can use FUTEX_FD to lock many
> pages of memory, achieving the same as mlock() but without the
> resource checks.

This raises a good point - I guess we should be doing something like
checking user limits (against locked memory, 'ulimit -l'). Something along
the lines of this [warning, dirty-fastly-scratched-draft, untested]:

diff -u futex.c.orig futex.c
--- futex.c.orig	2002-11-11 20:06:22.000000000 -0800
+++ futex.c	2002-11-11 20:08:48.000000000 -0800
@@ -261,8 +261,12 @@
 	struct page *page;
 	struct futex_q q;
 
+	if (current->mm->total_vm + 1 >
+            (current->rlim[RLIMIT_MEMLOCK].rlim_cur >> PAGE_SHIFT))
+          return -ENOMEM;
+        
 	init_waitqueue_head(&q.waiters);
-
+        
 	lock_futex_mm();
 
 	page = __pin_page(uaddr - offset);
@@ -358,6 +362,11 @@
 	if (signal < 0 || signal > _NSIG)
 		goto out;
 
+	ret = -ENOMEM;
+        if (current->mm->total_vm + 1 >
+            (current->rlim[RLIMIT_MEMLOCK].rlim_cur >> PAGE_SHIFT))
+          goto out;
+        
 	ret = get_unused_fd();
 	if (ret < 0)
 		goto out;

However, we could break the semantics of other programs that expect that the
amount of memory they lock is the only one that is used in the rlimit ... 

What else could be done?

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]

