Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264941AbSJPHs2>; Wed, 16 Oct 2002 03:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264945AbSJPHs2>; Wed, 16 Oct 2002 03:48:28 -0400
Received: from mx2.elte.hu ([157.181.151.9]:34513 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S264941AbSJPHs1>;
	Wed, 16 Oct 2002 03:48:27 -0400
Date: Wed, 16 Oct 2002 10:03:52 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] mmap-speedup-2.5.42-C3
In-Reply-To: <m3bs5vl79h.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.44.0210160957150.4018-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 15 Oct 2002, Andi Kleen wrote:

> When you oprofile KDE startup you notice that a lot of time is spent in
> get_unmapped_area too. The reason is that every KDE process links with
> 10-20 libraries and ends up with a 40-50 entry /proc/<pid>/maps.

actually, library mappings alone should not cause a slowdown, since we
start the search at MAP_UNMAPPED_BASE and most library mappings are below
1GB. But if those libraries use mmap()-ed anonymous RAM that has different
protections then the anonymous areas do not get merged and the scanning
overhead goes up.

> Optimizing this case would be likely useful too, although I suspect
> Ingo's last hit cache would already help somewhat.

well, could you check how much of an impact it has on KDE's kernel
profile? For the threaded test it's was a more than 10x application
speedup, and in the kernel profile get_unmapped_area() was like 90% of the
hits - after the change it was like 1% of the hits. (but, this test is the
best-case for the search cache, so ...)

if this simpler approach solves two different problem categories
sufficiently then i cannot see any reason to go for the much more complex
(and still not 100% scanning-less) approach.

	Ingo


