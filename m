Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129295AbQKYO1n>; Sat, 25 Nov 2000 09:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129434AbQKYO1d>; Sat, 25 Nov 2000 09:27:33 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:25720 "EHLO
        penguin.e-mind.com") by vger.kernel.org with ESMTP
        id <S129295AbQKYO1S>; Sat, 25 Nov 2000 09:27:18 -0500
Date: Sat, 25 Nov 2000 14:57:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Chip Salzenberg <chip@valinux.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Ville Herva <vherva@mail.niksula.cs.hut.fi>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blindingly stupid 2.2 VM bug
Message-ID: <20001125145701.A12719@athlon.random>
In-Reply-To: <20001119100100.A54301@niksula.cs.hut.fi> <Pine.LNX.4.21.0011201135590.4587-100000@duckman.distro.conectiva> <20001124152831.A5696@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001124152831.A5696@valinux.com>; from chip@valinux.com on Fri, Nov 24, 2000 at 03:28:31PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+               /* Only lower priority if we didn't make progress. */
+               if (count == loopcount)
+                       --priority;
+               loopcount = count;

If the while loops around the page-recycling-methods were missing we would
have just noticed as soon as we needed to recycle some byte of cache.

+       /* Return success if we have enough free memory or we freed a page. */
+       if (nr_free_pages > freepages.low)
+               return 1;

This anti-kill-flood check is just handled by the GFP layer (you don't
need to replicate it here in the memory balancing layer). It's currently
done against freepages.high to stay conservative (it's meant to catch
a task killed while we were blocked; a task killed will certainly
raise nr_free_pages over freepages.high).

+       return count < SWAP_CLUSTER_MAX;

This will make oom handling less graceful and if memory balancing
fails wrongly when the machine isn't truly oom this will only hide the problem
(and if there's a real problem like we had with MAP_SHARED and
always-async-kpiod [fixed by VM-global] it won't even be enough to hide it).


VM-global-*-7 has no known bugs AFIK.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
