Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318769AbSIPDDc>; Sun, 15 Sep 2002 23:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318780AbSIPDDc>; Sun, 15 Sep 2002 23:03:32 -0400
Received: from 2-028.ctame701-1.telepar.net.br ([200.193.160.28]:9162 "EHLO
	2-028.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S318769AbSIPDDb>; Sun, 15 Sep 2002 23:03:31 -0400
Date: Mon, 16 Sep 2002 00:07:58 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
       Robert Love <rml@tech9.net>
Subject: Re: [PATCH](3/2) rmap14 for ac  (was: Re: 2.5.34-mm4)
Message-ID: <Pine.LNX.4.44L.0209160005230.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

as an added bonus, here is patch 3 out of 2, with a small
SMP bugfix. It turned out Arjan's patch for rmap14 wasn't
safe as vmtruncate calls zap_page_range while holding a
spinlock.  Guess I'll have to release rmap14b soon ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Spamtraps of the month:  september@surriel.com trac@trac.org


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.688   -> 1.689
#	         mm/memory.c	1.56    -> 1.57
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/16	riel@imladris.surriel.com	1.689
# vmtruncate calls zap_page_range() with a spinlock held, so remove
# the explicit low latency schedule -- rml
# --------------------------------------------
#
diff -Nru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	Mon Sep 16 00:05:15 2002
+++ b/mm/memory.c	Mon Sep 16 00:05:15 2002
@@ -436,9 +436,6 @@

 		spin_unlock(&mm->page_table_lock);

-		if (current->need_resched)
-			schedule();
-
 		address += block;
 		size -= block;
 	}

