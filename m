Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273908AbRIRUmu>; Tue, 18 Sep 2001 16:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273909AbRIRUmk>; Tue, 18 Sep 2001 16:42:40 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:65031 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273908AbRIRUmb>; Tue, 18 Sep 2001 16:42:31 -0400
Date: Tue, 18 Sep 2001 16:18:34 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <Pine.LNX.4.21.0109181254200.7152-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0109181508080.7836-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Sep 2001, Marcelo Tosatti wrote:

> 
> 
> On Tue, 18 Sep 2001, Andrea Arcangeli wrote:
> 
> > On Tue, Sep 18, 2001 at 02:02:37AM -0300, Marcelo Tosatti wrote:
> > > Try to run several memory hungry threads (thus hiding more pages).
> > 
> > I did that indeed, not sure why I didn't reproduced (I guess the hogs
> > were sligthly different). (and of course they were killed but only after
> > the box was truly oom)
> 
> Easy reproducible way: 
> 
> Boot with 64M, start 4 setiathome processes, then start mtest (from
> memtest suite) with a lot of threads (I'm using 40 readers and 4 writers
> in this case, and a 100MB heap)
> 
> [root@matrix memtest-0.0.4]# ./mtest -m 100 -r 40 -w 4
> Starting test run with 100 megabyte heap.
> Setting up 25600 4096kB pages for test...
>  done.
> Child 00 started with pid 00935, readonly
> Child 01 started with pid 00936, readonly
> Child 02 started with pid 00937, readonly
> Child 03 started with pid 00938, readonly
> Child 04 started with pid 00939, readonly
> 
> 
> Sep 18 14:28:31 matrix kernel: __alloc_pages: 0-order allocation failed
> (gfp=0x1d2/0) from c012c3be
> Sep 18 14:28:31 matrix kernel: VM: killing process setiathome

Andrea, 

I still can reproduce the alloc pages failures with the following patch.

It should remove the "hidden pages" problem WRT ZONES. That is, a lot of
threads can still hide pages from each other independantly of the zone
hiding problem. 

--- linux.orig/mm/vmscan.c      Tue Sep 18 15:43:14 2001
+++ linux/mm/vmscan.c   Tue Sep 18 16:37:52 2001
@@ -361,13 +361,19 @@
                }
 
                deactivate_page_nolock(page);
+
                list_del(entry);
-               list_add_tail(entry, &inactive_local_lru);
 
-               if (__builtin_expect(!memclass(page->zone, classzone), 0))
+               if (__builtin_expect(!memclass(page->zone, classzone),
0)) {
+                       list_add_tail(entry, &inactive_list);
+                       __max_scan--;
                        continue;
+               }
 
                __max_scan--;
+
+               list_add_tail(entry, &inactive_local_lru);
+
 
                /* Racy check to avoid trylocking when not worthwhile */
                if (!page->buffers && page_count(page) != 1) {


