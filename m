Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132868AbRDQVaY>; Tue, 17 Apr 2001 17:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132871AbRDQVaV>; Tue, 17 Apr 2001 17:30:21 -0400
Received: from ns.caldera.de ([212.34.180.1]:31501 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S132868AbRDQV3a>;
	Tue, 17 Apr 2001 17:29:30 -0400
Date: Tue, 17 Apr 2001 23:29:23 +0200
Message-Id: <200104172129.XAA14514@ns.caldera.de>
From: hch@caldera.de (Christoph Hellwig)
To: andrea@suse.de (Andrea Arcangeli)
Cc: linux-kernel@vger.kernel.org, dhowells@astarte.free-online.co.uk
Subject: Re: generic rwsem [Re: Alpha "process table hang"]
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20010417224933.E31982@athlon.random>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

In article <20010417224933.E31982@athlon.random> you wrote:
> I didn't exported rwsem.c if CONFIG_RWSEM_GENERIC is set to n as suggested
> by Christoph yet because the old code couldn't be buggy and it's not obvious to
> me that the other way around is correct (Christoph are you sure we can export an
> object file that is not even compiled/generated? If answer is yes the export
> mechanism must be smart enough to discard that file if not present but I'm not
> sure if that's the case ;)

Yes! All the objects in export-objs only get additional depencies in
Rules.make - but if they do not get compiled at all that depencies won't
matter either.  All other makefile work this way, btw.

In my first mail I forgot that the makefile can be optimized even
further, the hunk should look like this:
(NOTE: the patch is handwritten, no apply gurantee)

diff -urN 2.4.4pre3/lib/Makefile rwsem/lib/Makefile
--- 2.4.4pre3/lib/Makefile      Sat Apr 14 15:21:29 2001
+++ rwsem/lib/Makefile  Tue Apr 17 21:58:57 2001
@@ -10,10 +10,12 @@

 export-objs := cmdline.o rwsem.o

-obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o rwsem.o
+obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o

 ifneq ($(CONFIG_HAVE_DEC_LOCK),y)
   obj-y += dec_and_lock.o
 endif

+obj-$(CONFIG_GENERIC_RWSEM)	+= rwsem.o
+
 include $(TOPDIR)/Rules.make



	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
