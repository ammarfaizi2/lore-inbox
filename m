Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBSXyc>; Mon, 19 Feb 2001 18:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129071AbRBSXyW>; Mon, 19 Feb 2001 18:54:22 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:10501 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129066AbRBSXyL>; Mon, 19 Feb 2001 18:54:11 -0500
Date: Mon, 19 Feb 2001 20:05:56 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rik van Riel <riel@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] run_task_queue(&tq_disk) only if we written data to disk
Message-ID: <Pine.LNX.4.21.0102192000170.3008-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

This patch makes page_launder() do actual disk IO
(run_task_queue(&tq_disk)) only if IO was queued in the page freeing
loop.

If we freed enough clean pages without needing do to any disk IO, there is
no need to call run_task_queue(&tq_disk).

 
--- linux/mm/vmscan.c.orig      Mon Feb 19 20:46:23 2001
+++ linux/mm/vmscan.c   Mon Feb 19 20:47:21 2001
@@ -657,12 +657,13 @@
        }
 
        /*
-        * We have to make sure the data is actually written to
-        * the disk now, otherwise we'll never get enough clean
-        * pages and the system will keep queueing dirty pages
+        * If we written something to disk, we have to make sure the data
is 
+        * actually written to the disk now, otherwise we'll never get
enough
+        * clean pages and the system will keep queueing dirty pages
         * for flushing.
         */
-       run_task_queue(&tq_disk);
+       if (launder_loop)
+               run_task_queue(&tq_disk);
 
        /*
         * Return the amount of pages we freed or made freeable.


