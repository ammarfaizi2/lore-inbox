Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289809AbSAWLp1>; Wed, 23 Jan 2002 06:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289806AbSAWLpR>; Wed, 23 Jan 2002 06:45:17 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:6140 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S289802AbSAWLpG>; Wed, 23 Jan 2002 06:45:06 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3C4E9291.8DA0BD7F@stud.uni-saarland.de> 
In-Reply-To: <3C4E9291.8DA0BD7F@stud.uni-saarland.de> 
To: manfred@colorfullife.com
Cc: Daniel Robbins <drobbins@gentoo.org>, linux-kernel@vger.kernel.org
Subject: Re: Athlon/AGP issue update 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 23 Jan 2002 11:44:48 +0000
Message-ID: <5553.1011786288@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


masp0008@stud.uni-saarland.de said:
>  speculative write operations always set the cache line dirty bit,
> even if the write operations is not executed (e.g. discarded due to a
> mispredicted jump) 

How predictable is this? Dealing with non-coherent memory is perfectly
normal - could we manage to work around this problem by flushing the caches
when the CPU _might_ have dirtied a cache line rather than only when we know
we've actually written to memory? Something like...

--- old.c	Wed Jan 23 11:31:01 2002
+++ new.c	Wed Jan 23 11:30:30 2002
@@ -1,5 +1,7 @@
 
 	if (condition) {
 		writeb();
-		simon_says_flush_cache_page();
 	}
+/* Flush the cache unconditionally - a speculative write may have dirtied
+   the cache line even though it didn't actually happen. */
+		simon_says_flush_cache_page();


Of course, if the behaviour is completely random, and the CPU will dirty
random cache lines from all over the place, even from completely unrelated
code that just happens to have the 'wrong' address in a register that it
doesn't actually end up dereferencing, that can never work.

--
dwmw2


